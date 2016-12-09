Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFGQX-0007Mg-I8
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 03:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFGQU-0002ax-AC
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 03:21:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:47373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cFGQU-0002ar-1I
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 03:21:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cFGQP-0005JM-O3
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 08:21:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 605D52E8219
	for <qemu-devel@nongnu.org>; Fri,  9 Dec 2016 08:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Dec 2016 08:09:58 -0000
From: Jack Coulter <1648726@bugs.launchpad.net>
Reply-To: Bug 1648726 <1648726@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20161209080958.23373.14363.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1648726] [NEW] Passthrough of UAS devices fails
 with Windows (10) guests
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

Split off from https://bugs.launchpad.net/qemu/+bug/1579306 as this is a
distinct issue.

Physical USB storage devices that support the UAS protocol do not work
correctly when passed through to Windows guests (I've only tested this
with Windows 10 x64, build 1607).

Passing through such a device results in the older BOT/MSC protocol
being used:

<See attachment win10-uas-fail.png>

Using the same domain configuration with a Linux guest (tested with
SystemRescueCD 4.8.0) works correctly:

/: Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 5000M
=C2=A0=C2=A0=C2=A0=C2=A0|__ Port 1: Dev 2, If 0, Class=3DMass Storage, Driv=
er=3Duas, 5000M
/: Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 480M

In both cases, the VM was launched via libvirt, which generated the
following command line:

/usr/bin/qemu-system-x86_64 -name guest=3DWin10-Edge-IE11,debug-threads=3Don
-S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-13-=
Win10
-Edge-IE11/master-key.aes -machine
pc-q35-2.7,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu
host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 4096 -realtime
mlock=3Doff -smp 8,sockets=3D1,cores=3D4,threads=3D2 -uuid 47c39707-088c-4e=
dc-
8b6a-a7856e09f43d -no-user-config -nodefaults -chardev
socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-13-Win10-Edge-
IE11/monitor.sock,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddiscard
-no-hpet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x0 -device nec-usb-
xhci,id=3Dusb,bus=3Dpci.2,addr=3D0x6 -device virtio-scsi-
pci,id=3Dscsi0,bus=3Dpci.2,addr=3D0x3 -device virtio-serial-pci,id=3Dvirtio-
serial0,bus=3Dpci.2,addr=3D0x4 -drive file=3D/home/jack/IMG/Win10-Edge-
IE11.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,discard=3Dunmap
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-
scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
scsi0-0-0-1,readonly=3Don -device scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-
id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev
tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vhostfd=3D24 -device virtio-net-
pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:27:94:5d,bus=3Dpci.2,addr=3D=
0x1
-chardev pty,id=3Dcharserial0 -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirt=
io-
serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spi=
ce.0
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D2 -spice
port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
,seamless-migration=3Don -device qxl-
vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0=
,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
-device intel-hda,id=3Dsound0,bus=3Dpci.2,addr=3D0x2 -device hda-
duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D3 -chardev
spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D4 -device usb-
host,hostbus=3D4,hostaddr=3D4,id=3Dhostdev0,bus=3Dusb.0,port=3D1 -device vi=
rtio-
balloon-pci,id=3Dballoon0,bus=3Dpci.2,addr=3D0x5 -msg timestamp=3Don

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: uas uasp usb usb-host xhci

** Attachment added: "win10-uas-fail.png"
   https://bugs.launchpad.net/bugs/1648726/+attachment/4789413/+files/2016-=
12-09-165117_504x687_scrot.png

** Description changed:

- Split off from #1579306 as this is a distinct issue.
+ Split off from https://bugs.launchpad.net/qemu/+bug/1579306 as this is a
+ distinct issue.
  =

  Physical USB storage devices that support the UAS protocol do not work
  correctly when passed through to Windows guests (I've only tested this
  with Windows 10 x64, build 1607).
  =

  Passing through such a device results in the older BOT/MSC protocol
  being used:
  =

  <See attachment win10-uas-fail.png>
  =

  Using the same domain configuration with a Linux guest (tested with
  SystemRescueCD 4.8.0) works correctly:
  =

  /: Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 5000M
-     |__ Port 1: Dev 2, If 0, Class=3DMass Storage, Driver=3Duas, 5000M
+ =C2=A0=C2=A0=C2=A0=C2=A0|__ Port 1: Dev 2, If 0, Class=3DMass Storage, Dr=
iver=3Duas, 5000M
  /: Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 480M
  =

- =

