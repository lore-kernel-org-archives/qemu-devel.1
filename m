Received: from eggs.gnu.org ([2001:4830:134:3::10]:56567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwbJL-0005tJ-RH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwbJJ-0003An-7Q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:20:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:47959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwbJJ-0003AZ-22
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:20:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwbJH-00020o-9j
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 21:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BFE982E80CD
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 21:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 21:15:21 -0000
From: Roger Lawhorn <rll@twc.com>
Reply-To: Bug 1680679 <1680679@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170407032144.12640.21952.malonedeb@gac.canonical.com>
Message-Id: <20170407211521.30800.31463.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1680679] Re: qemu cannot run twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

My uefi build script. If you see an error or issue that could cause
error 43 please confirm it:

#!/bin/bash

cd /home/dad/qemu/qemu2
sudo ./up.sh tap0

configfile=3D./vfio-pci1.cfg

vfiobind() {
    dev=3D"$1"
        vendor=3D$(cat /sys/bus/pci/devices/$dev/vendor)
        device=3D$(cat /sys/bus/pci/devices/$dev/device)
        if [ -e /sys/bus/pci/devices/$dev/driver ]; then
                echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
        fi
        echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id

}

modprobe vfio-pci

cat $configfile | while read line;do
    echo $line | grep ^# >/dev/null 2>&1 && continue
        vfiobind $line
done

vmname=3D"windows10vm"

if ps -A | grep -q $vmname; then
   echo "$vmname is already running." &
   exit 1

else

# use pulseaudio
export QEMU_AUDIO_DRV=3Dpa

cp /usr/share/OVMF/OVMF_VARS.fd /tmp/my_vars.fd

qemu-system-x86_64 \
  -name $vmname,process=3D$vmname \
  -machine type=3Dpc-i440fx-2.6,accel=3Dkvm \
  -cpu host,kvm=3Doff \
  -smp 8,sockets=3D1,cores=3D4,threads=3D2 \
  -enable-kvm \
  -m 4G \
  -mem-path /run/hugepages/kvm \
  -mem-prealloc \
  -balloon none \
  -rtc clock=3Dhost,base=3Dlocaltime \
  -serial none \
  -parallel none \
  -vga none \
  -device vfio-pci,host=3D01:00.0,multifunction=3Don \
  -device vfio-pci,host=3D01:00.1 \
  -drive if=3Dpflash,format=3Draw,readonly,file=3D/home/dad/qemu/qemu2/OVMF=
-pure-efi.fd \
  -drive if=3Dpflash,format=3Draw,file=3D/tmp/my_vars.fd \
  -boot order=3Ddc -boot menu=3Don \
  -device virtio-scsi-pci,id=3Dscsi \
  -drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D/home/dad/=
qemu/qemu2/win7.img \
  -drive file=3D/home/dad/qemu/qemu2/virtio-win-0.1.126.iso,id=3Dvirtiocd,f=
ormat=3Draw,if=3Dnone -device ide-cd,bus=3Dide.1,drive=3Dvirtiocd \
  -netdev type=3Dtap,id=3Dnet0,ifname=3Dtap0,vhost=3Don,script=3Dno,downscr=
ipt=3Dno \
  -device virtio-net-pci,netdev=3Dnet0,mac=3D00:16:3e:00:01:01 \
  -usb -usbdevice host:413c:a503 -usbdevice host:13fe:3100

sudo ./down.sh tap0
   exit 0
fi

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1680679

Title:
  qemu cannot run twice

Status in QEMU:
  Invalid

Bug description:
  After using qemu with gpu passthrough and then shutting down windows 7 pr=
operly I cannot boot windows 7 a second time.
  Only a full reboot of linux fixes this issue.
  Qemu appears to corrupt something in linux when exiting.
  I get no error messages but windows 7 never finishes booting during the 2=
nd try.
  Apparently I do try to run vfiobind each time the script is run.
  Wondering if rerunning vfiobind can cause an issue?

  =

  My specs:
  -------------------------------------------------------------------------=
----------------
  System:    Host: GT70-2PE Kernel: 4.5.4-040504-generic x86_64 (64 bit gcc=
: 5.3.1)
             Desktop: Cinnamon 3.2.7 (Gtk 3.18.9) Distro: Linux Mint 18.1 S=
erena
  Machine:   Mobo: Micro-Star model: MS-1763 v: REV:0.C Bios: American Mega=
trends v: E1763IMS.51B date: 01/29/2015
  CPU:       Quad core Intel Core i7-4810MQ (-HT-MCP-) cache: 6144 KB
             flags: (lm nx sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx) bmips: 22=
347
             clock speeds: max: 2801 MHz 1: 2801 MHz 2: 2801 MHz 3: 2801 MH=
z 4: 2801 MHz 5: 2801 MHz 6: 2801 MHz
             7: 2801 MHz 8: 2801 MHz
  Graphics:  Card-1: Intel 4th Gen Core Processor Integrated Graphics Contr=
oller bus-ID: 00:02.0
             Card-2: NVIDIA GK104M [GeForce GTX 880M] bus-ID: 01:00.0
             Display Server: X.Org 1.18.4 drivers: intel (unloaded: fbdev,v=
esa)
             Resolution: 1920x1080@60.02hz, 1920x1080@60.00hz
             GLX Renderer: Mesa DRI Intel Haswell Mobile GLX Version: 3.0 M=
esa 12.0.6 Direct Rendering: Yes

  =

  My script:
  -------------------------------------------------------------------------=
------------------
  #!/bin/bash

  cd ~/qemu
  sudo ./up.sh tap0

  configfile=3D~/qemu/vfio-pci1.cfg

  vfiobind() {
      dev=3D"$1"
          vendor=3D$(cat /sys/bus/pci/devices/$dev/vendor)
          device=3D$(cat /sys/bus/pci/devices/$dev/device)
          if [ -e /sys/bus/pci/devices/$dev/driver ]; then
                  echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
          fi
          echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id

  }

  modprobe vfio-pci

  cat $configfile | while read line;do
      echo $line | grep ^# >/dev/null 2>&1 && continue
          vfiobind $line
  done

  sudo qemu-system-x86_64 -machine type=3Dq35,accel=3Dkvm -cpu host,kvm=3Do=
ff \
  -smp 8,sockets=3D1,cores=3D4,threads=3D2 \
  -bios /usr/share/seabios/bios.bin \
  -serial none \
  -parallel none \
  -vga none \
  -m 4G \
  -mem-path /run/hugepages/kvm \
  -mem-prealloc \
  -balloon none \
  -rtc clock=3Dhost,base=3Dlocaltime \
  -device ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chas=
sis=3D1,id=3Droot.1 \
  -device vfio-pci,host=3D01:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3D=
on,x-vga=3Don \
  -device virtio-scsi-pci,id=3Dscsi \
  -drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D/home/dad/=
qemu/windows7.img \
  -drive file=3D/home/dad/1TB-Backup/Iso/SP1ForWin7.iso,id=3Disocd,format=
=3Draw,if=3Dnone -device scsi-cd,drive=3Disocd \
  -net nic -net tap,ifname=3Dtap0,script=3Dno,downscript=3Dno \
  -usbdevice host:413c:a503 \
  -usbdevice host:13fe:3100 \
  -usbdevice host:0bc2:ab21 \
  -boot menu=3Don \
  -boot order=3Dc

  sudo ./down.sh tap0

  exit 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1680679/+subscriptions
