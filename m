Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy5-0003kY-9z
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4Vy2-0000SK-EG
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4Vy2-0000S3-9h
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 14:20:06 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  6 Apr 2018 14:19:51 -0400
Message-Id: <1523038800-2494-9-git-send-email-cota@braap.org>
In-Reply-To: <1523038800-2494-1-git-send-email-cota@braap.org>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/17] target/mips: use *ctx for DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

No changes to the logic here; this is just to make the diff
that follows easier to read.

While at it, remove the unnecessary 'struct' in
'struct TranslationBlock'.

Note that checkpatch complains with a false positive:
  ERROR: space prohibited after that '&' (ctx:WxW)
  #75: FILE: target/mips/translate.c:20220:
  +    ctx->kscrexist = (env->CP0_Config4 >> CP0C4_KScrExist) & 0xff;
                                                              ^
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/translate.c | 166 ++++++++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 82 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index aefd729..08bd140 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20194,55 +20194,57 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
-void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
     CPUMIPSState *env = cs->env_ptr;
-    DisasContext ctx;
+    DisasContext ctx1;
+    DisasContext *ctx = &ctx1;
     target_ulong next_page_start;
     int max_insns;
     int insn_bytes;
     int is_slot;
 
-    ctx.base.tb = tb;
-    ctx.base.pc_first = tb->pc;
-    ctx.base.pc_next = tb->pc;
-    ctx.base.is_jmp = DISAS_NEXT;
-    ctx.base.singlestep_enabled = cs->singlestep_enabled;
-    ctx.base.num_insns = 0;
-
-    next_page_start = (ctx.base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-    ctx.saved_pc = -1;
-    ctx.insn_flags = env->insn_flags;
-    ctx.CP0_Config1 = env->CP0_Config1;
-    ctx.btarget = 0;
-    ctx.kscrexist = (env->CP0_Config4 >> CP0C4_KScrExist) & 0xff;
-    ctx.rxi = (env->CP0_Config3 >> CP0C3_RXI) & 1;
-    ctx.ie = (env->CP0_Config4 >> CP0C4_IE) & 3;
-    ctx.bi = (env->CP0_Config3 >> CP0C3_BI) & 1;
-    ctx.bp = (env->CP0_Config3 >> CP0C3_BP) & 1;
-    ctx.PAMask = env->PAMask;
-    ctx.mvh = (env->CP0_Config5 >> CP0C5_MVH) & 1;
-    ctx.eva = (env->CP0_Config5 >> CP0C5_EVA) & 1;
-    ctx.sc = (env->CP0_Config3 >> CP0C3_SC) & 1;
-    ctx.CP0_LLAddr_shift = env->CP0_LLAddr_shift;
-    ctx.cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
+    ctx->base.tb = tb;
+    ctx->base.pc_first = tb->pc;
+    ctx->base.pc_next = tb->pc;
+    ctx->base.is_jmp = DISAS_NEXT;
+    ctx->base.singlestep_enabled = cs->singlestep_enabled;
+    ctx->base.num_insns = 0;
+
+    next_page_start = (ctx->base.pc_first & TARGET_PAGE_MASK) +
+        TARGET_PAGE_SIZE;
+    ctx->saved_pc = -1;
+    ctx->insn_flags = env->insn_flags;
+    ctx->CP0_Config1 = env->CP0_Config1;
+    ctx->btarget = 0;
+    ctx->kscrexist = (env->CP0_Config4 >> CP0C4_KScrExist) & 0xff;
+    ctx->rxi = (env->CP0_Config3 >> CP0C3_RXI) & 1;
+    ctx->ie = (env->CP0_Config4 >> CP0C4_IE) & 3;
+    ctx->bi = (env->CP0_Config3 >> CP0C3_BI) & 1;
+    ctx->bp = (env->CP0_Config3 >> CP0C3_BP) & 1;
+    ctx->PAMask = env->PAMask;
+    ctx->mvh = (env->CP0_Config5 >> CP0C5_MVH) & 1;
+    ctx->eva = (env->CP0_Config5 >> CP0C5_EVA) & 1;
+    ctx->sc = (env->CP0_Config3 >> CP0C3_SC) & 1;
+    ctx->CP0_LLAddr_shift = env->CP0_LLAddr_shift;
+    ctx->cmgcr = (env->CP0_Config3 >> CP0C3_CMGCR) & 1;
     /* Restore delay slot state from the tb context.  */
-    ctx.hflags = (uint32_t)ctx.base.tb->flags; /* FIXME: maybe use 64 bits? */
-    ctx.ulri = (env->CP0_Config3 >> CP0C3_ULRI) & 1;
-    ctx.ps = ((env->active_fpu.fcr0 >> FCR0_PS) & 1) ||
+    ctx->hflags = (uint32_t)ctx->base.tb->flags; /* FIXME: maybe use 64 bits? */
+    ctx->ulri = (env->CP0_Config3 >> CP0C3_ULRI) & 1;
+    ctx->ps = ((env->active_fpu.fcr0 >> FCR0_PS) & 1) ||
              (env->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F));
