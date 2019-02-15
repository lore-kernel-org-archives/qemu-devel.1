Received: from eggs.gnu.org ([209.51.188.92]:60818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1guTvN-0004S1-Ih
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1guTtm-0003hv-8c
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:10:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:35524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1guTtk-0003ah-9N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:10:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1guTti-0004QV-H1
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:10:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C1402E8070
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:10:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Feb 2019 03:03:34 -0000
From: Cheng Chen <1815993@bugs.launchpad.net>
Reply-To: Bug 1815993 <1815993@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155019981452.28486.1507573377077994257.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815993] [NEW] drive-backup with iscsi will cause
 vm disk no response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

virsh qemu-monitor-command ${DOMAIN} '{ "execute" : "drive-backup" ,
"arguments" : { "device" : "drive-virtio-disk0" , "sync" : "top" ,
"target" : "iscsi://192.168.1.100:3260/iqn.2019-01.com.iaas/0" } }'

When the drive-backup is running, I manually crash the iscsi server=EF=BC=
=88or
interrupt network, eg. iptables -j DROP=EF=BC=89.

Then after less than 1 minute=EF=BC=9A
virsh qemu-monitor-command ${DOMAIN} --pretty '{ "execute": "query-block" }=
' will block and no any response, until timeout. This is still excusable.
But, the disk=EF=BC=88drive-virtio-disk0=EF=BC=89will occur the same situat=
ion=EF=BC=9Ain vm os, the disk will block and no any response.

In other words, when qemu and iscsi-server lose contact, It will cause
the vm unable.

---
Host: centos 7.5
qemu version: ovirt-4.2=EF=BC=88qemu-2.12.0=EF=BC=89
qemu command line: qemu-system-x86_64 -name guest=3Dtest,debug-threads=3Don=
 -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qem=
u/domain-190-test./master-key.aes -machine pc-i440fx-3.1,accel=3Dkvm,usb=3D=
off,dump-guest-core=3Doff,mem-merge=3Doff -m 1024 -mem-prealloc -mem-path /=
dev/hugepages1G/libvirt/qemu/190-test -realtime mlock=3Doff -smp 1,sockets=
=3D1,cores=3D1,threads=3D1 -uuid 1c8611c2-a18a-4b1c-b40b-9d82040eafa4 -smbi=
os type=3D1,manufacturer=3DIaaS -no-user-config -nodefaults -chardev socket=
,id=3Dcharmonitor,fd=3D31,server,nowait -mon chardev=3Dcharmonitor,id=3Dmon=
itor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot menu=3Don,strict=3Do=
n -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device virtio=
-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 -drive file=3D/opt/v=
ol/sas/fb0c7c37-13e7-41fe-b3f8-f0fbaaeec7ce,format=3Dqcow2,if=3Dnone,id=3Dd=
rive-virtio-disk0,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=
=3Dpci.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=
=3D1,write-cache=3Don -drive file=3D/opt/vol/sas/bde66671-536d-49cd-8b46-a4=
f1ea7be513,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dwriteba=
ck -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-v=
irtio-disk1,id=3Dvirtio-disk1,write-cache=3Don -netdev tap,fd=3D33,id=3Dhos=
tnet0,vhost=3Don,vhostfd=3D34 -device virtio-net-pci,netdev=3Dhostnet0,id=
=3Dnet0,mac=3D00:85:45:3e:d4:3a,bus=3Dpci.0,addr=3D0x6 -chardev pty,id=3Dch=
arserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev so=
cket,id=3Dcharchannel0,fd=3D35,server,nowait -device virtserialport,bus=3Dv=
irtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu=
.guest_agent.0 -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0=
.0.0:0,password -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -devi=
ce virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=
=3Don

iscsi=EF=BC=9A
yum -y install targetcli python-rtslib
systemctl start target
systemctl enable target

targetcli /iscsi create iqn.2019-01.com.iaas

targetcli /iscsi/iqn.2019-01.com.iaas/tpg1 set attribute
authentication=3D0 demo_mode_write_protect=3D0 generate_node_acls=3D1

