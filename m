Received: from eggs.gnu.org ([2001:4830:134:3::10]:57371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45c-0007IB-6X
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-00048M-Lx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:52 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eR45Z-0003vZ-BF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:49 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:30 +0100
Message-Id: <20171218224030.26726-7-aurelien@aurel32.net>
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 6/6] target/sh4: Convert to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
[aurel32: fix whitespace]
Message-Id: <20170907185057.23421-5-richard.henderson@linaro.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 154 +++++++++++++++++++++++++------------------------
 1 file changed, 78 insertions(+), 76 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index dd9aaa4e63..038663cc05 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -33,19 +33,19 @@
 
 
 typedef struct DisasContext {
-    struct TranslationBlock *tb;
-    target_ulong pc;
-    uint16_t opcode;
-    uint32_t tbflags;    /* should stay unmodified during the TB translation */
-    uint32_t envflags;   /* should stay in sync with env->flags using TCG ops */
-    DisasJumpType bstate;
+    DisasContextBase base;
+
+    uint32_t tbflags;  /* should stay unmodified during the TB translation */
+    uint32_t envflags; /* should stay in sync with env->flags using TCG ops */
     int memidx;
     int gbank;
     int fbank;
     uint32_t delayed_pc;
-    int singlestep_enabled;
     uint32_t features;
-    int has_movcal;
+
+    uint16_t opcode;
+
+    bool has_movcal;
 } DisasContext;
 
 #if defined(CONFIG_USER_ONLY)
@@ -54,7 +54,7 @@ typedef struct DisasContext {
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
 #endif
 
-/* Target-specific values for ctx->bstate.  */
+/* Target-specific values for ctx->base.is_jmp.  */
 /* We want to exit back to the cpu loop for some reason.
    Usually this is to recognize interrupts immediately.  */
 #define DISAS_STOP    DISAS_TARGET_0
@@ -209,7 +209,7 @@ static void gen_write_sr(TCGv src)
 static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
 {
     if (save_pc) {
-        tcg_gen_movi_i32(cpu_pc, ctx->pc);
+        tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
     }
     if (ctx->delayed_pc != (uint32_t) -1) {
         tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
@@ -227,11 +227,11 @@ static inline bool use_exit_tb(DisasContext *ctx)
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
     /* Use a direct jump if in same page and singlestep not enabled */
-    if (unlikely(ctx->singlestep_enabled || use_exit_tb(ctx))) {
+    if (unlikely(ctx->base.singlestep_enabled || use_exit_tb(ctx))) {
         return false;
     }
 #ifndef CONFIG_USER_ONLY
-    return (ctx->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+    return (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
 #else
     return true;
 #endif
@@ -242,10 +242,10 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
     if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
+        tcg_gen_exit_tb((uintptr_t)ctx->base.tb + n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        if (ctx->singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(0);
@@ -253,7 +253,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             tcg_gen_lookup_and_goto_ptr();
         }
     }
-    ctx->bstate = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_jump(DisasContext * ctx)
@@ -263,14 +263,14 @@ static void gen_jump(DisasContext * ctx)
 	   delayed jump as immediate jump are conditinal jumps */
 	tcg_gen_mov_i32(cpu_pc, cpu_delayed_pc);
         tcg_gen_discard_i32(cpu_delayed_pc);
-        if (ctx->singlestep_enabled) {
+        if (ctx->base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else if (use_exit_tb(ctx)) {
             tcg_gen_exit_tb(0);
         } else {
             tcg_gen_lookup_and_goto_ptr();
         }
-        ctx->bstate = DISAS_NORETURN;
+        ctx->base.is_jmp = DISAS_NORETURN;
     } else {
 	gen_goto_tb(ctx, 0, ctx->delayed_pc);
     }
@@ -300,8 +300,8 @@ static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
     tcg_gen_brcondi_i32(cond_not_taken, cpu_sr_t, 0, l1);
     gen_goto_tb(ctx, 0, dest);
     gen_set_label(l1);
-    gen_goto_tb(ctx, 1, ctx->pc + 2);
-    ctx->bstate = DISAS_NORETURN;
+    gen_goto_tb(ctx, 1, ctx->base.pc_next + 2);
+    ctx->base.is_jmp = DISAS_NORETURN;
 }
 
 /* Delayed conditional jump (bt or bf) */
@@ -324,12 +324,12 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
         gen_jump(ctx);
 
         gen_set_label(l1);
-        ctx->bstate = DISAS_NEXT;
+        ctx->base.is_jmp = DISAS_NEXT;
         return;
     }
 
     tcg_gen_brcondi_i32(TCG_COND_NE, ds, 0, l1);
-    gen_goto_tb(ctx, 1, ctx->pc + 2);
+    gen_goto_tb(ctx, 1, ctx->base.pc_next + 2);
     gen_set_label(l1);
     gen_jump(ctx);
 }
@@ -466,7 +466,7 @@ static void _decode_opc(DisasContext * ctx)
 	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
         ctx->envflags |= DELAY_SLOT_RTE;
 	ctx->delayed_pc = (uint32_t) - 1;
-        ctx->bstate = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
 	return;
     case 0x0058:		/* sets */
         tcg_gen_ori_i32(cpu_sr, cpu_sr, (1u << SR_S));
@@ -477,23 +477,23 @@ static void _decode_opc(DisasContext * ctx)
     case 0xfbfd:		/* frchg */
         CHECK_FPSCR_PR_0
 	tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_FR);
-        ctx->bstate = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
 	return;
     case 0xf3fd:		/* fschg */
         CHECK_FPSCR_PR_0
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
-        ctx->bstate = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
 	return;
     case 0xf7fd:                /* fpchg */
         CHECK_SH4A
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_PR);
-        ctx->bstate = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
         return;
     case 0x0009:		/* nop */
 	return;
     case 0x001b:		/* sleep */
 	CHECK_PRIVILEGED
-        tcg_gen_movi_i32(cpu_pc, ctx->pc + 2);
+        tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next + 2);
         gen_helper_sleep(cpu_env);
 	return;
     }
