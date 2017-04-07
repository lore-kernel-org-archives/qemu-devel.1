Received: from eggs.gnu.org ([2001:4830:134:3::10]:50497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW2-0003Vq-NU
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUW1-0000W8-JR
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:43270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUW1-0000VY-CO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:05:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUVz-0003Qr-Ol
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 14:05:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BA6F62E80CA
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:05:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:51:52 -0000
From: Thomas Huth <1073952@bugs.launchpad.net>
Reply-To: Bug 1073952 <1073952@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121101133028.9986.85821.malonedeb@wampee.canonical.com>
Message-Id: <20170407135152.12807.53120.malone@gac.canonical.com>
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

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1073952

Title:
  data sent to serial interface gets truncated after 64kb

Status in QEMU:
  Incomplete

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
