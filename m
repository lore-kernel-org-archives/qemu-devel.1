Received: from eggs.gnu.org ([209.51.188.92]:58180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFw-0007CN-Kk
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFv-0001Ph-Ls
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:12 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griFv-0001P8-FY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:11 -0500
Received: by mail-wr1-x442.google.com with SMTP id q15so11164507wro.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:46 +0000
Message-Id: <20190207115400.647-6-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/19] target/hppa: Unify specializations of OR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org

With decodetree.py, the specializations would conflict so we
must have a single entry point for all variants of OR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 108 ++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2ca0f5da10..6c2f560fc1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2622,21 +2622,69 @@ static bool trans_log(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return nullify_end(ctx);
 }
 
-/* OR r,0,t -> COPY (according to gas) */
-static bool trans_copy(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_or(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
 {
+    unsigned r2 = extract32(insn, 21, 5);
     unsigned r1 = extract32(insn, 16, 5);
+    unsigned cf = extract32(insn, 12, 4);
     unsigned rt = extract32(insn,  0, 5);
+    TCGv_reg tcg_r1, tcg_r2;
 
-    if (r1 == 0) {
-        TCGv_reg dest = dest_gpr(ctx, rt);
-        tcg_gen_movi_reg(dest, 0);
-        save_gpr(ctx, rt, dest);
-    } else {
-        save_gpr(ctx, rt, cpu_gr[r1]);
+    if (cf == 0) {
+        if (rt == 0) { /* NOP */
+            cond_free(&ctx->null_cond);
+            return true;
+        }
+        if (r2 == 0) { /* COPY */
+            if (r1 == 0) {
+                TCGv_reg dest = dest_gpr(ctx, rt);
+                tcg_gen_movi_reg(dest, 0);
+                save_gpr(ctx, rt, dest);
+            } else {
+                save_gpr(ctx, rt, cpu_gr[r1]);
+            }
+            cond_free(&ctx->null_cond);
+            return true;
+        }
+#ifndef CONFIG_USER_ONLY
+        /* These are QEMU extensions and are nops in the real architecture:
+         *
+         * or %r10,%r10,%r10 -- idle loop; wait for interrupt
+         * or %r31,%r31,%r31 -- death loop; offline cpu
+         *                      currently implemented as idle.
+         */
+        if ((rt == 10 || rt == 31) && r1 == rt && r2 == rt) { /* PAUSE */
+            TCGv_i32 tmp;
+
+            /* No need to check for supervisor, as userland can only pause
+               until the next timer interrupt.  */
+            nullify_over(ctx);
+
+            /* Advance the instruction queue.  */
+            copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
+            copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
+            nullify_set(ctx, 0);
+
+            /* Tell the qemu main loop to halt until this cpu has work.  */
+            tmp = tcg_const_i32(1);
+            tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
+                                         offsetof(CPUState, halted));
+            tcg_temp_free_i32(tmp);
+            gen_excp_1(EXCP_HALTED);
+            ctx->base.is_jmp = DISAS_NORETURN;
+
+            return nullify_end(ctx);
+        }
+#endif
     }
-    cond_free(&ctx->null_cond);
-    return true;
+
+    if (cf) {
+        nullify_over(ctx);
+    }
+    tcg_r1 = load_gpr(ctx, r1);
+    tcg_r2 = load_gpr(ctx, r2);
+    do_log(ctx, rt, tcg_r1, tcg_r2, cf, tcg_gen_or_reg);
+    return nullify_end(ctx);
 }
 
 static bool trans_cmpclr(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
@@ -2781,48 +2829,10 @@ static bool trans_ds(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return nullify_end(ctx);
 }
 
-#ifndef CONFIG_USER_ONLY
-/* These are QEMU extensions and are nops in the real architecture:
- *
- * or %r10,%r10,%r10 -- idle loop; wait for interrupt
- * or %r31,%r31,%r31 -- death loop; offline cpu
- *                      currently implemented as idle.
- */
-static bool trans_pause(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
-{
-    TCGv_i32 tmp;
-
-    /* No need to check for supervisor, as userland can only pause
-       until the next timer interrupt.  */
-    nullify_over(ctx);
-
-    /* Advance the instruction queue.  */
-    copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-    copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
-    nullify_set(ctx, 0);
-
-    /* Tell the qemu main loop to halt until this cpu has work.  */
-    tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                 offsetof(CPUState, halted));
-    tcg_temp_free_i32(tmp);
-    gen_excp_1(EXCP_HALTED);
-    ctx->base.is_jmp = DISAS_NORETURN;
-
-    return nullify_end(ctx);
-}
-#endif
-
 static const DisasInsn table_arith_log[] = {
-    { 0x08000240u, 0xfc00ffffu, trans_nop },  /* or x,y,0 */
-    { 0x08000240u, 0xffe0ffe0u, trans_copy }, /* or x,0,t */
-#ifndef CONFIG_USER_ONLY
-    { 0x094a024au, 0xffffffffu, trans_pause }, /* or r10,r10,r10 */
-    { 0x0bff025fu, 0xffffffffu, trans_pause }, /* or r31,r31,r31 */
-#endif
+    { 0x08000240u, 0xfc000fe0u, trans_or },
     { 0x08000000u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_andc_reg },
     { 0x08000200u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_and_reg },
-    { 0x08000240u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_or_reg },
     { 0x08000280u, 0xfc000fe0u, trans_log, .f.ttt = tcg_gen_xor_reg },
     { 0x08000880u, 0xfc000fe0u, trans_cmpclr },
     { 0x08000380u, 0xfc000fe0u, trans_uxor },
-- 
2.17.2