@@ -520,23 +520,24 @@ static void _decode_opc(DisasContext * ctx)
         /* Detect the start of a gUSA region.  If so, update envflags
            and end the TB.  This will allow us to see the end of the
            region (stored in R0) in the next TB.  */
-        if (B11_8 == 15 && B7_0s < 0 && (tb_cflags(ctx->tb) & CF_PARALLEL)) {
+        if (B11_8 == 15 && B7_0s < 0 &&
+            (tb_cflags(ctx->base.tb) & CF_PARALLEL)) {
             ctx->envflags = deposit32(ctx->envflags, GUSA_SHIFT, 8, B7_0s);
-            ctx->bstate = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
         }
 #endif
 	tcg_gen_movi_i32(REG(B11_8), B7_0s);
 	return;
     case 0x9000:		/* mov.w @(disp,PC),Rn */
 	{
-	    TCGv addr = tcg_const_i32(ctx->pc + 4 + B7_0 * 2);
+            TCGv addr = tcg_const_i32(ctx->base.pc_next + 4 + B7_0 * 2);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx, MO_TESW);
 	    tcg_temp_free(addr);
 	}
 	return;
     case 0xd000:		/* mov.l @(disp,PC),Rn */
 	{
-	    TCGv addr = tcg_const_i32((ctx->pc + 4 + B7_0 * 4) & ~3);
+            TCGv addr = tcg_const_i32((ctx->base.pc_next + 4 + B7_0 * 4) & ~3);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx, MO_TESL);
 	    tcg_temp_free(addr);
 	}
@@ -546,13 +547,13 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0xa000:		/* bra disp */
 	CHECK_NOT_DELAY_SLOT
-	ctx->delayed_pc = ctx->pc + 4 + B11_0s * 2;
+        ctx->delayed_pc = ctx->base.pc_next + 4 + B11_0s * 2;
         ctx->envflags |= DELAY_SLOT;
 	return;
     case 0xb000:		/* bsr disp */
 	CHECK_NOT_DELAY_SLOT
-	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
-	ctx->delayed_pc = ctx->pc + 4 + B11_0s * 2;
+        tcg_gen_movi_i32(cpu_pr, ctx->base.pc_next + 4);
+        ctx->delayed_pc = ctx->base.pc_next + 4 + B11_0s * 2;
         ctx->envflags |= DELAY_SLOT;
 	return;
     }
@@ -1180,22 +1181,22 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x8b00:		/* bf label */
 	CHECK_NOT_DELAY_SLOT
