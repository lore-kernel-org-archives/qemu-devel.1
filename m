Received: from eggs.gnu.org ([2001:4830:134:3::10]:48606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPl-0005jc-E3
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00040M-Fp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003VG-3s
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:25 +0200
Message-Id: <20170718215050.3812-7-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 06/31] target/sh4: Consolidate end-of-TB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

We can fold 3 different tests within the decode loop
into a more accurate computation of max_insns to start.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-3-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4c3512f62f..310c52ad2a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1830,17 +1830,28 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.features = env->features;
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
 
-    num_insns = 0;
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
+    max_insns = MIN(max_insns, TCG_MAX_INSNS);
+
+    /* Since the ISA is fixed-width, we can bound by the number
+       of instructions remaining on the page.  */
+    num_insns = -(ctx.pc | TARGET_PAGE_MASK) / 2;
+    max_insns = MIN(max_insns, num_insns);
+
+    /* Single stepping means just that.  */
+    if (ctx.singlestep_enabled || singlestep) {
+        max_insns = 1;
     }
 
     gen_tb_start(tb);
-    while (ctx.bstate == BS_NONE && !tcg_op_buf_full()) {
+    num_insns = 0;
+
+    while (ctx.bstate == BS_NONE
+           && num_insns < max_insns
+           && !tcg_op_buf_full()) {
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
         num_insns++;
 
@@ -1864,18 +1875,10 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
         ctx.opcode = cpu_lduw_code(env, ctx.pc);
 	decode_opc(&ctx);
 	ctx.pc += 2;
-	if ((ctx.pc & (TARGET_PAGE_SIZE - 1)) == 0)
-	    break;
-        if (cs->singlestep_enabled) {
-	    break;
-        }
-        if (num_insns >= max_insns)
-            break;
-        if (singlestep)
-            break;
     }
-    if (tb->cflags & CF_LAST_IO)
+    if (tb->cflags & CF_LAST_IO) {
         gen_io_end();
+    }
     if (cs->singlestep_enabled) {
         gen_save_cpu_state(&ctx, true);
         gen_helper_debug(cpu_env);
-- 
2.11.0
