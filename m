Received: from eggs.gnu.org ([2001:4830:134:3::10]:48667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy7-0003lI-3U
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy3-0000TS-Ik
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  6 Apr 2018 14:19:55 -0400
Message-Id: <1523038800-2494-13-git-send-email-cota@braap.org>
In-Reply-To: <1523038800-2494-1-git-send-email-cota@braap.org>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 12/17] target/s390x: convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

Note: I looked into dropping dc->do_debug. However, I don't see
an easy way to do it given that TOO_MANY is also valid
when we just translate more than max_insns. Thus, the check
for do_debug in "case DISAS_PC_CC_UPDATED" would still need
additional state to know whether or not we came from
breakpoint_check.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by:   David Hildenbrand <david@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/s390x/translate.c | 162 +++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 82 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a65e9cd..2cbd870 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -64,6 +64,7 @@ struct DisasContext {
     uint64_t pc_tmp;
     uint32_t ilen;
     enum cc_op cc_op;
+    bool do_debug;
 };
 
 /* Information carried about a condition to be evaluated.  */
@@ -6158,98 +6159,87 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     return ret;
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPUS390XState *env = cs->env_ptr;
-    DisasContext dc;
-    uint64_t next_page_start;
-    int num_insns, max_insns;
-    DisasJumpType status;
-    bool do_debug;
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    dc.base.pc_first = tb->pc;
     /* 31-bit mode */
-    if (!(tb->flags & FLAG_MASK_64)) {
-        dc.base.pc_first &= 0x7fffffff;
+    if (!(dc->base.tb->flags & FLAG_MASK_64)) {
+        dc->base.pc_first &= 0x7fffffff;
+        dc->base.pc_next = dc->base.pc_first;
     }
-    dc.base.pc_next = dc.base.pc_first;
-    dc.base.tb = tb;
-    dc.base.singlestep_enabled = cs->singlestep_enabled;
 
-    dc.cc_op = CC_OP_DYNAMIC;
-    dc.ex_value = dc.base.tb->cs_base;
-    do_debug = cs->singlestep_enabled;
+    dc->cc_op = CC_OP_DYNAMIC;
+    dc->ex_value = dc->base.tb->cs_base;
+    dc->do_debug = dc->base.singlestep_enabled;
+}
 
-    next_page_start = (dc.base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
+{
+}
 
-    num_insns = 0;
-    max_insns = tb_cflags(tb) & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
+static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    gen_tb_start(tb);
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+}
 
-    do {
-        tcg_gen_insn_start(dc.base.pc_next, dc.cc_op);
-        num_insns++;
+static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                      const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-        if (unlikely(cpu_breakpoint_test(cs, dc.base.pc_next, BP_ANY))) {
-            status = DISAS_PC_STALE;
-            do_debug = true;
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc.base.pc_next += 2;
-            break;
-        }
+    dc->base.is_jmp = DISAS_PC_STALE;
+    dc->do_debug = true;
+    /* The address covered by the breakpoint must be included in
+       [tb->pc, tb->pc + tb->size) in order to for it to be
+       properly cleared -- thus we increment the PC here so that
+       the logic setting tb->size does the right thing.  */
+    dc->base.pc_next += 2;
+    return true;
+}
 
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
-        }
+static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    CPUS390XState *env = cs->env_ptr;
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-        status = translate_one(env, &dc);
-
-        /* If we reach a page boundary, are single stepping,
-           or exhaust instruction count, stop generation.  */
-        if (status == DISAS_NEXT
-            && (dc.base.pc_next >= next_page_start
-                || tcg_op_buf_full()
-                || num_insns >= max_insns
-                || singlestep
-                || dc.base.singlestep_enabled
-                || dc.ex_value)) {
-            status = DISAS_TOO_MANY;
-        }
-    } while (status == DISAS_NEXT);
+    dc->base.is_jmp = translate_one(env, dc);
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        uint64_t next_page;
 
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
+        next_page = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+        if (dc->base.pc_next >= next_page || dc->ex_value) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
     }
+}
+
+static void s390x_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    switch (status) {
+    switch (dc->base.is_jmp) {
     case DISAS_GOTO_TB:
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
     case DISAS_PC_STALE:
     case DISAS_PC_STALE_NOCHAIN:
-        update_psw_addr(&dc);
+        update_psw_addr(dc);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         /* Next TB starts off with CC_OP_DYNAMIC, so make sure the
            cc op type is in env */
-        update_cc_op(&dc);
+        update_cc_op(dc);
         /* FALLTHRU */
     case DISAS_PC_CC_UPDATED:
         /* Exit the TB, either by raising a debug exception or by return.  */
-        if (do_debug) {
+        if (dc->do_debug) {
             gen_exception(EXCP_DEBUG);
-        } else if (use_exit_tb(&dc) || status == DISAS_PC_STALE_NOCHAIN) {
+        } else if (use_exit_tb(dc) ||
+                   dc->base.is_jmp == DISAS_PC_STALE_NOCHAIN) {
             tcg_gen_exit_tb(0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
@@ -6258,28 +6248,36 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     default:
         g_assert_not_reached();
     }
+}
 
-    gen_tb_end(tb, num_insns);
-
-    tb->size = dc.base.pc_next - dc.base.pc_first;
-    tb->icount = num_insns;
+static void s390x_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-#if defined(S390X_DEBUG_DISAS)
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(dc.base.pc_first)) {
-        qemu_log_lock();
-        if (unlikely(dc.ex_value)) {
-            /* ??? Unfortunately log_target_disas can't use host memory.  */
-            qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
-        } else {
-            qemu_log("IN: %s\n", lookup_symbol(dc.base.pc_first));
-            log_target_disas(cs, dc.base.pc_first,
-                             dc.base.pc_next - dc.base.pc_first);
-            qemu_log("\n");
-        }
-        qemu_log_unlock();
+    if (unlikely(dc->ex_value)) {
+        /* ??? Unfortunately log_target_disas can't use host memory.  */
+        qemu_log("IN: EXECUTE %016" PRIx64, dc->ex_value);
+    } else {
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+        log_target_disas(cs, dc->base.pc_first, dc->base.tb->size);
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