-        gen_conditional_jump(ctx, ctx->pc + 4 + B7_0s * 2, false);
+        gen_conditional_jump(ctx, ctx->base.pc_next + 4 + B7_0s * 2, false);
 	return;
     case 0x8f00:		/* bf/s label */
 	CHECK_NOT_DELAY_SLOT
         tcg_gen_xori_i32(cpu_delayed_cond, cpu_sr_t, 1);
-        ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2;
+        ctx->delayed_pc = ctx->base.pc_next + 4 + B7_0s * 2;
         ctx->envflags |= DELAY_SLOT_CONDITIONAL;
 	return;
     case 0x8900:		/* bt label */
 	CHECK_NOT_DELAY_SLOT
-        gen_conditional_jump(ctx, ctx->pc + 4 + B7_0s * 2, true);
+        gen_conditional_jump(ctx, ctx->base.pc_next + 4 + B7_0s * 2, true);
 	return;
     case 0x8d00:		/* bt/s label */
 	CHECK_NOT_DELAY_SLOT
         tcg_gen_mov_i32(cpu_delayed_cond, cpu_sr_t);
-        ctx->delayed_pc = ctx->pc + 4 + B7_0s * 2;
+        ctx->delayed_pc = ctx->base.pc_next + 4 + B7_0s * 2;
         ctx->envflags |= DELAY_SLOT_CONDITIONAL;
 	return;
     case 0x8800:		/* cmp/eq #imm,R0 */
@@ -1282,7 +1283,8 @@ static void _decode_opc(DisasContext * ctx)
 	}
 	return;
     case 0xc700:		/* mova @(disp,PC),R0 */
-	tcg_gen_movi_i32(REG(0), ((ctx->pc & 0xfffffffc) + 4 + B7_0 * 4) & ~3);
+        tcg_gen_movi_i32(REG(0), ((ctx->base.pc_next & 0xfffffffc) +
+                                  4 + B7_0 * 4) & ~3);
 	return;
     case 0xcb00:		/* or #imm,R0 */
 	tcg_gen_ori_i32(REG(0), REG(0), B7_0);
@@ -1308,7 +1310,7 @@ static void _decode_opc(DisasContext * ctx)
 	    imm = tcg_const_i32(B7_0);
             gen_helper_trapa(cpu_env, imm);
 	    tcg_temp_free(imm);
-            ctx->bstate = DISAS_NORETURN;
+            ctx->base.is_jmp = DISAS_NORETURN;
 	}
 	return;
     case 0xc800:		/* tst #imm,R0 */
@@ -1376,13 +1378,13 @@ static void _decode_opc(DisasContext * ctx)
     switch (ctx->opcode & 0xf0ff) {
     case 0x0023:		/* braf Rn */
 	CHECK_NOT_DELAY_SLOT
-	tcg_gen_addi_i32(cpu_delayed_pc, REG(B11_8), ctx->pc + 4);
+        tcg_gen_addi_i32(cpu_delayed_pc, REG(B11_8), ctx->base.pc_next + 4);
         ctx->envflags |= DELAY_SLOT;
 	ctx->delayed_pc = (uint32_t) - 1;
 	return;
     case 0x0003:		/* bsrf Rn */
 	CHECK_NOT_DELAY_SLOT
-	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
+        tcg_gen_movi_i32(cpu_pr, ctx->base.pc_next + 4);
 	tcg_gen_add_i32(cpu_delayed_pc, REG(B11_8), cpu_pr);
         ctx->envflags |= DELAY_SLOT;
 	ctx->delayed_pc = (uint32_t) - 1;
@@ -1405,7 +1407,7 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x400b:		/* jsr @Rn */
 	CHECK_NOT_DELAY_SLOT
-	tcg_gen_movi_i32(cpu_pr, ctx->pc + 4);
+        tcg_gen_movi_i32(cpu_pr, ctx->base.pc_next + 4);
 	tcg_gen_mov_i32(cpu_delayed_pc, REG(B11_8));
         ctx->envflags |= DELAY_SLOT;
 	ctx->delayed_pc = (uint32_t) - 1;
@@ -1417,7 +1419,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_andi_i32(val, REG(B11_8), 0x700083f3);
             gen_write_sr(val);
             tcg_temp_free(val);
-            ctx->bstate = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
         }
 	return;
     case 0x4007:		/* ldc.l @Rm+,SR */
