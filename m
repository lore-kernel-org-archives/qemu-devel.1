Received: from eggs.gnu.org ([2001:4830:134:3::10]:48623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBME1-0005vF-Jv
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBMDy-0003rb-Kd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:58152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBMDy-0003r9-EK
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:20:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBMDx-0004Ww-32
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 15:20:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 124622E806F
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 15:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Apr 2018 15:12:01 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1766904 <1766904@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152466858890.21548.13995835103547275465.malonedeb@soybean.canonical.com>
Message-Id: <152466912194.519.2563583812692683871.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1766904] Re: Creating high hdd load (with
 constant fsyncs) on a SATA disk leads to freezes and errors in guest dmesg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Copying command line into bug so we don't lose it:

LC_ALL=3DC
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
QEMU_AUDIO_DRV=3Dspice /usr/bin/kvm -name guest=3Dmyvm.local,debug-
threads=3Don -S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-3-m=
yvm.local
/master-key.aes -machine pc-i440fx-2.8,accel=3Dkvm,usb=3Doff,vmport=3Doff
,dump-guest-core=3Doff -cpu IvyBridge -m 2048 -realtime mlock=3Doff -smp
2,sockets=3D2,cores=3D1,threads=3D1 -uuid b10ea3d4-410c-4dc3-b9b0-818d43314=
323
-no-user-config -nodefaults -chardev
socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-3-myvm.local/mo=
nitor.sock,server,nowait
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet
-no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1
-boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7
-device ich9-usb-
uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x5
-device ich9-usb-
uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ic=
h9
-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -devi=
ce
ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x7 -device virtio-serial-pci,id=3Dvirti=
o-
serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/home/user/data/work/virt-
images/myvm.local.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-sata0-0-0 -devi=
ce
ide-hd,bus=3Dsata0.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootindex=3D1
-netdev tap,fd=3D26,id=3Dhostnet0,vhost=3Don,vhostfd=3D29 -device virtio-ne=
t-
pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:39:66:3c,bus=3Dpci.0,addr=3D=
0x3
-chardev pty,id=3Dcharserial0 -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/channel/target/domain=
-3-myvm.local/org.qemu.guest_agent.0,server,nowait
-device virtserialport,bus=3Dvirtio-
serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest=
_agent.0
-chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent -device
virtserialport,bus=3Dvirtio-
serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spi=
ce.0
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff
,seamless-migration=3Don -device qxl-
vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0=
,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
-device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-
balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don

and ccing in jsnow

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1766904

Title:
  Creating high hdd load (with constant fsyncs) on a SATA disk leads to
  freezes and errors in guest dmesg

Status in QEMU:
  New

Bug description:
  After upgrading from qemu 2.10.0+dfsg-2 to 2.12~rc3+dfsg-2 (on debian
  sid host), centos 7 guest started to show freezes and ata errors in
  dmesg during hdd workloads with writing many small files and repeated
  fsyncs.

  Host kernel 4.15.0-3-amd64.
  Guest kernel 3.10.0-693.21.1.el7.x86_64 (slightly older guest kernel was =
tested too with same result).

  Script that reproduces the bug (first run usualy goes smooth, second
  and later runs result in dmesg errors and freezes):

  http://paste.debian.net/hidden/472fb220/

  Sample of error messages in guest dmesg:

  http://paste.debian.net/hidden/8219e234/

  This vm is launchd using virsh start. VM launch command (from logfile
  in /var/log/libvirt/qemu/):

  http://paste.debian.net/plainh/5604126f

  A workaround that I am using right now: I have detached this SATA
  storage and reattached the same .qcow2 file as SCSI - this has fixed
  the issue for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1766904/+subscriptions
