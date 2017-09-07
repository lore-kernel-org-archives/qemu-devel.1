Received: from eggs.gnu.org ([2001:4830:134:3::10]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P5-0003KK-RH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P0-0007bG-Lj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:51 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:36653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1P0-0007ah-Ag
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:46 -0400
Received: by mail-pf0-x22f.google.com with SMTP id e199so713726pfh.3
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:19:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:19:37 -0700
Message-Id: <20170907181938.3948-4-richard.henderson@linaro.org>
In-Reply-To: <20170907181938.3948-1-richard.henderson@linaro.org>
References: <20170907181938.3948-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 3/4] target/alpha: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 185 ++++++++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 99 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index ba38717e0f..5a92c4accb 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2929,33 +2929,23 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     return ret;
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static int alpha_tr_init_disas_context(DisasContextBase *dcbase,
+                                       CPUState *cpu, int max_insns)
 {
-    CPUAlphaState *env = cs->env_ptr;
-    DisasContext ctx, *ctxp = &ctx;
-    target_ulong pc_start;
-    target_ulong pc_mask;
-    uint32_t insn;
-    DisasJumpType ret;
-    int num_insns;
-    int max_insns;
-
-    pc_start = tb->pc;
-
-    ctx.base.tb = tb;
-    ctx.base.pc_next = pc_start;
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUAlphaState *env = cpu->env_ptr;
+    int64_t bound, mask;
 
-    ctx.tbflags = tb->flags;
-    ctx.mem_idx = cpu_mmu_index(env, false);
-    ctx.implver = env->implver;
-    ctx.amask = env->amask;
+    ctx->tbflags = ctx->base.tb->flags;
+    ctx->mem_idx = cpu_mmu_index(env, false);
+    ctx->implver = env->implver;
+    ctx->amask = env->amask;
 
 #ifdef CONFIG_USER_ONLY
-    ctx.ir = cpu_std_ir;
+    ctx->ir = cpu_std_ir;
 #else
-    ctx.palbr = env->palbr;
-    ctx.ir = (ctx.tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
+    ctx->palbr = env->palbr;
+    ctx->ir = (ctx->tbflags & ENV_FLAG_PAL_MODE ? cpu_pal_ir : cpu_std_ir);
 #endif
 
     /* ??? Every TB begins with unset rounding mode, to be initialized on
@@ -2964,96 +2954,87 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
        to reset the FP_STATUS to that default at the end of any TB that
        changes the default.  We could even (gasp) dynamiclly figure out
        what default would be most efficient given the running program.  */
-    ctx.tb_rm = -1;
+    ctx->tb_rm = -1;
     /* Similarly for flush-to-zero.  */
-    ctx.tb_ftz = -1;
+    ctx->tb_ftz = -1;
 
-    TCGV_UNUSED_I64(ctx.zero);
-    TCGV_UNUSED_I64(ctx.sink);
-    TCGV_UNUSED_I64(ctx.lit);
-
-    num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
+    TCGV_UNUSED_I64(ctx->zero);
+    TCGV_UNUSED_I64(ctx->sink);
+    TCGV_UNUSED_I64(ctx->lit);
 
-    if (in_superpage(&ctx, pc_start)) {
-        pc_mask = (1ULL << 41) - 1;
+    /* Bound the number of insns to execute to those left on the page.  */
+    if (in_superpage(ctx, ctx->base.pc_first)) {
+        mask = -1ULL << 41;
     } else {
-        pc_mask = ~TARGET_PAGE_MASK;
+        mask = TARGET_PAGE_MASK;
     }
+    bound = -(ctx->base.pc_first | mask) / 4;
 
-    gen_tb_start(tb);
-    tcg_clear_temp_count();
+    return MIN(max_insns, bound);
+}
 
-    do {
-        tcg_gen_insn_start(ctx.base.pc_next);
-        num_insns++;
+static void alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+}
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
-            ret = gen_excp(&ctx, EXCP_DEBUG, 0);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            ctx.base.pc_next += 4;
-            break;
-        }
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-        insn = cpu_ldl_code(env, ctx.base.pc_next);
+static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    tcg_gen_insn_start(dcbase->pc_next);
+}
 
-        ctx.base.pc_next += 4;
-        ret = translate_one(ctxp, insn);
-        free_context_temps(ctxp);
+static bool alpha_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                      const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-        if (tcg_check_temp_count()) {
-            qemu_log("TCG temporary leak before "TARGET_FMT_lx"\n",
-                     ctx.base.pc_next);
-        }
+    ctx->base.is_jmp = gen_excp(ctx, EXCP_DEBUG, 0);
 
-        /* If we reach a page boundary, are single stepping,
-           or exhaust instruction count, stop generation.  */
-        if (ret == DISAS_NEXT
-            && ((ctx.base.pc_next & pc_mask) == 0
-                || tcg_op_buf_full()
-                || num_insns >= max_insns
-                || singlestep
-                || ctx.base.singlestep_enabled)) {
-            ret = DISAS_TOO_MANY;
-        }
-    } while (ret == DISAS_NEXT);
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    ctx->base.pc_next += 4;
+    return true;
+}
 
-    if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
-    }
+static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUAlphaState *env = cpu->env_ptr;
+    uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+
+    ctx->base.pc_next += 4;
+    ctx->base.is_jmp = translate_one(ctx, insn);
+
+    free_context_temps(ctx);
+    translator_loop_temp_check(&ctx->base);
+}
+
+static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    switch (ret) {
+    switch (ctx->base.is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-        if (use_goto_tb(&ctx, ctx.base.pc_next)) {
+        if (use_goto_tb(ctx, ctx->base.pc_next)) {
             tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(cpu_pc, ctx.base.pc_next);
-            tcg_gen_exit_tb((uintptr_t)ctx.base.tb);
+            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+            tcg_gen_exit_tb((uintptr_t)ctx->base.tb);
         }
         /* FALLTHRU */
     case DISAS_PC_STALE:
-        tcg_gen_movi_i64(cpu_pc, ctx.base.pc_next);
+        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
-        if (!use_exit_tb(&ctx)) {
+        if (!use_exit_tb(ctx)) {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
         }
         /* FALLTHRU */
     case DISAS_PC_UPDATED_NOCHAIN:
-        if (ctx.base.singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             gen_excp_1(EXCP_DEBUG, 0);
         } else {
             tcg_gen_exit_tb(0);
@@ -3062,22 +3043,28 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     default:
         g_assert_not_reached();
     }
+}
 
-    gen_tb_end(tb, num_insns);
-
-    tb->size = ctx.base.pc_next - pc_start;
-    tb->icount = num_insns;
+static void alpha_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size, 1);
+}
+
+static const TranslatorOps alpha_tr_ops = {
+    .init_disas_context = alpha_tr_init_disas_context,
+    .tb_start           = alpha_tr_tb_start,
+    .insn_start         = alpha_tr_insn_start,
+    .breakpoint_check   = alpha_tr_breakpoint_check,
+    .translate_insn     = alpha_tr_translate_insn,
+    .tb_stop            = alpha_tr_tb_stop,
+    .disas_log          = alpha_tr_disas_log,
+};
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start, 1);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    DisasContext dc;
+    translator_loop(&alpha_tr_ops, &dc.base, cpu, tb);
 }
 
 void restore_state_to_opc(CPUAlphaState *env, TranslationBlock *tb,
-- 
2.13.5
