Received: from eggs.gnu.org ([2001:4830:134:3::10]:49512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYic-000630-LC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYia-0004RC-Th
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:42 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYia-0004Qg-Ps
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:03:40 -0400
Received: by mail-qk0-x244.google.com with SMTP id q66so3779312qki.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:03:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:27 -1000
Message-Id: <20170718200255.31647-3-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 02/30] target/sh4: Consolidate end-of-TB
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

We can fold 3 different tests within the decode loop
into a more accurate computation of max_insns to start.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 45f7661..8740ee3 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1842,17 +1842,28 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
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
 
@@ -1876,18 +1887,10 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
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
2.9.4
