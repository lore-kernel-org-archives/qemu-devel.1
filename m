Received: from eggs.gnu.org ([2001:4830:134:3::10]:60085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1empcf-0005E4-N5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1empcd-0000Tv-6G
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 18:40:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 16 Feb 2018 18:40:45 -0500
Message-Id: <1518824446-20235-3-git-send-email-cota@braap.org>
In-Reply-To: <1518824446-20235-1-git-send-email-cota@braap.org>
References: <1518824446-20235-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/3] target/s390x: convert to DisasContextBase
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

Notes:

- Kept ctx.pc and ctx.next_pc; it would be very confusing
  to have ctx.base.pc_next and ctx.next_pc !
  Instead, just updated ctx.base.pc_next where relevant.

- Did not convert num_insns and is_jmp, since the corresponding
  code will go away in the next patch.

- Avoided a checkpatch error in use_exit_tb.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/s390x/translate.c | 85 ++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5346791..dd504a1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -52,14 +52,13 @@ typedef struct DisasInsn DisasInsn;
 typedef struct DisasFields DisasFields;
 
 struct DisasContext {
-    struct TranslationBlock *tb;
+    DisasContextBase base;
     const DisasInsn *insn;
     DisasFields *fields;
     uint64_t ex_value;
     uint64_t pc, next_pc;
     uint32_t ilen;
     enum cc_op cc_op;
-    bool singlestep_enabled;
 };
 
 /* Information carried about a condition to be evaluated.  */