targetcli /iscsi/iqn.2019-01.com.iaas/tpg1/portals create 192.168.1.100 3260
targetcli /backstores/fileio create testfile1 /backup/file1 2G
targetcli /iscsi/iqn.2019-01.com.iaas/tpg1/luns create /backstores/fileio/t=
estfile1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815993

Title:
  drive-backup with iscsi will cause vm disk no response

Status in QEMU:
  New

Bug description:
  virsh qemu-monitor-command ${DOMAIN} '{ "execute" : "drive-backup" ,
  "arguments" : { "device" : "drive-virtio-disk0" , "sync" : "top" ,
  "target" : "iscsi://192.168.1.100:3260/iqn.2019-01.com.iaas/0" } }'

  When the drive-backup is running, I manually crash the iscsi server=EF=BC=
=88or
  interrupt network, eg. iptables -j DROP=EF=BC=89.

  Then after less than 1 minute=EF=BC=9A
  virsh qemu-monitor-command ${DOMAIN} --pretty '{ "execute": "query-block"=
 }' will block and no any response, until timeout. This is still excusable.
  But, the disk=EF=BC=88drive-virtio-disk0=EF=BC=89will occur the same situ=
ation=EF=BC=9Ain vm os, the disk will block and no any response.

  In other words, when qemu and iscsi-server lose contact, It will cause
  the vm unable.

  ---
  Host: centos 7.5
  qemu version: ovirt-4.2=EF=BC=88qemu-2.12.0=EF=BC=89
  qemu command line: qemu-system-x86_64 -name guest=3Dtest,debug-threads=3D=
on -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/q=
emu/domain-190-test./master-key.aes -machine pc-i440fx-3.1,accel=3Dkvm,usb=
=3Doff,dump-guest-core=3Doff,mem-merge=3Doff -m 1024 -mem-prealloc -mem-pat=
h /dev/hugepages1G/libvirt/qemu/190-test -realtime mlock=3Doff -smp 1,socke=
ts=3D1,cores=3D1,threads=3D1 -uuid 1c8611c2-a18a-4b1c-b40b-9d82040eafa4 -sm=
bios type=3D1,manufacturer=3DIaaS -no-user-config -nodefaults -chardev sock=
et,id=3Dcharmonitor,fd=3D31,server,nowait -mon chardev=3Dcharmonitor,id=3Dm=
onitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot menu=3Don,strict=
=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device vi=
rtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 -drive file=3D/o=
pt/vol/sas/fb0c7c37-13e7-41fe-b3f8-f0fbaaeec7ce,format=3Dqcow2,if=3Dnone,id=
=3Ddrive-virtio-disk0,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,b=
us=3Dpci.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootinde=
x=3D1,write-cache=3Don -drive file=3D/opt/vol/sas/bde66671-536d-49cd-8b46-a=
4f1ea7be513,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dwriteb=
ack -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-=
virtio-disk1,id=3Dvirtio-disk1,write-cache=3Don -netdev tap,fd=3D33,id=3Dho=
stnet0,vhost=3Don,vhostfd=3D34 -device virtio-net-pci,netdev=3Dhostnet0,id=
=3Dnet0,mac=3D00:85:45:3e:d4:3a,bus=3Dpci.0,addr=3D0x6 -chardev pty,id=3Dch=
arserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev so=
cket,id=3Dcharchannel0,fd=3D35,server,nowait -device virtserialport,bus=3Dv=
irtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu=
.guest_agent.0 -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0=
.0.0:0,password -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -devi=
ce virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=
=3Don

  iscsi=EF=BC=9A
  yum -y install targetcli python-rtslib
  systemctl start target
  systemctl enable target

  targetcli /iscsi create iqn.2019-01.com.iaas

  targetcli /iscsi/iqn.2019-01.com.iaas/tpg1 set attribute
  authentication=3D0 demo_mode_write_protect=3D0 generate_node_acls=3D1

  targetcli /iscsi/iqn.2019-01.com.iaas/tpg1/portals create 192.168.1.100 3=
260
  targetcli /backstores/fileio create testfile1 /backup/file1 2G
  targetcli /iscsi/iqn.2019-01.com.iaas/tpg1/luns create /backstores/fileio=
/testfile1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815993/+subscriptions
