Received: from eggs.gnu.org ([2001:4830:134:3::10]:33877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTItz-0000w1-Vw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTItz-0007ec-5T
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:51 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTItz-0007eI-0r
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:51 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so2720716qte.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:21:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:46 -1000
Message-Id: <20170707022111.21836-3-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 02/27] target/sh4: Consolidate end-of-TB
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
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

We can fold 3 different tests within the decode loop
into a more accurate computation of max_insns to start.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 82d4d69..663b5c0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1848,7 +1848,6 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     ctx.features = env->features;
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
 
-    num_insns = 0;
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -1856,9 +1855,23 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    /* Since the ISA is fixed-width, we can bound by the number
+       of instructions remaining on the page.  */
+    num_insns = (TARGET_PAGE_SIZE - (ctx.pc & (TARGET_PAGE_SIZE - 1))) / 2;
+    if (max_insns > num_insns) {
+        max_insns = num_insns;
+    }
+    /* Single stepping means just that.  */
+    if (ctx.singlestep_enabled || singlestep) {
+        max_insns = 1;
+    }
 
     gen_tb_start(tb);
-    while (ctx.bstate == BS_NONE && !tcg_op_buf_full()) {
+    num_insns = 0;
+
+    while (ctx.bstate == BS_NONE
+           && num_insns < max_insns
+           && !tcg_op_buf_full()) {
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
         num_insns++;
 
@@ -1882,18 +1895,10 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
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
