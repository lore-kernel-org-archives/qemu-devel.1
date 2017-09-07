Received: from eggs.gnu.org ([2001:4830:134:3::10]:54202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tR-0000F0-K2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tL-0000XV-Qi
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:13 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:33555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1tL-0000X8-Ie
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:07 -0400
Received: by mail-pg0-x232.google.com with SMTP id t3so1011282pgt.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:51:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:50:57 -0700
Message-Id: <20170907185057.23421-6-richard.henderson@linaro.org>
In-Reply-To: <20170907185057.23421-1-richard.henderson@linaro.org>
References: <20170907185057.23421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 5/5] target/sh4: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 272 ++++++++++++++++++++++++++-----------------------
 1 file changed, 147 insertions(+), 125 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ed462bab12..ca6589047b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -34,6 +34,9 @@
 
 typedef struct DisasContext {
     DisasContextBase base;
+#ifdef CONFIG_USER_ONLY
+    TranslatorOps ops;
+#endif
 
     uint32_t tbflags;  /* should stay unmodified during the TB translation */
     uint32_t envflags; /* should stay in sync with env->flags using TCG ops */
@@ -1892,6 +1895,100 @@ static void decode_opc(DisasContext * ctx)
 }
 
 #ifdef CONFIG_USER_ONLY
+static void sh4_tr_translate_gusa(DisasContextBase *dcbase, CPUState *cpu);
+#endif
+
+static int sh4_tr_init_disas_context(DisasContextBase *dcbase,
+                                     CPUState *cpu, int max_insns)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUSH4State *env = cpu->env_ptr;
+    uint32_t pc = ctx->base.pc_next;
+    uint32_t tbflags = ctx->base.tb->flags;
+    int bound;
+
+    ctx->tbflags = tbflags;
+    ctx->envflags = tbflags & TB_FLAG_ENVFLAGS_MASK;
+    ctx->memidx = (tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
+    /* We don't know if the delayed pc came from a dynamic or static branch,
+       so assume it is a dynamic branch.  */
+    ctx->delayed_pc = -1; /* use delayed pc from env pointer */
+    ctx->features = env->features;
+    ctx->has_movcal = (tbflags & TB_FLAG_PENDING_MOVCA) != 0;
+    ctx->gbank = ((tbflags & (1 << SR_MD)) &&
+                  (tbflags & (1 << SR_RB))) * 0x10;
+    ctx->fbank = tbflags & FPSCR_FR ? 0x10 : 0;
+
+    /* Since the ISA is fixed-width, we can bound by the number
+       of instructions remaining on the page.  */
+    bound = -(pc | TARGET_PAGE_MASK) / 2;
+    max_insns = MIN(max_insns, bound);
+
+#ifdef CONFIG_USER_ONLY
+    if (tbflags & GUSA_MASK) {
+        uint32_t pc_end = ctx->base.tb->cs_base;
+        int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
+        int gusa_insns = -backup / 2;
+
+        if (pc != pc_end + backup || gusa_insns < 2) {
+            /* This is a malformed gUSA region.  Don't do anything special,
+               since the interpreter is likely to get confused.  */
+            ctx->envflags &= ~GUSA_MASK;
+        } else if (tbflags & GUSA_EXCLUSIVE) {
+            /* Regardless of single-stepping or the end of the page,
+               we must complete execution of the gUSA region while
+               holding the exclusive lock.  */
+            max_insns = gusa_insns;
+        } else {
+            /* Attempt to translate to an atomic insn.  */
+            ctx->ops.translate_insn = sh4_tr_translate_gusa;
+        }
+    }
+#endif
+
+    return max_insns;
+}
+
+static void sh4_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+}
+
+static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags);
+}
+
+static bool sh4_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    /* We have hit a breakpoint - make sure PC is up-to-date */
+    gen_save_cpu_state(ctx, true);
+    gen_helper_debug(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    ctx->base.pc_next += 2;
+    return true;
+}
+
+static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUSH4State *env = cpu->env_ptr;
+
+    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    decode_opc(ctx);
+    ctx->base.pc_next += 2;
+}
+
+#ifdef CONFIG_USER_ONLY
 /* For uniprocessors, SH4 uses optimistic restartable atomic sequences.
    Upon an interrupt, a real kernel would simply notice magic values in
    the registers and reset the PC to the start of the sequence.
@@ -1901,35 +1998,23 @@ static void decode_opc(DisasContext * ctx)
    any sequence via cpu_exec_step_atomic, we can recognize the "normal"
    sequences and transform them into atomic operations as seen by the host.
 */
