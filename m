Received: from eggs.gnu.org ([2001:4830:134:3::10]:54134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tL-00009b-WA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tG-0000UY-Sv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:08 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:34895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1tG-0000Tw-KU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:02 -0400
Received: by mail-pg0-x22d.google.com with SMTP id 188so996415pgb.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:51:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:50:54 -0700
Message-Id: <20170907185057.23421-3-richard.henderson@linaro.org>
In-Reply-To: <20170907185057.23421-1-richard.henderson@linaro.org>
References: <20170907185057.23421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/5] target/sh4: Convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 65 +++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4365b21624..6e03370871 100644
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
 static TCGv_env cpu_env;
@@ -269,6 +264,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
         }
     }
+    ctx->bstate = DISAS_NORETURN;
 }
 
 static void gen_jump(DisasContext * ctx)
@@ -315,7 +311,7 @@ static void gen_conditional_jump(DisasContext *ctx, target_ulong dest,
     gen_goto_tb(ctx, 0, dest);
     gen_set_label(l1);
     gen_goto_tb(ctx, 1, ctx->pc + 2);
-    ctx->bstate = BS_BRANCH;
+    ctx->bstate = DISAS_NORETURN;
 }
 
 /* Delayed conditional jump (bt or bf) */
@@ -338,6 +334,7 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
         gen_jump(ctx);
 
         gen_set_label(l1);
+        ctx->bstate = DISAS_NEXT;
         return;
     }
 
@@ -479,7 +476,7 @@ static void _decode_opc(DisasContext * ctx)
 	tcg_gen_mov_i32(cpu_delayed_pc, cpu_spc);
         ctx->envflags |= DELAY_SLOT_RTE;
 	ctx->delayed_pc = (uint32_t) - 1;
-        ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
 	return;
     case 0x0058:		/* sets */
         tcg_gen_ori_i32(cpu_sr, cpu_sr, (1u << SR_S));
@@ -490,17 +487,17 @@ static void _decode_opc(DisasContext * ctx)
     case 0xfbfd:		/* frchg */
         CHECK_FPSCR_PR_0
 	tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_FR);
-	ctx->bstate = BS_STOP;
+	ctx->bstate = DISAS_STOP;
 	return;
     case 0xf3fd:		/* fschg */
         CHECK_FPSCR_PR_0
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
-	ctx->bstate = BS_STOP;
+	ctx->bstate = DISAS_STOP;
 	return;
     case 0xf7fd:                /* fpchg */
         CHECK_SH4A
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_PR);
-        ctx->bstate = BS_STOP;
+        ctx->bstate = DISAS_STOP;
         return;
     case 0x0009:		/* nop */
 	return;
@@ -535,7 +532,7 @@ static void _decode_opc(DisasContext * ctx)
            region (stored in R0) in the next TB.  */
         if (B11_8 == 15 && B7_0s < 0 && parallel_cpus) {
             ctx->envflags = deposit32(ctx->envflags, GUSA_SHIFT, 8, B7_0s);
-            ctx->bstate = BS_STOP;
+            ctx->bstate = DISAS_STOP;
         }
 #endif
 	tcg_gen_movi_i32(REG(B11_8), B7_0s);
@@ -1320,7 +1317,7 @@ static void _decode_opc(DisasContext * ctx)
 	    imm = tcg_const_i32(B7_0);
             gen_helper_trapa(cpu_env, imm);
 	    tcg_temp_free(imm);
-            ctx->bstate = BS_EXCP;
+            ctx->bstate = DISAS_NORETURN;
 	}
 	return;
     case 0xc800:		/* tst #imm,R0 */
@@ -1429,7 +1426,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_andi_i32(val, REG(B11_8), 0x700083f3);
             gen_write_sr(val);
             tcg_temp_free(val);
-            ctx->bstate = BS_STOP;
+            ctx->bstate = DISAS_STOP;
         }
 	return;
     case 0x4007:		/* ldc.l @Rm+,SR */
@@ -1441,7 +1438,7 @@ static void _decode_opc(DisasContext * ctx)
             gen_write_sr(val);
 	    tcg_temp_free(val);
 	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-	    ctx->bstate = BS_STOP;
+	    ctx->bstate = DISAS_STOP;
 	}
 	return;
     case 0x0002:		/* stc SR,Rn */
@@ -1503,7 +1500,7 @@ static void _decode_opc(DisasContext * ctx)
     case 0x406a:		/* lds Rm,FPSCR */
 	CHECK_FPU_ENABLED
         gen_helper_ld_fpscr(cpu_env, REG(B11_8));
-	ctx->bstate = BS_STOP;
+	ctx->bstate = DISAS_STOP;
 	return;
     case 0x4066:		/* lds.l @Rm+,FPSCR */
 	CHECK_FPU_ENABLED
@@ -1513,7 +1510,7 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
             gen_helper_ld_fpscr(cpu_env, addr);
 	    tcg_temp_free(addr);
-	    ctx->bstate = BS_STOP;
+	    ctx->bstate = DISAS_STOP;
 	}
 	return;
     case 0x006a:		/* sts FPSCR,Rn */
@@ -1849,7 +1846,7 @@ static void _decode_opc(DisasContext * ctx)
         gen_save_cpu_state(ctx, true);
         gen_helper_raise_illegal_instruction(cpu_env);
     }
-    ctx->bstate = BS_EXCP;
+    ctx->bstate = DISAS_NORETURN;
     return;
 
  do_fpu_disabled:
@@ -1859,7 +1856,7 @@ static void _decode_opc(DisasContext * ctx)
     } else {
         gen_helper_raise_fpu_disable(cpu_env);
     }
-    ctx->bstate = BS_EXCP;
+    ctx->bstate = DISAS_NORETURN;
     return;
 }
 
@@ -1885,7 +1882,6 @@ static void decode_opc(DisasContext * ctx)
         ctx->envflags &= ~GUSA_MASK;
 
         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
-        ctx->bstate = BS_BRANCH;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
 	    gen_delayed_conditional_jump(ctx);
         } else {
@@ -2256,7 +2252,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     ctx->envflags |= GUSA_EXCLUSIVE;
     gen_save_cpu_state(ctx, false);
     gen_helper_exclusive(cpu_env);
-    ctx->bstate = BS_EXCP;
+    ctx->bstate = DISAS_NORETURN;
 
     /* We're not executing an instruction, but we must report one for the
        purposes of accounting within the TB.  We might as well report the
@@ -2279,7 +2275,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     ctx.pc = pc_start;
     ctx.tbflags = (uint32_t)tb->flags;
     ctx.envflags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
-    ctx.bstate = BS_NONE;
+    ctx.bstate = DISAS_NEXT;
     ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
     /* We don't know if the delayed pc came from a dynamic or static branch,
        so assume it is a dynamic branch.  */
@@ -2317,7 +2313,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     }
 #endif
 
-    while (ctx.bstate == BS_NONE
+    while (ctx.bstate == DISAS_NEXT
            && num_insns < max_insns
            && !tcg_op_buf_full()) {
         tcg_gen_insn_start(ctx.pc, ctx.envflags);
@@ -2327,7 +2323,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             /* We have hit a breakpoint - make sure PC is up-to-date */
             gen_save_cpu_state(&ctx, true);
             gen_helper_debug(cpu_env);
-            ctx.bstate = BS_EXCP;
+            ctx.bstate = DISAS_NORETURN;
             /* The address covered by the breakpoint must be included in
                [tb->pc, tb->pc + tb->size) in order to for it to be
                properly cleared -- thus we increment the PC here so that
@@ -2358,19 +2354,18 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
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
2.13.5
