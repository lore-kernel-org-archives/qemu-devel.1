Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTCxg-0002x1-Vp
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTCxb-0007Eb-LK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:05:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:40532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTCxa-0007C8-Sc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:05:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTCxZ-0001Gi-MT
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 21:05:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A5A632E80C8
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 21:05:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Jun 2018 20:53:10 -0000
From: rubenvb <1776760@bugs.launchpad.net>
Reply-To: Bug 1776760 <1776760@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152892319075.7374.9385099662589698544.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776760] [NEW] Loading from a saved state results
 in blue screen due to qxl_dod driver
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

Versions:
Arch Linux (kernel 4.16.13)
Qemu 2.12
libvirt 4.3.0
Windows 10 1803 latest updates installed under libvirt management
Spice tools 0.132
QXL DOD driver 0.18 (from redhat server)

Steps to reproduce:
1. Boot Windows (xml is attached)
2. Save VM state through libvirt interface
3. Restore VM state through libvirt interface

Result:
Blue screen. Previously, the result was high CPU usage and a black screen, =
nonresponsive VM; I could only force shut down or force reset it.

The blue screen mentioned the qxl DOD driver as the culprit, the created
minidump shows "SYSTEM_THREAD_EXCEPTION_NOT_HANDLED" as error. I can
provide the memory.dmp file if it's at all helpful (it's around 250 MB
in size).

libvirt domain logs for the above actions:
2018-06-13 18:59:49.913+0000: starting up libvirt version: 4.3.0, qemu vers=
ion: 2.12.0, hostname: arch-vaio.localdomain
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin QEMU_AUDIO_DRV=3D=
spice /usr/bin/qemu-system-x86_64 -name guest=3DWindows,debug-threads=3Don =
-S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu=
/domain-4-Windows/master-key.aes -machine pc-i440fx-2.7,accel=3Dkvm,usb=3Do=
ff,vmport=3Doff,dump-guest-core=3Doff -cpu Nehalem,vme=3Don,ss=3Don,pcid=3D=
on,x2apic=3Don,tsc-deadline=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,=
rdtscp=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 2048 -real=
time mlock=3Doff -smp 4,sockets=3D1,cores=3D2,threads=3D2 -uuid f14684d3-5f=
81-4743-8512-e516d85ca2c9 -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,path=3D/var/lib/libvirt/qemu/domain-4-Windows/monitor.sock,serv=
er,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s=
4=3D1 -boot strict=3Don -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x=
6 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -dri=
ve file=3D/mnt/media/Qemu/windows10.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddri=
ve-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,dr=
ive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/usr=
/share/spice-guest-tools/spice-guest-tools.iso,format=3Draw,if=3Dnone,id=3D=
drive-ide0-0-1,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D1,drive=3Ddr=
ive-ide0-0-1,id=3Dide0-0-1 -netdev user,id=3Dhostnet0 -device virtio-net-pc=
i,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:44:08:31,bus=3Dpci.0,addr=3D0x=
3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=
=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virts=
erialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel=
0,name=3Dcom.redhat.spice.0 -device usb-tablet,id=3Dinput2,bus=3Dusb.0,port=
=3D3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compressio=
n=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D6710=
8864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1=
,bus=3Dpci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x=
4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev spi=
cevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredir=
0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharredir1,name=
=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,=
port=3D2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -s=
andbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecon=
trol=3Ddeny -msg timestamp=3Don
2018-06-13T18:59:50.018852Z qemu-system-x86_64: -chardev pty,id=3Dcharseria=
l0: char device redirected to /dev/pts/6 (label charserial0)
main_channel_link: add main channel client
inputs_connect: inputs channel client create
red_qxl_set_cursor_peer: =

