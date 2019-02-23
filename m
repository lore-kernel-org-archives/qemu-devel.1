Received: from eggs.gnu.org ([209.51.188.92]:45440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgkB-0000PN-Nh
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxgk9-0007NQ-OH
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:07 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:36317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxgk9-0007KQ-GA
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:30:05 -0500
Received: by mail-pg1-x534.google.com with SMTP id r124so2781673pgr.3
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:30:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 23 Feb 2019 15:29:53 -0800
Message-Id: <20190223232954.7185-7-richard.henderson@linaro.org>
In-Reply-To: <20190223232954.7185-1-richard.henderson@linaro.org>
References: <20190223232954.7185-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC 6/7] target/hppa: Use pattern groups to decode OR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, f4bug@amsat.org

It seems clearer to decode specializations of OR within decodetree
instead of by hand within the translation function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 106 ++++++++++++++++++++-------------------
 target/hppa/insns.decode |  10 +++-
 2 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b4fd307b77..8f5010b633 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2619,59 +2619,63 @@ static bool trans_and(DisasContext *ctx, arg_rrr_cf *a)
     return do_log_reg(ctx, a, tcg_gen_and_reg);
 }
 
+static bool trans_copy(DisasContext *ctx, arg_copy *a)
+{
+    unsigned r = a->r;
+    unsigned t = a->t;
+
+    if (r == 0) {
+        TCGv_reg dest = dest_gpr(ctx, t);
+        tcg_gen_movi_reg(dest, 0);
+        save_gpr(ctx, t, dest);
+    } else {
+        save_gpr(ctx, t, cpu_gr[r]);
+    }
+    cond_free(&ctx->null_cond);
+    return true;
+}
+
+static bool trans_pause(DisasContext *ctx, arg_pause *a)
+{
+#ifndef CONFIG_USER_ONLY
+    /*
+     * These are QEMU extensions and are nops in the real architecture:
+     *
+     * or %r10,%r10,%r10 -- idle loop; wait for interrupt
+     * or %r31,%r31,%r31 -- death loop; offline cpu
+     *                      currently implemented as idle.
+     */
+    TCGv_i32 tmp;
+
+    /*
+     * No need to check for supervisor, as userland can only pause
+     * until the next timer interrupt.
+     */
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
+                   offsetof(CPUState, halted));
+    tcg_temp_free_i32(tmp);
+    gen_excp_1(EXCP_HALTED);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    return nullify_end(ctx);
+#else
+    /* For user-only, don't pause but treat as nop.  */
+    cond_free(&ctx->null_cond);
+    return true;
+#endif
+}
+
 static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
 {
-    if (a->cf == 0) {
-        unsigned r2 = a->r2;
-        unsigned r1 = a->r1;
-        unsigned rt = a->t;
-
-        if (rt == 0) { /* NOP */
-            cond_free(&ctx->null_cond);
-            return true;
-        }
-        if (r2 == 0) { /* COPY */
-            if (r1 == 0) {
-                TCGv_reg dest = dest_gpr(ctx, rt);
-                tcg_gen_movi_reg(dest, 0);
-                save_gpr(ctx, rt, dest);
-            } else {
-                save_gpr(ctx, rt, cpu_gr[r1]);
-            }
-            cond_free(&ctx->null_cond);
-            return true;
-        }
-#ifndef CONFIG_USER_ONLY
-        /* These are QEMU extensions and are nops in the real architecture:
-         *
-         * or %r10,%r10,%r10 -- idle loop; wait for interrupt
-         * or %r31,%r31,%r31 -- death loop; offline cpu
-         *                      currently implemented as idle.
-         */
-        if ((rt == 10 || rt == 31) && r1 == rt && r2 == rt) { /* PAUSE */
-            TCGv_i32 tmp;
-
-            /* No need to check for supervisor, as userland can only pause
-               until the next timer interrupt.  */
-            nullify_over(ctx);
-
-            /* Advance the instruction queue.  */
-            copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
-            copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
-            nullify_set(ctx, 0);
-
-            /* Tell the qemu main loop to halt until this cpu has work.  */
-            tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                         offsetof(CPUState, halted));
-            tcg_temp_free_i32(tmp);
-            gen_excp_1(EXCP_HALTED);
-            ctx->base.is_jmp = DISAS_NORETURN;
-
-            return nullify_end(ctx);
-        }
-#endif
-    }
     return do_log_reg(ctx, a, tcg_gen_or_reg);
 }
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 55ff39dd05..46c64334d1 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -148,7 +148,15 @@ lci             000001 ----- ----- -- 01001100 0 t:5
 
 andcm           000010 ..... ..... .... 000000 0 .....  @rrr_cf
 and             000010 ..... ..... .... 001000 0 .....  @rrr_cf
-or              000010 ..... ..... .... 001001 0 .....  @rrr_cf
+{
+  {
+    nop         000010 ----- ----- 0000 001001 0 00000
+    copy        000010 00000 r:5   0000 001001 0 t:5
+    pause       000010 01010 01010 0000 001001 0 01010
+    pause       000010 11111 11111 0000 001001 0 11111
+  }
+  or            000010 ..... ..... .... 001001 0 .....  @rrr_cf
+}
 xor             000010 ..... ..... .... 001010 0 .....  @rrr_cf
 uxor            000010 ..... ..... .... 001110 0 .....  @rrr_cf
 ds              000010 ..... ..... .... 010001 0 .....  @rrr_cf
-- 
2.17.2
