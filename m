Received: from eggs.gnu.org ([2001:4830:134:3::10]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bBu-0005dS-28
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9bBq-00021J-L5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9bBq-00020h-Ae
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:55:22 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 20 Apr 2018 14:55:13 -0400
Message-Id: <1524250517-28032-15-git-send-email-cota@braap.org>
In-Reply-To: <1524250517-28032-1-git-send-email-cota@braap.org>
References: <1524250517-28032-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 14/18] target/openrisc: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

While at it, set is_jmp to DISAS_NORETURN when generating
an exception.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/openrisc/translate.c | 93 ++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 2747b24..b37414f 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -36,7 +36,8 @@
 #include "exec/log.h"
 
 #define LOG_DIS(str, ...) \
-    qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->pc, ## __VA_ARGS__)
+    qemu_log_mask(CPU_LOG_TB_IN_ASM, "%08x: " str, dc->base.pc_next,    \
+                  ## __VA_ARGS__)
 
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
@@ -44,13 +45,10 @@
 #define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 typedef struct DisasContext {
-    TranslationBlock *tb;
-    target_ulong pc;
-    uint32_t is_jmp;
+    DisasContextBase base;
     uint32_t mem_idx;
     uint32_t tb_flags;
     uint32_t delayed_branch;
-    bool singlestep_enabled;
 } DisasContext;
 
 static TCGv cpu_sr;
@@ -126,9 +124,9 @@ static void gen_exception(DisasContext *dc, unsigned int excp)
 
 static void gen_illegal_exception(DisasContext *dc)
 {
-    tcg_gen_movi_tl(cpu_pc, dc->pc);
+    tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
     gen_exception(dc, EXCP_ILLEGAL);
-    dc->is_jmp = DISAS_UPDATE;
+    dc->base.is_jmp = DISAS_NORETURN;
 }
 
 /* not used yet, open it when we need or64.  */
