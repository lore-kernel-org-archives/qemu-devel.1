Received: from eggs.gnu.org ([2001:4830:134:3::10]:56339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOk-0002X1-26
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSKOf-0000mp-OT
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSKOf-0000lA-96
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:50:01 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Jun 2018 12:49:33 +0200
Message-Id: <20180611104935.20499-8-laurent@vivier.eu>
In-Reply-To: <20180611104935.20499-1-laurent@vivier.eu>
References: <20180611104935.20499-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 7/9] target/m68k: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512050250.12774-8-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 180 +++++++++++++++++++++++-------------------------
 1 file changed, 88 insertions(+), 92 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 12a74b0b59..62a96bedcd 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6059,113 +6059,109 @@ static void disas_m68k_insn(CPUM68KState * env, DisasContext *s)
     do_release(s);
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void m68k_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
-    CPUM68KState *env = cs->env_ptr;
-    DisasContext dc1, *dc = &dc1;
-    target_ulong pc_start;
-    int pc_offset;
-    int num_insns;
-    int max_insns;
-
-    /* generate intermediate code */
-    pc_start = tb->pc;
-
-    dc->base.tb = tb;
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUM68KState *env = cpu->env_ptr;
 
     dc->env = env;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->pc = pc_start;
+    dc->pc = dc->base.pc_first;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->cc_op_synced = 1;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
     dc->done_mac = 0;
     dc->writeback_mask = 0;
-    num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-
     init_release_array(dc);
+}
 
-    gen_tb_start(tb);
-    do {
-        pc_offset = dc->pc - pc_start;
-        tcg_gen_insn_start(dc->pc, dc->cc_op);
-        num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
-            gen_exception(dc, dc->pc, EXCP_DEBUG);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc->pc += 2;
-            break;
-        }
+static void m68k_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+}
 
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static void m68k_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+}
 
-        dc->base.pc_next = dc->pc;
-	disas_m68k_insn(env, dc);
-    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
-             !singlestep &&
-             (pc_offset) < (TARGET_PAGE_SIZE - 32) &&
-             num_insns < max_insns);
-
-    if (tb_cflags(tb) & CF_LAST_IO)
-        gen_io_end();
-    if (unlikely(cs->singlestep_enabled)) {
-        /* Make sure the pc is updated, and raise a debug exception.  */
-        if (!dc->base.is_jmp) {
-            update_cc_op(dc);
-            tcg_gen_movi_i32(QREG_PC, dc->pc);
-        }
+static bool m68k_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                     const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    gen_exception(dc, dc->base.pc_next, EXCP_DEBUG);
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    dc->base.pc_next += 2;
+
+    return true;
+}
+
+static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    disas_m68k_insn(cpu->env_ptr, dc);
+    dc->base.pc_next = dc->pc;
+
+    if (dc->base.is_jmp == DISAS_NEXT
+        && dc->pc - dc->base.pc_first >= TARGET_PAGE_SIZE - 32) {
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    }
+}
+
+static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (dc->base.is_jmp == DISAS_NORETURN) {
+        return;
+    }
+    if (dc->base.singlestep_enabled) {
         gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
-    } else {
-        switch (dc->base.is_jmp) {
-        case DISAS_NEXT:
-            update_cc_op(dc);
-            gen_jmp_tb(dc, 0, dc->pc);
-            break;
-        case DISAS_JUMP:
-            /* We updated CC_OP and PC in gen_jmp/gen_jmp_im.  */
-            tcg_gen_lookup_and_goto_ptr();
-            break;
-        default:
-        case DISAS_EXIT:
-            /* We updated CC_OP and PC in gen_exit_tb, but also modified
-               other state that may require returning to the main loop.  */
-            tcg_gen_exit_tb(NULL, 0);
-            break;
-        case DISAS_NORETURN:
-            /* nothing more to generate */
-            break;
-        }
+        return;
     }
-    gen_tb_end(tb, num_insns);
 
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start);
-        qemu_log("\n");
-        qemu_log_unlock();
+    switch (dc->base.is_jmp) {
+    case DISAS_TOO_MANY:
+        update_cc_op(dc);
+        gen_jmp_tb(dc, 0, dc->pc);
+        break;
+    case DISAS_JUMP:
+        /* We updated CC_OP and PC in gen_jmp/gen_jmp_im.  */
+        tcg_gen_lookup_and_goto_ptr();
+        break;
+    case DISAS_EXIT:
+        /* We updated CC_OP and PC in gen_exit_tb, but also modified
+           other state that may require returning to the main loop.  */
+        tcg_gen_exit_tb(NULL, 0);
+        break;
+    default:
+        g_assert_not_reached();
     }
-#endif
-    tb->size = dc->pc - pc_start;
-    tb->icount = num_insns;
+}
+
+static void m68k_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps m68k_tr_ops = {
+    .init_disas_context = m68k_tr_init_disas_context,
+    .tb_start           = m68k_tr_tb_start,
+    .insn_start         = m68k_tr_insn_start,
+    .breakpoint_check   = m68k_tr_breakpoint_check,
+    .translate_insn     = m68k_tr_translate_insn,
+    .tb_stop            = m68k_tr_tb_stop,
+    .disas_log          = m68k_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
+{
+    DisasContext dc;
+    translator_loop(&m68k_tr_ops, &dc.base, cpu, tb);
 }
 
 static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
-- 
2.14.4
