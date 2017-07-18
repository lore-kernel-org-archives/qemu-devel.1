Received: from eggs.gnu.org ([2001:4830:134:3::10]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPo-0005nn-Q2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00041H-JH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003V3-3c
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:34 +0200
Message-Id: <20170718215050.3812-16-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/31] target/sh4: Unify cpu_fregs into FREG
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

We were treating FREG as an index and REG as a TCGv.
Making FREG return a TCGv is both less confusing and
a step toward cleaner banking of cpu_fregs.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-12-rth@twiddle.net>
[aurel32: fix whitespace issues]
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 125 ++++++++++++++++++++-----------------------------
 1 file changed, 52 insertions(+), 73 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d6e05f77fe..bed52c9075 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -354,10 +354,11 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 #define REG(x)     cpu_gregs[(x) ^ ctx->gbank]
 #define ALTREG(x)  cpu_gregs[(x) ^ ctx->gbank ^ 0x10]
 
-#define FREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
+#define FREG(x) cpu_fregs[ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x)]
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-#define XREG(x) (ctx->tbflags & FPSCR_FR ? XHACK(x) ^ 0x10 : XHACK(x))
-#define DREG(x) FREG(x) /* Assumes lsb of (x) is always 0 */
+#define XREG(x) FREG(XHACK(x))
+/* Assumes lsb of (x) is always 0 */
+#define DREG(x) (ctx->tbflags & FPSCR_FR ? (x) ^ 0x10 : (x))
 
 #define CHECK_NOT_DELAY_SLOT \
     if (ctx->envflags & DELAY_SLOT_MASK) {                           \
@@ -977,56 +978,51 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, XREG(B7_4));
-	    gen_store_fpr64(fp, XREG(B11_8));
+            gen_load_fpr64(fp, XHACK(B7_4));
+            gen_store_fpr64(fp, XHACK(B11_8));
 	    tcg_temp_free_i64(fp);
 	} else {
-	    tcg_gen_mov_i32(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B7_4)]);
+            tcg_gen_mov_i32(FREG(B11_8), FREG(B7_4));
 	}
 	return;
     case 0xf00a: /* fmov {F,D,X}Rm,@Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
 	    TCGv addr_hi = tcg_temp_new();
-	    int fr = XREG(B7_4);
+            int fr = XHACK(B7_4);
 	    tcg_gen_addi_i32(addr_hi, REG(B11_8), 4);
-            tcg_gen_qemu_st_i32(cpu_fregs[fr], REG(B11_8),
-                                ctx->memidx, MO_TEUL);
-            tcg_gen_qemu_st_i32(cpu_fregs[fr+1], addr_hi,
-                                ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_st_i32(FREG(fr), REG(B11_8), ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_st_i32(FREG(fr + 1), addr_hi, ctx->memidx, MO_TEUL);
 	    tcg_temp_free(addr_hi);
 	} else {
-            tcg_gen_qemu_st_i32(cpu_fregs[FREG(B7_4)], REG(B11_8),
-                                ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_st_i32(FREG(B7_4), REG(B11_8), ctx->memidx, MO_TEUL);
 	}
 	return;
     case 0xf008: /* fmov @Rm,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
 	    TCGv addr_hi = tcg_temp_new();
-	    int fr = XREG(B11_8);
+            int fr = XHACK(B11_8);
 	    tcg_gen_addi_i32(addr_hi, REG(B7_4), 4);
-            tcg_gen_qemu_ld_i32(cpu_fregs[fr], REG(B7_4), ctx->memidx, MO_TEUL);
-            tcg_gen_qemu_ld_i32(cpu_fregs[fr+1], addr_hi, ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(FREG(fr), REG(B7_4), ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(FREG(fr + 1), addr_hi, ctx->memidx, MO_TEUL);
 	    tcg_temp_free(addr_hi);
 	} else {
-            tcg_gen_qemu_ld_i32(cpu_fregs[FREG(B11_8)], REG(B7_4),
-                                ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(FREG(B11_8), REG(B7_4), ctx->memidx, MO_TEUL);
 	}
 	return;
     case 0xf009: /* fmov @Rm+,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
 	    TCGv addr_hi = tcg_temp_new();
-	    int fr = XREG(B11_8);
+            int fr = XHACK(B11_8);
 	    tcg_gen_addi_i32(addr_hi, REG(B7_4), 4);
-            tcg_gen_qemu_ld_i32(cpu_fregs[fr], REG(B7_4), ctx->memidx, MO_TEUL);
-            tcg_gen_qemu_ld_i32(cpu_fregs[fr+1], addr_hi, ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(FREG(fr), REG(B7_4), ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(FREG(fr + 1), addr_hi, ctx->memidx, MO_TEUL);
 	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 8);
 	    tcg_temp_free(addr_hi);
 	} else {
-            tcg_gen_qemu_ld_i32(cpu_fregs[FREG(B11_8)], REG(B7_4),
-                                ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_ld_i32(FREG(B11_8), REG(B7_4), ctx->memidx, MO_TEUL);
 	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
 	}
 	return;
@@ -1035,13 +1031,12 @@ static void _decode_opc(DisasContext * ctx)
         TCGv addr = tcg_temp_new_i32();
         tcg_gen_subi_i32(addr, REG(B11_8), 4);
         if (ctx->tbflags & FPSCR_SZ) {
-	    int fr = XREG(B7_4);
-            tcg_gen_qemu_st_i32(cpu_fregs[fr+1], addr, ctx->memidx, MO_TEUL);
+            int fr = XHACK(B7_4);
+            tcg_gen_qemu_st_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
 	    tcg_gen_subi_i32(addr, addr, 4);
-            tcg_gen_qemu_st_i32(cpu_fregs[fr], addr, ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_st_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
 	} else {
-            tcg_gen_qemu_st_i32(cpu_fregs[FREG(B7_4)], addr,
-                                ctx->memidx, MO_TEUL);
+            tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
 	}
         tcg_gen_mov_i32(REG(B11_8), addr);
         tcg_temp_free(addr);
@@ -1052,15 +1047,12 @@ static void _decode_opc(DisasContext * ctx)
 	    TCGv addr = tcg_temp_new_i32();
 	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
-		int fr = XREG(B11_8);
-                tcg_gen_qemu_ld_i32(cpu_fregs[fr], addr,
-                                    ctx->memidx, MO_TEUL);
+                int fr = XHACK(B11_8);
+                tcg_gen_qemu_ld_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
 		tcg_gen_addi_i32(addr, addr, 4);
-                tcg_gen_qemu_ld_i32(cpu_fregs[fr+1], addr,
-                                    ctx->memidx, MO_TEUL);
+                tcg_gen_qemu_ld_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
 	    } else {
-                tcg_gen_qemu_ld_i32(cpu_fregs[FREG(B11_8)], addr,
-                                    ctx->memidx, MO_TEUL);
+                tcg_gen_qemu_ld_i32(FREG(B11_8), addr, ctx->memidx, MO_TEUL);
 	    }
 	    tcg_temp_free(addr);
 	}
@@ -1071,15 +1063,12 @@ static void _decode_opc(DisasContext * ctx)
 	    TCGv addr = tcg_temp_new();
 	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
-		int fr = XREG(B7_4);
-                tcg_gen_qemu_ld_i32(cpu_fregs[fr], addr,
-                                    ctx->memidx, MO_TEUL);
+                int fr = XHACK(B7_4);
+                tcg_gen_qemu_ld_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
 		tcg_gen_addi_i32(addr, addr, 4);
-                tcg_gen_qemu_ld_i32(cpu_fregs[fr+1], addr,
-                                    ctx->memidx, MO_TEUL);
+                tcg_gen_qemu_ld_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
 	    } else {
-                tcg_gen_qemu_st_i32(cpu_fregs[FREG(B7_4)], addr,
-                                    ctx->memidx, MO_TEUL);
+                tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
 	    }
 	    tcg_temp_free(addr);
 	}
@@ -1127,34 +1116,28 @@ static void _decode_opc(DisasContext * ctx)
 	    } else {
                 switch (ctx->opcode & 0xf00f) {
                 case 0xf000:		/* fadd Rm,Rn */
