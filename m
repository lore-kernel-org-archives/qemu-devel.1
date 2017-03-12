Received: from eggs.gnu.org ([2001:4830:134:3::10]:44647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cn1Tn-0003I7-8w
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cn1Ti-00006R-AQ
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:16:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:52308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cn1Th-00005e-UZ
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:15:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cn1Tf-0001bX-Tc
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 11:15:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DC6F42E80C0
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 11:15:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Mar 2017 11:03:11 -0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reply-To: Bug 597362 <597362@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100622173200.15537.61592.malonedeb@gandwana.canonical.com>
Message-Id: <20170312110311.25214.27684.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 597362] Re: qemu-system-sparc singlestep not work
 in gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm sure this has been fixed years ago (and qemu-system-sparc single-
step seems fine in local tests) so I'm marking this as "Fix released".


** Changed in: qemu
       Status: Expired =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/597362

Title:
  qemu-system-sparc singlestep not work in gdbstub

Status in QEMU:
  Fix Released

Bug description:
  Debugging with gdb-stub does not work with qemu-system-sparc target

  Qemu compiled from current git tree.

  execution string: qemu-system-sparc.exe -s -S -m 256 -L Bios -hda
  sparc.img -boot c
  connect with telnet localhost 1234
  enter '$s#73' (without quotes, this is single step command to gdb stub)
  gdb stub reply '+' (without quotes, as it accept command)
  After this qemu continuously execute instructions in single step mode
  and does not exit to gdb stub after each executed instruction with
  interrupt signal
  ("T%02xthread:%02x;" /gdb_vm_state_change in gdbstub.c/ );

  If we look at target-sparc/translate.c, we can see that
  gen_helper_debug() is not called in single step mode:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      if ((pc & TARGET_PAGE_MASK) =3D=3D (tb->pc & TARGET_PAGE_MASK) &&
          (npc & TARGET_PAGE_MASK) =3D=3D (tb->pc & TARGET_PAGE_MASK) &&
          !s->singlestep)  {
          /* jump to same page: we can use a direct jump */
          tcg_gen_goto_tb(tb_num);
          tcg_gen_movi_tl(cpu_pc, pc);
          tcg_gen_movi_tl(cpu_npc, npc);
          tcg_gen_exit_tb((long)tb + tb_num);
      } else {
          /* jump to another page: currently not optimized */
          tcg_gen_movi_tl(cpu_pc, pc);
          tcg_gen_movi_tl(cpu_npc, npc);
          tcg_gen_exit_tb(0);
      }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
          /* if single step mode, we generate only one instruction and
             generate an exception */
          if (dc->singlestep) {
              break;
          }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  If we look similar code at target-sh4/translate.c we can see that is
  called in this cases:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      if ((tb->pc & TARGET_PAGE_MASK) =3D=3D (dest & TARGET_PAGE_MASK) &&
  	!ctx->singlestep_enabled) {
  	/* Use a direct jump if in same page and singlestep not enabled */
          tcg_gen_goto_tb(n);
          tcg_gen_movi_i32(cpu_pc, dest);
          tcg_gen_exit_tb((long) tb + n);
      } else {
          tcg_gen_movi_i32(cpu_pc, dest);
          if (ctx->singlestep_enabled)
              gen_helper_debug();
          tcg_gen_exit_tb(0);
      }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      if (tb->cflags & CF_LAST_IO)
          gen_io_end();
      if (env->singlestep_enabled) {
          tcg_gen_movi_i32(cpu_pc, ctx.pc);
          gen_helper_debug();
      } else {
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/597362/+subscriptions
