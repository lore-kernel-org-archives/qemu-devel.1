Received: from eggs.gnu.org ([2001:4830:134:3::10]:51774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dMJVT-0003mX-Kc
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 15:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dMJVO-0004p2-8q
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 15:35:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:44129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dMJVO-0004om-37
	for qemu-devel@nongnu.org; Sat, 17 Jun 2017 15:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dMJVN-0008Ul-0c
	for <qemu-devel@nongnu.org>; Sat, 17 Jun 2017 19:35:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F3B982E8193
	for <qemu-devel@nongnu.org>; Sat, 17 Jun 2017 19:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Jun 2017 19:23:53 -0000
From: Roger Lawhorn <rll@twc.com>
Reply-To: Bug 1698574 <1698574@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149772743364.22138.5473878179113955993.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1698574] [NEW] slow boot windows 7
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
I have a nice working qemu with gpu passthrough setup.
I pass through my nvidia gtx 880m.
It boots in 4mins 18secs.

If I remove the "-vga none" switch and allow qemu to create a vga
adapter I can boot in 1min.

Why does a normal boot with the nvidia card hang for 3mins (yes, the hd
light just flickers for that long)?

Nothing major but I'd like to know, especially if it can be fixed.

I cannot leave -vga none turned on as the vga adapter grabs up resources
and the nvidia card complains it cannot start due to lack of resources.
I'd love to just add resources if possible and keep both cards running
to get the 1min boot time.

Here is my script:

qemu-system-x86_64 -machine type=3Dq35,accel=3Dkvm -cpu host,kvm=3Doff \
-smp 8,sockets=3D1,cores=3D4,threads=3D2 \
-bios /usr/share/seabios/bios.bin \
-serial none \
-parallel none \
-vga none \
-m 7G \
-mem-prealloc \
-balloon none \
-rtc clock=3Dhost,base=3Dlocaltime \
-device ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chassi=
s=3D1,id=3Droot.1 \
-device vfio-pci,host=3D01:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3Don=
,x-vga=3Don \
-device virtio-scsi-pci,id=3Dscsi \
-drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D/home/bob/qe=
mu/windows7.img \
-drive file=3D/home/bob/qemu/qemu2/virtio-win-0.1.126.iso,id=3Disocd,format=
=3Draw,if=3Dnone -device scsi-cd,drive=3Disocd \
-netdev type=3Dtap,id=3Dnet0,ifname=3Dtap0 \
-device virtio-net-pci,netdev=3Dnet0,mac=3D00:16:3e:00:01:01 \
-usbdevice host:413c:a503 \
-usbdevice host:13fe:3100 \
-usbdevice host:0bc2:ab21 \
-boot menu=3Don \
-boot order=3Dc


Here are my specs:

System:    Host: MSI-GT70-2PE Kernel: 4.8.0-51-generic x86_64 (64 bit gcc: =
5.4.0)
           Desktop: Cinnamon 3.2.7 (Gtk 3.18.9) Distro: Linux Mint 18.1 Ser=
ena
Machine:   Mobo: Micro-Star model: MS-1763 v: REV:0.C Bios: American Megatr=
ends v: E1763IMS.51B date: 01/29/2015
CPU:       Quad core Intel Core i7-4810MQ (-HT-MCP-) cache: 6144 KB
           flags: (lm nx sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx) bmips: 22348
           clock speeds: max: 2801 MHz 1: 2801 MHz 2: 800 MHz 3: 900 MHz 4:=
 900 MHz 5: 900 MHz 6: 1700 MHz
           7: 800 MHz 8: 900 MHz
Graphics:  Card-1: Intel 4th Gen Core Processor Integrated Graphics Control=
ler bus-ID: 00:02.0
           Card-2: NVIDIA GK104M [GeForce GTX 880M] bus-ID: 01:00.0
           Display Server: X.Org 1.18.4 driver: nvidia Resolution: 1920x108=