-                    gen_helper_fadd_FT(cpu_fregs[FREG(B11_8)], cpu_env,
-                                       cpu_fregs[FREG(B11_8)],
-                                       cpu_fregs[FREG(B7_4)]);
+                    gen_helper_fadd_FT(FREG(B11_8), cpu_env,
+                                       FREG(B11_8), FREG(B7_4));
                     break;
                 case 0xf001:		/* fsub Rm,Rn */
-                    gen_helper_fsub_FT(cpu_fregs[FREG(B11_8)], cpu_env,
-                                       cpu_fregs[FREG(B11_8)],
-                                       cpu_fregs[FREG(B7_4)]);
+                    gen_helper_fsub_FT(FREG(B11_8), cpu_env,
+                                       FREG(B11_8), FREG(B7_4));
                     break;
                 case 0xf002:		/* fmul Rm,Rn */
-                    gen_helper_fmul_FT(cpu_fregs[FREG(B11_8)], cpu_env,
-                                       cpu_fregs[FREG(B11_8)],
-                                       cpu_fregs[FREG(B7_4)]);
+                    gen_helper_fmul_FT(FREG(B11_8), cpu_env,
+                                       FREG(B11_8), FREG(B7_4));
                     break;
                 case 0xf003:		/* fdiv Rm,Rn */