@@ -166,12 +164,12 @@ static void check_ov64s(DisasContext *dc)
 
 static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 {
-    if (unlikely(dc->singlestep_enabled)) {
+    if (unlikely(dc->base.singlestep_enabled)) {
         return false;
     }
 
 #ifndef CONFIG_USER_ONLY
-    return (dc->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (dc->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -182,10 +180,10 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_movi_tl(cpu_pc, dest);
         tcg_gen_goto_tb(n);
-        tcg_gen_exit_tb((uintptr_t)dc->tb + n);
+        tcg_gen_exit_tb((uintptr_t)dc->base.tb + n);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        if (dc->singlestep_enabled) {
+        if (dc->base.singlestep_enabled) {
             gen_exception(dc, EXCP_DEBUG);
         }
         tcg_gen_exit_tb(0);
@@ -194,16 +192,16 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 
 static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
 {
-    target_ulong tmp_pc = dc->pc + n26 * 4;
+    target_ulong tmp_pc = dc->base.pc_next + n26 * 4;
 
     switch (op0) {
     case 0x00:     /* l.j */
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
         break;
     case 0x01:     /* l.jal */
-        tcg_gen_movi_tl(cpu_R[9], dc->pc + 8);
+        tcg_gen_movi_tl(cpu_R[9], dc->base.pc_next + 8);
         /* Optimize jal being used to load the PC for PIC.  */
-        if (tmp_pc == dc->pc + 8) {
+        if (tmp_pc == dc->base.pc_next + 8) {
             return;
         }
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
@@ -211,7 +209,7 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
     case 0x03:     /* l.bnf */
     case 0x04:     /* l.bf  */
         {
-            TCGv t_next = tcg_const_tl(dc->pc + 8);
+            TCGv t_next = tcg_const_tl(dc->base.pc_next + 8);
             TCGv t_true = tcg_const_tl(tmp_pc);
             TCGv t_zero = tcg_const_tl(0);
 
@@ -227,7 +225,7 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
         tcg_gen_mov_tl(jmp_pc, cpu_R[reg]);
         break;
     case 0x12:     /* l.jalr */
-        tcg_gen_movi_tl(cpu_R[9], (dc->pc + 8));
+        tcg_gen_movi_tl(cpu_R[9], (dc->base.pc_next + 8));
         tcg_gen_mov_tl(jmp_pc, cpu_R[reg]);
         break;
     default:
@@ -795,7 +793,7 @@ static void dec_misc(DisasContext *dc, uint32_t insn)
                 return;
             }
             gen_helper_rfe(cpu_env);
-            dc->is_jmp = DISAS_UPDATE;
+            dc->base.is_jmp = DISAS_UPDATE;
 #endif
         }
         break;
@@ -1254,15 +1252,16 @@ static void dec_sys(DisasContext *dc, uint32_t insn)
     switch (op0) {
     case 0x000:    /* l.sys */
         LOG_DIS("l.sys %d\n", K16);
-        tcg_gen_movi_tl(cpu_pc, dc->pc);
+        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
         gen_exception(dc, EXCP_SYSCALL);
-        dc->is_jmp = DISAS_UPDATE;
+        dc->base.is_jmp = DISAS_NORETURN;
         break;
 
     case 0x100:    /* l.trap */
         LOG_DIS("l.trap %d\n", K16);
-        tcg_gen_movi_tl(cpu_pc, dc->pc);
+        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
         gen_exception(dc, EXCP_TRAP);
+        dc->base.is_jmp = DISAS_NORETURN;
         break;
 
     case 0x300:    /* l.csync */
@@ -1479,7 +1478,7 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
 {
     uint32_t op0;
     uint32_t insn;
-    insn = cpu_ldl_code(&cpu->env, dc->pc);
+    insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
     op0 = extract32(insn, 26, 6);
 
     switch (op0) {
@@ -1532,14 +1531,15 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     int max_insns;
 
     pc_start = tb->pc;
-    dc->tb = tb;
 
-    dc->is_jmp = DISAS_NEXT;
-    dc->pc = pc_start;
+    dc->base.tb = tb;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    dc->base.pc_next = pc_start;
+    dc->base.is_jmp = DISAS_NEXT;
+
     dc->mem_idx = cpu_mmu_index(&cpu->env, false);
-    dc->tb_flags = tb->flags;
+    dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = (dc->tb_flags & TB_FLAGS_DFLAG) != 0;
-    dc->singlestep_enabled = cs->singlestep_enabled;
 
     next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     num_insns = 0;
@@ -1570,19 +1570,19 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     }
 
     do {
-        tcg_gen_insn_start(dc->pc, (dc->delayed_branch ? 1 : 0)
+        tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
 			   | (num_insns ? 2 : 0));
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
-            tcg_gen_movi_tl(cpu_pc, dc->pc);
+        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
+            tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
             gen_exception(dc, EXCP_DEBUG);
-            dc->is_jmp = DISAS_UPDATE;
+            dc->base.is_jmp = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            dc->pc += 4;
+            dc->base.pc_next += 4;
             break;
         }
 
@@ -1590,7 +1590,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             gen_io_start();
         }
         disas_openrisc_insn(dc, cpu);
-        dc->pc = dc->pc + 4;
+        dc->base.pc_next += 4;
 
         /* delay slot */
         if (dc->delayed_branch) {
@@ -1598,15 +1598,15 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             if (!dc->delayed_branch) {
                 tcg_gen_mov_tl(cpu_pc, jmp_pc);
                 tcg_gen_discard_tl(jmp_pc);
-                dc->is_jmp = DISAS_UPDATE;
+                dc->base.is_jmp = DISAS_UPDATE;
                 break;
             }
         }
-    } while (!dc->is_jmp
+    } while (!dc->base.is_jmp
              && !tcg_op_buf_full()
-             && !cs->singlestep_enabled
+             && !dc->base.singlestep_enabled
              && !singlestep
-             && (dc->pc < next_page_start)
+             && (dc->base.pc_next < next_page_start)
              && num_insns < max_insns);
 
     if (tb_cflags(tb) & CF_LAST_IO) {
@@ -1617,35 +1617,34 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         tcg_gen_movi_i32(cpu_dflag, dc->delayed_branch != 0);
     }
 
-    tcg_gen_movi_tl(cpu_ppc, dc->pc - 4);
-    if (dc->is_jmp == DISAS_NEXT) {
-        dc->is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_tl(cpu_pc, dc->pc);
+    tcg_gen_movi_tl(cpu_ppc, dc->base.pc_next - 4);
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        dc->base.is_jmp = DISAS_UPDATE;
+        tcg_gen_movi_tl(cpu_pc, dc->base.pc_next);
     }
-    if (unlikely(cs->singlestep_enabled)) {
+    if (unlikely(dc->base.singlestep_enabled)) {
         gen_exception(dc, EXCP_DEBUG);
     } else {
-        switch (dc->is_jmp) {
+        switch (dc->base.is_jmp) {
         case DISAS_NEXT:
-            gen_goto_tb(dc, 0, dc->pc);
+            gen_goto_tb(dc, 0, dc->base.pc_next);
             break;
         default:
+        case DISAS_NORETURN:
         case DISAS_JUMP:
+        case DISAS_TB_JUMP:
             break;
         case DISAS_UPDATE:
             /* indicate that the hash table must be used
                to find the next TB */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_TB_JUMP:
-            /* nothing more to generate */
-            break;
         }
     }
 
     gen_tb_end(tb, num_insns);
 
-    tb->size = dc->pc - pc_start;
+    tb->size = dc->base.pc_next - pc_start;
     tb->icount = num_insns;
 
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-- 
2.7.4
