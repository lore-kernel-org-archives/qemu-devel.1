Received: from eggs.gnu.org ([2001:4830:134:3::10]:46943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYly-0005x6-41
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYlv-0002tg-Pw
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:34 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHYlv-0002ta-Hm
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:31 -0400
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so5040128plb.1
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 10:57:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 12 May 2018 10:57:22 -0700
Message-Id: <20180512175724.5923-3-richard.henderson@linaro.org>
In-Reply-To: <20180512175724.5923-1-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] target/xtensa: Convert to DisasContextBase
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
 target/xtensa/translate.c | 89 +++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index a1e63f9661..cc48d105e9 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -48,16 +48,13 @@
 
 
 struct DisasContext {
+    DisasContextBase base;
     const XtensaConfig *config;
-    TranslationBlock *tb;
     uint32_t pc;
-    uint32_t next_pc;
     int cring;
     int ring;
     uint32_t lbeg;
     uint32_t lend;
-    int is_jmp;
-    int singlestep_enabled;
 
     bool sar_5bit;
     bool sar_m32_5bit;
@@ -314,7 +311,7 @@ static void gen_exception_cause(DisasContext *dc, uint32_t cause)
     tcg_temp_free(tcause);
     if (cause == ILLEGAL_INSTRUCTION_CAUSE ||
             cause == SYSCALL_CAUSE) {
-        dc->is_jmp = DISAS_NORETURN;
+        dc->base.is_jmp = DISAS_NORETURN;
     }
 }
 
@@ -336,7 +333,7 @@ static void gen_debug_exception(DisasContext *dc, uint32_t cause)
     tcg_temp_free(tpc);
     tcg_temp_free(tcause);
     if (cause & (DEBUGCAUSE_IB | DEBUGCAUSE_BI | DEBUGCAUSE_BN)) {
-        dc->is_jmp = DISAS_NORETURN;
+        dc->base.is_jmp = DISAS_NORETURN;
     }
 }
 
@@ -348,7 +345,7 @@ static bool gen_check_privilege(DisasContext *dc)
     }
 #endif
     gen_exception_cause(dc, PRIVILEGED_CAUSE);
-    dc->is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_NORETURN;
     return false;
 }
 
@@ -357,7 +354,7 @@ static bool gen_check_cpenable(DisasContext *dc, unsigned cp)
     if (option_enabled(dc, XTENSA_OPTION_COPROCESSOR) &&
             !(dc->cpenable & (1 << cp))) {
         gen_exception_cause(dc, COPROCESSOR0_DISABLED + cp);
-        dc->is_jmp = DISAS_NORETURN;
+        dc->base.is_jmp = DISAS_NORETURN;
         return false;
     }
     return true;
@@ -369,17 +366,17 @@ static void gen_jump_slot(DisasContext *dc, TCGv dest, int slot)
     if (dc->icount) {
         tcg_gen_mov_i32(cpu_SR[ICOUNT], dc->next_icount);
     }
