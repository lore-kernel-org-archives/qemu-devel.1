Received: from eggs.gnu.org ([2001:4830:134:3::10]:35611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNCSO-0001YD-6U
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNCSL-0003rJ-0O
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fNCSK-0003q3-Q3
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fNCSJ-0004zk-6h
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2E6DB2E80C7
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 May 2018 07:14:28 -0000
From: mou <arnaudalies.py@gmail.com>
Reply-To: Bug 1773743 <1773743@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152749166822.25806.7057935660205888607.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1773743] [NEW] qemu-user -g xxx -E LD_PROFILE=xxx
 segfault
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

Here is two simple steps to reproduce the bug:

$ qemu-x86_64 -E LD_PROFILE=3Dlibc.so.6 -E LD_PROFILE_OUTPUT=3D. -g 12345 -L
/ /bin/ls

(libc.so and /bin/ls might change on your system, in this case we just
need a binary with a profilable needed library)

In a other window launch:

$ gdb
(gdb) target remote :12345
(gdb) c

At this point qemu will segfault.

It seems this problem is appends when sigprof passed to gdb.
One way I have found to bypass this:
patch gdbstub.c gdb_handlesig and ignore sig if
sig =3D=3D TARGET_SIGPROF
(which means now I can't catch sigprof on gdb anymore)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1773743

Title:
  qemu-user -g xxx -E LD_PROFILE=3Dxxx segfault

Status in QEMU:
  New

Bug description:
  Here is two simple steps to reproduce the bug:

  $ qemu-x86_64 -E LD_PROFILE=3Dlibc.so.6 -E LD_PROFILE_OUTPUT=3D. -g 12345
  -L / /bin/ls

  (libc.so and /bin/ls might change on your system, in this case we just
  need a binary with a profilable needed library)

  In a other window launch:

  $ gdb
  (gdb) target remote :12345
  (gdb) c

  At this point qemu will segfault.

  It seems this problem is appends when sigprof passed to gdb.
  One way I have found to bypass this:
  patch gdbstub.c gdb_handlesig and ignore sig if
  sig =3D=3D TARGET_SIGPROF
  (which means now I can't catch sigprof on gdb anymore)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1773743/+subscriptions
