Received: from eggs.gnu.org ([2001:4830:134:3::10]:60537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT10-00064s-6A
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0v-0006rN-6r
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:22 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0v-0006qu-0T
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:17 -0500
Received: by mail-pf0-x243.google.com with SMTP id b25so6074221pfd.9
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:43:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:12 -0800
Message-Id: <20180122034217.19593-39-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 38/43] target/hppa: Implement a pause instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an extension to the base ISA, but we can use this in
the kernel idle loop to reduce the host cpu time consumed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 76ed7e1ad4..8884754f05 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2815,9 +2815,45 @@ static DisasJumpType trans_ds(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, DISAS_NEXT);
 }
 
+#ifndef CONFIG_USER_ONLY
+/* These are QEMU extensions and are nops in the real architecture:
+ *
+ * or %r10,%r10,%r10 -- idle loop; wait for interrupt
+ * or %r31,%r31,%r31 -- death loop; offline cpu
+ *                      currently implemented as idle.
+ */
+static DisasJumpType trans_pause(DisasContext *ctx, uint32_t insn,
+                                 const DisasInsn *di)
+{
+    TCGv_i32 tmp;
+
+    /* No need to check for supervisor, as userland can only pause
+       until the next timer interrupt.  */
+    nullify_over(ctx);
+
+    /* Advance the instruction queue.  */
+    copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+    copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+    nullify_set(ctx, 0);
+
+    /* Tell the qemu main loop to halt until this cpu has work.  */
+    tmp = tcg_const_i32(1);
+    tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
+                                 offsetof(CPUState, halted));
+    tcg_temp_free_i32(tmp);
+    gen_excp_1(EXCP_HALTED);
+
+    return nullify_end(ctx, DISAS_NORETURN);
+}
+#endif
+
 static const DisasInsn table_arith_log[] = {
     { 0x08000240u, 0xfc00ffffu, trans_nop },  /* or x,y,0 */
     { 0x08000240u, 0xffe0ffe0u, trans_copy }, /* or x,0,t */
+#ifndef CONFIG_USER_ONLY
+    { 0x094a024au, 0xffffffffu, trans_pause }, /* or r10,r10,r10 */
+    { 0x0bff025fu, 0xffffffffu, trans_pause }, /* or r31,r31,r31 */
+#endif
     { 0x08000000u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_andc_reg },
     { 0x08000200u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_and_reg },
     { 0x08000240u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_or_reg },
-- 
2.14.3
