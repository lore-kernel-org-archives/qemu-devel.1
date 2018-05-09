Received: from eggs.gnu.org ([2001:4830:134:3::10]:48730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJc-0005YY-VS
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJV-00068T-0i
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:48 -0400
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:44719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJU-00066J-Ha
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:40 -0400
Received: by mail-pl0-x233.google.com with SMTP id e6-v6so4745283plt.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:52 -0700
Message-Id: <20180509175458.15642-23-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 22/28] target/s390x: convert to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Michael Clark <mjc@sifive.com>, Eduardo Habkost <ehabkost@redhat.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Notes:

- Did not convert {num,max}_insns and is_jmp, since the corresponding
  code will go away in the next patch.

- Avoided a checkpatch error in use_exit_tb.

- As suggested by David, (1) Drop ctx.pc and use
  ctx.base.pc_next instead, and (2) Rename ctx.next_pc to
  ctx.pc_tmp and add a comment about it.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by:  David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 148 ++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d08c109fe1..5094128e9c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -52,14 +52,18 @@ typedef struct DisasInsn DisasInsn;
 typedef struct DisasFields DisasFields;
 
 struct DisasContext {
-    struct TranslationBlock *tb;
+    DisasContextBase base;
     const DisasInsn *insn;
     DisasFields *fields;
     uint64_t ex_value;
-    uint64_t pc, next_pc;
+    /*
+     * During translate_one(), pc_tmp is used to determine the instruction
+     * to be executed after base.pc_next - e.g. next sequential instruction
+     * or a branch target.
+     */
+    uint64_t pc_tmp;
     uint32_t ilen;
     enum cc_op cc_op;
-    bool singlestep_enabled;
 };
 
 /* Information carried about a condition to be evaluated.  */
