Received: from eggs.gnu.org ([2001:4830:134:3::10]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYlz-00063K-OL
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYly-0002vF-AC
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:35 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHYly-0002us-2n
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:34 -0400
Received: by mail-pf0-x242.google.com with SMTP id e9-v6so4152429pfi.4
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 10:57:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 12 May 2018 10:57:24 -0700
Message-Id: <20180512175724.5923-5-richard.henderson@linaro.org>
In-Reply-To: <20180512175724.5923-1-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] target/xtensa: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcmvbkbc@gmail.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 229 ++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 107 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 45f32dc71f..9de45e4be4 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1048,148 +1048,163 @@ static void gen_ibreak_check(CPUXtensaState *env, DisasContext *dc)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
+                                         CPUState *cpu)
 {
-    CPUXtensaState *env = cs->env_ptr;
-    DisasContext dc1, *dc = &dc1;
-    int insn_count = 0;
-    int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    uint32_t pc_start = tb->pc;
-    uint32_t page_start = pc_start & TARGET_PAGE_MASK;
-
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUXtensaState *env = cpu->env_ptr;
+    uint32_t tb_flags = dc->base.tb->flags;
 
     dc->config = env->config;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
-    dc->base.tb = tb;
-    dc->pc = pc_start;
-    dc->ring = tb->flags & XTENSA_TBFLAG_RING_MASK;
-    dc->cring = (tb->flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
+    dc->pc = dc->base.pc_first;
+    dc->ring = tb_flags & XTENSA_TBFLAG_RING_MASK;
+    dc->cring = (tb_flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
     dc->lbeg = env->sregs[LBEG];
     dc->lend = env->sregs[LEND];
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->debug = tb->flags & XTENSA_TBFLAG_DEBUG;
-    dc->icount = tb->flags & XTENSA_TBFLAG_ICOUNT;
-    dc->cpenable = (tb->flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
+    dc->debug = tb_flags & XTENSA_TBFLAG_DEBUG;
+    dc->icount = tb_flags & XTENSA_TBFLAG_ICOUNT;
+    dc->cpenable = (tb_flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
         XTENSA_TBFLAG_CPENABLE_SHIFT;
-    dc->window = ((tb->flags & XTENSA_TBFLAG_WINDOW_MASK) >>
+    dc->window = ((tb_flags & XTENSA_TBFLAG_WINDOW_MASK) >>
                  XTENSA_TBFLAG_WINDOW_SHIFT);
 
     if (dc->config->isa) {
         dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
         dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
     }
-
     init_sar_tracker(dc);
+}
+
+static void xtensa_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
     if (dc->icount) {
         dc->next_icount = tcg_temp_local_new_i32();
     }
+}
 
-    gen_tb_start(tb);
+static void xtensa_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    tcg_gen_insn_start(dcbase->pc_next);
+}
 
-    if ((tb_cflags(tb) & CF_USE_ICOUNT) &&
-        (tb->flags & XTENSA_TBFLAG_YIELD)) {
-        tcg_gen_insn_start(dc->pc);
-        ++insn_count;
+static bool xtensa_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                       const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
+    gen_exception(dc, EXCP_DEBUG);
+    dc->base.is_jmp = DISAS_NORETURN;
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    dc->base.pc_next += 2;
+    return true;
+}
+
+static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUXtensaState *env = cpu->env_ptr;
+    target_ulong page_start;
+
+    /* These two conditions only apply to the first insn in the TB,
+       but this is the first TranslateOps hook that allows exiting.  */
+    if ((tb_cflags(dc->base.tb) & CF_USE_ICOUNT)
+        && (dc->base.tb->flags & XTENSA_TBFLAG_YIELD)) {
         gen_exception(dc, EXCP_YIELD);
         dc->base.is_jmp = DISAS_NORETURN;
-        goto done;
+        return;
     }
-    if (tb->flags & XTENSA_TBFLAG_EXCEPTION) {
-        tcg_gen_insn_start(dc->pc);
-        ++insn_count;
+    if (dc->base.tb->flags & XTENSA_TBFLAG_EXCEPTION) {
         gen_exception(dc, EXCP_DEBUG);
         dc->base.is_jmp = DISAS_NORETURN;
-        goto done;
+        return;
     }
 
-    do {
-        tcg_gen_insn_start(dc->pc);
-        ++insn_count;
-
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
-            tcg_gen_movi_i32(cpu_pc, dc->pc);
-            gen_exception(dc, EXCP_DEBUG);
-            dc->base.is_jmp = DISAS_NORETURN;
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc->pc += 2;
-            break;
-        }
-
-        if (insn_count == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        if (dc->icount) {
-            TCGLabel *label = gen_new_label();
-
-            tcg_gen_addi_i32(dc->next_icount, cpu_SR[ICOUNT], 1);
-            tcg_gen_brcondi_i32(TCG_COND_NE, dc->next_icount, 0, label);
-            tcg_gen_mov_i32(dc->next_icount, cpu_SR[ICOUNT]);
-            if (dc->debug) {
-                gen_debug_exception(dc, DEBUGCAUSE_IC);
-            }
-            gen_set_label(label);
-        }
-
-        if (dc->debug) {
-            gen_ibreak_check(env, dc);
-        }
-
-        disas_xtensa_insn(env, dc);
-        if (dc->icount) {
-            tcg_gen_mov_i32(cpu_SR[ICOUNT], dc->next_icount);
-        }
-        if (dc->base.singlestep_enabled) {
-            tcg_gen_movi_i32(cpu_pc, dc->pc);
-            gen_exception(dc, EXCP_DEBUG);
-            break;
-        }
-    } while (dc->base.is_jmp == DISAS_NEXT &&
-             insn_count < max_insns &&
-             dc->pc - page_start < TARGET_PAGE_SIZE &&
-             dc->pc - page_start + xtensa_insn_len(env, dc) <= TARGET_PAGE_SIZE
-             && !tcg_op_buf_full());
-done:
-    reset_sar_tracker(dc);
     if (dc->icount) {
-        tcg_temp_free(dc->next_icount);
+        TCGLabel *label = gen_new_label();
+
+        tcg_gen_addi_i32(dc->next_icount, cpu_SR[ICOUNT], 1);
+        tcg_gen_brcondi_i32(TCG_COND_NE, dc->next_icount, 0, label);
+        tcg_gen_mov_i32(dc->next_icount, cpu_SR[ICOUNT]);
+        if (dc->debug) {
+            gen_debug_exception(dc, DEBUGCAUSE_IC);
+        }
+        gen_set_label(label);
     }
+
+    if (dc->debug) {
+        gen_ibreak_check(env, dc);
+    }
+
+    disas_xtensa_insn(env, dc);
+
+    if (dc->icount) {
+        tcg_gen_mov_i32(cpu_SR[ICOUNT], dc->next_icount);
+    }
+
+    /* End the TB if the next insn will cross into the next page.  */
+    page_start = dc->base.pc_first & TARGET_PAGE_MASK;
+    if (dc->base.is_jmp == DISAS_NEXT &&
+        dc->pc - page_start < TARGET_PAGE_SIZE &&
+        dc->pc - page_start + xtensa_insn_len(env, dc) <= TARGET_PAGE_SIZE) {
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    }
+}
+
+static void xtensa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    reset_sar_tracker(dc);
     if (dc->config->isa) {
         xtensa_insnbuf_free(dc->config->isa, dc->insnbuf);
         xtensa_insnbuf_free(dc->config->isa, dc->slotbuf);
     }
-
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
+    if (dc->icount) {
+        tcg_temp_free(dc->next_icount);
     }
 
-    if (dc->base.is_jmp == DISAS_NEXT) {
-        gen_jumpi(dc, dc->pc, 0);
+    switch (dc->base.is_jmp) {
+    case DISAS_NORETURN:
+        break;
+    case DISAS_TOO_MANY:
+        if (dc->base.singlestep_enabled) {
+            tcg_gen_movi_i32(cpu_pc, dc->pc);
+            gen_exception(dc, EXCP_DEBUG);
+        } else {
+            gen_jumpi(dc, dc->pc, 0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
     }
-    gen_tb_end(tb, insn_count);
+}
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-    tb->size = dc->pc - pc_start;
-    tb->icount = insn_count;
+static void xtensa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps xtensa_translator_ops = {
+    .init_disas_context = xtensa_tr_init_disas_context,
+    .tb_start           = xtensa_tr_tb_start,
+    .insn_start         = xtensa_tr_insn_start,
+    .breakpoint_check   = xtensa_tr_breakpoint_check,
+    .translate_insn     = xtensa_tr_translate_insn,
+    .tb_stop            = xtensa_tr_tb_stop,
+    .disas_log          = xtensa_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    DisasContext dc = {};
+    translator_loop(&xtensa_translator_ops, &dc.base, cpu, tb);
 }
 
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
-- 
2.17.0
