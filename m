Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYly-0005zA-Jg
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYlx-0002uR-2S
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:34 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHYlw-0002tq-Pk
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:32 -0400
Received: by mail-pl0-x242.google.com with SMTP id v24-v6so5053491plo.3
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 10:57:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 12 May 2018 10:57:23 -0700
Message-Id: <20180512175724.5923-4-richard.henderson@linaro.org>
In-Reply-To: <20180512175724.5923-1-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] target/xtensa: Change
 gen_intermediate_code dc to pointer
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

This will reduce the size of the patch in the next patch,
where the context will have to be a pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 122 +++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index cc48d105e9..45f32dc71f 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1051,7 +1051,7 @@ static void gen_ibreak_check(CPUXtensaState *env, DisasContext *dc)
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
     CPUXtensaState *env = cs->env_ptr;
-    DisasContext dc;
+    DisasContext dc1, *dc = &dc1;
     int insn_count = 0;
     int max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     uint32_t pc_start = tb->pc;
@@ -1064,63 +1064,63 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    dc.config = env->config;
-    dc.base.singlestep_enabled = cs->singlestep_enabled;
-    dc.base.tb = tb;
-    dc.pc = pc_start;
-    dc.ring = tb->flags & XTENSA_TBFLAG_RING_MASK;
-    dc.cring = (tb->flags & XTENSA_TBFLAG_EXCM) ? 0 : dc.ring;
-    dc.lbeg = env->sregs[LBEG];
-    dc.lend = env->sregs[LEND];
-    dc.base.is_jmp = DISAS_NEXT;
-    dc.debug = tb->flags & XTENSA_TBFLAG_DEBUG;
-    dc.icount = tb->flags & XTENSA_TBFLAG_ICOUNT;
-    dc.cpenable = (tb->flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
+    dc->config = env->config;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    dc->base.tb = tb;
+    dc->pc = pc_start;
+    dc->ring = tb->flags & XTENSA_TBFLAG_RING_MASK;
+    dc->cring = (tb->flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
+    dc->lbeg = env->sregs[LBEG];
+    dc->lend = env->sregs[LEND];
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->debug = tb->flags & XTENSA_TBFLAG_DEBUG;
+    dc->icount = tb->flags & XTENSA_TBFLAG_ICOUNT;
+    dc->cpenable = (tb->flags & XTENSA_TBFLAG_CPENABLE_MASK) >>
         XTENSA_TBFLAG_CPENABLE_SHIFT;
-    dc.window = ((tb->flags & XTENSA_TBFLAG_WINDOW_MASK) >>
+    dc->window = ((tb->flags & XTENSA_TBFLAG_WINDOW_MASK) >>
                  XTENSA_TBFLAG_WINDOW_SHIFT);
 
-    if (dc.config->isa) {
-        dc.insnbuf = xtensa_insnbuf_alloc(dc.config->isa);
-        dc.slotbuf = xtensa_insnbuf_alloc(dc.config->isa);
+    if (dc->config->isa) {
+        dc->insnbuf = xtensa_insnbuf_alloc(dc->config->isa);
+        dc->slotbuf = xtensa_insnbuf_alloc(dc->config->isa);
     }
 
-    init_sar_tracker(&dc);
-    if (dc.icount) {
-        dc.next_icount = tcg_temp_local_new_i32();
+    init_sar_tracker(dc);
+    if (dc->icount) {
+        dc->next_icount = tcg_temp_local_new_i32();
     }
 
     gen_tb_start(tb);
 
     if ((tb_cflags(tb) & CF_USE_ICOUNT) &&
         (tb->flags & XTENSA_TBFLAG_YIELD)) {
-        tcg_gen_insn_start(dc.pc);
+        tcg_gen_insn_start(dc->pc);
         ++insn_count;
-        gen_exception(&dc, EXCP_YIELD);
-        dc.base.is_jmp = DISAS_NORETURN;
+        gen_exception(dc, EXCP_YIELD);
+        dc->base.is_jmp = DISAS_NORETURN;
         goto done;
     }
     if (tb->flags & XTENSA_TBFLAG_EXCEPTION) {
-        tcg_gen_insn_start(dc.pc);
+        tcg_gen_insn_start(dc->pc);
         ++insn_count;
-        gen_exception(&dc, EXCP_DEBUG);
-        dc.base.is_jmp = DISAS_NORETURN;
+        gen_exception(dc, EXCP_DEBUG);
+        dc->base.is_jmp = DISAS_NORETURN;
         goto done;
     }
 
     do {
-        tcg_gen_insn_start(dc.pc);
+        tcg_gen_insn_start(dc->pc);
         ++insn_count;
 
-        if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
-            tcg_gen_movi_i32(cpu_pc, dc.pc);
-            gen_exception(&dc, EXCP_DEBUG);
-            dc.base.is_jmp = DISAS_NORETURN;
+        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+            tcg_gen_movi_i32(cpu_pc, dc->pc);
+            gen_exception(dc, EXCP_DEBUG);
+            dc->base.is_jmp = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            dc.pc += 2;
+            dc->pc += 2;
             break;
         }
 
@@ -1128,52 +1128,52 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_io_start();
         }
 
-        if (dc.icount) {
+        if (dc->icount) {
             TCGLabel *label = gen_new_label();
 
-            tcg_gen_addi_i32(dc.next_icount, cpu_SR[ICOUNT], 1);
-            tcg_gen_brcondi_i32(TCG_COND_NE, dc.next_icount, 0, label);
-            tcg_gen_mov_i32(dc.next_icount, cpu_SR[ICOUNT]);
-            if (dc.debug) {
-                gen_debug_exception(&dc, DEBUGCAUSE_IC);
+            tcg_gen_addi_i32(dc->next_icount, cpu_SR[ICOUNT], 1);
+            tcg_gen_brcondi_i32(TCG_COND_NE, dc->next_icount, 0, label);
+            tcg_gen_mov_i32(dc->next_icount, cpu_SR[ICOUNT]);
+            if (dc->debug) {
+                gen_debug_exception(dc, DEBUGCAUSE_IC);
             }
             gen_set_label(label);
         }
 
-        if (dc.debug) {
-            gen_ibreak_check(env, &dc);
+        if (dc->debug) {
+            gen_ibreak_check(env, dc);
         }
 
-        disas_xtensa_insn(env, &dc);
-        if (dc.icount) {
-            tcg_gen_mov_i32(cpu_SR[ICOUNT], dc.next_icount);
+        disas_xtensa_insn(env, dc);
+        if (dc->icount) {
+            tcg_gen_mov_i32(cpu_SR[ICOUNT], dc->next_icount);
         }
-        if (cs->singlestep_enabled) {
-            tcg_gen_movi_i32(cpu_pc, dc.pc);
-            gen_exception(&dc, EXCP_DEBUG);
+        if (dc->base.singlestep_enabled) {
+            tcg_gen_movi_i32(cpu_pc, dc->pc);
+            gen_exception(dc, EXCP_DEBUG);
             break;
         }
-    } while (dc.base.is_jmp == DISAS_NEXT &&
-            insn_count < max_insns &&
-            dc.pc - page_start < TARGET_PAGE_SIZE &&
-            dc.pc - page_start + xtensa_insn_len(env, &dc) <= TARGET_PAGE_SIZE
-            && !tcg_op_buf_full());
+    } while (dc->base.is_jmp == DISAS_NEXT &&
+             insn_count < max_insns &&
+             dc->pc - page_start < TARGET_PAGE_SIZE &&
+             dc->pc - page_start + xtensa_insn_len(env, dc) <= TARGET_PAGE_SIZE
+             && !tcg_op_buf_full());
 done:
-    reset_sar_tracker(&dc);
-    if (dc.icount) {
-        tcg_temp_free(dc.next_icount);
+    reset_sar_tracker(dc);
+    if (dc->icount) {
+        tcg_temp_free(dc->next_icount);
     }
-    if (dc.config->isa) {
-        xtensa_insnbuf_free(dc.config->isa, dc.insnbuf);
-        xtensa_insnbuf_free(dc.config->isa, dc.slotbuf);
+    if (dc->config->isa) {
+        xtensa_insnbuf_free(dc->config->isa, dc->insnbuf);
+        xtensa_insnbuf_free(dc->config->isa, dc->slotbuf);
     }
 
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
 
-    if (dc.base.is_jmp == DISAS_NEXT) {
-        gen_jumpi(&dc, dc.pc, 0);
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        gen_jumpi(dc, dc->pc, 0);
     }
     gen_tb_end(tb, insn_count);
 
@@ -1183,12 +1183,12 @@ done:
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc.pc - pc_start);
+        log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    tb->size = dc.pc - pc_start;
+    tb->size = dc->pc - pc_start;
     tb->icount = insn_count;
 }
 
-- 
2.17.0