@@ -81,8 +85,8 @@ static uint64_t inline_branch_miss[CC_OP_MAX];
 
 static uint64_t pc_to_link_info(DisasContext *s, uint64_t pc)
 {
-    if (!(s->tb->flags & FLAG_MASK_64)) {
-        if (s->tb->flags & FLAG_MASK_32) {
+    if (!(s->base.tb->flags & FLAG_MASK_64)) {
+        if (s->base.tb->flags & FLAG_MASK_32) {
             return pc | 0x80000000;
         }
     }
@@ -188,16 +192,16 @@ static void return_low128(TCGv_i64 dest)
 static void update_psw_addr(DisasContext *s)
 {
     /* psw.addr */
-    tcg_gen_movi_i64(psw_addr, s->pc);
+    tcg_gen_movi_i64(psw_addr, s->base.pc_next);
 }
 
 static void per_branch(DisasContext *s, bool to_next)
 {
 #ifndef CONFIG_USER_ONLY
-    tcg_gen_movi_i64(gbea, s->pc);
+    tcg_gen_movi_i64(gbea, s->base.pc_next);
 
-    if (s->tb->flags & FLAG_MASK_PER) {
-        TCGv_i64 next_pc = to_next ? tcg_const_i64(s->next_pc) : psw_addr;
+    if (s->base.tb->flags & FLAG_MASK_PER) {
+        TCGv_i64 next_pc = to_next ? tcg_const_i64(s->pc_tmp) : psw_addr;
         gen_helper_per_branch(cpu_env, gbea, next_pc);
         if (to_next) {
             tcg_temp_free_i64(next_pc);
@@ -210,16 +214,16 @@ static void per_branch_cond(DisasContext *s, TCGCond cond,
                             TCGv_i64 arg1, TCGv_i64 arg2)
 {
 #ifndef CONFIG_USER_ONLY
-    if (s->tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER) {
         TCGLabel *lab = gen_new_label();
         tcg_gen_brcond_i64(tcg_invert_cond(cond), arg1, arg2, lab);
 
-        tcg_gen_movi_i64(gbea, s->pc);
+        tcg_gen_movi_i64(gbea, s->base.pc_next);
         gen_helper_per_branch(cpu_env, gbea, psw_addr);
 
         gen_set_label(lab);
     } else {
-        TCGv_i64 pc = tcg_const_i64(s->pc);
+        TCGv_i64 pc = tcg_const_i64(s->base.pc_next);
         tcg_gen_movcond_i64(cond, gbea, arg1, arg2, gbea, pc);
         tcg_temp_free_i64(pc);
     }
@@ -228,7 +232,7 @@ static void per_branch_cond(DisasContext *s, TCGCond cond,
 
 static void per_breaking_event(DisasContext *s)
 {
-    tcg_gen_movi_i64(gbea, s->pc);
+    tcg_gen_movi_i64(gbea, s->base.pc_next);
 }
 
 static void update_cc_op(DisasContext *s)
@@ -250,11 +254,11 @@ static inline uint64_t ld_code4(CPUS390XState *env, uint64_t pc)
 
 static int get_mem_index(DisasContext *s)
 {
-    if (!(s->tb->flags & FLAG_MASK_DAT)) {
+    if (!(s->base.tb->flags & FLAG_MASK_DAT)) {
         return MMU_REAL_IDX;
     }
 
-    switch (s->tb->flags & FLAG_MASK_ASC) {
+    switch (s->base.tb->flags & FLAG_MASK_ASC) {
     case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
         return MMU_PRIMARY_IDX;
     case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
@@ -319,7 +323,7 @@ static inline void gen_trap(DisasContext *s)
 #ifndef CONFIG_USER_ONLY
 static void check_privileged(DisasContext *s)
 {
-    if (s->tb->flags & FLAG_MASK_PSTATE) {
+    if (s->base.tb->flags & FLAG_MASK_PSTATE) {
         gen_program_exception(s, PGM_PRIVILEGED);
     }
 }
@@ -328,7 +332,7 @@ static void check_privileged(DisasContext *s)
 static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
-    bool need_31 = !(s->tb->flags & FLAG_MASK_64);
+    bool need_31 = !(s->base.tb->flags & FLAG_MASK_64);
 
     /* Note that d2 is limited to 20 bits, signed.  If we crop negative
        displacements early we create larger immedate addends.  */
@@ -541,9 +545,9 @@ static void gen_op_calc_cc(DisasContext *s)
 
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
@@ -552,8 +556,8 @@ static bool use_goto_tb(DisasContext *s, uint64_t dest)
         return false;
     }
 #ifndef CONFIG_USER_ONLY
-    return (dest & TARGET_PAGE_MASK) == (s->tb->pc & TARGET_PAGE_MASK) ||
-           (dest & TARGET_PAGE_MASK) == (s->pc & TARGET_PAGE_MASK);
+    return (dest & TARGET_PAGE_MASK) == (s->base.tb->pc & TARGET_PAGE_MASK) ||
+           (dest & TARGET_PAGE_MASK) == (s->base.pc_next & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -1145,7 +1149,7 @@ static void help_l2_shift(DisasContext *s, DisasFields *f,
 
 static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
 {
-    if (dest == s->next_pc) {
+    if (dest == s->pc_tmp) {
         per_branch(s, true);
         return DISAS_NEXT;
     }
@@ -1154,7 +1158,7 @@ static DisasJumpType help_goto_direct(DisasContext *s, uint64_t dest)
         per_breaking_event(s);
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(psw_addr, dest);
-        tcg_gen_exit_tb((uintptr_t)s->tb);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb);
         return DISAS_GOTO_TB;
     } else {
         tcg_gen_movi_i64(psw_addr, dest);
@@ -1167,7 +1171,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
                                  bool is_imm, int imm, TCGv_i64 cdest)
 {
     DisasJumpType ret;
-    uint64_t dest = s->pc + 2 * imm;
+    uint64_t dest = s->base.pc_next + 2 * imm;
     TCGLabel *lab;
 
     /* Take care of the special cases first.  */
@@ -1176,7 +1180,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         goto egress;
     }
     if (is_imm) {
-        if (dest == s->next_pc) {
+        if (dest == s->pc_tmp) {
             /* Branch to next.  */
             per_branch(s, true);
             ret = DISAS_NEXT;
@@ -1200,7 +1204,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         }
     }
 
-    if (use_goto_tb(s, s->next_pc)) {
+    if (use_goto_tb(s, s->pc_tmp)) {
         if (is_imm && use_goto_tb(s, dest)) {
             /* Both exits can use goto_tb.  */
             update_cc_op(s);
@@ -1214,15 +1218,15 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
 
             /* Branch not taken.  */
             tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(psw_addr, s->next_pc);
-            tcg_gen_exit_tb((uintptr_t)s->tb + 0);
+            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
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
@@ -1244,8 +1248,8 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
             /* Branch not taken.  */
             update_cc_op(s);
             tcg_gen_goto_tb(0);
-            tcg_gen_movi_i64(psw_addr, s->next_pc);
-            tcg_gen_exit_tb((uintptr_t)s->tb + 0);
+            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
+            tcg_gen_exit_tb((uintptr_t)s->base.tb + 0);
 
             gen_set_label(lab);
             if (is_imm) {
@@ -1259,7 +1263,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
            Most commonly we're single-stepping or some other condition that
            disables all use of goto_tb.  Just update the PC and exit.  */
 
-        TCGv_i64 next = tcg_const_i64(s->next_pc);
+        TCGv_i64 next = tcg_const_i64(s->pc_tmp);
         if (is_imm) {
             cdest = tcg_const_i64(dest);
         }
@@ -1448,7 +1452,7 @@ static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->next_pc));
+    tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
     if (o->in2) {
         tcg_gen_mov_i64(psw_addr, o->in2);
         per_branch(s, false);
@@ -1460,8 +1464,8 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->next_pc));
-    return help_goto_direct(s, s->pc + 2 * get_field(s->fields, i2));
+    tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
+    return help_goto_direct(s, s->base.pc_next + 2 * get_field(s->fields, i2));
 }
 
 static DisasJumpType op_bc(DisasContext *s, DisasOps *o)
@@ -1994,7 +1998,7 @@ static DisasJumpType op_cdsg(DisasContext *s, DisasOps *o)
     addr = get_address(s, 0, b2, d2);
     t_r1 = tcg_const_i32(r1);
     t_r3 = tcg_const_i32(r3);
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_cdsg_parallel(cpu_env, addr, t_r1, t_r3);
     } else {
         gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
@@ -2012,7 +2016,7 @@ static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
     int r3 = get_field(s->fields, r3);
     TCGv_i32 t_r3 = tcg_const_i32(r3);
 
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2);
     } else {
         gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
@@ -2972,7 +2976,7 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
     TCGMemOp mop = s->insn->data;
 
     /* In a parallel context, stop the world and single step.  */
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         update_psw_addr(s);
         update_cc_op(s);
         gen_exception(EXCP_ATOMIC);
@@ -2994,7 +2998,7 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
 {
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
     } else {
         gen_helper_lpq(o->out, cpu_env, o->in2);
@@ -3044,7 +3048,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
     o->in2 = NULL;
     o->g_in2 = false;
 
-    switch (s->tb->flags & FLAG_MASK_ASC) {
+    switch (s->base.tb->flags & FLAG_MASK_ASC) {
     case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
         tcg_gen_movi_i64(ar1, 0);
         break;
@@ -3694,11 +3698,11 @@ static DisasJumpType op_sam(DisasContext *s, DisasOps *o)
     /* Bizarre but true, we check the address of the current insn for the
        specification exception, not the next to be executed.  Thus the PoO
        documents that Bad Things Happen two bytes before the end.  */
-    if (s->pc & ~mask) {
+    if (s->base.pc_next & ~mask) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
-    s->next_pc &= mask;
+    s->pc_tmp &= mask;
 
     tsam = tcg_const_i64(sam);
     tcg_gen_deposit_i64(psw_mask, psw_mask, tsam, 31, 2);
@@ -4411,7 +4415,7 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
 {
-    if (tb_cflags(s->tb) & CF_PARALLEL) {
+    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
     } else {
         gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
@@ -4500,8 +4504,8 @@ static DisasJumpType op_tam(DisasContext *s, DisasOps *o)
 {
     int cc = 0;
 
-    cc |= (s->tb->flags & FLAG_MASK_64) ? 2 : 0;
-    cc |= (s->tb->flags & FLAG_MASK_32) ? 1 : 0;
+    cc |= (s->base.tb->flags & FLAG_MASK_64) ? 2 : 0;
+    cc |= (s->base.tb->flags & FLAG_MASK_32) ? 1 : 0;
     gen_op_movi_cc(s, cc);
     return DISAS_NEXT;
 }
@@ -5625,7 +5629,7 @@ static void in2_a2(DisasContext *s, DisasFields *f, DisasOps *o)
 
 static void in2_ri2(DisasContext *s, DisasFields *f, DisasOps *o)
 {
-    o->in2 = tcg_const_i64(s->pc + (int64_t)get_field(f, i2) * 2);
+    o->in2 = tcg_const_i64(s->base.pc_next + (int64_t)get_field(f, i2) * 2);
 }
 #define SPEC_in2_ri2 0
 
@@ -5926,7 +5930,7 @@ static void extract_field(DisasFields *o, const DisasField *f, uint64_t insn)
 static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
                                      DisasFields *f)
 {
-    uint64_t insn, pc = s->pc;
+    uint64_t insn, pc = s->base.pc_next;
     int op, op2, ilen;
     const DisasInsn *info;
 
@@ -5958,7 +5962,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
             g_assert_not_reached();
         }
     }
-    s->next_pc = s->pc + ilen;
+    s->pc_tmp = s->base.pc_next + ilen;
     s->ilen = ilen;
 
     /* We can't actually determine the insn format until we've looked up
@@ -6043,8 +6047,8 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->tb->flags & FLAG_MASK_PER) {
-        TCGv_i64 addr = tcg_const_i64(s->pc);
+    if (s->base.tb->flags & FLAG_MASK_PER) {
+        TCGv_i64 addr = tcg_const_i64(s->base.pc_next);
         gen_helper_per_ifetch(cpu_env, addr);
         tcg_temp_free_i64(addr);
     }
@@ -6138,10 +6142,10 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (s->tb->flags & FLAG_MASK_PER) {
+    if (s->base.tb->flags & FLAG_MASK_PER) {
         /* An exception might be triggered, save PSW if not already done.  */
         if (ret == DISAS_NEXT || ret == DISAS_PC_STALE) {
-            tcg_gen_movi_i64(psw_addr, s->next_pc);
+            tcg_gen_movi_i64(psw_addr, s->pc_tmp);
         }
 
         /* Call the helper to check for a possible PER exception.  */
@@ -6150,7 +6154,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 #endif
 
     /* Advance to the next instruction.  */
-    s->pc = s->next_pc;
+    s->base.pc_next = s->pc_tmp;
     return ret;
 }
 
@@ -6158,26 +6162,25 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
     CPUS390XState *env = cs->env_ptr;
     DisasContext dc;
-    target_ulong pc_start;
     uint64_t page_start;
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
     dc.cc_op = CC_OP_DYNAMIC;
-    dc.ex_value = tb->cs_base;
-    do_debug = dc.singlestep_enabled = cs->singlestep_enabled;
+    dc.ex_value = dc.base.tb->cs_base;
+    do_debug = cs->singlestep_enabled;
 
-    page_start = pc_start & TARGET_PAGE_MASK;
+    page_start = dc.base.pc_first & TARGET_PAGE_MASK;
 
     num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
@@ -6191,17 +6194,17 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     gen_tb_start(tb);
 
     do {
-        tcg_gen_insn_start(dc.pc, dc.cc_op);
+        tcg_gen_insn_start(dc.base.pc_next, dc.cc_op);
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, dc.base.pc_next, BP_ANY))) {
             status = DISAS_PC_STALE;
             do_debug = true;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            dc.pc += 2;
+            dc.base.pc_next += 2;
             break;
         }
 
@@ -6214,11 +6217,11 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
         if (status == DISAS_NEXT
-            && (dc.pc - page_start >= TARGET_PAGE_SIZE
+            && (dc.base.pc_next - page_start >= TARGET_PAGE_SIZE
                 || tcg_op_buf_full()
                 || num_insns >= max_insns
                 || singlestep
-                || cs->singlestep_enabled
+                || dc.base.singlestep_enabled
                 || dc.ex_value)) {
             status = DISAS_TOO_MANY;
         }
@@ -6258,19 +6261,20 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     gen_tb_end(tb, num_insns);
 
-    tb->size = dc.pc - pc_start;
+    tb->size = dc.base.pc_next - dc.base.pc_first;
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
+            log_target_disas(cs, dc.base.pc_first,
+                             dc.base.pc_next - dc.base.pc_first);
             qemu_log("\n");
         }
         qemu_log_unlock();
-- 
2.17.0
