Received: from eggs.gnu.org ([2001:4830:134:3::10]:41032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbPt0-0003iJ-L6
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbPsv-0004H5-OQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:56466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbPsv-0004GF-GT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbPst-00065r-3B
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 12:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0A25E2E819D
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 12:24:22 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1779955 <1779955@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153065712229.13372.17157400567540509420.malonedeb@gac.canonical.com>
Message-Id: <153087986302.13074.4678012762204451950.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779955] Re: qemu-arm-static read() doesn't
 accept mmap address as destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The problem here is not the mmap(), it is that you are mapping it as
only PROT_WRITE and not also PROT_READ. With the native kernel, syscalls
which only write to a buffer and do not read from it (like read(2)) only
require write permissions on that memory. QEMU's implementation requires
both write and read permission.

This is a QEMU bug, but not a major one, because in practice no guest
binaries set up memory that is only writable and can't be read (what
would they do with the data that they wrote into that memory?). You can
work around it in your test program by using mmap(..., PROT_READ |
PROT_WRITE, ...), which will allow it to work in QEMU.

(Technical QEMU internal notes for other developers: the issue here is
that we do permissions checks in syscall.c using lock_user(VERIFY_WRITE,
...) etc, but in access_ok() we treat VERIFY_WRITE as "implies read
access" when we're choosing the permissions flags to pass to
page_check_range(). To fix this we would have to check all the places we
use VERIFY_WRITE to identify which should be "only need write" and which
are "need both read and write".)


** Summary changed:

- qemu-arm-static read() doesn't accept mmap address as destination
+ qemu linux-user requires read permissions on memory passed to syscalls th=
at should only need write access

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779955

Title:
  qemu linux-user requires read permissions on memory passed to syscalls
  that should only need write access

Status in QEMU:
  Confirmed

Bug description:
  When read() function takes an mmap'ed address as output buffer, it
  returns EFAULT. The expected behavior is it should just work.

  The following code works for qemu-system-arm, but not for qemu-arm-
  static.

  QEMU version affected: latest release 2.12.0.

  Steps to reproduce (please substitute /path/to/qemu-arm-static with
  the path of the binary, and /tmp/a.cpp with the example source code
  attached):

  # First register binfmt_misc
  [hidden]$ docker run --rm --privileged multiarch/qemu-user-static:registe=
r --reset

  # Compile the code and run
  [hidden]$ docker run --rm -it -v /tmp/a.cpp:/tmp/a.cpp -v /path/to/qemu-a=
rm-static:/usr/bin/qemu-arm-static arm32v7/ubuntu:18.04 bash -c '{ apt upda=
te -y && apt install -y g++; } >& /dev/null && g++ -std=3Dc++14 /tmp/a.cpp =
-o /tmp/a.out && echo hehe > /tmp/haha.txt && /tmp/a.out'
  ofd=3D3
  ftruncate=3D0
  mmap=3D0xff3f5000
  fd=3D4
  0xff3f5023 -1 14

  The expected result in qemu-system-arm as well as natively on x86_64 host:
  hidden$ ./a.out
  ofd=3D3
  ftruncate=3D0
  mmap=3D0xb6fb7000
  fd=3D4
  0xb6fb7023 5 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779955/+subscriptions