-                    gen_helper_fdiv_FT(cpu_fregs[FREG(B11_8)], cpu_env,
-                                       cpu_fregs[FREG(B11_8)],
-                                       cpu_fregs[FREG(B7_4)]);
+                    gen_helper_fdiv_FT(FREG(B11_8), cpu_env,
+                                       FREG(B11_8), FREG(B7_4));
                     break;
                 case 0xf004:		/* fcmp/eq Rm,Rn */
                     gen_helper_fcmp_eq_FT(cpu_sr_t, cpu_env,
-                                          cpu_fregs[FREG(B11_8)],
-                                          cpu_fregs[FREG(B7_4)]);
+                                          FREG(B11_8), FREG(B7_4));
                     return;
                 case 0xf005:		/* fcmp/gt Rm,Rn */
                     gen_helper_fcmp_gt_FT(cpu_sr_t, cpu_env,
-                                          cpu_fregs[FREG(B11_8)],
-                                          cpu_fregs[FREG(B7_4)]);
+                                          FREG(B11_8), FREG(B7_4));
                     return;
                 }
 	    }
@@ -1166,9 +1149,8 @@ static void _decode_opc(DisasContext * ctx)
             if (ctx->tbflags & FPSCR_PR) {
                 break; /* illegal instruction */
             } else {
-                gen_helper_fmac_FT(cpu_fregs[FREG(B11_8)], cpu_env,
-                                   cpu_fregs[FREG(0)], cpu_fregs[FREG(B7_4)],
-                                   cpu_fregs[FREG(B11_8)]);
+                gen_helper_fmac_FT(FREG(B11_8), cpu_env,
+                                   FREG(0), FREG(B7_4), FREG(B11_8));
                 return;
             }
         }
@@ -1693,11 +1675,11 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0xf00d: /* fsts FPUL,FRn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
-	tcg_gen_mov_i32(cpu_fregs[FREG(B11_8)], cpu_fpul);
+        tcg_gen_mov_i32(FREG(B11_8), cpu_fpul);
 	return;
     case 0xf01d: /* flds FRm,FPUL - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
-	tcg_gen_mov_i32(cpu_fpul, cpu_fregs[FREG(B11_8)]);
+        tcg_gen_mov_i32(cpu_fpul, FREG(B11_8));
 	return;
     case 0xf02d: /* float FPUL,FRn/DRn - FPSCR: R[PR,Enable.I]/W[Cause,Flag] */
 	CHECK_FPU_ENABLED
@@ -1711,7 +1693,7 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_temp_free_i64(fp);
 	}
 	else {
-            gen_helper_float_FT(cpu_fregs[FREG(B11_8)], cpu_env, cpu_fpul);
+            gen_helper_float_FT(FREG(B11_8), cpu_env, cpu_fpul);
 	}
 	return;
     case 0xf03d: /* ftrc FRm/DRm,FPUL - FPSCR: R[PR,Enable.V]/W[Cause,Flag] */
@@ -1726,18 +1708,16 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_temp_free_i64(fp);
 	}
 	else {
-            gen_helper_ftrc_FT(cpu_fpul, cpu_env, cpu_fregs[FREG(B11_8)]);
+            gen_helper_ftrc_FT(cpu_fpul, cpu_env, FREG(B11_8));
 	}
 	return;
     case 0xf04d: /* fneg FRn/DRn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
-        tcg_gen_xori_i32(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)],
-                         0x80000000);
+        tcg_gen_xori_i32(FREG(B11_8), FREG(B11_8), 0x80000000);
 	return;
     case 0xf05d: /* fabs FRn/DRn - FPCSR: Nothing */
 	CHECK_FPU_ENABLED
-        tcg_gen_andi_i32(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)],
-                         0x7fffffff);
+        tcg_gen_andi_i32(FREG(B11_8), FREG(B11_8), 0x7fffffff);
 	return;
     case 0xf06d: /* fsqrt FRn */
 	CHECK_FPU_ENABLED
@@ -1750,8 +1730,7 @@ static void _decode_opc(DisasContext * ctx)
 	    gen_store_fpr64(fp, DREG(B11_8));
 	    tcg_temp_free_i64(fp);
 	} else {
-            gen_helper_fsqrt_FT(cpu_fregs[FREG(B11_8)], cpu_env,
-                                cpu_fregs[FREG(B11_8)]);
+            gen_helper_fsqrt_FT(FREG(B11_8), cpu_env, FREG(B11_8));
 	}
 	return;
     case 0xf07d: /* fsrra FRn */
@@ -1760,13 +1739,13 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf08d: /* fldi0 FRn - FPSCR: R[PR] */
 	CHECK_FPU_ENABLED
         if (!(ctx->tbflags & FPSCR_PR)) {
-	    tcg_gen_movi_i32(cpu_fregs[FREG(B11_8)], 0);
+            tcg_gen_movi_i32(FREG(B11_8), 0);
 	}
 	return;
     case 0xf09d: /* fldi1 FRn - FPSCR: R[PR] */
 	CHECK_FPU_ENABLED
         if (!(ctx->tbflags & FPSCR_PR)) {
-	    tcg_gen_movi_i32(cpu_fregs[FREG(B11_8)], 0x3f800000);
+            tcg_gen_movi_i32(FREG(B11_8), 0x3f800000);
 	}
 	return;
     case 0xf0ad: /* fcnvsd FPUL,DRn */
-- 
2.11.0