main_channel_handle_message: agent start
main_channel_handle_message: agent start
main_channel_handle_message: agent start
main_channel_handle_message: agent start
main_channel_handle_message: agent start
main_channel_handle_message: agent start
main_channel_handle_message: agent start
2018-06-13 20:28:19.077+0000: shutting down, reason=3Dsaved
2018-06-13T20:28:19.118226Z qemu-system-x86_64: terminating on signal 15 fr=
om pid 457 (/usr/bin/libvirtd)
red_channel_client_disconnect: rcc=3D0x7f7eaa3d8a30 (channel=3D0x7f7eaa34d3=
00 type=3D5 id=3D0)
red_channel_client_disconnect: rcc=3D0x7f7e22bf04b0 (channel=3D0x7f7eaa34d3=
c0 type=3D6 id=3D0)
red_channel_client_disconnect: rcc=3D0x7f7e22bd89b0 (channel=3D0x7f7e214599=
a0 type=3D9 id=3D0)
red_channel_client_disconnect: rcc=3D0x7f7eaa3de270 (channel=3D0x7f7e21459a=
70 type=3D9 id=3D1)
2018-06-13 20:29:04.933+0000: starting up libvirt version: 4.3.0, qemu vers=
ion: 2.12.0, hostname: arch-vaio.localdomain
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin QEMU_AUDIO_DRV=3D=
spice /usr/bin/qemu-system-x86_64 -name guest=3DWindows,debug-threads=3Don =
-S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu=
/domain-5-Windows/master-key.aes -machine pc-i440fx-2.7,accel=3Dkvm,usb=3Do=
ff,vmport=3Doff,dump-guest-core=3Doff -cpu Nehalem,vme=3Don,ss=3Don,pcid=3D=
on,x2apic=3Don,tsc-deadline=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,=
rdtscp=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 2048 -real=
time mlock=3Doff -smp 4,sockets=3D1,cores=3D2,threads=3D2 -uuid f14684d3-5f=
81-4743-8512-e516d85ca2c9 -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,path=3D/var/lib/libvirt/qemu/domain-5-Windows/monitor.sock,serv=
er,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=
=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s=
4=3D1 -boot strict=3Don -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x=
6 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -dri=
ve file=3D/mnt/media/Qemu/windows10.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddri=
ve-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,dr=
ive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/usr=
/share/spice-guest-tools/spice-guest-tools.iso,format=3Draw,if=3Dnone,id=3D=
drive-ide0-0-1,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D1,drive=3Ddr=
ive-ide0-0-1,id=3Dide0-0-1 -netdev user,id=3Dhostnet0 -device virtio-net-pc=
i,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:44:08:31,bus=3Dpci.0,addr=3D0x=
3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=
=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virts=
erialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel=
0,name=3Dcom.redhat.spice.0 -device usb-tablet,id=3Dinput1,bus=3Dusb.0,port=
=3D3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compressio=
n=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D6710=
8864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1=
,bus=3Dpci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x=
4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev spi=
cevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredir=
0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharredir1,name=
=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,=
port=3D2 -incoming defer -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci=
.0,addr=3D0x8 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3D=
deny,resourcecontrol=3Ddeny -msg timestamp=3Don
2018-06-13T20:29:05.185563Z qemu-system-x86_64: -chardev pty,id=3Dcharseria=
l0: char device redirected to /dev/pts/6 (label charserial0)
red_qxl_loadvm_commands: =

2018-06-13T20:29:28.899527Z qemu-system-x86_64: warning: usb-redir connecti=
on broken during migration

2018-06-13T20:29:28.904336Z qemu-system-x86_64: warning: usb-redir
connection broken during migration

main_channel_link: add main channel client
main_channel_handle_message: agent start
red_qxl_set_cursor_peer: =

inputs_connect: inputs channel client create
main_channel_handle_message: agent start
main_channel_handle_message: agent start

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "libvirt domain xml"
   https://bugs.launchpad.net/bugs/1776760/+attachment/5152235/+files/domai=
n.xml

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776760

Title:
  Loading from a saved state results in blue screen due to qxl_dod
  driver

Status in QEMU:
  New

Bug description:
  Versions:
  Arch Linux (kernel 4.16.13)
  Qemu 2.12
  libvirt 4.3.0
  Windows 10 1803 latest updates installed under libvirt management
  Spice tools 0.132
  QXL DOD driver 0.18 (from redhat server)

  Steps to reproduce:
  1. Boot Windows (xml is attached)
  2. Save VM state through libvirt interface
  3. Restore VM state through libvirt interface

  Result:
  Blue screen. Previously, the result was high CPU usage and a black screen=
, nonresponsive VM; I could only force shut down or force reset it.

  The blue screen mentioned the qxl DOD driver as the culprit, the
  created minidump shows "SYSTEM_THREAD_EXCEPTION_NOT_HANDLED" as error.
  I can provide the memory.dmp file if it's at all helpful (it's around
  250 MB in size).

  libvirt domain logs for the above actions:
  2018-06-13 18:59:49.913+0000: starting up libvirt version: 4.3.0, qemu ve=
rsion: 2.12.0, hostname: arch-vaio.localdomain
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin QEMU_AUDIO_DRV=
=3Dspice /usr/bin/qemu-system-x86_64 -name guest=3DWindows,debug-threads=3D=
on -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/q=
emu/domain-4-Windows/master-key.aes -machine pc-i440fx-2.7,accel=3Dkvm,usb=
=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu Nehalem,vme=3Don,ss=3Don,pci=
d=3Don,x2apic=3Don,tsc-deadline=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=
=3Don,rdtscp=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 2048=
 -realtime mlock=3Doff -smp 4,sockets=3D1,cores=3D2,threads=3D2 -uuid f1468=
4d3-5f81-4743-8512-e516d85ca2c9 -no-user-config -nodefaults -chardev socket=
,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-4-Windows/monitor.soc=
k,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc=
 base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay =
-no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disa=
ble_s4=3D1 -boot strict=3Don -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=
=3D0x6 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5=
 -drive file=3D/mnt/media/Qemu/windows10.qcow2,format=3Dqcow2,if=3Dnone,id=
