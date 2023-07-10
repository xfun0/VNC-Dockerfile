FROM debian
RUN apt update
RUN apt dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt install qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr gnome-system-monitor mate-system-monitor git xfce4 xfce4-terminal tightvncserver wget -y
RUN DEBIAN_FRONTEND=noninteractive apt install htop nginx net-tools php php-fpm tar vim psmisc -y
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN curl -LO https://proot.gitlab.io/proot/bin/proot
RUN chmod 755 proot
RUN mv proot /bin
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir  $HOME/.vnc
RUN echo 'vnc' | vncpasswd -f > $HOME/.vnc/passwd
RUN chmod 600 $HOME/.vnc/passwd
RUN echo 'whoami ' >>/vnc.sh
RUN echo 'cd ' >>/vnc.sh
RUN echo "su -l -c  'vncserver :2000 -geometry 1200x600' "  >>/vnc.sh
RUN echo 'cd /noVNC-1.2.0' >>/vnc.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 8900 ' >>/vnc.sh
RUN chmod 755 /vnc.sh
EXPOSE 8900
CMD  /vnc.sh
