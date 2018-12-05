Received: from eggs.gnu.org ([2001:4830:134:3::10]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUVKe-0002Qz-HT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUVKX-0001WJ-6i
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:27:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gUVKW-0001Td-Vs
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:27:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gUVKT-0002ka-5J
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:26:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7512E2E80D8
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 11:26:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Dec 2018 11:06:36 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1364501 <1364501@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140902163848.4037.99496.malonedeb@soybean.canonical.com>
Message-Id: <154400799757.26298.14592356957580172975.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1364501] Re: Gdb hangs when trying to single-step
 after an invalid instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags added: gdbstub

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1364501

Title:
  Gdb hangs when trying to single-step after an invalid instruction

Status in QEMU:
  Triaged

Bug description:
  When using Gdb to remote-debug a program and manually setting its PC
  to point to an address containing an invalid instruction and then
  doing a single step, Qemu will never return control to the remote Gdb.

  For instance, let's say address 0x114 contains an invalid instruction.
  On the remote Gdb, we'd do:

  (gdb) set $pc =3D 0x114
  (gdb) stepi

  After doing that we won't get the (gdb) prompt unless we do a Ctrl-C.
  If we do so we'll be left at 0x114 instead of going towards the
  exception handler as we should. This happens with stepi, step and
  next. If instead of single-stepping we used continue, the program will
  proceed into the exception handler as it should.

  The reason this is happening is that when Qemu realizes it's about to
  translate an instruction it doesn't recognize it'll generate a call to
  helper_exception_with_syndrome(), which will register the exception
  and then call cpu_loop_exit(). At the same time, because we're doing a
  single-step, Qemu will also generate a call to
  helper_exception_internal() passing it an EXCP_DEBUG, which lets the
  system know it'll give control back to the remote debugger, and it
  also ends with a call to cpu_loop_exit(). However, because the
  syndrome exception calls cpu_loop_exit() first, the call to the
  internal exception won't be reached and Qemu will be stuck in a loop
  without returning control to the remote debugger.

  What makes this a bit tricky to fix is that we must call
  cpu_loop_exit() at the end of helper_exception_with_syndrome(),
  otherwise the target exception will go undetected and its handler
  won't be excecuted.

  Tested on latest head by emulating a Stellaris lm3s6965 board and
  running RTEMS 4.11:

  $ qemu-system-arm -nographic -s -S -M lm3s6965evb -kernel my_rtems_app

  Commit hash in qemu.git: 30eaca3acdf17d7bcbd1213eb149c02037edfb0b

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1364501/+subscriptions
