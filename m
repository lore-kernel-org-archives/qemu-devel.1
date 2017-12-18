Received: from eggs.gnu.org ([2001:4830:134:3::10]:57341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45b-0007Hp-6I
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-000484-KH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:51 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eR45Z-0003vW-At
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:49 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:28 +0100
Message-Id: <20171218224030.26726-5-aurelien@aurel32.net>
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 4/6] target/sh4: Convert to DisasJumpType
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
Message-Id: <20170907185057.23421-3-richard.henderson@linaro.org>
[aurel32: fix whitespace]
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 65 +++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index f7fe1a46d8..efd1081c57 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -25,10 +25,9 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
-
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
+#include "exec/translator.h"
 #include "trace-tcg.h"
 #include "exec/log.h"
 
@@ -39,7 +38,7 @@ typedef struct DisasContext {
     uint16_t opcode;
     uint32_t tbflags;    /* should stay unmodified during the TB translation */
     uint32_t envflags;   /* should stay in sync with env->flags using TCG ops */
-    int bstate;
+    DisasJumpType bstate;
     int memidx;
     int gbank;
     int fbank;
@@ -55,14 +54,10 @@ typedef struct DisasContext {
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
 #endif
 
-enum {
-    BS_NONE     = 0, /* We go out of the TB without reaching a branch or an
-                      * exception condition
-                      */
-    BS_STOP     = 1, /* We want to stop translation for any reason */
-    BS_BRANCH   = 2, /* We reached a branch condition     */
-    BS_EXCP     = 3, /* We reached an exception condition */
-};
+/* Target-specific values for ctx->bstate.  */
+/* We want to exit back to the cpu loop for some reason.
+   Usually this is to recognize interrupts immediately.  */
+#define DISAS_STOP    DISAS_TARGET_0
 
 /* global register indexes */
 static TCGv cpu_gregs[32];
@@ -258,6 +253,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             tcg_gen_lookup_and_goto_ptr();
         }
     }
+    ctx->bstate = DISAS_NORETURN;
 }
 
 static void gen_jump(DisasContext * ctx)
@@ -304,7 +300,7 @@ static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
     gen_goto_tb(ctx, 0, dest);
     gen_set_label(l1);
     gen_goto_tb(ctx, 1, ctx->pc + 2);
-    ctx->bstate = BS_BRANCH;
+    ctx->bstate = DISAS_NORETURN;
 }
 
 /* Delayed conditional jump (bt or bf) */
@@ -327,6 +323,7 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
         gen_jump(ctx);
 
         gen_set_label(l1);
+        ctx->bstate = DISAS_NEXT;
         return;
     }
 
@@ -468,7 +465,7 @@ static void _decode_opc(DisasContext * ctx)
 	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
         ctx->envflags |= DELAY_SLOT_RTE;
 	ctx->delayed_pc = (uint32_t) - 1;
-        ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
 	return;
     case 0x0058:		/* sets */
         tcg_gen_ori_i32(cpu_sr, cpu_sr, (1u << SR_S));
@@ -479,17 +476,17 @@ static void _decode_opc(DisasContext * ctx)
     case 0xfbfd:		/* frchg */
         CHECK_FPSCR_PR_0
 	tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_FR);
-	ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
 	return;
     case 0xf3fd:		/* fschg */
         CHECK_FPSCR_PR_0
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
-	ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
 	return;
     case 0xf7fd:                /* fpchg */
         CHECK_SH4A
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_PR);
-        ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
         return;
     case 0x0009:		/* nop */
 	return;
@@ -524,7 +521,7 @@ static void _decode_opc(DisasContext * ctx)
            region (stored in R0) in the next TB.  */
         if (B11_8 == 15 && B7_0s < 0 && (tb_cflags(ctx->tb) & CF_PARALLEL)) {
             ctx->envflags = deposit32(ctx->envflags, GUSA_SHIFT, 8, B7_0s);
-            ctx->bstate = BS_STOP;
+            ctx->bstate = DISAS_STOP;
         }
 #endif
 	tcg_gen_movi_i32(REG(B11_8), B7_0s);
@@ -1310,7 +1307,7 @@ static void _decode_opc(DisasContext * ctx)
 	    imm = tcg_const_i32(B7_0);
             gen_helper_trapa(cpu_env, imm);
 	    tcg_temp_free(imm);
