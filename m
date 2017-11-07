Received: from eggs.gnu.org ([2001:4830:134:3::10]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9V7-0006ud-C2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC9V2-0007mO-A6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:25:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:49164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC9V2-0007m4-3C
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:25:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC9V0-0005KQ-NG
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 19:25:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AD03A2E80C7
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 19:25:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 19:10:37 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1156313 <1156313@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130317193406.10807.11580.malonedeb@wampee.canonical.com>
Message-Id: <151008183758.4552.14214222790503931677.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1156313] Re: X86-64 flags handling broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It looks from this bug that we fixed the initial ADOX bug in commit
c53de1a2896cc (2013), and I've just tried the 'qemu-denorm-problem.s'
test case from comment #1 and it works OK, so I think we've fixed that
denormals bug too. Given that, and that this bug report is 4 years old,
I'm going to close it. If you're still having problems with recent
versions of QEMU, please open a new bug.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1156313

Title:
  X86-64 flags handling broken

Status in QEMU:
  Fix Released

Bug description:
  The current qemu sources cause improper handling of flags on x86-64.
  This bug seems to have shown up a few weeks ago.

  A plain install of Debian GNU/Linux makes user processes catch
  spurious signals.  The kernel seems to run stably, though.

  The ADX feature works very poorly.  It might be related; at least it
  allows for reproducibly provoking invalid behaviour.

  Here is a test case:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  qemumain.c
  #include <stdio.h>
  long adx();
  int
  main ()
  {
    printf ("%lx\n", adx (0xffbeef, 17));
    return 0;
  }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  qemuadx.s:
          .globl  adx
  adx:    xor     %rax, %rax
  1:      dec     %rdi
          jnz     1b
          .byte 0xf3, 0x48, 0x0f, 0x38, 0xf6, 0xc0        # adox  %rax, %rax
          .byte 0x66, 0x48, 0x0f, 0x38, 0xf6, 0xc0        # adcx  %rax, %rax
          ret
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Compile and execute:
  $ gcc -m64 qemumain.c qemuadx.s
  $ a.out
  ffffff8000378cd8

  Expected output is simply "0".  The garbage value varies between qemu
  compiles and guest systems.

  Note that one needs a recent GNU assembler in order to handle adox and
  adcx.  For convenience I have supplied them as byte sequences.

  Exaplanation and feeble analysis:

  The 0xffbeef argument is a loop count.  It is necessary to loop for a
  while in order to trigger this bug.  If the loop count is decreased,
  the bug will seen intermittently; the lower the count, the less
  frequent the invalid behaviour.

  It seems like a reasonable assumption that this bug is related to
  flags handling at context switch.  Presumably, qemu keeps flags state
  in some internal format, then recomputes then when needing to form the
  eflags register, as needed for example for context switching.

  I haven't tried to reproduce this bug using qemu-x86_64 and SYSROOT,
  but I strongly suspect that to be impossible.  I use
  qemu-system-x86_64 and the guest Debian GNU/Linux x86_64 (version
  6.0.6) .

  The bug happens also with the guest FreeBSD x86_64 version 9.1.  (The
  iteration count for triggering the problem 50% of the runs is not the
  same when using the kernel Linux and FreeBSD's kernel, presumably due
  to different ticks.)

  The bug happens much more frequently for a loaded system; in fact, the
  loop count can be radically decreased if two instances of the trigger
  program are run in parallel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1156313/+subscriptions
