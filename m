Received: from eggs.gnu.org ([209.51.188.92]:36701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGFVV-00053P-Bl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGFVT-0007AW-Cq
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:15:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:43426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGFVR-00078o-Gb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 00:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGFVO-000222-R5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 04:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9085C2E80CB
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 04:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Apr 2019 04:01:16 -0000
From: Richard Henderson <rth@twiddle.net>
Reply-To: Bug 1824853 <1824853@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155534806981.13632.6401186723464432088.malonedeb@gac.canonical.com>
Message-Id: <155538727676.8124.13231873298190691578.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1824853] Re: 4.0.0-rc3 crashes with
 tcg/tcg.c:3952: tcg_gen_code: Assertion `s->gen_insn_end_off[num_insns] ==
 off' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Returning -1 does not help because all that signals that the buffer is full.
We then flush the buffer and try again, assuming the at the buffer will not=
 fill.
Given that the buffer is usually many megabytes, this is reasonable.

We need something different to signal that the buffer is not full, but that
another offset has overflowed.

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
       Status: Confirmed =3D> In Progress

** Changed in: qemu
     Assignee: (unassigned) =3D> Richard Henderson (rth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824853

Title:
  4.0.0-rc3 crashes with tcg/tcg.c:3952: tcg_gen_code: Assertion
  `s->gen_insn_end_off[num_insns] =3D=3D off' failed

Status in QEMU:
  In Progress

Bug description:
  I tried to bootstrap and regtested gcc trunk (gcc svn rev 270278,
  datestamp 20190411) inside my arm64-gentoo installation under qemu-
  system-aarch64.

  Qemu version was 4.0.0-rc3 and -cpu cortex-a57. Qemu configured with
  only --target-list=3Daarch64-softmmu,aarch64-linux-user and compiled
  using gcc "version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1~16.04)".

  Executable created from gcc/testsuite/gcc.target/aarch64/advsimd-
  intrinsics/vldX.c compiled with -O2 crashed the whole qemu-system.

  To investigate a bit I also manually run
  ~/gcc/inst/trunk/bin/gcc ~/gcc/src/trunk/gcc/testsuite/gcc.target/aarch64=
/advsimd-intrinsics/vldX.c
  with different options like:
  -O0 -lm -o d0.exe
  -O1 -lm -o d1.exe
  -O2 -lm -o d2.exe
  -O0 -static -lm -o s0.exe
  -O1 -static -lm -o s1.exe
  -O2 -static -lm -o s2.exe

  So, now I have 6 different arm64 executables created with different optim=
ization levels. O0 and O1 versions run ok.
  Three sN.exe static executables I've also tried in qemu user mode (with s=
ame -cpu), no issue in user mode.

  And inside qemu-system I can see that
  running "d2.exe" (attached) gives:
  tcg/tcg.c:3952: tcg_gen_code: Assertion `s->gen_insn_end_off[num_insns] =
=3D=3D off' failed.

  And running "s2.exe" gives:
  tcg/tcg.c:320: set_jmp_reset_offset: Assertion `s->tb_jmp_reset_offset[wh=
ich] =3D=3D off' failed.

  It seems like this test is an counter-example for logic that
  "tcg_ctx->nb_ops < 4000" implies tcg will fit into 16-bit signed size
  (see tcg_op_buf_full comments).

  Richard's changes in abebf92597186 and 9f754620651d were not enough, tran=
slation block must be smaller, or we have to find some proper way to bail o=
ut when buffer overflows.
  I don't know why this situation is not caught by code_gen_highwater logic=
 in tcg.c

  I've also tried this "bail out" patch

  diff --git a/tcg/tcg.c b/tcg/tcg.c
  --- a/tcg/tcg.c
  +++ b/tcg/tcg.c
  @@ -3949,7 +3949,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *t=
b)
                   size_t off =3D tcg_current_code_size(s);
                   s->gen_insn_end_off[num_insns] =3D off;
                   /* Assert that we do not overflow our stored offset.  */
  -                assert(s->gen_insn_end_off[num_insns] =3D=3D off);
  +                if (s->gen_insn_end_off[num_insns] !=3D off)
  +                  return -1;
               }
               num_insns++;
               for (i =3D 0; i < TARGET_INSN_START_WORDS; ++i) {

  But then running "d2.exe" just hangs the whole qemu-system. It seems
  that when tcg_gen_code return -1 (like in highwater logic mentioned
  before), we just re-call it again and again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824853/+subscriptions