@@ -1429,7 +1431,7 @@ static void _decode_opc(DisasContext * ctx)
             gen_write_sr(val);
 	    tcg_temp_free(val);
 	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-            ctx->bstate = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
 	}
 	return;
     case 0x0002:		/* stc SR,Rn */
@@ -1491,7 +1493,7 @@ static void _decode_opc(DisasContext * ctx)
     case 0x406a:		/* lds Rm,FPSCR */
 	CHECK_FPU_ENABLED
         gen_helper_ld_fpscr(cpu_env, REG(B11_8));
-        ctx->bstate = DISAS_STOP;
+        ctx->base.is_jmp = DISAS_STOP;
 	return;
     case 0x4066:		/* lds.l @Rm+,FPSCR */
 	CHECK_FPU_ENABLED
@@ -1501,7 +1503,7 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
             gen_helper_ld_fpscr(cpu_env, addr);
 	    tcg_temp_free(addr);
-            ctx->bstate = DISAS_STOP;
+            ctx->base.is_jmp = DISAS_STOP;
 	}
 	return;
     case 0x006a:		/* sts FPSCR,Rn */
@@ -1565,7 +1567,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGLabel *fail = gen_new_label();
             TCGLabel *done = gen_new_label();
 
-            if ((tb_cflags(ctx->tb) & CF_PARALLEL)) {
+            if ((tb_cflags(ctx->base.tb) & CF_PARALLEL)) {
                 TCGv tmp;
 
                 tcg_gen_brcond_i32(TCG_COND_NE, REG(B11_8),
@@ -1599,7 +1601,7 @@ static void _decode_opc(DisasContext * ctx)
          * In a parallel context, we must also save the loaded value
          * for use with the cmpxchg that we'll use with movco.l.  */
         CHECK_SH4A
-        if ((tb_cflags(ctx->tb) & CF_PARALLEL)) {
+        if ((tb_cflags(ctx->base.tb) & CF_PARALLEL)) {
             TCGv tmp = tcg_temp_new();
             tcg_gen_mov_i32(tmp, REG(B11_8));
             tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
@@ -1827,7 +1829,7 @@ static void _decode_opc(DisasContext * ctx)
     }
 #if 0
     fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
-	    ctx->opcode, ctx->pc);
+            ctx->opcode, ctx->base.pc_next);
     fflush(stderr);
 #endif
  do_illegal:
@@ -1839,7 +1841,7 @@ static void _decode_opc(DisasContext * ctx)
         gen_save_cpu_state(ctx, true);
         gen_helper_raise_illegal_instruction(cpu_env);
     }
-    ctx->bstate = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
     return;
 
  do_fpu_disabled:
@@ -1849,7 +1851,7 @@ static void _decode_opc(DisasContext * ctx)
     } else {
         gen_helper_raise_fpu_disable(cpu_env);
     }
-    ctx->bstate = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
     return;
 }
 
@@ -1901,8 +1903,8 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     int mv_src, mt_dst, st_src, st_mop;
     TCGv op_arg;
 
-    uint32_t pc = ctx->pc;
-    uint32_t pc_end = ctx->tb->cs_base;
+    uint32_t pc = ctx->base.pc_next;
+    uint32_t pc_end = ctx->base.tb->cs_base;
     int backup = sextract32(ctx->tbflags, GUSA_SHIFT, 8);
     int max_insns = (pc_end - pc) / 2;
     int i;
@@ -2232,7 +2234,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
 
     /* The entire region has been translated.  */
     ctx->envflags &= ~GUSA_MASK;
-    ctx->pc = pc_end;
+    ctx->base.pc_next = pc_end;
     return max_insns;
 
  fail:
@@ -2245,13 +2247,13 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     ctx->envflags |= GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(cpu_env);
-    ctx->bstate = DISAS_NORETURN;
+    ctx->base.is_jmp = DISAS_NORETURN;
 
     /* We're not executing an instruction, but we must report one for the
        purposes of accounting within the TB.  We might as well report the
-       entire region consumed via ctx->pc so that it's immediately available
-       in the disassembly dump.  */
-    ctx->pc = pc_end;
+       entire region consumed via ctx->base.pc_next so that it's immediately
+       available in the disassembly dump.  */
+    ctx->base.pc_next = pc_end;
     return 1;
 }
 #endif