-            ctx->bstate = BS_EXCP;
+            ctx->bstate = DISAS_NORETURN;
 	}
 	return;
     case 0xc800:		/* tst #imm,R0 */
@@ -1419,7 +1416,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_andi_i32(val, REG(B11_8), 0x700083f3);
             gen_write_sr(val);
             tcg_temp_free(val);
-            ctx->bstate = BS_STOP;
+            ctx->bstate = DISAS_STOP;
         }
 	return;
     case 0x4007:		/* ldc.l @Rm+,SR */
@@ -1431,7 +1428,7 @@ static void _decode_opc(DisasContext * ctx)
             gen_write_sr(val);
 	    tcg_temp_free(val);
 	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-	    ctx->bstate = BS_STOP;
+            ctx->bstate = DISAS_STOP;
 	}
 	return;
     case 0x0002:		/* stc SR,Rn */
@@ -1493,7 +1490,7 @@ static void _decode_opc(DisasContext * ctx)
     case 0x406a:		/* lds Rm,FPSCR */
 	CHECK_FPU_ENABLED
         gen_helper_ld_fpscr(cpu_env, REG(B11_8));
-	ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
 	return;
     case 0x4066:		/* lds.l @Rm+,FPSCR */
 	CHECK_FPU_ENABLED
@@ -1503,7 +1500,7 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
             gen_helper_ld_fpscr(cpu_env, addr);
 	    tcg_temp_free(addr);
-	    ctx->bstate = BS_STOP;
+            ctx->bstate = DISAS_STOP;
 	}
 	return;
     case 0x006a:		/* sts FPSCR,Rn */
@@ -1841,7 +1838,7 @@ static void _decode_opc(DisasContext * ctx)
         gen_save_cpu_state(ctx, true);
         gen_helper_raise_illegal_instruction(cpu_env);
     }
-    ctx->bstate = BS_EXCP;
+    ctx->bstate = DISAS_NORETURN;
     return;
 
  do_fpu_disabled:
@@ -1851,7 +1848,7 @@ static void _decode_opc(DisasContext * ctx)
     } else {
         gen_helper_raise_fpu_disable(cpu_env);
     }
-    ctx->bstate = BS_EXCP;
+    ctx->bstate = DISAS_NORETURN;
     return;
 }
 
@@ -1877,7 +1874,6 @@ static void decode_opc(DisasContext * ctx)
         ctx->envflags &= ~GUSA_MASK;
 
         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
-        ctx->bstate = BS_BRANCH;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
 	    gen_delayed_conditional_jump(ctx);
         } else {
@@ -2248,7 +2244,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     ctx->envflags |= GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(cpu_env);
-    ctx->bstate = BS_EXCP;
+    ctx->bstate = DISAS_NORETURN;
 
     /* We're not executing an instruction, but we must report one for the
        purposes of accounting within the TB.  We might as well report the
@@ -2271,7 +2267,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     ctx.pc = pc_start;
     ctx.tbflags = (uint32_t)tb->flags;
     ctx.envflags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
-    ctx.bstate = BS_NONE;
+    ctx.bstate = DISAS_NEXT;
     ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
     /* We don't know if the delayed pc came from a dynamic or static branch,
        so assume it is a dynamic branch.  */
@@ -2309,7 +2305,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     }
 #endif
 
-    while (ctx.bstate == BS_NONE
+    while (ctx.bstate == DISAS_NEXT
            && num_insns < max_insns
            && !tcg_op_buf_full()) {
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
@@ -2319,7 +2315,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             /* We have hit a breakpoint - make sure PC is up-to-date */
             gen_save_cpu_state(&ctx, true);
             gen_helper_debug(cpu_env);
-            ctx.bstate = BS_EXCP;
+            ctx.bstate = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
@@ -2350,19 +2346,18 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         gen_helper_debug(cpu_env);
     } else {
 	switch (ctx.bstate) {
-        case BS_STOP:
+        case DISAS_STOP:
             gen_save_cpu_state(&ctx, true);
             tcg_gen_exit_tb(0);
             break;
-        case BS_NONE:
+        case DISAS_NEXT:
             gen_save_cpu_state(&ctx, false);
             gen_goto_tb(&ctx, 0, ctx.pc);
             break;
-        case BS_EXCP:
-            /* fall through */
-        case BS_BRANCH:
-        default:
+        case DISAS_NORETURN:
             break;
+        default:
+            g_assert_not_reached();
 	}
     }
 
-- 
2.15.1
