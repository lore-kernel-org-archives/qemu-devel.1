Received: from eggs.gnu.org ([2001:4830:134:3::10]:58800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQs84-0006rM-23
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQs7z-0006id-4S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:54:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQs7y-0006i7-S4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:54:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQs7x-00028F-Nw
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:54:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A379D2E80D1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:54:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 09:43:57 -0000
From: Thomas Huth <1373228@bugs.launchpad.net>
Reply-To: Bug 1373228 <1373228@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140924050719.32220.61692.malonedeb@gac.canonical.com>
Message-Id: <151359023741.19292.16772146843203235556.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1373228] Re: Crash upon adding a USB device in
 Windows 7 (64-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7da76e12c

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1373228

Title:
  Crash upon adding a USB device in Windows 7 (64-bit)

Status in QEMU:
  Fix Released

Bug description:
  Command line:

  qemu-system-x86_64 -cpu host -smp cores=3D2,threads=3D2 -boot menu=3Don -m
  6144 -soundhw ac97 -drive file=3Dwin7.raw,if=3Dvirtio -cdrom virtio-
  win-0.1-81.iso -vga qxl -usb -device nec-usb-xhci,id=3Dxhci -spice
  port=3D5924,disable-ticketing -device virtio-serial -chardev
  spicevmc,id=3Dvdagent,name=3Dvdagent -device
  virtserialport,chardev=3Dvdagent,name=3Dcom.redhat.spice.0 -monitor stdio
  -enable-kvm

  QEMU version:

  git master branch (QEMU emulator version 2.1.50, commit hash:
  769188d3bbf95ce8d96a335624234dad083f4db6)

  This happens when I plug in the USB flash drive (or any other USB
  device, just using the flash drive for testing) and run the following
  command in the QEMU command-line:

  (qemu) device_add usb-host,vendorid=3D0x12f7,productid=3D0x1a00,bus=3Dxhc=
i.0
  (qemu) qemu-system-x86_64: /var/tmp/portage/app-emulation/qemu-9999/work/=
qemu-9999/hw/usb/hcd-xhci.c:897: xhci_events_update: Assertion `intr->er_fu=
ll' failed.

  Then, QEMU just crashes/dies.

  Meanwhile, dmesg shows this:

  [ 3444.894865] usb 1-2: new high-speed USB device number 8 using xhci_hcd
  [ 3445.063285] usb 1-2: New USB device found, idVendor=3D12f7, idProduct=
=3D1a00
  [ 3445.063288] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
  [ 3445.063290] usb 1-2: Product: Flashdrive 601B =

  [ 3445.063291] usb 1-2: Manufacturer: Memorex =

  [ 3445.063292] usb 1-2: SerialNumber: 076A122122DB
  [ 3445.063854] usb-storage 1-2:1.0: USB Mass Storage device detected
  [ 3445.063923] scsi host3: usb-storage 1-2:1.0
  [ 3446.068031] scsi 3:0:0:0: Direct-Access     Memorex  Flashdrive 601B  =
PMAP PQ: 0 ANSI: 0 CCS
  [ 3446.499830] sd 3:0:0:0: [sdd] 977664 512-byte logical blocks: (500 MB/=
477 MiB)
  [ 3446.500005] sd 3:0:0:0: [sdd] Write Protect is off
  [ 3446.500008] sd 3:0:0:0: [sdd] Mode Sense: 23 00 00 00
  [ 3446.500138] sd 3:0:0:0: [sdd] No Caching mode page found
  [ 3446.500141] sd 3:0:0:0: [sdd] Assuming drive cache: write through
  [ 3446.501591]  sdd: sdd1
  [ 3446.502321] sd 3:0:0:0: [sdd] Attached SCSI removable disk
  [ 3535.501320] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3535.501348] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3535.501350] usb 1-2: hub failed to enable device, error -22
  [ 3535.654313] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3535.654347] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3535.654349] usb 1-2: hub failed to enable device, error -22
  [ 3535.807428] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3535.820755] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b5569c0
  [ 3535.820757] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b556a08
  [ 3536.016706] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3536.016737] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3536.016739] usb 1-2: hub failed to enable device, error -22
  [ 3536.169702] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3536.169737] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3536.169738] usb 1-2: hub failed to enable device, error -22
  [ 3536.322817] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3536.336160] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b5569c0
  [ 3536.336162] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b556a08
  [ 3536.532116] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3536.532144] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3536.532146] usb 1-2: hub failed to enable device, error -22
  [ 3536.685090] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3536.685125] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3536.685126] usb 1-2: hub failed to enable device, error -22
  [ 3536.838204] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3536.851539] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b5569c0
  [ 3536.851541] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b556a08
  [ 3542.168509] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3542.168531] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3542.168535] usb 1-2: hub failed to enable device, error -22
  [ 3542.321423] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3542.321445] xhci_hcd 0000:00:14.0: Setup ERROR: setup context command =
for slot 9.
  [ 3542.321449] usb 1-2: hub failed to enable device, error -22
  [ 3542.474538] usb 1-2: reset high-speed USB device number 8 using xhci_h=
cd
  [ 3542.488160] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b5569c0
  [ 3542.488164] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with=
 disabled ep ffff88045b556a08

  For good measure, here is lspci -nn from the host:

  00:00.0 Host bridge [0600]: Intel Corporation Haswell-ULT DRAM Controller=
 [8086:0a04] (rev 09)
  00:02.0 VGA compatible controller [0300]: Intel Corporation Device [8086:=
0a2e] (rev 09)
  00:03.0 Audio device [0403]: Intel Corporation Haswell-ULT HD Audio Contr=
oller [8086:0a0c] (rev 09)
  00:14.0 USB controller [0c03]: Intel Corporation 8 Series USB xHCI HC [80=
86:9c31] (rev 04)
  00:16.0 Communication controller [0780]: Intel Corporation 8 Series HECI =
#0 [8086:9c3a] (rev 04)
  00:1b.0 Audio device [0403]: Intel Corporation 8 Series HD Audio Controll=
er [8086:9c20] (rev 04)
  00:1c.0 PCI bridge [0604]: Intel Corporation 8 Series PCI Express Root Po=
rt 1 [8086:9c10] (rev e4)
  00:1c.1 PCI bridge [0604]: Intel Corporation 8 Series PCI Express Root Po=
rt 2 [8086:9c12] (rev e4)
  00:1c.2 PCI bridge [0604]: Intel Corporation 8 Series PCI Express Root Po=
rt 3 [8086:9c14] (rev e4)
  00:1c.4 PCI bridge [0604]: Intel Corporation 8 Series PCI Express Root Po=
rt 5 [8086:9c18] (rev e4)
  00:1c.5 PCI bridge [0604]: Intel Corporation 8 Series PCI Express Root Po=
rt 6 [8086:9c1a] (rev e4)
  00:1f.0 ISA bridge [0601]: Intel Corporation 8 Series LPC Controller [808=
6:9c43] (rev 04)
  00:1f.3 SMBus [0c05]: Intel Corporation 8 Series SMBus Controller [8086:9=
c22] (rev 04)
  02:00.0 Multimedia controller [0480]: Broadcom Corporation Device [14e4:1=
570]
  03:00.0 Network controller [0280]: Broadcom Corporation BCM4360 802.11ac =
Wireless Network Adapter [14e4:43a0] (rev 03)
  04:00.0 SATA controller [0106]: Samsung Electronics Co Ltd Apple PCIe SSD=
 [144d:1600] (rev 01)
  05:00.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
  06:00.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
  06:03.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
  06:04.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
  06:05.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
  06:06.0 PCI bridge [0604]: Intel Corporation Device [8086:156d]
  07:00.0 System peripheral [0880]: Intel Corporation Device [8086:156c]

  Please let me know what other information you need and I'll try to
  provide it.

  Many thanks,
  uriah

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1373228/+subscriptions