@@ -2265,16 +2267,16 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     int max_insns;
 
     pc_start = tb->pc;
-    ctx.pc = pc_start;
+    ctx.base.pc_next = pc_start;
     ctx.tbflags = (uint32_t)tb->flags;
     ctx.envflags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
-    ctx.bstate = DISAS_NEXT;
+    ctx.base.is_jmp = DISAS_NEXT;
     ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
     /* We don't know if the delayed pc came from a dynamic or static branch,
        so assume it is a dynamic branch.  */
     ctx.delayed_pc = -1; /* use delayed pc from env pointer */
-    ctx.tb = tb;
-    ctx.singlestep_enabled = cs->singlestep_enabled;
+    ctx.base.tb = tb;
+    ctx.base.singlestep_enabled = cs->singlestep_enabled;
     ctx.features = env->features;
     ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
     ctx.gbank = ((ctx.tbflags & (1 << SR_MD)) &&
@@ -2289,11 +2291,11 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     /* Since the ISA is fixed-width, we can bound by the number
        of instructions remaining on the page.  */
-    num_insns = -(ctx.pc | TARGET_PAGE_MASK) / 2;
+    num_insns = -(ctx.base.pc_next | TARGET_PAGE_MASK) / 2;
     max_insns = MIN(max_insns, num_insns);
 
     /* Single stepping means just that.  */
-    if (ctx.singlestep_enabled || singlestep) {
+    if (ctx.base.singlestep_enabled || singlestep) {
         max_insns = 1;
     }
 
@@ -2306,22 +2308,22 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     }
 #endif
 
-    while (ctx.bstate == DISAS_NEXT
+    while (ctx.base.is_jmp == DISAS_NEXT
            && num_insns < max_insns
            && !tcg_op_buf_full()) {
-        tcg_gen_insn_start(ctx.pc, ctx.envflags);
+        tcg_gen_insn_start(ctx.base.pc_next, ctx.envflags);
         num_insns++;
 
-        if (unlikely(cpu_breakpoint_test(cs, ctx.pc, BP_ANY))) {
+        if (unlikely(cpu_breakpoint_test(cs, ctx.base.pc_next, BP_ANY))) {
             /* We have hit a breakpoint - make sure PC is up-to-date */
             gen_save_cpu_state(&ctx, true);
             gen_helper_debug(cpu_env);
-            ctx.bstate = DISAS_NORETURN;
+            ctx.base.is_jmp = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
                the logic setting tb->size below does the right thing.  */
-            ctx.pc += 2;
+            ctx.base.pc_next += 2;
             break;
         }
 
@@ -2329,9 +2331,9 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             gen_io_start();
         }
 
-        ctx.opcode = cpu_lduw_code(env, ctx.pc);
+        ctx.opcode = cpu_lduw_code(env, ctx.base.pc_next);
 	decode_opc(&ctx);
-	ctx.pc += 2;
+        ctx.base.pc_next += 2;
     }
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
@@ -2342,10 +2344,10 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         ctx.envflags &= ~GUSA_MASK;
     }
 
-    switch (ctx.bstate) {
+    switch (ctx.base.is_jmp) {
     case DISAS_STOP:
         gen_save_cpu_state(&ctx, true);
-        if (cs->singlestep_enabled) {
+        if (ctx.base.singlestep_enabled) {
             gen_helper_debug(cpu_env);
         } else {
             tcg_gen_exit_tb(0);
@@ -2353,7 +2355,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         break;
     case DISAS_NEXT:
         gen_save_cpu_state(&ctx, false);
-        gen_goto_tb(&ctx, 0, ctx.pc);
+        gen_goto_tb(&ctx, 0, ctx.base.pc_next);
         break;
     case DISAS_NORETURN:
         break;
@@ -2363,7 +2365,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     gen_tb_end(tb, num_insns);
 
-    tb->size = ctx.pc - pc_start;
+    tb->size = ctx.base.pc_next - pc_start;
     tb->icount = num_insns;
 
 #ifdef DEBUG_DISAS
@@ -2371,7 +2373,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
 	qemu_log("IN:\n");	/* , lookup_symbol(pc_start)); */
-        log_target_disas(cs, pc_start, ctx.pc - pc_start);
+        log_target_disas(cs, pc_start, ctx.base.pc_next - pc_start);
 	qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.15.1