-    if (dc->singlestep_enabled) {
+    if (dc->base.singlestep_enabled) {
         gen_exception(dc, EXCP_DEBUG);
     } else {
         if (slot >= 0) {
             tcg_gen_goto_tb(slot);
-            tcg_gen_exit_tb((uintptr_t)dc->tb + slot);
+            tcg_gen_exit_tb((uintptr_t)dc->base.tb + slot);
         } else {
             tcg_gen_exit_tb(0);
         }
     }
-    dc->is_jmp = DISAS_NORETURN;
+    dc->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_jump(DisasContext *dc, TCGv dest)
@@ -391,7 +388,7 @@ static void gen_jumpi(DisasContext *dc, uint32_t dest, int slot)
 {
     TCGv_i32 tmp = tcg_const_i32(dest);
 #ifndef CONFIG_USER_ONLY
-    if (((dc->tb->pc ^ dest) & TARGET_PAGE_MASK) != 0) {
+    if (((dc->base.pc_first ^ dest) & TARGET_PAGE_MASK) != 0) {
         slot = -1;
     }
 #endif
@@ -408,7 +405,7 @@ static void gen_callw_slot(DisasContext *dc, int callinc, TCGv_i32 dest,
             tcallinc, PS_CALLINC_SHIFT, PS_CALLINC_LEN);
     tcg_temp_free(tcallinc);
     tcg_gen_movi_i32(cpu_R[callinc << 2],
-            (callinc << 30) | (dc->next_pc & 0x3fffffff));
+            (callinc << 30) | (dc->base.pc_next & 0x3fffffff));
     gen_jump_slot(dc, dest, slot);
 }
 
@@ -421,7 +418,7 @@ static void gen_callwi(DisasContext *dc, int callinc, uint32_t dest, int slot)
 {
     TCGv_i32 tmp = tcg_const_i32(dest);
 #ifndef CONFIG_USER_ONLY
-    if (((dc->tb->pc ^ dest) & TARGET_PAGE_MASK) != 0) {
+    if (((dc->base.pc_first ^ dest) & TARGET_PAGE_MASK) != 0) {
         slot = -1;
     }
 #endif
@@ -432,15 +429,15 @@ static void gen_callwi(DisasContext *dc, int callinc, uint32_t dest, int slot)
 static bool gen_check_loop_end(DisasContext *dc, int slot)
 {
     if (option_enabled(dc, XTENSA_OPTION_LOOP) &&
-            !(dc->tb->flags & XTENSA_TBFLAG_EXCM) &&
-            dc->next_pc == dc->lend) {
+            !(dc->base.tb->flags & XTENSA_TBFLAG_EXCM) &&
+            dc->base.pc_next == dc->lend) {
         TCGLabel *label = gen_new_label();
 
         tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_SR[LCOUNT], 0, label);
         tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_SR[LCOUNT], 1);
         gen_jumpi(dc, dc->lbeg, slot);
         gen_set_label(label);
-        gen_jumpi(dc, dc->next_pc, -1);
+        gen_jumpi(dc, dc->base.pc_next, -1);
         return true;
     }
     return false;
@@ -449,7 +446,7 @@ static bool gen_check_loop_end(DisasContext *dc, int slot)
 static void gen_jumpi_check_loop_end(DisasContext *dc, int slot)
 {
     if (!gen_check_loop_end(dc, slot)) {
-        gen_jumpi(dc, dc->next_pc, slot);
+        gen_jumpi(dc, dc->base.pc_next, slot);
     }
 }
 
@@ -500,12 +497,12 @@ static bool gen_check_sr(DisasContext *dc, uint32_t sr, unsigned access)
 #ifndef CONFIG_USER_ONLY
 static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
 {
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(d, cpu_SR[sr]);
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         return true;
     }
@@ -689,11 +686,11 @@ static bool gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
 static void gen_check_interrupts(DisasContext *dc)
 {
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_check_interrupts(cpu_env);
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
 }
@@ -747,11 +744,11 @@ static bool gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
 static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 {
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_wsr_ccount(cpu_env, v);
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
         gen_jumpi_check_loop_end(dc, 0);
         return true;
@@ -788,11 +785,11 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
 
         tcg_gen_mov_i32(cpu_SR[sr], v);
         tcg_gen_andi_i32(cpu_SR[INTSET], cpu_SR[INTSET], ~int_bit);
-        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
         gen_helper_update_ccompare(cpu_env, tmp);
-        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
             gen_io_end();
             gen_jumpi_check_loop_end(dc, 0);
             ret = true;
@@ -892,14 +889,14 @@ static void gen_load_store_alignment(DisasContext *dc, int shift,
 #ifndef CONFIG_USER_ONLY
 static void gen_waiti(DisasContext *dc, uint32_t imm4)
 {
-    TCGv_i32 pc = tcg_const_i32(dc->next_pc);
+    TCGv_i32 pc = tcg_const_i32(dc->base.pc_next);
     TCGv_i32 intlevel = tcg_const_i32(imm4);
 
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
     }
     gen_helper_waiti(cpu_env, pc, intlevel);
-    if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
     }
     tcg_temp_free(pc);
@@ -915,7 +912,7 @@ static bool gen_window_check1(DisasContext *dc, unsigned r1)
         TCGv_i32 w = tcg_const_i32(r1 / 4);
 
         gen_helper_window_check(cpu_env, pc, w);
-        dc->is_jmp = DISAS_NORETURN;
+        dc->base.is_jmp = DISAS_NORETURN;
         return false;
     }
     return true;
@@ -966,7 +963,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
-    dc->next_pc = dc->pc + len;
+    dc->base.pc_next = dc->pc + len;
     for (i = 1; i < len; ++i) {
         b[i] = cpu_ldub_code(env, dc->pc + i);
     }
@@ -1026,10 +1023,10 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
             return;
         }
     }
-    if (dc->is_jmp == DISAS_NEXT) {
+    if (dc->base.is_jmp == DISAS_NEXT) {
         gen_check_loop_end(dc, 0);
     }
-    dc->pc = dc->next_pc;
+    dc->pc = dc->base.pc_next;
 }
 
 static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContext *dc)
@@ -1068,14 +1065,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     }
 
     dc.config = env->config;
