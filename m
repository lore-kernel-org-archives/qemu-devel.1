Received: from eggs.gnu.org ([2001:4830:134:3::10]:36665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfQ0-0000oM-FZ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfPz-0003kv-8c
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:50054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBfPy-0003kj-SL
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:45:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBfPx-0002fn-CZ
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8F9E12E80C9
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 10:30:52 -0000
From: Thomas Huth <1198350@bugs.launchpad.net>
Reply-To: Bug 1198350 <1198350@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130705221111.16044.84094.malonedeb@chaenomeles.canonical.com>
Message-Id: <149518985270.11750.4171733921340715462.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1198350] Re: USB pass-through fails with
 USBDEVFS_DISCONNECT: Invalid argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (currently v2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1198350

Title:
  USB pass-through fails with USBDEVFS_DISCONNECT: Invalid argument

Status in QEMU:
  Incomplete

Bug description:
  Host Gentoo linux 32bit
  Guest Windows XP SP3
  qemu 1.4.2 and
  qemu fresh get clone and build 2013-07-04 (version1.5.50)
  qemu command line

  qemu-system-i386 -enable-kvm localtime -m 2047 -boot d
  /archive3/qemu/WindowsXP.img -net nic,model=3Drtl8139 -net user -usb
  -device usb-ehci,id=3Dehci -usbdevice host:1493:19

  The device I am trying to use with the guest is an interface for the
  Suunto Ambit 2 GPS watch which has no linux support.

  When the USB device is plugged in qemu reports to the command line:

  USBDEVFS_DISCONNECT: Invalid argument
  Invalid argument

  dmesg shows

  [237755.495968] usb 2-1.5: new full-speed USB device number 34 using ehci=
-pci
  [237755.582778] usb 2-1.5: config 1 has an invalid interface number: 1 bu=
t max is 0
  [237755.582781] usb 2-1.5: config 1 has no interface number 0
  [237755.583628] usb 2-1.5: New USB device found, idVendor=3D1493, idProdu=
ct=3D0019
  [237755.583631] usb 2-1.5: New USB device strings: Mfr=3D1, Product=3D2, =
SerialNumber=3D3
  [237755.583633] usb 2-1.5: Product: Ambit
  [237755.583634] usb 2-1.5: Manufacturer: Suunto
  [237755.583636] usb 2-1.5: SerialNumber: CE83095110000700
  [237756.584937] usb 2-1.5: reset full-speed USB device number 34 using eh=
ci-pci
  [237756.832658] usb 2-1.5: reset full-speed USB device number 34 using eh=
ci-pci
  [237757.143585] usb 2-1.5: usbfs: process 12684 (qemu-system-i38) did not=
 claim interface 1 before use

  In the windows guest Device Manager a HID device is listed but nothing
  else happens, no found new hardware dialog or the Suunto software
  (which is sitting there waiting) is not triggered as it should be.

  I have tried successfully with several other devices (flash drive,
  mouse, printer and video capture device). Because this device pretends
  to be an HID device my kernel's hid-generic driver was picking it up
  first until I modified hid-core.c to ignore this vendorid/productid.
  But still no joy.

  I'm guessing it has something to do with the the dmesg lines:

  [237755.582778] usb 2-1.5: config 1 has an invalid interface number: 1 bu=
t max is 0
  [237755.582781] usb 2-1.5: config 1 has no interface number 0

  But read that these warnings are not important though I don't get them
  for other devices. Nor do I get:

  [237757.143585] usb 2-1.5: usbfs: process 12684 (qemu-system-i38) did
  not claim interface 1 before use

  I've done alot of searching and I've run out of ideas. Any help would
  be great.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1198350/+subscriptions
