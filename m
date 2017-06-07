Received: from eggs.gnu.org ([2001:4830:134:3::10]:50728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIScT-0001Wz-7I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIScR-0007Uz-Ro
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:49268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIScR-0007UB-M8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 00:30:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIScP-0003zJ-Uq
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 04:30:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 57A892E81A8
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 04:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2017 04:17:32 -0000
From: Launchpad Bug Tracker <1073952@bugs.launchpad.net>
Reply-To: Bug 1073952 <1073952@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121101133028.9986.85821.malonedeb@wampee.canonical.com>
Message-Id: <149680905287.16952.8788928015113451628.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1073952] Re: data sent to serial interface gets
 truncated after 64kb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1073952

Title:
  data sent to serial interface gets truncated after 64kb

Status in QEMU:
  Expired

Bug description:
  When sending more than 64kb of data to the serial interface in a short
  timespan, the data seems to disappear.

  I tested it with the latest release (qemu-kvm-1.2.0-rc2.tar.gz) where
  the bug still occurs. I stumbled upon it when I upraged my qemu
  version. The bug did not occur in the last version i had (0.12.5).

  You can reproduce it as follows:

  1. Start a dd or cat command in one terminal and pipe the output to a
  netcat. The testfile has to be larger than 64kb. I used one that had
  93kb and did contain only ascii text.

       $ dd if=3D<TESTFILE> | nc -l 127.0.0.1 65432
       or
       $ cat <TESTFILE> | nc -l 127.0.0.1 65432

  2. Start a qemu and let the first serial port connect to the listening
  netcat. I suppose that the testsystem can be any system that does not
  read from the serial port on its own (e.g. during boot process). I
  used a self compiled minimal linux.

       $ qemu -cdrom <TESTSYSTEM> -serial tcp:127.0.0.1:65432

  3. When the testsystem is booted, read from the serial device and
  write it to a file.

       $ dd if=3D/dev/ttyS0 of=3D/tmp/testFile
       or
       $ cat /dev/ttyS0 > /tmp/testFile

  =

  The result in almost all of my testruns is, that the /tmp/testFile does o=
nly has the size of 64kb. The rest of the data vanished. In some cases the =
file was slightly bigger (65kb or 67kb) but allways under 70kb. The complet=
e file (93kb) was not trasmitted in any of the runs.

  I hope my explanation is exactly enough for you to reproduce it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1073952/+subscriptions
