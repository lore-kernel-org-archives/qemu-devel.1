Received: from eggs.gnu.org ([2001:4830:134:3::10]:48940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJo-0005l5-37
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGTJd-0006M0-HR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:56:00 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGTJd-0006KV-51
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:55:49 -0400
Received: by mail-pl0-x242.google.com with SMTP id n10-v6so1647184plp.0
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 10:55:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 10:54:57 -0700
Message-Id: <20180509175458.15642-28-richard.henderson@linaro.org>
In-Reply-To: <20180509175458.15642-1-richard.henderson@linaro.org>
References: <20180509175458.15642-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 27/28] target/riscv: convert to DisasContextBase
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

- Did not convert {num,max}_insns, since the corresponding code
  will go away in the next patch.

- ctx->pc becomes ctx->base.pc_next, and ctx->next_pc becomes
  ctx->pc_succ_insn.

While at it, convert the remaining tb->cflags readers to tb_cflags().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 129 +++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 65 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1fee5b51dc..68979abfd7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -40,14 +40,12 @@ static TCGv load_val;
 #include "exec/gen-icount.h"
 
 typedef struct DisasContext {
-    struct TranslationBlock *tb;
-    target_ulong pc;
-    target_ulong next_pc;
+    DisasContextBase base;
+    /* pc_succ_insn points to the instruction following base.pc_next */
+    target_ulong pc_succ_insn;
     uint32_t opcode;
     uint32_t flags;
     uint32_t mem_idx;
-    int singlestep_enabled;
-    DisasJumpType is_jmp;
     /* Remember the rounding mode encoded in the previous fp instruction,
        which we have already installed into env->fp_status.  Or -1 for
        no previous fp instruction.  Note that we exit the TB when writing
@@ -78,21 +76,21 @@ static const int tcg_memop_lookup[8] = {
 
 static void generate_exception(DisasContext *ctx, int excp)
 {
-    tcg_gen_movi_tl(cpu_pc, ctx->pc);
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
     TCGv_i32 helper_tmp = tcg_const_i32(excp);
     gen_helper_raise_exception(cpu_env, helper_tmp);
     tcg_temp_free_i32(helper_tmp);
-    ctx->is_jmp = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void generate_exception_mbadaddr(DisasContext *ctx, int excp)
 {
-    tcg_gen_movi_tl(cpu_pc, ctx->pc);
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
     tcg_gen_st_tl(cpu_pc, cpu_env, offsetof(CPURISCVState, badaddr));
     TCGv_i32 helper_tmp = tcg_const_i32(excp);
     gen_helper_raise_exception(cpu_env, helper_tmp);
     tcg_temp_free_i32(helper_tmp);
-    ctx->is_jmp = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_exception_debug(void)
@@ -114,12 +112,12 @@ static void gen_exception_inst_addr_mis(DisasContext *ctx)
 
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
-    if (unlikely(ctx->singlestep_enabled)) {
+    if (unlikely(ctx->base.singlestep_enabled)) {
         return false;
     }
 
 #ifndef CONFIG_USER_ONLY
-    return (ctx->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -131,10 +129,10 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
         /* chaining is only allowed when the jump is to the same page */
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
     } else {
         tcg_gen_movi_tl(cpu_pc, dest);
-        if (ctx->singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             gen_exception_debug();
         } else {
             tcg_gen_exit_tb(0);
@@ -513,7 +511,7 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
     target_ulong next_pc;
 
     /* check misaligned: */
-    next_pc = ctx->pc + imm;
+    next_pc = ctx->base.pc_next + imm;
     if (!riscv_has_ext(env, RVC)) {
         if ((next_pc & 0x3) != 0) {
             gen_exception_inst_addr_mis(ctx);
@@ -521,11 +519,11 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
         }
     }
     if (rd != 0) {
-        tcg_gen_movi_tl(cpu_gpr[rd], ctx->next_pc);
+        tcg_gen_movi_tl(cpu_gpr[rd], ctx->pc_succ_insn);
     }
 
-    gen_goto_tb(ctx, 0, ctx->pc + imm); /* must use this for safety */
-    ctx->is_jmp = DISAS_NORETURN;
+    gen_goto_tb(ctx, 0, ctx->base.pc_next + imm); /* must use this for safety */
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
@@ -548,7 +546,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         }
 
         if (rd != 0) {
-            tcg_gen_movi_tl(cpu_gpr[rd], ctx->next_pc);
+            tcg_gen_movi_tl(cpu_gpr[rd], ctx->pc_succ_insn);
         }
         tcg_gen_exit_tb(0);
 
@@ -556,7 +554,7 @@ static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_set_label(misaligned);
             gen_exception_inst_addr_mis(ctx);
         }
-        ctx->is_jmp = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
         break;
 
     default:
@@ -602,15 +600,15 @@ static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     tcg_temp_free(source1);
     tcg_temp_free(source2);
 
