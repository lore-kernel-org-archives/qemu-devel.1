Received: from eggs.gnu.org ([2001:4830:134:3::10]:48620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy5-0003kX-9N
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy1-0000RR-9W
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4Vy1-0000RB-3x
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  6 Apr 2018 14:19:47 -0400
Message-Id: <1523038800-2494-5-git-send-email-cota@braap.org>
In-Reply-To: <1523038800-2494-1-git-send-email-cota@braap.org>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 04/17] target/sparc: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Notes:

- pc and npc are left unmodified, since they can point to out-of-TB
  jump targets.

- Got rid of last_pc in gen_intermediate_code(), using base.pc_next
  instead. Only update pc_next (1) on a breakpoint (so that tb->size
  includes the insn), and (2) after reading the current instruction
  from memory. This allows us to use base.pc_next in the BP check,
  which is what the translator loop does.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/translate.c | 92 +++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 03c6510..889c439 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -67,14 +67,13 @@ static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 #include "exec/gen-icount.h"
 
 typedef struct DisasContext {
+    DisasContextBase base;
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
     target_ulong npc;   /* next PC: integer or DYNAMIC_PC or JUMP_PC */
     target_ulong jump_pc[2]; /* used when JUMP_PC pc value is used */
-    DisasJumpType is_jmp;
     int mem_idx;
     bool fpu_enabled;
     bool address_mask_32bit;
-    bool singlestep;
 #ifndef CONFIG_USER_ONLY
     bool supervisor;
 #ifdef TARGET_SPARC64
@@ -83,7 +82,6 @@ typedef struct DisasContext {
 #endif
 
     uint32_t cc_op;  /* current CC operation */
-    struct TranslationBlock *tb;
     sparc_def_t *def;
     TCGv_i32 t32[3];
     TCGv ttl[5];
@@ -342,13 +340,13 @@ static inline TCGv gen_dest_gpr(DisasContext *dc, int reg)
 static inline bool use_goto_tb(DisasContext *s, target_ulong pc,
                                target_ulong npc)
 {
-    if (unlikely(s->singlestep)) {
+    if (unlikely(s->base.singlestep_enabled || singlestep)) {
         return false;
     }
 
 #ifndef CONFIG_USER_ONLY
-    return (pc & TARGET_PAGE_MASK) == (s->tb->pc & TARGET_PAGE_MASK) &&
-           (npc & TARGET_PAGE_MASK) == (s->tb->pc & TARGET_PAGE_MASK);
+    return (pc & TARGET_PAGE_MASK) == (s->base.tb->pc & TARGET_PAGE_MASK) &&
+           (npc & TARGET_PAGE_MASK) == (s->base.tb->pc & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -362,7 +360,7 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num,
         tcg_gen_goto_tb(tb_num);
         tcg_gen_movi_tl(cpu_pc, pc);
         tcg_gen_movi_tl(cpu_npc, npc);
-        tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
+        tcg_gen_exit_tb((uintptr_t)s->base.tb + tb_num);
     } else {
         /* jump to another page: currently not optimized */
         tcg_gen_movi_tl(cpu_pc, pc);
@@ -996,7 +994,7 @@ static void gen_branch_a(DisasContext *dc, target_ulong pc1)
     gen_set_label(l1);
     gen_goto_tb(dc, 1, npc + 4, npc + 8);
 
-    dc->is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_branch_n(DisasContext *dc, target_ulong pc1)
@@ -1079,7 +1077,7 @@ static void gen_exception(DisasContext *dc, int which)
     t = tcg_const_i32(which);
     gen_helper_raise_exception(cpu_env, t);
     tcg_temp_free_i32(t);
-    dc->is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_check_align(TCGv addr, int mask)
@@ -2442,7 +2440,7 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
     default:
         /* ??? In theory, this should be raise DAE_invalid_asi.
            But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
-        if (tb_cflags(dc->tb) & CF_PARALLEL) {
+        if (tb_cflags(dc->base.tb) & CF_PARALLEL) {
             gen_helper_exit_atomic(cpu_env);
         } else {
             TCGv_i32 r_asi = tcg_const_i32(da.asi);
@@ -3352,7 +3350,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 
                 if (cond == 8) {
                     /* An unconditional trap ends the TB.  */
-                    dc->is_jmp = DISAS_NORETURN;
+                    dc->base.is_jmp = DISAS_NORETURN;
                     goto jmp_insn;
                 } else {
                     /* A conditional trap falls through to the next insn.  */
@@ -4332,7 +4330,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_jmp = DISAS_NORETURN;
+                                dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0x6: /* V9 wrfprs */
                                 tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
@@ -4341,7 +4339,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_jmp = DISAS_NORETURN;
+                                dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0xf: /* V9 sir, nop if user */
 #if !defined(CONFIG_USER_ONLY)
@@ -4469,7 +4467,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                             save_state(dc);
                             gen_op_next_insn();
                             tcg_gen_exit_tb(0);
-                            dc->is_jmp = DISAS_NORETURN;
+                            dc->base.is_jmp = DISAS_NORETURN;
 #endif
                         }
                         break;
@@ -4625,7 +4623,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 save_state(dc);
                                 gen_op_next_insn();
                                 tcg_gen_exit_tb(0);
-                                dc->is_jmp = DISAS_NORETURN;
+                                dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 1: // htstate
                                 // XXX gen_op_wrhtstate();
@@ -5691,7 +5689,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
     } else if (dc->npc == JUMP_PC) {
         /* we can do a static jump */
         gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
-        dc->is_jmp = DISAS_NORETURN;
+        dc->base.is_jmp = DISAS_NORETURN;
     } else {
         dc->pc = dc->npc;
         dc->npc = dc->npc + 4;
@@ -5742,25 +5740,25 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 {
     CPUSPARCState *env = cs->env_ptr;
-    target_ulong pc_start, last_pc;
     DisasContext dc1, *dc = &dc1;
-    int num_insns;
     int max_insns;
     unsigned int insn;
 
     memset(dc, 0, sizeof(DisasContext));
-    dc->tb = tb;
-    pc_start = tb->pc;
-    dc->pc = pc_start;
-    last_pc = dc->pc;
-    dc->is_jmp = DISAS_NEXT;
+    dc->base.tb = tb;
+    dc->base.pc_first = tb->pc;
+    dc->base.pc_next = tb->pc;
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->base.num_insns = 0;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+
+    dc->pc = dc->base.pc_first;
     dc->npc = (target_ulong) tb->cs_base;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->mem_idx = tb->flags & TB_FLAG_MMU_MASK;
     dc->def = &env->def;
     dc->fpu_enabled = tb_fpu_enabled(tb->flags);
     dc->address_mask_32bit = tb_am_enabled(tb->flags);
-    dc->singlestep = (cs->singlestep_enabled || singlestep);
 #ifndef CONFIG_USER_ONLY
     dc->supervisor = (tb->flags & TB_FLAG_SUPER) != 0;
 #endif
@@ -5772,7 +5770,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
 #endif
 #endif
 
-    num_insns = 0;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -5780,6 +5777,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
     if (max_insns > TCG_MAX_INSNS) {
         max_insns = TCG_MAX_INSNS;
     }
+    if (dc->base.singlestep_enabled || singlestep) {
+        max_insns = 1;
+    }
 
     gen_tb_start(tb);
     do {
@@ -5789,51 +5789,48 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
         } else {
             tcg_gen_insn_start(dc->pc, dc->npc);
         }
-        num_insns++;
-        last_pc = dc->pc;
+        dc->base.num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
-            if (dc->pc != pc_start) {
+        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
+            if (dc->pc != dc->base.pc_first) {
                 save_state(dc);
             }
             gen_helper_debug(cpu_env);
             tcg_gen_exit_tb(0);
-            dc->is_jmp = DISAS_NORETURN;
+            dc->base.is_jmp = DISAS_NORETURN;
+            dc->base.pc_next += 4;
             goto exit_gen_loop;
         }
 
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
+        if (dc->base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
         insn = cpu_ldl_code(env, dc->pc);
+        dc->base.pc_next += 4;
 
         disas_sparc_insn(dc, insn);
 
-        if (dc->is_jmp == DISAS_NORETURN) {
+        if (dc->base.is_jmp == DISAS_NORETURN) {
             break;
         }
         /* if the next PC is different, we abort now */
-        if (dc->pc != (last_pc + 4))
+        if (dc->pc != dc->base.pc_next) {
             break;
+        }
         /* if we reach a page boundary, we stop generation so that the
            PC of a TT_TFAULT exception is always in the right page */
         if ((dc->pc & (TARGET_PAGE_SIZE - 1)) == 0)
             break;
-        /* if single step mode, we generate only one instruction and
-           generate an exception */
-        if (dc->singlestep) {
-            break;
-        }
     } while (!tcg_op_buf_full() &&
-             (dc->pc - pc_start) < (TARGET_PAGE_SIZE - 32) &&
-             num_insns < max_insns);
+             (dc->pc - dc->base.pc_first) < (TARGET_PAGE_SIZE - 32) &&
+             dc->base.num_insns < max_insns);
 
  exit_gen_loop:
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
-    if (dc->is_jmp != DISAS_NORETURN) {
+    if (dc->base.is_jmp != DISAS_NORETURN) {
         if (dc->pc != DYNAMIC_PC &&
             (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
             /* static PC and NPC: we can use direct chaining */
@@ -5846,18 +5843,19 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
             tcg_gen_exit_tb(0);
         }
     }
-    gen_tb_end(tb, num_insns);
+    gen_tb_end(tb, dc->base.num_insns);
 
-    tb->size = last_pc + 4 - pc_start;
-    tb->icount = num_insns;
+    tb->size = dc->base.pc_next - dc->base.pc_first;
+    tb->icount = dc->base.num_insns;
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
+        && qemu_log_in_addr_range(dc->base.pc_first)) {
         qemu_log_lock();
         qemu_log("--------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, last_pc + 4 - pc_start);
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+        log_target_disas(cs, dc->base.pc_first,
+                         dc->base.pc_next - dc->base.pc_first);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.7.4
