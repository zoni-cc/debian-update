#!/bin/bash
RELEASE=$(cat /etc/issue)

__do_apt_update(){
    apt update
    if [ $? -ne 0 ]; then
        exit 1
    fi;
}

__do_apt_upgrade(){
    __do_apt_update
    apt upgrade -y
    apt dist-upgrade -y
    apt full-upgrade -y
}

__do_debian10_upgrade(){
    echo "[INFO] Doing debian 10 upgrade..."
    __do_apt_upgrade
    curl -o https://raw.githubusercontent.com/zoni-cc/debian-update/main/buster.sources.list /etc/apt/sources.list
    __do_apt_upgrade
    echo "[INFO] Please reboot"
}

__do_debian11_upgrade(){
    echo "[INFO] Doing debian 11 upgrade..."
    __do_apt_upgrade
    curl -o https://raw.githubusercontent.com/zoni-cc/debian-update/main/bullseye.sources.list /etc/apt/sources.list
    __do_apt_upgrade
    echo "[INFO] Please reboot"
}

__do_debian12_upgrade(){
    echo "[INFO] Doing debian 12 upgrade..."
    __do_apt_upgrade
    curl -o https://raw.githubusercontent.com/zoni-cc/debian-update/main/bookworm.sources.list /etc/apt/sources.list
    __do_apt_upgrade
    echo "[INFO] Please reboot"
}


echo $RELEASE | grep ' 9 '
if [ $? -eq 0 ]; then
    __do_debian10_upgrade
    exit 0
fi;

echo $RELEASE | grep ' 10 '
if [ $? -eq 0 ]; then
    __do_debian11_upgrade
    exit 0
fi;

echo $RELEASE | grep ' 11 '
if [ $? -eq 0 ]; then
    __do_debian12_upgrade
    exit 0
fi;
