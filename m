Received: from eggs.gnu.org ([208.118.235.92]:52846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eobDb-0003j8-TE
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eobC9-0002uw-Fa
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:42:23 -0500
Received: from indium.canonical.com ([91.189.90.7]:50602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eobC8-0002r4-1m
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:40:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eobC6-0002V3-Pp
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 20:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C163B2E80C3
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 20:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2018 20:31:21 -0000
From: Michael Akushsky <1750899@bugs.launchpad.net>
Reply-To: Bug 1750899 <1750899@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151924508195.2772.10456724922935523718.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1750899] [NEW] Mouse cursor sometimes can't pass
 the invisible border on the right side of the screen
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

I'm using qemu 2.11 on Gentoo Linux, with configured GPU passthrough (Radeo=
n RX580) to the guest Windows 10.
This configuration is alive for last 4 years, this time I changed a lot qem=
u, linux kernel and windows versions, changed GPU and always all was workin=
g as expected. I always used standard PS/2 mouse emulation and that was eno=
ugh for me.

Now, I bought two new monitors, instead of old one, and setup them as
one logical monitor, using technology called Eyefinity - it's a part of
standard Radeon software. Now Windows thinks, that I have one monitor
with resolution 2160x1920 (I bought Dell monitors with a thin borders
and use them in portrait mode).

Windows uses it without any problems, but mouse become crazy - sometimes (~=
3 times from each 5) I can't move cursor to the right border of the screen,=
 it looks like the invisible vertical border. I spent really huge amount of=
 time to understand, which component is the root of problem and found, that=
 it's really a mouse. I tried all possible variants (standard, tablet, virt=
io-mouse-pci, virtio-tablet-pci), and found, that in both mouse variants bu=
g is reproducing, and in both tablet variants - cursor stuck near all real =
borders and corners, so it's not a variant too.
The only working variant becomes passing real USB port to my VM and insert =
second mouse to this port. So, now it's working, but I have two mice on my =
working place, which doesn't seems very useful.

Here is my command line:

QEMU_AUDIO_DRV=3Dpa QEMU_PA_SAMPLES=3D4096 qemu-system-x86_64 -enable-kvm -=
M q35 -m 12168 -cpu host,kvm=3Doff -smp 4,sockets=3D1,cores=3D4 \
-bios /usr/share/qemu/bios.bin -rtc base=3Dlocaltime -vga none -device seco=
ndary-vga \
-drive id=3Dvirtiocd,if=3Dnone,format=3Draw,file=3D/home/akushsky/virtio-wi=
n-0.1.141.iso \
-device driver=3Dide-cd,bus=3Dide.1,drive=3Dvirtiocd \
-device ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chassi=
s=3D1,id=3Droot.1 \
-device vfio-pci,host=3D05:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3Don=
,romfile=3D/opt/kvm/images/Sapphire.RX580.8192.170320_1.bin,x-vga=3Don \
-device virtio-scsi-pci,id=3Dscsi \
-drive file=3D/dev/sdb,id=3Ddisk,format=3Draw,if=3Dnone,discard=3Don,cache=
=3Dnone,aio=3Dnative,detect-zeroes=3Dunmap -device scsi-hd,drive=3Ddisk,id=
=3Dscsi0 \
-device ich9-intel-hda,bus=3Dpcie.0,addr=3D1b.0,id=3Dsound0 -device hda-dup=
lex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 \
-usb -usbdevice host:046d:c52b

All in all, I checked on Windows 7 and Windows 10, and on qemu 2.10 and
2.11 - bug is always reproducible.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1750899

Title:
  Mouse cursor sometimes can't pass the invisible border on the right
  side of the screen

Status in QEMU:
  New

Bug description:
  I'm using qemu 2.11 on Gentoo Linux, with configured GPU passthrough (Rad=
eon RX580) to the guest Windows 10.
  This configuration is alive for last 4 years, this time I changed a lot q=
emu, linux kernel and windows versions, changed GPU and always all was work=
ing as expected. I always used standard PS/2 mouse emulation and that was e=
nough for me.

  Now, I bought two new monitors, instead of old one, and setup them as
  one logical monitor, using technology called Eyefinity - it's a part
  of standard Radeon software. Now Windows thinks, that I have one
  monitor with resolution 2160x1920 (I bought Dell monitors with a thin
  borders and use them in portrait mode).

  Windows uses it without any problems, but mouse become crazy - sometimes =
(~3 times from each 5) I can't move cursor to the right border of the scree=
n, it looks like the invisible vertical border. I spent really huge amount =
of time to understand, which component is the root of problem and found, th=
at it's really a mouse. I tried all possible variants (standard, tablet, vi=
rtio-mouse-pci, virtio-tablet-pci), and found, that in both mouse variants =
bug is reproducing, and in both tablet variants - cursor stuck near all rea=
l borders and corners, so it's not a variant too.
  The only working variant becomes passing real USB port to my VM and inser=
t second mouse to this port. So, now it's working, but I have two mice on m=
y working place, which doesn't seems very useful.

  Here is my command line:

  QEMU_AUDIO_DRV=3Dpa QEMU_PA_SAMPLES=3D4096 qemu-system-x86_64 -enable-kvm=
 -M q35 -m 12168 -cpu host,kvm=3Doff -smp 4,sockets=3D1,cores=3D4 \
  -bios /usr/share/qemu/bios.bin -rtc base=3Dlocaltime -vga none -device se=
condary-vga \
  -drive id=3Dvirtiocd,if=3Dnone,format=3Draw,file=3D/home/akushsky/virtio-=
win-0.1.141.iso \
  -device driver=3Dide-cd,bus=3Dide.1,drive=3Dvirtiocd \
  -device ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chas=
sis=3D1,id=3Droot.1 \
  -device vfio-pci,host=3D05:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3D=
on,romfile=3D/opt/kvm/images/Sapphire.RX580.8192.170320_1.bin,x-vga=3Don \
  -device virtio-scsi-pci,id=3Dscsi \
  -drive file=3D/dev/sdb,id=3Ddisk,format=3Draw,if=3Dnone,discard=3Don,cach=
e=3Dnone,aio=3Dnative,detect-zeroes=3Dunmap -device scsi-hd,drive=3Ddisk,id=
=3Dscsi0 \
  -device ich9-intel-hda,bus=3Dpcie.0,addr=3D1b.0,id=3Dsound0 -device hda-d=
uplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 \
  -usb -usbdevice host:046d:c52b

  All in all, I checked on Windows 7 and Windows 10, and on qemu 2.10
  and 2.11 - bug is always reproducible.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1750899/+subscriptions
