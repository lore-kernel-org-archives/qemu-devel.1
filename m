Received: from eggs.gnu.org ([2001:4830:134:3::10]:37144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQC-0005B1-Fq
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001Lc-Qe
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001HE-HH
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:35 +0200
Message-Id: <20170513093248.18230-3-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/15] target/sh4: get rid of DELAY_SLOT_CLEARME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Now that ctx->flags has been split, it becomes clear that
DELAY_SLOT_CLEARME has not impact on the code generation: in both case
ctx->envflags is cleared, either by clearing all the flags, or by
setting it to 0. This is left-over from pre-TCG era.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/cpu.h       |  3 +--
 target/sh4/helper.c    |  2 --
 target/sh4/translate.c | 17 +++++------------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index cad8989f7e..9445cc779f 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -93,7 +93,6 @@
 #define DELAY_SLOT             (1 << 0)
 #define DELAY_SLOT_CONDITIONAL (1 << 1)
 #define DELAY_SLOT_TRUE        (1 << 2)
-#define DELAY_SLOT_CLEARME     (1 << 3)
 /* The dynamic value of the DELAY_SLOT_TRUE flag determines whether the jump
  * after the delay slot should be taken or not. It is calculated from SR_T.
  *
@@ -384,7 +383,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
     *pc = env->pc;
     *cs_base = 0;
     *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL
-                    | DELAY_SLOT_TRUE | DELAY_SLOT_CLEARME))   /* Bits  0- 3 */
+                    | DELAY_SLOT_TRUE))                        /* Bits  0- 2 */
             | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
             | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
             | (env->sr & (1u << SR_FD))                        /* Bit 15 */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 036c5ca56c..71bb49a670 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -170,8 +170,6 @@ void superh_cpu_do_interrupt(CPUState *cs)
 	/* Clear flags for exception/interrupt routine. */
 	env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL | DELAY_SLOT_TRUE);
     }
-    if (env->flags & DELAY_SLOT_CLEARME)
-        env->flags = 0;
 
     if (do_exp) {
         env->expevt = cs->exception_index;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6b526a02f2..d84a7a2e6e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1804,15 +1804,9 @@ static void decode_opc(DisasContext * ctx)
     _decode_opc(ctx);
 
     if (old_flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
-        if (ctx->envflags & DELAY_SLOT_CLEARME) {
-            gen_store_flags(0);
-        } else {
-	    /* go out of the delay slot */
-            uint32_t new_flags = ctx->envflags;
-	    new_flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
-	    gen_store_flags(new_flags);
-        }
-        ctx->envflags = 0;
+        /* go out of the delay slot */
+        ctx->envflags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
+        gen_store_flags(ctx->envflags);
         ctx->bstate = BS_BRANCH;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
 	    gen_delayed_conditional_jump(ctx);
@@ -1840,8 +1834,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     pc_start = tb->pc;
     ctx.pc = pc_start;
     ctx.tbflags = (uint32_t)tb->flags;
-    ctx.envflags = tb->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL |
-                                DELAY_SLOT_CLEARME);
+    ctx.envflags = tb->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
     ctx.bstate = BS_NONE;
     ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
     /* We don't know if the delayed pc came from a dynamic or static branch,
@@ -1908,7 +1901,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
             /* fall through */
         case BS_NONE:
             if (ctx.envflags) {
-                gen_store_flags(ctx.envflags | DELAY_SLOT_CLEARME);
+                gen_store_flags(ctx.envflags);
 	    }
             gen_goto_tb(&ctx, 0, ctx.pc);
             break;
-- 
2.11.0