@@ -81,8 +80,8 @@ static uint64_t inline_branch_miss[CC_OP_MAX];
 
 static uint64_t pc_to_link_info(DisasContext *s, uint64_t pc)
 {
-    if (!(s->tb->flags & FLAG_MASK_64)) {
-        if (s->tb->flags & FLAG_MASK_32) {
+    if (!(s->base.tb->flags & FLAG_MASK_64)) {
+        if (s->base.tb->flags & FLAG_MASK_32) {
             return pc | 0x80000000;
         }
     }
@@ -196,7 +195,7 @@ static void per_branch(DisasContext *s, bool to_next)
 #ifndef CONFIG_USER_ONLY
     tcg_gen_movi_i64(gbea, s->pc);
 
-    if (s->tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER) {
         TCGv_i64 next_pc = to_next ? tcg_const_i64(s->next_pc) : psw_addr;
         gen_helper_per_branch(cpu_env, gbea, next_pc);
         if (to_next) {
@@ -210,7 +209,7 @@ static void per_branch_cond(DisasContext *s, TCGCond cond,
                             TCGv_i64 arg1, TCGv_i64 arg2)
 {
 #ifndef CONFIG_USER_ONLY
-    if (s->tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER) {
         TCGLabel *lab = gen_new_label();
         tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
 
@@ -250,7 +249,7 @@ static inline uint64_t ld_code4(CPUS390XState *env, uint64_t pc)
 
 static int get_mem_index(DisasContext *s)
 {
-    switch (s->tb->flags & FLAG_MASK_ASC) {
+    switch (s->base.tb->flags & FLAG_MASK_ASC) {
     case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
         return 0;
     case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
@@ -315,7 +314,7 @@ static inline void gen_trap(DisasContext *s)
 #ifndef CONFIG_USER_ONLY
 static void check_privileged(DisasContext *s)
 {
-    if (s->tb->flags & FLAG_MASK_PSTATE) {
+    if (s->base.tb->flags & FLAG_MASK_PSTATE) {
         gen_program_exception(s, PGM_PRIVILEGED);
     }
 }
@@ -324,7 +323,7 @@ static void check_privileged(DisasContext *s)
 static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
-    bool need_31 = !(s->tb->flags & FLAG_MASK_64);
+    bool need_31 = !(s->base.tb->flags & FLAG_MASK_64);
 
     /* Note that d2 is limited to 20 bits, signed.  If we crop negative
        displacements early we create larger immedate addends.  */
@@ -537,9 +536,9 @@ static void gen_op_calc_cc(DisasContext *s)
 
 static bool use_exit_tb(DisasContext *s)
 {
-    return (s->singlestep_enabled ||
-            (tb_cflags(s->tb) & CF_LAST_IO) ||
-            (s->tb->flags & FLAG_MASK_PER));
+    return s->base.singlestep_enabled ||
+            (tb_cflags(s->base.tb) & CF_LAST_IO) ||
+            (s->base.tb->flags & FLAG_MASK_PER);
 }
 
 static bool use_goto_tb(DisasContext *s, uint64_t dest)
@@ -548,7 +547,7 @@ static bool use_goto_tb(DisasContext *s, uint64_t dest)
         return false;
     }
 #ifndef CONFIG_USER_ONLY
-    return (dest & TARGET_PAGE_MASK) == (s->tb->pc & TARGET_PAGE_MASK) ||
+    return (dest & TARGET_PAGE_MASK) == (s->base.tb->pc & TARGET_PAGE_MASK) ||
            (dest & TARGET_PAGE_MASK) == (s->pc & TARGET_PAGE_MASK);
 #else
     return true;
@@ -1150,7 +1149,7 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
         per_breaking_event(s);
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb);
         return DISAS_GOTO_TB;
     } else {
         tcg_gen_movi_i64(psw_addr, dest);
@@ -1211,14 +1210,14 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             /* Branch not taken.  */
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(psw_addr, s->next_pc);
-            tcg_gen_exit_tb((uintptr_t)s->tb + 0);
+            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
 
             /* Branch taken.  */
             gen_set_label(lab);
             per_breaking_event(s);
             tcg_gen_goto_tb(1);
             tcg_gen_movi_i64(psw_addr, dest);
-            tcg_gen_exit_tb((uintptr_t)s->tb + 1);
+            tcg_gen_exit_tb((uintptr_t)s->base.tb + 1);
 
             ret = DISAS_GOTO_TB;
         } else {
@@ -1241,7 +1240,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             update_cc_op(s);
             tcg_gen_goto_tb(0);
             tcg_gen_movi_i64(psw_addr, s->next_pc);
-            tcg_gen_exit_tb((uintptr_t)s->tb + 0);
+            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
 
             gen_set_label(lab);
             if (is_imm) {
@@ -1990,7 +1989,7 @@ static DisasJumpType op_cdsg(DisasContext *s, DisasOps *o)
     addr = get_address(s, 0, b2, d2);
     t_r1 = tcg_const_i32(r1);
     t_r3 = tcg_const_i32(r3);
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_cdsg_parallel(cpu_env, addr, t_r1, t_r3);
     } else {
         gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
@@ -2008,7 +2007,7 @@ static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
     int r3 = get_field(s->fields, r3);
     TCGv_i32 t_r3 = tcg_const_i32(r3);
 
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2);
     } else {
         gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
@@ -2968,7 +2967,7 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
     TCGMemOp mop = s->insn->data;
 
     /* In a parallel context, stop the world and single step.  */
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         update_psw_addr(s);
         update_cc_op(s);
         gen_exception(EXCP_ATOMIC);
@@ -2990,7 +2989,7 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 {
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
     } else {
         gen_helper_lpq(o->out, cpu_env, o->in2);
@@ -3040,7 +3039,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
     o->in2 = NULL;
     o->g_in2 = false;
 
-    switch (s->tb->flags & FLAG_MASK_ASC) {
+    switch (s->base.tb->flags & FLAG_MASK_ASC) {
     case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
         tcg_gen_movi_i64(ar1, 0);
         break;
@@ -4408,7 +4407,7 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
 {
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
     } else {
         gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
@@ -4497,8 +4496,8 @@ static DisasJumpType op_tam(DisasContext *s, DisasOps *o)
 {
     int cc = 0;
 
-    cc |= (s->tb->flags & FLAG_MASK_64) ? 2 : 0;
-    cc |= (s->tb->flags & FLAG_MASK_32) ? 1 : 0;
+    cc |= (s->base.tb->flags & FLAG_MASK_64) ? 2 : 0;
+    cc |= (s->base.tb->flags & FLAG_MASK_32) ? 1 : 0;
     gen_op_movi_cc(s, cc);
     return DISAS_NEXT;
 }
@@ -5998,7 +5997,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER) {
         TCGv_i64 addr = tcg_const_i64(s->pc);
         gen_helper_per_ifetch(cpu_env, addr);
         tcg_temp_free_i64(addr);
@@ -6093,7 +6092,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER) {
         /* An exception might be triggered, save PSW if not already done.  */
         if (ret == DISAS_NEXT || ret == DISAS_PC_STALE) {
             tcg_gen_movi_i64(psw_addr, s->next_pc);
@@ -6113,26 +6112,26 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
     CPUS390XState *env = cs->env_ptr;
     DisasContext dc;
-    target_ulong pc_start;
     uint64_t next_page_start;
     int num_insns, max_insns;
     DisasJumpType status;
     bool do_debug;
 
-    pc_start = tb->pc;
-
+    dc.base.pc_first = tb->pc;
     /* 31-bit mode */
     if (!(tb->flags & FLAG_MASK_64)) {
-        pc_start &= 0x7fffffff;
+        dc.base.pc_first &= 0x7fffffff;
     }
+    dc.base.pc_next = dc.base.pc_first;
+    dc.base.tb = tb;
+    dc.base.singlestep_enabled = cs->singlestep_enabled;
 
-    dc.tb = tb;
-    dc.pc = pc_start;
+    dc.pc = dc.base.pc_first;
     dc.cc_op = CC_OP_DYNAMIC;
-    dc.ex_value = tb->cs_base;
-    do_debug = dc.singlestep_enabled = cs->singlestep_enabled;
+    dc.ex_value = dc.base.tb->cs_base;
+    do_debug = cs->singlestep_enabled;
 
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    next_page_start = (dc.base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 
     num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
@@ -6149,7 +6148,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         tcg_gen_insn_start(dc.pc, dc.cc_op);
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, dc.base.pc_next, BP_ANY))) {
             status = DISAS_PC_STALE;
             do_debug = true;
             /* The address covered by the breakpoint must be included in
@@ -6157,6 +6156,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
             dc.pc += 2;
+            dc.base.pc_next += 2;
             break;
         }
 
@@ -6165,6 +6165,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
 
         status = translate_one(env, &dc);
+        dc.base.pc_next = dc.pc;
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
@@ -6173,7 +6174,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
                 || tcg_op_buf_full()
                 || num_insns >= max_insns
                 || singlestep
-                || cs->singlestep_enabled
+                || dc.base.singlestep_enabled
                 || dc.ex_value)) {
             status = DISAS_TOO_MANY;
         }
@@ -6213,19 +6214,19 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     gen_tb_end(tb, num_insns);
 
-    tb->size = dc.pc - pc_start;
+    tb->size = dc.pc - dc.base.pc_first;
     tb->icount = num_insns;
 
 #if defined(S390X_DEBUG_DISAS)
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
+        && qemu_log_in_addr_range(dc.base.pc_first)) {
         qemu_log_lock();
         if (unlikely(dc.ex_value)) {
             /* ??? Unfortunately log_target_disas can't use host memory.  */
             qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
         } else {
-            qemu_log("IN: %s\n", lookup_symbol(pc_start));
-            log_target_disas(cs, pc_start, dc.pc - pc_start);
+            qemu_log("IN: %s\n", lookup_symbol(dc.base.pc_first));
+            log_target_disas(cs, dc.base.pc_first, dc.pc - dc.base.pc_first);
             qemu_log("\n");
         }
         qemu_log_unlock();
-- 
2.7.4