=3Ddrive-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D=
0x7,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=
=3D/usr/share/spice-guest-tools/spice-guest-tools.iso,format=3Draw,if=3Dnon=
e,id=3Ddrive-ide0-0-1,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D1,dri=
ve=3Ddrive-ide0-0-1,id=3Dide0-0-1 -netdev user,id=3Dhostnet0 -device virtio=
-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:44:08:31,bus=3Dpci.0,ad=
dr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharser=
ial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -devic=
e virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3D=
channel0,name=3Dcom.redhat.spice.0 -device usb-tablet,id=3Dinput2,bus=3Dusb=
.0,port=3D3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-com=
pression=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=
=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outp=
uts=3D1,bus=3Dpci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,ad=
dr=3D0x4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -char=
dev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dch=
arredir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharredir1=
,name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Du=
sb.0,port=3D2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0=
x8 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resour=
cecontrol=3Ddeny -msg timestamp=3Don
  2018-06-13T18:59:50.018852Z qemu-system-x86_64: -chardev pty,id=3Dcharser=
ial0: char device redirected to /dev/pts/6 (label charserial0)
  main_channel_link: add main channel client
  inputs_connect: inputs channel client create
  red_qxl_set_cursor_peer: =

  main_channel_handle_message: agent start
  main_channel_handle_message: agent start
  main_channel_handle_message: agent start
  main_channel_handle_message: agent start
  main_channel_handle_message: agent start
  main_channel_handle_message: agent start
  main_channel_handle_message: agent start
  2018-06-13 20:28:19.077+0000: shutting down, reason=3Dsaved
  2018-06-13T20:28:19.118226Z qemu-system-x86_64: terminating on signal 15 =
from pid 457 (/usr/bin/libvirtd)
  red_channel_client_disconnect: rcc=3D0x7f7eaa3d8a30 (channel=3D0x7f7eaa34=
d300 type=3D5 id=3D0)
  red_channel_client_disconnect: rcc=3D0x7f7e22bf04b0 (channel=3D0x7f7eaa34=
d3c0 type=3D6 id=3D0)
  red_channel_client_disconnect: rcc=3D0x7f7e22bd89b0 (channel=3D0x7f7e2145=
99a0 type=3D9 id=3D0)
  red_channel_client_disconnect: rcc=3D0x7f7eaa3de270 (channel=3D0x7f7e2145=
9a70 type=3D9 id=3D1)
  2018-06-13 20:29:04.933+0000: starting up libvirt version: 4.3.0, qemu ve=
rsion: 2.12.0, hostname: arch-vaio.localdomain
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin QEMU_AUDIO_DRV=
=3Dspice /usr/bin/qemu-system-x86_64 -name guest=3DWindows,debug-threads=3D=
on -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/q=
emu/domain-5-Windows/master-key.aes -machine pc-i440fx-2.7,accel=3Dkvm,usb=
=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu Nehalem,vme=3Don,ss=3Don,pci=
d=3Don,x2apic=3Don,tsc-deadline=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=
=3Don,rdtscp=3Don,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 2048=
 -realtime mlock=3Doff -smp 4,sockets=3D1,cores=3D2,threads=3D2 -uuid f1468=
4d3-5f81-4743-8512-e516d85ca2c9 -no-user-config -nodefaults -chardev socket=
,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-5-Windows/monitor.soc=
k,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc=
 base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay =
-no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disa=
ble_s4=3D1 -boot strict=3Don -device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=
=3D0x6 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5=
 -drive file=3D/mnt/media/Qemu/windows10.qcow2,format=3Dqcow2,if=3Dnone,id=
=3Ddrive-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D=
0x7,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=
=3D/usr/share/spice-guest-tools/spice-guest-tools.iso,format=3Draw,if=3Dnon=
e,id=3Ddrive-ide0-0-1,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D1,dri=
ve=3Ddrive-ide0-0-1,id=3Dide0-0-1 -netdev user,id=3Dhostnet0 -device virtio=
-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:44:08:31,bus=3Dpci.0,ad=
dr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharser=
ial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -devic=
e virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3D=
channel0,name=3Dcom.redhat.spice.0 -device usb-tablet,id=3Dinput1,bus=3Dusb=
.0,port=3D3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-com=
pression=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=
=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outp=
uts=3D1,bus=3Dpci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,ad=
dr=3D0x4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -char=
dev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dch=
arredir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharredir1=
,name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Du=
sb.0,port=3D2 -incoming defer -device virtio-balloon-pci,id=3Dballoon0,bus=
=3Dpci.0,addr=3D0x8 -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,sp=
awn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=3Don
  2018-06-13T20:29:05.185563Z qemu-system-x86_64: -chardev pty,id=3Dcharser=
ial0: char device redirected to /dev/pts/6 (label charserial0)
  red_qxl_loadvm_commands: =

  2018-06-13T20:29:28.899527Z qemu-system-x86_64: warning: usb-redir connec=
tion broken during migration

  2018-06-13T20:29:28.904336Z qemu-system-x86_64: warning: usb-redir
  connection broken during migration

  main_channel_link: add main channel client
  main_channel_handle_message: agent start
  red_qxl_set_cursor_peer: =

  inputs_connect: inputs channel client create
  main_channel_handle_message: agent start
  main_channel_handle_message: agent start

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776760/+subscriptions