-    ctx.vp = (env->CP0_Config5 >> CP0C5_VP) & 1;
-    ctx.mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
-    ctx.nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
-    ctx.abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
-    restore_cpu_state(env, &ctx);
+    ctx->vp = (env->CP0_Config5 >> CP0C5_VP) & 1;
+    ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
+    ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
+    ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
+    restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
-        ctx.mem_idx = MIPS_HFLAG_UM;
+        ctx->mem_idx = MIPS_HFLAG_UM;
 #else
-        ctx.mem_idx = hflags_mmu_index(ctx.hflags);
+        ctx->mem_idx = hflags_mmu_index(ctx->hflags);
 #endif
-    ctx.default_tcg_memop_mask = (ctx.insn_flags & ISA_MIPS32R6) ?
-                                 MO_UNALN : MO_ALIGN;
+    ctx->default_tcg_memop_mask = (ctx->insn_flags & ISA_MIPS32R6) ?
+                                  MO_UNALN : MO_ALIGN;
     max_insns = tb_cflags(tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -20251,74 +20253,74 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
-    LOG_DISAS("\ntb %p idx %d hflags %04x\n", tb, ctx.mem_idx, ctx.hflags);
+    LOG_DISAS("\ntb %p idx %d hflags %04x\n", tb, ctx->mem_idx, ctx->hflags);
     gen_tb_start(tb);
-    while (ctx.base.is_jmp == DISAS_NEXT) {
-        tcg_gen_insn_start(ctx.base.pc_next, ctx.hflags & MIPS_HFLAG_BMASK,
-                           ctx.btarget);
-        ctx.base.num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
-            save_cpu_state(&ctx, 1);
-            ctx.base.is_jmp = DISAS_NORETURN;
+    while (ctx->base.is_jmp == DISAS_NEXT) {
+        tcg_gen_insn_start(ctx->base.pc_next, ctx->hflags & MIPS_HFLAG_BMASK,
+                           ctx->btarget);
+        ctx->base.num_insns++;
+
+        if (unlikely(cpu_breakpoint_test(cs, ctx->base.pc_next, BP_ANY))) {
+            save_cpu_state(ctx, 1);
+            ctx->base.is_jmp = DISAS_NORETURN;
             gen_helper_raise_exception_debug(cpu_env);
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            ctx.base.pc_next += 4;
+            ctx->base.pc_next += 4;
             goto done_generating;
         }
 
-        if (ctx.base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
+        if (ctx->base.num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
-        is_slot = ctx.hflags & MIPS_HFLAG_BMASK;
-        if (!(ctx.hflags & MIPS_HFLAG_M16)) {
-            ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
+        is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
+        if (!(ctx->hflags & MIPS_HFLAG_M16)) {
+            ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
             insn_bytes = 4;
-            decode_opc(env, &ctx);
-        } else if (ctx.insn_flags & ASE_MICROMIPS) {
-            ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
-            insn_bytes = decode_micromips_opc(env, &ctx);
-        } else if (ctx.insn_flags & ASE_MIPS16) {
-            ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
-            insn_bytes = decode_mips16_opc(env, &ctx);
+            decode_opc(env, ctx);
+        } else if (ctx->insn_flags & ASE_MICROMIPS) {
+            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+            insn_bytes = decode_micromips_opc(env, ctx);
+        } else if (ctx->insn_flags & ASE_MIPS16) {
+            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+            insn_bytes = decode_mips16_opc(env, ctx);
         } else {
-            generate_exception_end(&ctx, EXCP_RI);
+            generate_exception_end(ctx, EXCP_RI);
             break;
         }
 
-        if (ctx.hflags & MIPS_HFLAG_BMASK) {
-            if (!(ctx.hflags & (MIPS_HFLAG_BDS16 | MIPS_HFLAG_BDS32 |
+        if (ctx->hflags & MIPS_HFLAG_BMASK) {
+            if (!(ctx->hflags & (MIPS_HFLAG_BDS16 | MIPS_HFLAG_BDS32 |
                                 MIPS_HFLAG_FBNSLOT))) {
                 /* force to generate branch as there is neither delay nor
                    forbidden slot */
                 is_slot = 1;
             }
-            if ((ctx.hflags & MIPS_HFLAG_M16) &&
-                (ctx.hflags & MIPS_HFLAG_FBNSLOT)) {
+            if ((ctx->hflags & MIPS_HFLAG_M16) &&
+                (ctx->hflags & MIPS_HFLAG_FBNSLOT)) {
                 /* Force to generate branch as microMIPS R6 doesn't restrict
                    branches in the forbidden slot. */
                 is_slot = 1;
             }
         }
         if (is_slot) {
-            gen_branch(&ctx, insn_bytes);
+            gen_branch(ctx, insn_bytes);
         }
-        ctx.base.pc_next += insn_bytes;
+        ctx->base.pc_next += insn_bytes;
 
         /* Execute a branch and its delay slot as a single instruction.
            This is what GDB expects and is consistent with what the
            hardware does (e.g. if a delay slot instruction faults, the
            reported PC is the PC of the branch).  */
-        if (ctx.base.singlestep_enabled &&
-            (ctx.hflags & MIPS_HFLAG_BMASK) == 0) {
+        if (ctx->base.singlestep_enabled &&
+            (ctx->hflags & MIPS_HFLAG_BMASK) == 0) {
             break;
         }
 
-        if (ctx.base.pc_next >= next_page_start) {
+        if (ctx->base.pc_next >= next_page_start) {
             break;
         }
 
@@ -20326,7 +20328,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
 
-        if (ctx.base.num_insns >= max_insns) {
+        if (ctx->base.num_insns >= max_insns) {
             break;
         }
 
@@ -20336,17 +20338,17 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
     }
-    if (ctx.base.singlestep_enabled && ctx.base.is_jmp != DISAS_NORETURN) {
-        save_cpu_state(&ctx, ctx.base.is_jmp != DISAS_EXCP);
+    if (ctx->base.singlestep_enabled && ctx->base.is_jmp != DISAS_NORETURN) {
+        save_cpu_state(ctx, ctx->base.is_jmp != DISAS_EXCP);
         gen_helper_raise_exception_debug(cpu_env);
     } else {
-        switch (ctx.base.is_jmp) {
+        switch (ctx->base.is_jmp) {
         case DISAS_STOP:
-            gen_goto_tb(&ctx, 0, ctx.base.pc_next);
+            gen_goto_tb(ctx, 0, ctx->base.pc_next);
             break;
         case DISAS_NEXT:
-            save_cpu_state(&ctx, 0);
-            gen_goto_tb(&ctx, 0, ctx.base.pc_next);
+            save_cpu_state(ctx, 0);
+            gen_goto_tb(ctx, 0, ctx->base.pc_next);
             break;
         case DISAS_EXCP:
             tcg_gen_exit_tb(0);
@@ -20357,19 +20359,19 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         }
     }
 done_generating:
-    gen_tb_end(tb, ctx.base.num_insns);
+    gen_tb_end(tb, ctx->base.num_insns);
 
-    tb->size = ctx.base.pc_next - ctx.base.pc_first;
-    tb->icount = ctx.base.num_insns;
+    tb->size = ctx->base.pc_next - ctx->base.pc_first;
+    tb->icount = ctx->base.num_insns;
 
 #ifdef DEBUG_DISAS
     LOG_DISAS("\n");
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(ctx.base.pc_first)) {
+        && qemu_log_in_addr_range(ctx->base.pc_first)) {
         qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(ctx.base.pc_first));
-        log_target_disas(cs, ctx.base.pc_first,
-                         ctx.base.pc_next - ctx.base.pc_first);
+        qemu_log("IN: %s\n", lookup_symbol(ctx->base.pc_first));
+        log_target_disas(cs, ctx->base.pc_first,
+                         ctx->base.pc_next - ctx->base.pc_first);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.7.4
