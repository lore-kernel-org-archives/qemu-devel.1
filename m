Received: from eggs.gnu.org ([2001:4830:134:3::10]:39418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foFqn-00041e-EP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foFqi-0007Bo-LA
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:25:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1foFqi-0007B2-BD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:25:36 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 11 Aug 2018 00:25:02 +0200
Message-Id: <20180810222502.19663-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

This patch revert changes from 4834871bc9 that are
not only state renaming.

This fixes java in a linux-user chroot:
  $ java --version
  qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)

The problem seems to be in gen_conditional_jump() in the
GUSA_EXCLUSIVE part: it should reset base.is_jmp to DISAS_NEXT after the
gen_goto_tb() as it is done in gen_delayed_conditional_jump() after the
gen_jump().

Bug: https://bugs.launchpad.net/qemu/+bug/1768246
Fixes: 4834871bc95b67343248100e2a75ae0d287bc08b
       ("target/sh4: Convert to DisasJumpType")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sh4/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 1b9a201d6d..5010b0d349 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -253,7 +253,6 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             tcg_gen_lookup_and_goto_ptr();
         }
     }
-    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_jump(DisasContext * ctx)
@@ -324,7 +323,6 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
         gen_jump(ctx);
 
         gen_set_label(l1);
-        ctx->base.is_jmp = DISAS_NEXT;
         return;
     }
 
@@ -1877,6 +1875,7 @@ static void decode_opc(DisasContext * ctx)
         ctx->envflags &= ~GUSA_MASK;
 
         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
+        ctx->base.is_jmp = DISAS_NORETURN;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
 	    gen_delayed_conditional_jump(ctx);
         } else {
-- 
2.17.1