-    gen_goto_tb(ctx, 1, ctx->next_pc);
+    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
     gen_set_label(l); /* branch taken */
-    if (!riscv_has_ext(env, RVC) && ((ctx->pc + bimm) & 0x3)) {
+    if (!riscv_has_ext(env, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
         /* misaligned */
         gen_exception_inst_addr_mis(ctx);
     } else {
-        gen_goto_tb(ctx, 0, ctx->pc + bimm);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next + bimm);
     }
-    ctx->is_jmp = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
@@ -836,7 +834,7 @@ static void gen_atomic(DisasContext *ctx, uint32_t opc,
         if (rl) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
         }
-        if (tb_cflags(ctx->tb) & CF_PARALLEL) {
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
             l1 = gen_new_label();
             gen_set_label(l1);
         } else {
@@ -853,7 +851,7 @@ static void gen_atomic(DisasContext *ctx, uint32_t opc,
         tcg_gen_qemu_ld_tl(dat, src1, ctx->mem_idx, mop);
         tcg_gen_movcond_tl(cond, src2, dat, src2, dat, src2);
 
-        if (tb_cflags(ctx->tb) & CF_PARALLEL) {
+        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
             /* Parallel context.  Make this operation atomic by verifying
                that the memory didn't change while we computed the result.  */
             tcg_gen_atomic_cmpxchg_tl(src2, src1, dat, src2, ctx->mem_idx, mop);
@@ -1317,7 +1315,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     rs1_pass = tcg_temp_new();
     imm_rs1 = tcg_temp_new();
     gen_get_gpr(source1, rs1);
-    tcg_gen_movi_tl(cpu_pc, ctx->pc);
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
     tcg_gen_movi_tl(rs1_pass, rs1);
     tcg_gen_movi_tl(csr_store, csr); /* copy into temp reg to feed to helper */
 
@@ -1338,12 +1336,12 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             /* always generates U-level ECALL, fixed in do_interrupt handler */
             generate_exception(ctx, RISCV_EXCP_U_ECALL);
             tcg_gen_exit_tb(0); /* no chaining */
-            ctx->is_jmp = DISAS_NORETURN;
+            ctx->base.is_jmp = DISAS_NORETURN;
             break;
         case 0x1: /* EBREAK */
             generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
             tcg_gen_exit_tb(0); /* no chaining */
-            ctx->is_jmp = DISAS_NORETURN;
+            ctx->base.is_jmp = DISAS_NORETURN;
             break;
 #ifndef CONFIG_USER_ONLY
         case 0x002: /* URET */
@@ -1353,7 +1351,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             if (riscv_has_ext(env, RVS)) {
                 gen_helper_sret(cpu_pc, cpu_env, cpu_pc);
                 tcg_gen_exit_tb(0); /* no chaining */
-                ctx->is_jmp = DISAS_NORETURN;
+                ctx->base.is_jmp = DISAS_NORETURN;
             } else {
                 gen_exception_illegal(ctx);
             }
@@ -1364,13 +1362,13 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         case 0x302: /* MRET */
             gen_helper_mret(cpu_pc, cpu_env, cpu_pc);
             tcg_gen_exit_tb(0); /* no chaining */
-            ctx->is_jmp = DISAS_NORETURN;
+            ctx->base.is_jmp = DISAS_NORETURN;
             break;
         case 0x7b2: /* DRET */
             gen_exception_illegal(ctx);
             break;
         case 0x105: /* WFI */
-            tcg_gen_movi_tl(cpu_pc, ctx->next_pc);
+            tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
             gen_helper_wfi(cpu_env);
             break;
         case 0x104: /* SFENCE.VM */
@@ -1411,9 +1409,9 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         gen_io_end();
         gen_set_gpr(rd, dest);
         /* end tb since we may be changing priv modes, to get mmu_index right */
-        tcg_gen_movi_tl(cpu_pc, ctx->next_pc);
+        tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
         tcg_gen_exit_tb(0); /* no chaining */
-        ctx->is_jmp = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
         break;
     }
     tcg_temp_free(source1);
@@ -1731,7 +1729,7 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
             break; /* NOP */
         }
         tcg_gen_movi_tl(cpu_gpr[rd], (sextract64(ctx->opcode, 12, 20) << 12) +
-               ctx->pc);
+               ctx->base.pc_next);
         break;
     case OPC_RISC_JAL:
         imm = GET_JAL_IMM(ctx->opcode);
@@ -1804,9 +1802,9 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
         if (ctx->opcode & 0x1000) {
             /* FENCE_I is a no-op in QEMU,
              * however we need to end the translation block */
-            tcg_gen_movi_tl(cpu_pc, ctx->next_pc);
+            tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
             tcg_gen_exit_tb(0);
-            ctx->is_jmp = DISAS_NORETURN;
+            ctx->base.is_jmp = DISAS_NORETURN;
         } else {
             /* FENCE is a full memory barrier. */
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
@@ -1830,11 +1828,11 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
         if (!riscv_has_ext(env, RVC)) {
             gen_exception_illegal(ctx);
         } else {
-            ctx->next_pc = ctx->pc + 2;
+            ctx->pc_succ_insn = ctx->base.pc_next + 2;
             decode_RV32_64C(env, ctx);
         }
     } else {
-        ctx->next_pc = ctx->pc + 4;
+        ctx->pc_succ_insn = ctx->base.pc_next + 4;
         decode_RV32_64G(env, ctx);
     }
 }
