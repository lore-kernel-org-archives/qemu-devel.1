Received: from eggs.gnu.org ([209.51.188.92]:33541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggukL-0002tT-NP
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggukD-0006y7-R4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:00:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggukB-0006q4-Vt
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:00:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggukA-0000NN-4s
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 17:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 239F12E8054
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 17:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jan 2019 16:55:01 -0000
From: Laurent Bigonville <bigon@bigon.be>
Reply-To: Bug 1810975 <1810975@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154696650145.19442.16431088160952702777.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810975] [NEW] qemu crashes when using "host"
 smartcard
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

Hello,

When starting qemu 3.1 (via libvirt) with an "host" smartcard defined,
it crashes with:


                Stack trace of thread 15264:
                #0  0x00007f17029ae5f7 __GI___getpriority (libc.so.6)
                #1  0x00007f170254ae18 _pt_root (libnspr4.so)
                #2  0x00007f1702a86fa3 start_thread (libpthread.so.0)
                #3  0x00007f17029b789f __clone (libc.so.6)
                =

                Stack trace of thread 15210:
                #0  0x00007f17029b7891 __clone (libc.so.6)
                #1  0x0000000000000000 n/a (n/a)


Command line:

qemu-system-x86_64 -enable-kvm -name guest=3Dwin10,debug-threads=3Don -S
-object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-6-w=
in10
/master-key.aes -machine pc-i440fx-2.11,accel=3Dkvm,usb=3Doff,vmport=3Doff
,dump-guest-core=3Doff -cpu Broadwell-
IBRS,vme=3Don,ss=3Don,f16c=3Don,rdrand=3Don,hypervisor=3Don,arat=3Don,tsc_a=
djust=3Don,umip=3Don,ssbd=3Don,xsaveopt=3Don,pdpe1gb=3Don,abm=3Don,hv_time,=
hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff
-m 4096 -realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid
2109c1d6-edb0-4e2e-bd6a-cd7e38d303f2 -no-user-config -nodefaults
-chardev socket,id=3Dcharmonitor,fd=3D26,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -=
no-
hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device ich9-usb-
ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ich9-usb-
uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x5
-device ich9-usb-
uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ic=
h9
-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -devi=
ce
virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x8 -device virtio-serial-pci=
,id
=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -device usb-
ccid,id=3Dccid0,bus=3Dusb.0,port=3D4 -drive
file=3D/var/lib/libvirt/images/win10.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddr=
ive-
scsi0-0-0-1,discard=3Dunmap -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-
id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1,bootindex=3D1 -dr=
ive
if=3Dnone,id=3Ddrive-ide0-0-1,readonly=3Don -device ide-
cd,bus=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 -netdev
tap,fd=3D28,id=3Dhostnet0 -device
rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:b4:0f:cc,bus=3Dpci.0,add=
r=3D0x3
-device ccid-card-emulated,backend=3Dnss-
emulated,id=3Dsmartcard0,bus=3Dccid0.0 -chardev pty,id=3Dcharserial0 -device
isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirt=
io-
serial0.0,nr=3D2,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spi=
ce.0
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D0,disable-
ticketing,image-compression=3Doff,seamless-migration=3Don -device qxl-
vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0=
,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
-device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-
balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -sandbox
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny
-msg timestamp=3Don


https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D917007

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810975

Title:
  qemu crashes when using "host" smartcard

Status in QEMU:
  New

Bug description:
  Hello,

  When starting qemu 3.1 (via libvirt) with an "host" smartcard defined,
  it crashes with:

  =

                  Stack trace of thread 15264:
                  #0  0x00007f17029ae5f7 __GI___getpriority (libc.so.6)
                  #1  0x00007f170254ae18 _pt_root (libnspr4.so)
                  #2  0x00007f1702a86fa3 start_thread (libpthread.so.0)
                  #3  0x00007f17029b789f __clone (libc.so.6)
                  =

                  Stack trace of thread 15210:
                  #0  0x00007f17029b7891 __clone (libc.so.6)
                  #1  0x0000000000000000 n/a (n/a)

  =

  Command line:

  qemu-system-x86_64 -enable-kvm -name guest=3Dwin10,debug-threads=3Don -S
  -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-6=
-win10
  /master-key.aes -machine pc-i440fx-2.11,accel=3Dkvm,usb=3Doff,vmport=3Doff
  ,dump-guest-core=3Doff -cpu Broadwell-
  IBRS,vme=3Don,ss=3Don,f16c=3Don,rdrand=3Don,hypervisor=3Don,arat=3Don,tsc=
_adjust=3Don,umip=3Don,ssbd=3Don,xsaveopt=3Don,pdpe1gb=3Don,abm=3Don,hv_tim=
e,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff
  -m 4096 -realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -u=
uid
  2109c1d6-edb0-4e2e-bd6a-cd7e38d303f2 -no-user-config -nodefaults
  -chardev socket,id=3Dcharmonitor,fd=3D26,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay
  -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
  PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device ich9-usb-
  ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ich9-usb-
  uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x5
  -device ich9-usb-
  uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device =
ich9
  -usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -de=
vice
  virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x8 -device virtio-serial-
  pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -device usb-
  ccid,id=3Dccid0,bus=3Dusb.0,port=3D4 -drive
  file=3D/var/lib/libvirt/images/win10.qcow2,format=3Dqcow2,if=3Dnone,id
  =3Ddrive-scsi0-0-0-1,discard=3Dunmap -device scsi-hd,bus=3Dscsi0.0,channe=
l=3D0
  ,scsi-id=3D0,lun=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1,bootindex=
=3D1
  -drive if=3Dnone,id=3Ddrive-ide0-0-1,readonly=3Don -device ide-
  cd,bus=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 -netdev
  tap,fd=3D28,id=3Dhostnet0 -device
  rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:b4:0f:cc,bus=3Dpci.0,a=
ddr=3D0x3
  -device ccid-card-emulated,backend=3Dnss-
  emulated,id=3Dsmartcard0,bus=3Dccid0.0 -chardev pty,id=3Dcharserial0 -dev=
ice
  isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus
  =3Dvirtio-
  serial0.0,nr=3D2,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice port=3D0,disab=
le-
  ticketing,image-compression=3Doff,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
  -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virti=
o-
  balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -sandbox
  on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny
  -msg timestamp=3Don

  =

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D917007

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810975/+subscriptions
