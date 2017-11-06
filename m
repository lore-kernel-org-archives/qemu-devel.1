Received: from eggs.gnu.org ([2001:4830:134:3::10]:47863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBlP4-0004AP-DA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBlP0-0000GV-7V
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:41:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:40024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBlP0-0000G5-0P
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:41:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBlOy-00033O-3H
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 17:41:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B59C2E80D7
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 17:41:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 17:33:10 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1705118 <1705118@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150041005567.6544.17518405784140614257.malonedeb@gac.canonical.com>
Message-Id: <150998959032.4653.16108094323125875858.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1705118] Re: qemu user mode does not support
 catching SIGSEGV on some architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an interesting collection of different bugs:
 * s390x is missing masking operations, as you describe
 * ppc is passing the PC of the offending insn, not the data address, into =
si_addr
 * sparc fails to record the address of a data fault and so passes 0 into s=
i_addr
 * sparc also isn't implementing rt_sigaction correctly and so the calls in=
 your test program fail EINVAL (your test program doesn't check the return =
value from sigaction, so it ploughs ahead and makes the faulting data acces=
s with the SIG_DFL behaviour for SEGV, hence the uncaught SEGV).

I'm putting together some patches for these.


** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1705118

Title:
  qemu user mode does not support catching SIGSEGV on some architectures

Status in QEMU:
  Confirmed

Bug description:
  The documentation
  <https://qemu.weilnetz.de/doc/qemu-doc.html#Features> says that
  qemu in user mode supports POSIX signal handling.

  Catching SIGSEGV according to POSIX, however, does not work on
    ppc, ppc64, ppc64le, s390x, sparc64.
  It does work, however, on
    aarch64, alpha, arm, hppa, m68k, mips, mips64, sh4.

  How to reproduce:
  The attached program runs fine (exits with code 0) on
    - real hardware Linux/PowerPC64 (in 32-bit and 64-bit mode),
    - real hardware Linux/PowerPC64LE,
    - qemu-system-s390x emulated Linux/s390x,
    - real hardware Linux/SPARC64.
  $ gcc -O -Wall testsigsegv.c; ./a.out; echo $?
  0

  For ppc:
  $ powerpc-linux-gnu-gcc-5 -O -Wall -static testsigsegv.c -o testsigsegv-p=
pc
  $ ~/inst-qemu/2.9.0/bin/qemu-ppc testsigsegv-ppc
  $ echo $?
  3

  For ppc64:
  $ powerpc64-linux-gnu-gcc-5 -O -Wall -static testsigsegv.c -o testsigsegv=
-ppc64
  $ ~/inst-qemu/2.9.0/bin/qemu-ppc64 testsigsegv-ppc64
  $ echo $?
  3

  For ppc64le:
  $ powerpc64le-linux-gnu-gcc-5 -O -Wall -static testsigsegv.c -o testsigse=
gv-ppc64le
  $ ~/inst-qemu/2.9.0/bin/qemu-ppc64le testsigsegv-ppc64le
  $ echo $?
  3

  For s390x:
  $ s390x-linux-gnu-gcc-5 -O -Wall -static testsigsegv.c -o testsigsegv-s39=
0x
  $ ~/inst-qemu/2.9.0/bin/qemu-s390x testsigsegv-s390x
  $ echo $?
  3
  $ s390x-linux-gnu-gcc-5 -O -Wall -static testsigsegv.c -DAVOID_LINUX_S390=
X_COMPAT -o testsigsegv-s390x-a
  $ ~/inst-qemu/2.9.0/bin/qemu-s390x testsigsegv-s390x-a
  $ echo $?
  0
  So, the test fails here because the Linux/s390x kernel omits the least
  significant 12 bits of the fault address in the 'si_addr' field. But
  qemu-s390x is not compatible with the Linux/s390x behaviour: it puts
  the complete fault address in the 'si_addr' field.

  For sparc64:
  $ sparc64-linux-gnu-gcc-5 -O -Wall -static testsigsegv.c -o testsigsegv-s=
parc64
  $ ~/inst-qemu/2.9.0/bin/qemu-sparc64 testsigsegv-sparc64
  Segmentation fault (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1705118/+subscriptions
