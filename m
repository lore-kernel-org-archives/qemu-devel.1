Received: from eggs.gnu.org ([2001:4830:134:3::10]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD7-0007sg-5b
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD5-0004wO-BF
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:21 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUD5-0004wK-6H
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:19 -0500
Received: by mail-qt0-x243.google.com with SMTP id a29so14087662qtb.1
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:19 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:41 -0800
Message-Id: <20170123021748.13170-20-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 19/26] target-hppa: Add nullification framework
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

The HPPA cpu has a unique form of predicated execution in which
almost any instruction can set the PSW[N] (or "nullify") bit,
which suppresses execution (and even decoding) of the following
instruction.  Execution of a nullified insn clears the PSW[N] bit.

This adds a generic framework for branching over nullified insns,
or for sufficiently simple insns, transforming the writeback of
the result to a conditional move.  In the process, we want to be
able to represent PSW[N] as a TCG condition, which implies management
of the related tcg temps.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 228 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8d61853..22dfb73 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -151,6 +151,78 @@ void hppa_translate_init(void)
     }
 }
 
+static DisasCond cond_make_f(void)
+{
+    DisasCond r = { .c = TCG_COND_NEVER };
+    TCGV_UNUSED(r.a0);
+    TCGV_UNUSED(r.a1);
+    return r;
+}
+
+static DisasCond cond_make_n(void)
+{
+    DisasCond r = { .c = TCG_COND_NE, .a0_is_n = true, .a1_is_0 = true };
+    r.a0 = cpu_psw_n;
+    TCGV_UNUSED(r.a1);
+    return r;
+}
+
+static DisasCond cond_make_0(TCGCond c, TCGv a0)
+{
+    DisasCond r = { .c = c, .a1_is_0 = true };
+
+    assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
+    r.a0 = tcg_temp_new();
+    tcg_gen_mov_tl(r.a0, a0);
+    TCGV_UNUSED(r.a1);
+
+    return r;
+}
+
+static DisasCond cond_make(TCGCond c, TCGv a0, TCGv a1)
+{
+    DisasCond r = { .c = c };
+
+    assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
+    r.a0 = tcg_temp_new();
+    tcg_gen_mov_tl(r.a0, a0);
+    r.a1 = tcg_temp_new();
+    tcg_gen_mov_tl(r.a1, a1);
+
+    return r;
+}
+
+static void cond_prep(DisasCond *cond)
+{
+    if (cond->a1_is_0) {
+        cond->a1_is_0 = false;
+        cond->a1 = tcg_const_tl(0);
+    }
+}
+
+static void cond_free(DisasCond *cond)
+{
+    switch (cond->c) {
+    default:
+        if (!cond->a0_is_n) {
+            tcg_temp_free(cond->a0);
+        }
+        if (!cond->a1_is_0) {
+            tcg_temp_free(cond->a1);
+        }
+        cond->a0_is_n = false;
+        cond->a1_is_0 = false;
+        TCGV_UNUSED(cond->a0);
+        TCGV_UNUSED(cond->a1);
+        /* fallthru */
+    case TCG_COND_ALWAYS:
+        cond->c = TCG_COND_NEVER;
+        break;
+    case TCG_COND_NEVER:
+        break;
+    }
+}
+
 static TCGv get_temp(DisasContext *ctx)
 {
     unsigned i = ctx->ntemps++;
@@ -178,13 +250,125 @@ static TCGv load_gpr(DisasContext *ctx, unsigned reg)
 
 static TCGv dest_gpr(DisasContext *ctx, unsigned reg)
 {
-    if (reg == 0) {
+    if (reg == 0 || ctx->null_cond.c != TCG_COND_NEVER) {
         return get_temp(ctx);
     } else {
         return cpu_gr[reg];
     }
 }
 
+static void save_or_nullify(DisasContext *ctx, TCGv dest, TCGv t)
+{
+    if (ctx->null_cond.c != TCG_COND_NEVER) {
+        cond_prep(&ctx->null_cond);
+        tcg_gen_movcond_tl(ctx->null_cond.c, dest, ctx->null_cond.a0,
+                           ctx->null_cond.a1, dest, t);
+    } else {
+        tcg_gen_mov_tl(dest, t);
+    }
+}
+
+static void save_gpr(DisasContext *ctx, unsigned reg, TCGv t)
+{
+    if (reg != 0) {
+        save_or_nullify(ctx, cpu_gr[reg], t);
+    }
+}
+
+/* Skip over the implementation of an insn that has been nullified.
+   Use this when the insn is too complex for a conditional move.  */
+static void nullify_over(DisasContext *ctx)
+{
+    if (ctx->null_cond.c != TCG_COND_NEVER) {
+        /* The always condition should have been handled in the main loop.  */
+        assert(ctx->null_cond.c != TCG_COND_ALWAYS);
+
+        ctx->null_lab = gen_new_label();
+        cond_prep(&ctx->null_cond);
+
+        /* If we're using PSW[N], copy it to a temp because... */
+        if (ctx->null_cond.a0_is_n) {
+            ctx->null_cond.a0_is_n = false;
+            ctx->null_cond.a0 = tcg_temp_new();
+            tcg_gen_mov_tl(ctx->null_cond.a0, cpu_psw_n);
+        }
+        /* ... we clear it before branching over the implementation,
+           so that (1) it's clear after nullifying this insn and
+           (2) if this insn nullifies the next, PSW[N] is valid.  */
+        if (ctx->psw_n_nonzero) {
+            ctx->psw_n_nonzero = false;
+            tcg_gen_movi_tl(cpu_psw_n, 0);
+        }
+
+        tcg_gen_brcond_tl(ctx->null_cond.c, ctx->null_cond.a0,
+                          ctx->null_cond.a1, ctx->null_lab);
+        cond_free(&ctx->null_cond);
+    }
+}
+
+/* Save the current nullification state to PSW[N].  */
+static void nullify_save(DisasContext *ctx)
+{
+    if (ctx->null_cond.c == TCG_COND_NEVER) {
+        if (ctx->psw_n_nonzero) {
+            tcg_gen_movi_tl(cpu_psw_n, 0);
+        }
+        return;
+    }
+    if (!ctx->null_cond.a0_is_n) {
+        cond_prep(&ctx->null_cond);
+        tcg_gen_setcond_tl(ctx->null_cond.c, cpu_psw_n,
+                           ctx->null_cond.a0, ctx->null_cond.a1);
+        ctx->psw_n_nonzero = true;
+    }
+    cond_free(&ctx->null_cond);
+}
+
+/* Set a PSW[N] to X.  The intention is that this is used immediately
+   before a goto_tb/exit_tb, so that there is no fallthru path to other
+   code within the TB.  Therefore we do not update psw_n_nonzero.  */
+static void nullify_set(DisasContext *ctx, bool x)
+{
+    if (ctx->psw_n_nonzero || x) {
+        tcg_gen_movi_tl(cpu_psw_n, x);
+    }
+}
+
+/* Mark the end of an instruction that may have been nullified.
+   This is the pair to nullify_over.  */
+static ExitStatus nullify_end(DisasContext *ctx, ExitStatus status)
+{
+    TCGLabel *null_lab = ctx->null_lab;
+
+    if (likely(null_lab == NULL)) {
+        /* The current insn wasn't conditional or handled the condition
+           applied to it without a branch, so the (new) setting of
+           NULL_COND can be applied directly to the next insn.  */
+        return status;
+    }
+    ctx->null_lab = NULL;
+
+    if (likely(ctx->null_cond.c == TCG_COND_NEVER)) {
+        /* The next instruction will be unconditional,
+           and NULL_COND already reflects that.  */
+        gen_set_label(null_lab);
+    } else {
+        /* The insn that we just executed is itself nullifying the next
+           instruction.  Store the condition in the PSW[N] global.
+           We asserted PSW[N] = 0 in nullify_over, so that after the
+           label we have the proper value in place.  */
+        nullify_save(ctx);
+        gen_set_label(null_lab);
+        ctx->null_cond = cond_make_n();
+    }
+
+    assert(status != EXIT_GOTO_TB && status != EXIT_IAQ_N_UPDATED);
+    if (status == EXIT_NORETURN) {
+        status = NO_EXIT;
+    }
+    return status;
+}
+
 static void copy_iaoq_entry(TCGv dest, target_ulong ival, TCGv vval)
 {
     if (unlikely(ival == -1)) {
@@ -210,13 +394,15 @@ static ExitStatus gen_excp(DisasContext *ctx, int exception)
 {
     copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
     copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    nullify_save(ctx);
     gen_excp_1(exception);
     return EXIT_NORETURN;
 }
 
 static ExitStatus gen_illegal(DisasContext *ctx)
 {
-    return gen_excp(ctx, EXCP_SIGILL);
+    nullify_over(ctx);
+    return nullify_end(ctx, gen_excp(ctx, EXCP_SIGILL));
 }
 
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
@@ -228,6 +414,16 @@ static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
     return true;
 }
 
+/* If the next insn is to be nullified, and it's on the same page,
+   and we're not attempting to set a breakpoint on it, then we can
+   totally skip the nullified insn.  This avoids creating and
+   executing a TB that merely branches to the next TB.  */
+static bool use_nullify_skip(DisasContext *ctx)
+{
+    return (((ctx->iaoq_b ^ ctx->iaoq_f) & TARGET_PAGE_MASK) == 0
+            && !cpu_breakpoint_test(ctx->cs, ctx->iaoq_b, BP_ANY));
+}
+
 static void gen_goto_tb(DisasContext *ctx, int which,
                         target_ulong f, target_ulong b)
 {
@@ -308,6 +504,15 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
     num_insns = 0;
     gen_tb_start(tb);
 
+    /* Seed the nullification status from PSW[N], as shown in TB->FLAGS.  */
+    ctx.null_cond = cond_make_f();
+    ctx.psw_n_nonzero = false;
+    if (tb->flags & 1) {
+        ctx.null_cond.c = TCG_COND_ALWAYS;
+        ctx.psw_n_nonzero = true;
+    }
+    ctx.null_lab = NULL;
+
     do {
         tcg_gen_insn_start(ctx.iaoq_f, ctx.iaoq_b);
         num_insns++;
@@ -336,7 +541,13 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
                 TCGV_UNUSED(ctx.iaoq_n_var);
             }
 
-            ret = translate_one(&ctx, insn);
+            if (unlikely(ctx.null_cond.c == TCG_COND_ALWAYS)) {
+                ctx.null_cond.c = TCG_COND_NEVER;
+                ret = NO_EXIT;
+            } else {
+                ret = translate_one(&ctx, insn);
+                assert(ctx.null_lab == NULL);
+            }
         }
 
         for (i = 0; i < ctx.ntemps; ++i) {
@@ -354,7 +565,14 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
             && (ctx.iaoq_b != ctx.iaoq_f + 4
                 || num_insns >= max_insns
                 || tcg_op_buf_full())) {
-            ret = EXIT_IAQ_N_STALE;
+            if (ctx.null_cond.c == TCG_COND_NEVER
+                || ctx.null_cond.c == TCG_COND_ALWAYS) {
+                nullify_set(&ctx, ctx.null_cond.c == TCG_COND_ALWAYS);
+                gen_goto_tb(&ctx, 0, ctx.iaoq_b, ctx.iaoq_n);
+                ret = EXIT_GOTO_TB;
+            } else {
+                ret = EXIT_IAQ_N_STALE;
+            }
         }
 
         ctx.iaoq_f = ctx.iaoq_b;
@@ -367,6 +585,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
         if (ctx.iaoq_f == -1) {
             tcg_gen_mov_tl(cpu_iaoq_f, cpu_iaoq_b);
             copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_n, ctx.iaoq_n_var);
+            nullify_save(&ctx);
             ret = EXIT_IAQ_N_UPDATED;
             break;
         }
@@ -386,6 +605,7 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
     case EXIT_IAQ_N_STALE:
         copy_iaoq_entry(cpu_iaoq_f, ctx.iaoq_f, cpu_iaoq_f);
         copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_b, cpu_iaoq_b);
+        nullify_save(&ctx);
         /* FALLTHRU */
     case EXIT_IAQ_N_UPDATED:
         if (ctx.singlestep_enabled) {
-- 
2.9.3