@@ -1843,26 +1841,26 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
     CPURISCVState *env = cs->env_ptr;
     DisasContext ctx;
-    target_ulong pc_start;
     target_ulong page_start;
     int num_insns;
     int max_insns;
-    pc_start = tb->pc;
-    page_start = pc_start & TARGET_PAGE_MASK;
-    ctx.pc = pc_start;
 
+    ctx.base.pc_first = tb->pc;
+    ctx.base.pc_next = ctx.base.pc_first;
     /* once we have GDB, the rest of the translate.c implementation should be
        ready for singlestep */
-    ctx.singlestep_enabled = cs->singlestep_enabled;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
+    ctx.base.tb = tb;
+    ctx.base.is_jmp = DISAS_NEXT;
 
-    ctx.tb = tb;
-    ctx.is_jmp = DISAS_NEXT;
+    page_start = ctx.base.pc_first & TARGET_PAGE_MASK;
+    ctx.pc_succ_insn = ctx.base.pc_first;
     ctx.flags = tb->flags;
     ctx.mem_idx = tb->flags & TB_FLAGS_MMU_MASK;
     ctx.frm = -1;  /* unknown rounding mode */
 
     num_insns = 0;
-    max_insns = tb->cflags & CF_COUNT_MASK;
+    max_insns = tb_cflags(ctx.base.tb) & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
     }
@@ -1871,45 +1869,45 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     }
     gen_tb_start(tb);
 
-    while (ctx.is_jmp == DISAS_NEXT) {
-        tcg_gen_insn_start(ctx.pc);
+    while (ctx.base.is_jmp == DISAS_NEXT) {
+        tcg_gen_insn_start(ctx.base.pc_next);
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
-            tcg_gen_movi_tl(cpu_pc, ctx.pc);
-            ctx.is_jmp = DISAS_NORETURN;
+        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
+            tcg_gen_movi_tl(cpu_pc, ctx.base.pc_next);
+            ctx.base.is_jmp = DISAS_NORETURN;
             gen_exception_debug();
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            ctx.pc += 4;
+            ctx.base.pc_next += 4;
             goto done_generating;
         }
 
-        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+        if (num_insns == max_insns && (tb_cflags(ctx.base.tb) & CF_LAST_IO)) {
             gen_io_start();
         }
 
-        ctx.opcode = cpu_ldl_code(env, ctx.pc);
+        ctx.opcode = cpu_ldl_code(env, ctx.base.pc_next);
         decode_opc(env, &ctx);
-        ctx.pc = ctx.next_pc;
+        ctx.base.pc_next = ctx.pc_succ_insn;
 
-        if (ctx.is_jmp == DISAS_NEXT &&
+        if (ctx.base.is_jmp == DISAS_NEXT &&
             (cs->singlestep_enabled ||
-             ctx.pc - page_start >= TARGET_PAGE_SIZE ||
+             ctx.base.pc_next - page_start >= TARGET_PAGE_SIZE ||
              tcg_op_buf_full() ||
              num_insns >= max_insns ||
              singlestep)) {
-            ctx.is_jmp = DISAS_TOO_MANY;
+            ctx.base.is_jmp = DISAS_TOO_MANY;
         }
     }
-    if (tb->cflags & CF_LAST_IO) {
+    if (tb_cflags(ctx.base.tb) & CF_LAST_IO) {
         gen_io_end();
     }
-    switch (ctx.is_jmp) {
+    switch (ctx.base.is_jmp) {
     case DISAS_TOO_MANY:
-        tcg_gen_movi_tl(cpu_pc, ctx.pc);
+        tcg_gen_movi_tl(cpu_pc, ctx.base.pc_next);
         if (cs->singlestep_enabled) {
             gen_exception_debug();
         } else {
@@ -1923,14 +1921,15 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     }
 done_generating:
     gen_tb_end(tb, num_insns);
-    tb->size = ctx.pc - pc_start;
+    tb->size = ctx.base.pc_next - ctx.base.pc_first;
     tb->icount = num_insns;
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start);
+        && qemu_log_in_addr_range(ctx.base.pc_first)) {
+        qemu_log("IN: %s\n", lookup_symbol(ctx.base.pc_first));
+        log_target_disas(cs, ctx.base.pc_first,
+                         ctx.base.pc_next - ctx.base.pc_first);
         qemu_log("\n");
     }
 #endif
-- 
2.17.0
