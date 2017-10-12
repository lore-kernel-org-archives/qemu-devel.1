Received: from eggs.gnu.org ([2001:4830:134:3::10]:44428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2UzP-0004HQ-Gc
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2UzL-0006XD-H6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:20:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:50140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2UzL-0006WW-Bm
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:20:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2UzJ-0007eh-OZ
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 04:20:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AF0BE2E80CB
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 04:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2017 04:12:32 -0000
From: Geoffrey McRae <1722884@bugs.launchpad.net>
Reply-To: Bug 1722884 <1722884@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150774787109.964.13450141235232669497.malonedeb@chaenomeles.canonical.com>
Message-Id: <150778155304.843.8014359061193857659.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1722884] Re: keyboard input while mouse moving
 triggers mouse failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Further to this, it appears to be a race condition with reading from the
i8042 controller. I have turned on debugging of PS2 and KBD and filtered
out the event that causes the issue. I have split the below up to show
the valid reads for the mouse and then the sequence that triggers a
reset when the keyboard is used.

KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x08
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x00
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x02
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x00

KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x18
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0xfe
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x02
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x00

KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x08
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x00
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x01
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x00

KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x1d <-- the status changed on the 2nd call.
KBD: kbd: read status=3D0x1d
KBD: kbd: read data=3D0x9e

KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x18
KBD: kbd: read data=3D0xff <-- two data reads without checking status
KBD: kbd: read status=3D0x3d <-- guest looking for mouse movements
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x02   <-- first byte
KBD: kbd: read status=3D0x3d
KBD: kbd: read status=3D0x3d
KBD: kbd: read data=3D0x00   <-- 2nd byte
KBD: kbd: read status=3D0x1c <-- no more data, there should be two more byt=
es
KBD: kbd: read status=3D0x1c
KBD: kbd: read status=3D0x1c

here the host attempts to reset the device

KBD: kbd: write cmd=3D0xd4   <-- write to mouse cmd
KBD: kbd: read status=3D0x1c
KBD: kbd: read status=3D0x1c
KBD: kbd: read status=3D0x1c
KBD: kbd: write data=3D0xff  <-- reset mouse
kbd: write mouse 0xff

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722884

Title:
  keyboard input while mouse moving triggers mouse failure

Status in QEMU:
  New

Bug description:
  When QEMU is getting a ton of mouse input events if keys are pressed
  on the keyboard the scan code will be corrupted causing erroneous
  behavior. I have confirmed this problem in the latest version in git
  (530049bc1dcc24c1178a29d99ca08b6dd08413e0).

  After the erroneous behavior the operating system issues a keyboard
  reset which prevents the mouse from functioning until the operating
  system is restarted.

  This seems to only occur if the PS2 mouse is being used as the input,
  the tablet input device doesn't exhibit this behavior.

  The same problem was reported here also:
  https://openxt.atlassian.net/browse/OXT-562

  Host  : Debian 9
  CPU   : Ryzen 1700X
  RAM   : 16GB
  Kernel: 4.12.0-0.bpo.2-amd64

  Guest : Windows 10 (KVM)
  RAM   : 8GB (1GB Huge pages)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722884/+subscriptions
