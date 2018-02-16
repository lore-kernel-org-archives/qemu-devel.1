Received: from eggs.gnu.org ([2001:4830:134:3::10]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1empcf-0005E2-N3
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1empcd-0000UB-H1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:40:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 16 Feb 2018 18:40:46 -0500
Message-Id: <1518824446-20235-4-git-send-email-cota@braap.org>
In-Reply-To: <1518824446-20235-1-git-send-email-cota@braap.org>
References: <1518824446-20235-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/3] target/s390x: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/s390x/translate.c | 170 ++++++++++++++++++++++++-----------------------
 1 file changed, 86 insertions(+), 84 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index dd504a1..2b27a69 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -55,10 +55,12 @@ struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
     DisasFields *fields;
+    uint64_t next_page_start;
     uint64_t ex_value;
     uint64_t pc, next_pc;
     uint32_t ilen;
     enum cc_op cc_op;
+    bool do_debug;
 };
 
 /* Information carried about a condition to be evaluated.  */
@@ -6108,101 +6110,92 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     return ret;
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static int s390x_tr_init_disas_context(DisasContextBase *dcbase,
+                                       CPUState *cs, int max_insns)
 {
-    CPUS390XState *env = cs->env_ptr;
-    DisasContext dc;
-    uint64_t next_page_start;
-    int num_insns, max_insns;
-    DisasJumpType status;
-    bool do_debug;
+    DisasContext *s = container_of(dcbase, DisasContext, base);
 
-    dc.base.pc_first = tb->pc;
     /* 31-bit mode */
-    if (!(tb->flags & FLAG_MASK_64)) {
-        dc.base.pc_first &= 0x7fffffff;
+    if (!(s->base.tb->flags & FLAG_MASK_64)) {
+        s->base.pc_first &= 0x7fffffff;
+        s->base.pc_next = s->base.pc_first;
     }
-    dc.base.pc_next = dc.base.pc_first;
-    dc.base.tb = tb;
-    dc.base.singlestep_enabled = cs->singlestep_enabled;
 
-    dc.pc = dc.base.pc_first;
-    dc.cc_op = CC_OP_DYNAMIC;
-    dc.ex_value = dc.base.tb->cs_base;
-    do_debug = cs->singlestep_enabled;
+    s->pc = s->base.pc_first;
+    s->cc_op = CC_OP_DYNAMIC;
+    s->ex_value = s->base.tb->cs_base;
+    s->do_debug = s->base.singlestep_enabled;
+    s->next_page_start = (s->base.pc_first & TARGET_PAGE_MASK) +
+        TARGET_PAGE_SIZE;
 
-    next_page_start = (dc.base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    return max_insns;
+}
 
-    num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
+static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
+{
+}
 
-    gen_tb_start(tb);
+static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *s = container_of(dcbase, DisasContext, base);
 
-    do {
-        tcg_gen_insn_start(dc.pc, dc.cc_op);
-        num_insns++;
+    tcg_gen_insn_start(s->pc, s->cc_op);
+}
 
-        if (unlikely(cpu_breakpoint_test(cs, dc.base.pc_next, BP_ANY))) {
-            status = DISAS_PC_STALE;
-            do_debug = true;
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc.pc += 2;
-            dc.base.pc_next += 2;
-            break;
-        }
+static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                      const CPUBreakpoint *bp)
+{
+    DisasContext *s = container_of(dcbase, DisasContext, base);
 
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
+    s->base.is_jmp = DISAS_PC_STALE;
+    s->do_debug = true;
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size below does the right thing.  */
+    s->pc += 2;
+    s->base.pc_next += 2;
+    return true;
+}
 
-        status = translate_one(env, &dc);
-        dc.base.pc_next = dc.pc;
-
-        /* If we reach a page boundary, are single stepping,
-           or exhaust instruction count, stop generation.  */
-        if (status == DISAS_NEXT
-            && (dc.pc >= next_page_start
-                || tcg_op_buf_full()
-                || num_insns >= max_insns
-                || singlestep
-                || dc.base.singlestep_enabled
-                || dc.ex_value)) {
-            status = DISAS_TOO_MANY;
-        }
-    } while (status == DISAS_NEXT);
+static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    CPUS390XState *env = cs->env_ptr;
+    DisasContext *s = container_of(dcbase, DisasContext, base);
+
+    s->base.is_jmp = translate_one(env, s);
+    s->base.pc_next = s->pc;
 
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
+    if (s->base.is_jmp == DISAS_NEXT
+        && (s->pc >= s->next_page_start
+            || s->ex_value)) {
+        s->base.is_jmp = DISAS_TOO_MANY;
     }
+}
 
-    switch (status) {
+static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *s = container_of(dcbase, DisasContext, base);
+
+    switch (s->base.is_jmp) {
     case DISAS_GOTO_TB:
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
     case DISAS_PC_STALE:
     case DISAS_PC_STALE_NOCHAIN:
-        update_psw_addr(&dc);
+        update_psw_addr(s);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
            cc op type is in env */
-        update_cc_op(&dc);
+        update_cc_op(s);
         /* FALLTHRU */
     case DISAS_PC_CC_UPDATED:
         /* Exit the TB, either by raising a debug exception or by return.  */
-        if (do_debug) {
+        if (s->do_debug) {
             gen_exception(EXCP_DEBUG);
-        } else if (use_exit_tb(&dc) || status == DISAS_PC_STALE_NOCHAIN) {
+        } else if (use_exit_tb(s) || s->base.is_jmp == DISAS_PC_STALE_NOCHAIN) {
             tcg_gen_exit_tb(0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
@@ -6211,27 +6204,36 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     default:
         g_assert_not_reached();
     }
+}
 
-    gen_tb_end(tb, num_insns);
-
-    tb->size = dc.pc - dc.base.pc_first;
-    tb->icount = num_insns;
+static void s390x_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *s = container_of(dcbase, DisasContext, base);
 
-#if defined(S390X_DEBUG_DISAS)
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(dc.base.pc_first)) {
-        qemu_log_lock();
-        if (unlikely(dc.ex_value)) {
-            /* ??? Unfortunately log_target_disas can't use host memory.  */
-            qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
-        } else {
-            qemu_log("IN: %s\n", lookup_symbol(dc.base.pc_first));
-            log_target_disas(cs, dc.base.pc_first, dc.pc - dc.base.pc_first);
-            qemu_log("\n");
-        }
-        qemu_log_unlock();
+    if (unlikely(s->ex_value)) {
+        /* ??? Unfortunately log_target_disas can't use host memory.  */
+        qemu_log("IN: EXECUTE %016" PRIx64, s->ex_value);
+    } else {
+        qemu_log("IN: %s\n", lookup_symbol(s->base.pc_first));
+        log_target_disas(cs, s->base.pc_first, s->base.tb->size);
     }
-#endif
+}
+
+static const TranslatorOps s390x_tr_ops = {
+    .init_disas_context = s390x_tr_init_disas_context,
+    .tb_start           = s390x_tr_tb_start,
+    .insn_start         = s390x_tr_insn_start,
+    .breakpoint_check   = s390x_tr_breakpoint_check,
+    .translate_insn     = s390x_tr_translate_insn,
+    .tb_stop            = s390x_tr_tb_stop,
+    .disas_log          = s390x_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    DisasContext dc;
+
+    translator_loop(&s390x_tr_ops, &dc.base, cs, tb);
 }
 
 void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
-- 
2.7.4
