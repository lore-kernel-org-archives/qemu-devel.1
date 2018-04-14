Received: from eggs.gnu.org ([2001:4830:134:3::10]:52581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7O8d-0000nu-B8
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 12:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7O8Z-0005MB-D9
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 12:34:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:46686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f7O8Z-0005Kq-6o
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 12:34:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f7O8W-0006DE-UQ
	for <qemu-devel@nongnu.org>; Sat, 14 Apr 2018 16:34:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DBF3A2E8023
	for <qemu-devel@nongnu.org>; Sat, 14 Apr 2018 16:34:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Apr 2018 16:23:43 -0000
From: Christian Bohr <christian_bohr@web.de>
Reply-To: Bug 1191326 <1191326@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130615151015.21597.4187.malonedeb@chaenomeles.canonical.com>
Message-Id: <152372302338.31030.3418442863734481570.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1191326] Re: QNX 4 doesn't boot on qemu >= 1.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I had the same problem, and maybe it can help. I wrote my own toy OS
with a PATA / IDE driver back in 2012 using older version of QEMU and
everything worked fine. These days, I tried that on a recent version
(2.5) and it failed with exactly the same behaviour - lots of zeros
being written during a DMA transfer.

After some research, I found that the behaviour that was changed with
1.3 is that the bus master configuration bit (bit 2 of the PCI command
register) is now emulated, and my driver did not set this bit.
Apparently, the BIOS does not set it either, so it was off and the DMA
transfer silently failed and only wrote zeros.

So I added some code to my init routine that sets this bit, and voila -
it worked. I have tried 1.2, 1.3 and 2.5.0 and this works with all of
them.

I do not know the internals of QNX, but I learned that apparently also
Linux did not set this bit in older version, so it might very well be
that QNX does not set it either and this is the issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1191326

Title:
  QNX 4 doesn't boot on qemu >=3D 1.3

Status in QEMU:
  Confirmed

Bug description:
  I am using virtual machine with QNX4 operating system installed on it.  I=
 updated my qemu from version
  to newer and QNX4 doesn't start any more. All is ok on version 1.2 but wh=
en I try to use any newer version
  (1.3, 1.4, 1.5)  QNX4 doesn't boot.  I tried on windows and linux ubuntu =
hosts - effects are the same.

  When virtual machine boots qnx bootloader loads and starts operating syst=
em. In the next step
  qnx starts its ide driver, which detects qemu harddisk and cdrom. Problem=
 starts when operating system
  tries mount partition - an error occur and qnx stop booting procedure:

  mount -p "No bios signature in partition sector on /dev/hd0"

  I have tried install qnx from cdrom but it seems that there is the same p=
roblem. QNX installer boot from
  cdrom, detects hard disk and cdrom, but cdrom can't be mounted in the nex=
t step of installation procedure.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1191326/+subscriptions
