Received: from eggs.gnu.org ([2001:4830:134:3::10]:34118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQsYe-00058r-Mw
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQsYa-0003cf-MW
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:17:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:53982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQsYa-0003cG-I0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:17:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQsYZ-0006LD-1s
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:17:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 75E3C2E80C4
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:17:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jan 2017 08:57:59 -0000
From: Thomas Huth <597362@bugs.launchpad.net>
Reply-To: Bug 597362 <597362@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100622173200.15537.61592.malonedeb@gandwana.canonical.com>
Message-Id: <20170110085759.19993.41580.malone@wampee.canonical.com>
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

Triaging old bug reports ... Can you still reproduce this problem with
the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/597362

Title:
  qemu-system-sparc singlestep not work in gdbstub

Status in QEMU:
  Incomplete

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
