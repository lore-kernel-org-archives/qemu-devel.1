Received: from eggs.gnu.org ([2001:4830:134:3::10]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQsDE-0001Ju-8j
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQsD9-0004h2-D8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:59:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQsD9-0004fr-6K
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:59:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQsD7-0002q1-Vb
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:59:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E75312E80CB
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:59:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 09:46:36 -0000
From: Thomas Huth <1486768@bugs.launchpad.net>
Reply-To: Bug 1486768 <1486768@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150819225907.17083.44407.malonedeb@soybean.canonical.com>
Message-Id: <151359039657.17836.13653491025344806339.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1486768] Re: BlackMagic USB3 video capture
 returns only blank frames in Windows (xHCI issue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1486768

Title:
  BlackMagic USB3 video capture returns only blank frames in Windows
  (xHCI issue)

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  I've got an Intensity Shuttle USB3; it's a HDMI video capture card. It
  doesn't have any Linux drivers, so I'm trying to get it to work in a
  Windows 10 guest inside QEMU. I'm running latest git as of today
  (2015-08-20). I use this command line:

  sudo x86_64-softmmu/qemu-system-x86_64 -enable-kvm -smp 2 -m 4096
  -acpitable file=3D/sys/firmware/acpi/tables/MSDM -drive
  file=3D/home/sesse/windows.raw,if=3Dvirtio,format=3Draw -cpu host -netdev
  tap,id=3Dhostnet0 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0
  -monitor stdio -device nec-usb-xhci,id=3Dxhci -device usb-
  host,bus=3Dxhci.0,vendorid=3D0x1edb,productid=3D0xbd3b -usbdevice tablet

  (I will add that the seemingly logical =E2=80=9Chost:1edb:bd3b,bus=3Dxhci=
.0=E2=80=9D did
  _not_ add the device at all. I don't know why, probably some parser
  issue?)

  The card is properly detected, and the driver thinks everything is
  fine, running on the virtualized USB3 host and all. Looking at usbmon,
  there's lots of isochronous frames during capture, and they reach the
  host (looking at USBpcap on the Windows 10 side). However, the driver
  refuses to capture any video=E2=80=94all frames become black in all
  applications I try (well, Media Express seems to hardly store any
  frames at all in the .avi). However, audio is captured without a
  hitch. Curiously enough, no dropped frames are reported. There's no
  sign of CPU shortage; both host and guest seem to be happy around 20%
  of one core.

  I am fairly certain this is an issue with the xHCI driver in QEMU,
  because if I give it the entire USB controller via VT-d, it works
  flawlessly, with video and all. For reference, here's the associated
  command line I use for that (after I've unbound it from the Linux
  system):

  sudo x86_64-softmmu/qemu-system-x86_64 -enable-kvm -smp 2 -m 4096
  -acpitable file=3D/sys/firmware/acpi/tables/MSDM -drive
  file=3D/home/sesse/windows.raw,if=3Dvirtio,format=3Draw -cpu host -netdev
  tap,id=3Dhostnet0 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0
  -monitor stdio  -usbdevice tablet -device pci-assign,host=3D00:14.0

  I can get USB pcap logs from both sides if you want, but they are huge
  (gigabytes) since the data rate is so high.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1486768/+subscriptions
