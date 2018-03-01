Received: from eggs.gnu.org ([2001:4830:134:3::10]:33083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erX5Q-0000J8-FO
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1erX5M-0004p2-Vp
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:04 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1erX5M-0004lW-Ov
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:54:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  1 Mar 2018 17:53:46 -0500
Message-Id: <1519944838-12430-3-git-send-email-cota@braap.org>
In-Reply-To: <1519944838-12430-1-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCHv1 02/14] target/sh4: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This was fairly straightforward since it had already been converted
to DisasContextBase; just had to add TARGET_TOO_MANY to the switch
in tb_stop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sh4/translate.c | 171 +++++++++++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 85 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 012156b..58bdfeb 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2258,126 +2258,127 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 }
 #endif
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUSH4State *env = cs->env_ptr;
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
+    int bound;
+
+    ctx->tbflags = (uint32_t)ctx->base.tb->flags;
+    ctx->envflags = ctx->base.tb->flags & TB_FLAG_ENVFLAGS_MASK;
+    ctx->memidx = (ctx->tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
     /* We don't know if the delayed pc came from a dynamic or static branch,
        so assume it is a dynamic branch.  */
-    ctx.delayed_pc = -1; /* use delayed pc from env pointer */
-    ctx.base.tb = tb;
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.features = env->features;
-    ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
-    ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
-                 (ctx.tbflags & (1 << SR_RB))) * 0x10;
-    ctx.fbank = ctx.tbflags & FPSCR_FR ? 0x10 : 0;
-
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    max_insns = MIN(max_insns, TCG_MAX_INSNS);
+    ctx->delayed_pc = -1; /* use delayed pc from env pointer */
+    ctx->features = env->features;
+    ctx->has_movcal = (ctx->tbflags & TB_FLAG_PENDING_MOVCA);
+    ctx->gbank = ((ctx->tbflags & (1 << SR_MD)) &&
+                  (ctx->tbflags & (1 << SR_RB))) * 0x10;
+    ctx->fbank = ctx->tbflags & FPSCR_FR ? 0x10 : 0;
 
     /* Since the ISA is fixed-width, we can bound by the number
        of instructions remaining on the page.  */
-    num_insns = -(ctx.base.pc_next | TARGET_PAGE_MASK) / 2;
-    max_insns = MIN(max_insns, num_insns);
-
-    /* Single stepping means just that.  */
-    if (ctx.base.singlestep_enabled || singlestep) {
-        max_insns = 1;
-    }
-
-    gen_tb_start(tb);
-    num_insns = 0;
+    bound = -(ctx->base.pc_next | TARGET_PAGE_MASK) / 2;
+    ctx->base.max_insns = MIN(ctx->base.max_insns, bound);
+}
 
+static void sh4_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
+{
 #ifdef CONFIG_USER_ONLY
-    if (ctx.tbflags & GUSA_MASK) {
-        num_insns = decode_gusa(&ctx, env, &max_insns);
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUSH4State *env = cs->env_ptr;
+
+    if (ctx->tbflags & GUSA_MASK) {
+        ctx->base.num_insns = decode_gusa(ctx, env, &ctx->base.max_insns);
     }
 #endif
+}
 
-    while (ctx.base.is_jmp == DISAS_NEXT
-           && num_insns < max_insns
-           && !tcg_op_buf_full()) {
-        tcg_gen_insn_start(ctx.base.pc_next, ctx.envflags);
-        num_insns++;
+static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
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
+    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags);
+}
 
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static bool sh4_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-        ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
-	decode_opc(&ctx);
-        ctx.base.pc_next += 2;
-    }
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
-    }
+    /* We have hit a breakpoint - make sure PC is up-to-date */
+    gen_save_cpu_state(ctx, true);
+    gen_helper_debug(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    ctx->base.pc_next += 2;
+    return true;
+}
+
+static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    CPUSH4State *env = cs->env_ptr;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    if (ctx.tbflags & GUSA_EXCLUSIVE) {
+    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    decode_opc(ctx);
+    ctx->base.pc_next += 2;
+}
+
+static void sh4_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
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
     case DISAS_NEXT:
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
+static void sh4_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    qemu_log("IN:\n");  /* , lookup_symbol(dcbase->pc_first)); */
+    log_target_disas(cs, dcbase->pc_first, dcbase->tb->size);
+}
 
-    tb->size = ctx.base.pc_next - pc_start;
-    tb->icount = num_insns;
+static const TranslatorOps sh4_tr_ops = {
+    .init_disas_context = sh4_tr_init_disas_context,
+    .tb_start           = sh4_tr_tb_start,
+    .insn_start         = sh4_tr_insn_start,
+    .breakpoint_check   = sh4_tr_breakpoint_check,
+    .translate_insn     = sh4_tr_translate_insn,
+    .tb_stop            = sh4_tr_tb_stop,
+    .disas_log          = sh4_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    DisasContext ctx;
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-	qemu_log("IN:\n");	/* , lookup_symbol(pc_start)); */
-        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start);
-	qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
+    translator_loop(&sh4_tr_ops, &ctx.base, cs, tb);
 }
 
 void restore_state_to_opc(CPUSH4State *env, TranslationBlock *tb,
-- 
2.7.4