- In both cases, the VM was launched via libvirt, which generated the follo=
wing command line:
+ In both cases, the VM was launched via libvirt, which generated the
+ following command line:
  =

  /usr/bin/qemu-system-x86_64 -name guest=3DWin10-Edge-IE11,debug-threads=
=3Don
  -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1=
3-Win10
  -Edge-IE11/master-key.aes -machine
  pc-q35-2.7,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu
  host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 4096 -realtime
  mlock=3Doff -smp 8,sockets=3D1,cores=3D4,threads=3D2 -uuid 47c39707-088c-=
4edc-
  8b6a-a7856e09f43d -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-13-Win10-Edge-
  IE11/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddisca=
rd
  -no-hpet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
  ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
  i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
  bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x0 -device nec-usb-
  xhci,id=3Dusb,bus=3Dpci.2,addr=3D0x6 -device virtio-scsi-
  pci,id=3Dscsi0,bus=3Dpci.2,addr=3D0x3 -device virtio-serial-pci,id=3Dvirt=
io-
  serial0,bus=3Dpci.2,addr=3D0x4 -drive file=3D/home/jack/IMG/Win10-Edge-
  IE11.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,discard=3Dunmap
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddri=
ve-
  scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
  scsi0-0-0-1,readonly=3Don -device scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-
  id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev
  tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vhostfd=3D24 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:27:94:5d,bus=3Dpci.2,addr=
=3D0x1
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvi=
rtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D2 -spice
  port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
  ,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
  -device intel-hda,id=3Dsound0,bus=3Dpci.2,addr=3D0x2 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D3 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D4 -device usb-
  host,hostbus=3D4,hostaddr=3D4,id=3Dhostdev0,bus=3Dusb.0,port=3D1 -device =
virtio-
  balloon-pci,id=3Dballoon0,bus=3Dpci.2,addr=3D0x5 -msg timestamp=3Don

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1648726

Title:
  Passthrough of UAS devices fails with Windows (10) guests

Status in QEMU:
  New

Bug description:
  Split off from https://bugs.launchpad.net/qemu/+bug/1579306 as this is
  a distinct issue.

  Physical USB storage devices that support the UAS protocol do not work
  correctly when passed through to Windows guests (I've only tested this
  with Windows 10 x64, build 1607).

  Passing through such a device results in the older BOT/MSC protocol
  being used:

  <See attachment win10-uas-fail.png>

  Using the same domain configuration with a Linux guest (tested with
  SystemRescueCD 4.8.0) works correctly:

  /: Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 5000M
  =C2=A0=C2=A0=C2=A0=C2=A0|__ Port 1: Dev 2, If 0, Class=3DMass Storage, Dr=
iver=3Duas, 5000M
  /: Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci_hcd/4p, 480M

  In both cases, the VM was launched via libvirt, which generated the
  following command line:

  /usr/bin/qemu-system-x86_64 -name guest=3DWin10-Edge-IE11,debug-
  threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1=
3-Win10
  -Edge-IE11/master-key.aes -machine
  pc-q35-2.7,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu
  host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 4096 -realtime
  mlock=3Doff -smp 8,sockets=3D1,cores=3D4,threads=3D2 -uuid 47c39707-088c-=
4edc-
  8b6a-a7856e09f43d -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-13-Win10-Edge-
  IE11/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddisca=
rd
  -no-hpet -no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
  ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
  i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
  bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x0 -device nec-usb-
  xhci,id=3Dusb,bus=3Dpci.2,addr=3D0x6 -device virtio-scsi-
  pci,id=3Dscsi0,bus=3Dpci.2,addr=3D0x3 -device virtio-serial-pci,id=3Dvirt=
io-
  serial0,bus=3Dpci.2,addr=3D0x4 -drive file=3D/home/jack/IMG/Win10-Edge-
  IE11.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,discard=3Dunmap
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddri=
ve-
  scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
  scsi0-0-0-1,readonly=3Don -device scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-
  id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1 -netdev
  tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vhostfd=3D24 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:27:94:5d,bus=3Dpci.2,addr=
=3D0x1
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus
  =3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D2 -spice
  port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
  ,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
  -device intel-hda,id=3Dsound0,bus=3Dpci.2,addr=3D0x2 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D3 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D4 -device usb-
  host,hostbus=3D4,hostaddr=3D4,id=3Dhostdev0,bus=3Dusb.0,port=3D1 -device =
virtio-
  balloon-pci,id=3Dballoon0,bus=3Dpci.2,addr=3D0x5 -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1648726/+subscriptions