-static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
+static void sh4_tr_translate_gusa(DisasContextBase *dcbase, CPUState *cpu)
 {
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUSH4State *env = cpu->env_ptr;
+
+    int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
+    int max_insns = -backup / 2;
+    uint32_t pc = ctx->base.pc_next;
+    uint32_t pc_end = ctx->base.tb->cs_base;
+
     uint16_t insns[5];
     int ld_adr, ld_dst, ld_mop;
     int op_dst, op_src, op_opc;
     int mv_src, mt_dst, st_src, st_mop;
     TCGv op_arg;
-
-    uint32_t pc = ctx->base.pc_next;
-    uint32_t pc_end = ctx->base.tb->cs_base;
-    int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
-    int max_insns = (pc_end - pc) / 2;
     int i;
 
-    if (pc != pc_end + backup || max_insns < 2) {
-        /* This is a malformed gUSA region.  Don't do anything special,
-           since the interpreter is likely to get confused.  */
-        ctx->envflags &= ~GUSA_MASK;
-        return 0;
-    }
-
-    if (ctx->tbflags & GUSA_EXCLUSIVE) {
-        /* Regardless of single-stepping or the end of the page,
-           we must complete execution of the gUSA region while
-           holding the exclusive lock.  */
-        *pmax_insns = max_insns;
-        return 0;
-    }
-
     /* The state machine below will consume only a few insns.
        If there are more than that in a region, fail now.  */
     if (max_insns > ARRAY_SIZE(insns)) {
@@ -2146,7 +2231,6 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     /*
      * Emit the operation.
      */
-    tcg_gen_insn_start(pc, ctx->envflags);
     switch (op_opc) {
     case -1:
         /* No operation found.  Look for exchange pattern.  */
@@ -2239,9 +2323,13 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     }
 
     /* The entire region has been translated.  */
-    ctx->envflags &= ~GUSA_MASK;
     ctx->base.pc_next = pc_end;
-    return max_insns;
+    ctx->base.num_insns = max_insns;
+
+    /* Revert to normal parsing for the rest of the TB.  */
+    ctx->envflags &= ~GUSA_MASK;
+    ctx->ops.translate_insn = sh4_tr_translate_insn;
+    return;
 
  fail:
     qemu_log_mask(LOG_UNIMP, "Unrecognized gUSA sequence %08x-%08x\n",
@@ -2249,7 +2337,6 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 
     /* Restart with the EXCLUSIVE bit set, within a TB run via
        cpu_exec_step_atomic holding the exclusive lock.  */
-    tcg_gen_insn_start(pc, ctx->envflags);
     ctx->envflags |= GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(cpu_env);
@@ -2260,129 +2347,64 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
        entire region consumed via ctx->base.pc_next so that it's immediately
        available in the disassembly dump.  */
     ctx->base.pc_next = pc_end;
-    return 1;
 }
 #endif
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static void sh4_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
-    CPUSH4State *env = cs->env_ptr;
-    DisasContext ctx;
-    target_ulong pc_start;
-    int num_insns;
-    int max_insns;
-
-    pc_start = tb->pc;
-    ctx.base.pc_next = pc_start;
-    ctx.tbflags = (uint32_t)tb->flags;
-    ctx.envflags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
-    ctx.base.is_jmp = DISAS_NEXT;
-    ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
-    /* We don't know if the delayed pc came from a dynamic or static branch,
-       so assume it is a dynamic branch.  */
-    ctx.delayed_pc = -1; /* use delayed pc from env pointer */
-    ctx.base.tb = tb;
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.features = env->features;
-    ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
-    ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
-                 (ctx.tbflags & (1 << SR_RB))) * 0x10;
-    ctx.fbank = ctx.tbflags & FPSCR_FR ? 0x10 : 0;
-
-    max_insns = tb->cflags & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    max_insns = MIN(max_insns, TCG_MAX_INSNS);
-
-    /* Since the ISA is fixed-width, we can bound by the number
-       of instructions remaining on the page.  */
-    num_insns = -(ctx.base.pc_next | TARGET_PAGE_MASK) / 2;
-    max_insns = MIN(max_insns, num_insns);
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    /* Single stepping means just that.  */
-    if (ctx.base.singlestep_enabled || singlestep) {
-        max_insns = 1;
-    }
-
-    gen_tb_start(tb);
-    num_insns = 0;
-
-#ifdef CONFIG_USER_ONLY
-    if (ctx.tbflags & GUSA_MASK) {
-        num_insns = decode_gusa(&ctx, env, &max_insns);
-    }
-#endif
-
-    while (ctx.base.is_jmp == DISAS_NEXT
-           && num_insns < max_insns
-           && !tcg_op_buf_full()) {
-        tcg_gen_insn_start(ctx.base.pc_next, ctx.envflags);
-        num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
-            /* We have hit a breakpoint - make sure PC is up-to-date */
-            gen_save_cpu_state(&ctx, true);
-            gen_helper_debug(cpu_env);
-            ctx.base.is_jmp = DISAS_NORETURN;
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            ctx.base.pc_next += 2;
-            break;
-        }
-
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
-	decode_opc(&ctx);
-	ctx.base.pc_next += 2;
-    }
-    if (tb->cflags & CF_LAST_IO) {
-        gen_io_end();
-    }
-
-    if (ctx.tbflags & GUSA_EXCLUSIVE) {
+    if (ctx->tbflags & GUSA_EXCLUSIVE) {
         /* Ending the region of exclusivity.  Clear the bits.  */
-        ctx.envflags &= ~GUSA_MASK;
+        ctx->envflags &= ~GUSA_MASK;
     }
 
-    switch (ctx.base.is_jmp) {
+    switch (ctx->base.is_jmp) {
     case DISAS_STOP:
-        gen_save_cpu_state(&ctx, true);
-        if (ctx.base.singlestep_enabled) {
+        gen_save_cpu_state(ctx, true);
+        if (ctx->base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else {
             tcg_gen_exit_tb(0);
         }
         break;
-    case DISAS_NEXT:
-        gen_save_cpu_state(&ctx, false);
-        gen_goto_tb(&ctx, 0, ctx.base.pc_next);
+    case DISAS_TOO_MANY:
+        gen_save_cpu_state(ctx, false);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next);
         break;
     case DISAS_NORETURN:
         break;
     default:
         g_assert_not_reached();
     }
+}
 
-    gen_tb_end(tb, num_insns);
+static void sh4_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size, 0);
+}
 
-    tb->size = ctx.base.pc_next - pc_start;
-    tb->icount = num_insns;
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
+{
+    static const TranslatorOps ops = {
+        .init_disas_context = sh4_tr_init_disas_context,
+        .tb_start           = sh4_tr_tb_start,
+        .insn_start         = sh4_tr_insn_start,
+        .breakpoint_check   = sh4_tr_breakpoint_check,
+        .translate_insn     = sh4_tr_translate_insn,
+        .tb_stop            = sh4_tr_tb_stop,
+        .disas_log          = sh4_tr_disas_log,
+    };
+    DisasContext ctx;
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-	qemu_log("IN:\n");	/* , lookup_symbol(pc_start)); */
-        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start, 0);
-	qemu_log("\n");
-        qemu_log_unlock();
-    }
+#ifdef CONFIG_USER_ONLY
+    /* We may switch the translate_insn hook in init_disas_context
+       and within translate_insn itself.  */
+    ctx.ops = ops;
+    translator_loop(&ctx.ops, &ctx.base, cpu, tb);
+#else
+    translator_loop(&ops, &ctx.base, cpu, tb);
 #endif
 }
 
-- 
2.13.5
