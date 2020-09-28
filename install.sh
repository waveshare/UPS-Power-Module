#!/bin/sh

set -e

password=$1

# enable i2c permissions
echo $password | sudo -S usermod -aG i2c $USER

# install pip and some apt dependencies
echo $password | sudo -S apt-get update
echo $password | sudo -S apt install -y python3-pip python3-pil python3-smbus
echo $password | sudo -S pip3 install flask

# install ups_display
echo $password | sudo -S python3 setup.py install

# install UPS_Power_Module display service
python3 -m ups_display.create_display_service
echo $password | sudo -S mv ups_display.service /etc/systemd/system/ups_display.service
echo $password | sudo -S systemctl enable ups_display
echo $password | sudo -S systemctl start ups_display