-    dc.singlestep_enabled = cs->singlestep_enabled;
-    dc.tb = tb;
+    dc.base.singlestep_enabled = cs->singlestep_enabled;
+    dc.base.tb = tb;
     dc.pc = pc_start;
     dc.ring = tb->flags & XTENSA_TBFLAG_RING_MASK;
     dc.cring = (tb->flags & XTENSA_TBFLAG_EXCM) ? 0 : dc.ring;
     dc.lbeg = env->sregs[LBEG];
     dc.lend = env->sregs[LEND];
-    dc.is_jmp = DISAS_NEXT;
+    dc.base.is_jmp = DISAS_NEXT;
     dc.debug = tb->flags & XTENSA_TBFLAG_DEBUG;
     dc.icount = tb->flags & XTENSA_TBFLAG_ICOUNT;
     dc.cpenable = (tb->flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
@@ -1100,14 +1097,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
         gen_exception(&dc, EXCP_YIELD);
-        dc.is_jmp = DISAS_NORETURN;
+        dc.base.is_jmp = DISAS_NORETURN;
         goto done;
     }
     if (tb->flags & XTENSA_TBFLAG_EXCEPTION) {
         tcg_gen_insn_start(dc.pc);
         ++insn_count;
         gen_exception(&dc, EXCP_DEBUG);
-        dc.is_jmp = DISAS_NORETURN;
+        dc.base.is_jmp = DISAS_NORETURN;
         goto done;
     }
 
@@ -1118,7 +1115,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
             tcg_gen_movi_i32(cpu_pc, dc.pc);
             gen_exception(&dc, EXCP_DEBUG);
-            dc.is_jmp = DISAS_NORETURN;
+            dc.base.is_jmp = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
@@ -1156,7 +1153,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_exception(&dc, EXCP_DEBUG);
             break;
         }
-    } while (dc.is_jmp == DISAS_NEXT &&
+    } while (dc.base.is_jmp == DISAS_NEXT &&
             insn_count < max_insns &&
             dc.pc - page_start < TARGET_PAGE_SIZE &&
             dc.pc - page_start + xtensa_insn_len(env, &dc) <= TARGET_PAGE_SIZE
@@ -1175,7 +1172,7 @@ done:
         gen_io_end();
     }
 
-    if (dc.is_jmp == DISAS_NEXT) {
+    if (dc.base.is_jmp == DISAS_NEXT) {
         gen_jumpi(&dc, dc.pc, 0);
     }
     gen_tb_end(tb, insn_count);
@@ -1480,7 +1477,7 @@ static void translate_break(DisasContext *dc, const uint32_t arg[],
 static void translate_call0(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    tcg_gen_movi_i32(cpu_R[0], dc->next_pc);
+    tcg_gen_movi_i32(cpu_R[0], dc->base.pc_next);
     gen_jumpi(dc, arg[0], 0);
 }
 
@@ -1498,7 +1495,7 @@ static void translate_callx0(DisasContext *dc, const uint32_t arg[],
     if (gen_window_check1(dc, arg[0])) {
         TCGv_i32 tmp = tcg_temp_new_i32();
         tcg_gen_mov_i32(tmp, cpu_R[arg[0]]);
-        tcg_gen_movi_i32(cpu_R[0], dc->next_pc);
+        tcg_gen_movi_i32(cpu_R[0], dc->base.pc_next);
         gen_jump(dc, tmp);
         tcg_temp_free(tmp);
     }
@@ -1700,7 +1697,7 @@ static void translate_l32r(DisasContext *dc, const uint32_t arg[],
     if (gen_window_check1(dc, arg[0])) {
         TCGv_i32 tmp;
 
-        if (dc->tb->flags & XTENSA_TBFLAG_LITBASE) {
+        if (dc->base.tb->flags & XTENSA_TBFLAG_LITBASE) {
             tmp = tcg_const_i32(dc->raw_arg[1] - 1);
             tcg_gen_add_i32(tmp, cpu_SR[LITBASE], tmp);
         } else {
@@ -1719,7 +1716,7 @@ static void translate_loop(DisasContext *dc, const uint32_t arg[],
         TCGv_i32 tmp = tcg_const_i32(lend);
 
         tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[arg[0]], 1);
-        tcg_gen_movi_i32(cpu_SR[LBEG], dc->next_pc);
+        tcg_gen_movi_i32(cpu_SR[LBEG], dc->base.pc_next);
         gen_helper_wsr_lend(cpu_env, tmp);
         tcg_temp_free(tmp);
 
@@ -1730,7 +1727,7 @@ static void translate_loop(DisasContext *dc, const uint32_t arg[],
             gen_set_label(label);
         }
 
-        gen_jumpi(dc, dc->next_pc, 0);
+        gen_jumpi(dc, dc->base.pc_next, 0);
     }
 }
 
-- 
2.17.0