0@60.00hz
           GLX Renderer: GeForce GTX 880M/PCIe/SSE2 GLX Version: 4.5.0 NVID=
IA 375.66
Direct Rendering: Yes

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: boot nvidia slow windows7

** Tags added: boot nvidia slow windows7

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1698574

Title:
  slow boot windows 7

Status in QEMU:
  New

Bug description:
  Hello,
  I have a nice working qemu with gpu passthrough setup.
  I pass through my nvidia gtx 880m.
  It boots in 4mins 18secs.

  If I remove the "-vga none" switch and allow qemu to create a vga
  adapter I can boot in 1min.

  Why does a normal boot with the nvidia card hang for 3mins (yes, the
  hd light just flickers for that long)?

  Nothing major but I'd like to know, especially if it can be fixed.

  I cannot leave -vga none turned on as the vga adapter grabs up
  resources and the nvidia card complains it cannot start due to lack of
  resources. I'd love to just add resources if possible and keep both
  cards running to get the 1min boot time.

  Here is my script:

  qemu-system-x86_64 -machine type=3Dq35,accel=3Dkvm -cpu host,kvm=3Doff \
  -smp 8,sockets=3D1,cores=3D4,threads=3D2 \
  -bios /usr/share/seabios/bios.bin \
  -serial none \
  -parallel none \
  -vga none \
  -m 7G \
  -mem-prealloc \
  -balloon none \
  -rtc clock=3Dhost,base=3Dlocaltime \
  -device ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chas=
sis=3D1,id=3Droot.1 \
  -device vfio-pci,host=3D01:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3D=
on,x-vga=3Don \
  -device virtio-scsi-pci,id=3Dscsi \
  -drive id=3Ddisk0,if=3Dvirtio,cache=3Dnone,format=3Draw,file=3D/home/bob/=
qemu/windows7.img \
  -drive file=3D/home/bob/qemu/qemu2/virtio-win-0.1.126.iso,id=3Disocd,form=
at=3Draw,if=3Dnone -device scsi-cd,drive=3Disocd \
  -netdev type=3Dtap,id=3Dnet0,ifname=3Dtap0 \
  -device virtio-net-pci,netdev=3Dnet0,mac=3D00:16:3e:00:01:01 \
  -usbdevice host:413c:a503 \
  -usbdevice host:13fe:3100 \
  -usbdevice host:0bc2:ab21 \
  -boot menu=3Don \
  -boot order=3Dc


  Here are my specs:

  System:    Host: MSI-GT70-2PE Kernel: 4.8.0-51-generic x86_64 (64 bit gcc=
: 5.4.0)
             Desktop: Cinnamon 3.2.7 (Gtk 3.18.9) Distro: Linux Mint 18.1 S=
erena
  Machine:   Mobo: Micro-Star model: MS-1763 v: REV:0.C Bios: American Mega=
trends v: E1763IMS.51B date: 01/29/2015
  CPU:       Quad core Intel Core i7-4810MQ (-HT-MCP-) cache: 6144 KB
             flags: (lm nx sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx) bmips: 22=
348
             clock speeds: max: 2801 MHz 1: 2801 MHz 2: 800 MHz 3: 900 MHz =
4: 900 MHz 5: 900 MHz 6: 1700 MHz
             7: 800 MHz 8: 900 MHz
  Graphics:  Card-1: Intel 4th Gen Core Processor Integrated Graphics Contr=
oller bus-ID: 00:02.0
             Card-2: NVIDIA GK104M [GeForce GTX 880M] bus-ID: 01:00.0
             Display Server: X.Org 1.18.4 driver: nvidia Resolution: 1920x1=
080@60.00hz
             GLX Renderer: GeForce GTX 880M/PCIe/SSE2 GLX Version: 4.5.0 NV=
IDIA 375.66
  Direct Rendering: Yes

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1698574/+subscriptions
