Received: from eggs.gnu.org ([209.51.188.92]:41838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwX2D-0007Eb-F4
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwX24-0006lL-Bw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:55:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:57602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gwX1y-0006h3-CF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:55:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gwX1s-0005YM-QT
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 18:55:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C699D2E80C7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 18:55:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Feb 2019 18:47:21 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1813165 <1813165@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154833838504.19548.14915901097039330455.malonedeb@gac.canonical.com>
Message-Id: <155068844125.30047.8968795061853338849.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813165] Re: KVM internal error. Suberror: 1
 emulation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Right, an L1 line of :
./x86_64-softmmu/qemu-system-x86_64  -M q35,accel=3Dkvm -cpu host

does trigger it for me.

My L0 is:

/usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name guest=3Dfedora29
,debug-threads=3Don -S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/home/dgilbert/.config/libvirt/q=
emu/lib/domain-1-fedora29
/master-key.aes -machine pc-q35-3.0,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-
guest-core=3Doff -cpu Skylake-Client-
IBRS,ss=3Don,vmx=3Don,hypervisor=3Don,tsc_adjust=3Don,clflushopt=3Don,ssbd=
=3Don,xsaves=3Don,pdpe1gb=3Don
-m 4096 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid
d070c898-4323-46f6-b8c2-566061a2f88d -no-user-config -nodefaults
-chardev socket,id=3Dcharmonitor,fd=3D27,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=
=3Dslew
-global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global
ICH9-LPC.disable_s3=3D1 -global ICH9-LPC.disable_s4=3D1 -boot strict=3Don
-device pcie-root-
port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Don,add=
r=3D0x2
-device pcie-root-
port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x2.0x1 -device=
 pcie-
root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x2.0x2 -d=
evice
pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0=
x3
-device pcie-root-
port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x4 -device=
 pcie-
root-port,port=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x5 -d=
evice
pcie-root-port,port=3D0x16,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0=
x6
-device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device v=
irtio-
serial-pci,id=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 -drive
file=3D/home/vmimages/fedora29.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-vi=
rtio-
disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddriv=
e-
virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive if=3Dnone,id=3Ddrive-
sata0-0-0,media=3Dcdrom,readonly=3Don -device ide-cd,bus=3Dide.0,drive=3Ddr=
ive-
sata0-0-0,id=3Dsata0-0-0 -netdev user,id=3Dhostnet0 -device virtio-net-
pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:c3:dc:36,bus=3Dpci.1,addr=3D=
0x0
-chardev pty,id=3Dcharserial0 -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
socket,id=3Dcharchannel0,fd=3D29,server,nowait -device virtserialport,bus
=3Dvirtio-
serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest=
_agent.0
-chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent -device
virtserialport,bus=3Dvirtio-
serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spi=
ce.0
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
,seamless-migration=3Don -device virtio-
vga,id=3Dvideo0,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1 -device ich9-intel-
hda,id=3Dsound0,bus=3Dpcie.0,addr=3D0x1b -device hda-
duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-
balloon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -object rng-
random,id=3Dobjrng0,filename=3D/dev/urandom -device virtio-rng-
pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.6,addr=3D0x0 -sandbox
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny
-msg timestamp=3Don

using a f29 packaged qemu-kvm-3.0.0-3.fc29.x86_64 on
4.20.8-200.fc29.x86_64 host.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813165

Title:
  KVM internal error. Suberror: 1 emulation failure

Status in QEMU:
  New

Bug description:
  Hello Devs.

  Having problems getting VM to run with qemu 3.1.0. I should mention
  it's a nested configuration.

  2019-01-24 13:46:08.648+0000: starting up libvirt version: 4.10.0, qemu v=
ersion: 3.1.0, kernel: 4.14.94, hostname: one....
  LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/=
sbin:/usr/local/bin:/usr/local/sbin:/opt/bin HOME=3D/root USER=3Droot QEMU_=
AUDIO_DRV=3Dnone /usr/bin/kvm -name guest=3Done-266,debug-threads=3Don -S -=
object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/dom=
ain-1-one-266/master-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,usb=3Doff,d=
ump-guest-core=3Doff -cpu Skylake-Client-IBRS,ss=3Don,hypervisor=3Don,tsc_a=
djust=3Don,clflushopt=3Don,ssbd=3Don,xsaves=3Don,pdpe1gb=3Don -m 1024 -real=
time mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid b219b45d-a2=
f0-4128-a948-8673a7abf968 -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,fd=3D21,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,m=
ode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -device piix3-=
usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/var/lib/one//da=
tastores/0/266/disk.0,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cach=
e=3Dnone -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Dd=
rive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don -drive f=
ile=3D/var/lib/one//datastores/0/266/disk.1,format=3Draw,if=3Dnone,id=3Ddri=
ve-ide0-0-0,readonly=3Don -device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive=
-ide0-0-0,id=3Dide0-0-0 -netdev tap,fd=3D23,id=3Dhostnet0 -device rtl8139,n=
etdev=3Dhostnet0,id=3Dnet0,mac=3D02:00:00:76:69:85,bus=3Dpci.0,addr=3D0x3 -=
chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3D=
serial0 -vnc 0.0.0.0:266 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D=
0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -sandbo=
x on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny -msg timestamp=3Don
  char device redirected to /dev/pts/1 (label charserial0)
  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D00000001 EBX=3D000f7c2c ECX=3D00000001 EDX=3D00000001
  ESI=3D00006a26 EDI=3D3ffbdc48 EBP=3D000069e6 ESP=3D000a8000
  EIP=3D000fd057 EFL=3D00010016 [----AP-] CPL=3D0 II=3D0 A20=3D1 SMM=3D1 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00c09300
  CS =3D0000 00000000 00000fff 00809b00
  SS =3D0010 00000000 ffffffff 00c09300
  DS =3D0010 00000000 ffffffff 00c09300
  FS =3D0010 00000000 ffffffff 00c09300
  GS =3D0010 00000000 ffffffff 00c09300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     10387cfe 0000fe6c
  IDT=3D     0010387c 00003810
  CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000
  DR6=3D00000000fffecffc DR7=3D000000000e1e0400
  EFER=3D0000000000000000
  Code=3Dcb 66 ba 4d d0 0f 00 e9 c8 fe bc 00 80 0a 00 e8 31 3a ff ff <0f> a=
a fa fc 66 ba 66 d0 0f 00 e9 b1 fe f3 90 f0 0f ba 2d ac 3b 0f 00 00 72 f3 8=
b 25 a8 3b
  2019-01-24T13:47:39.383366Z kvm: terminating on signal 15 from pid 2708 (=
/usr/sbin/libvirtd)

  Someone has an idea whats going wrong here?

  thanks and cheers
  t.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813165/+subscriptions
