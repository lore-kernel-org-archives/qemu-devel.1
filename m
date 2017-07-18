Received: from eggs.gnu.org ([2001:4830:134:3::10]:48698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPn-0005mC-IY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00040h-He
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003VD-25
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:39 +0200
Message-Id: <20170718215050.3812-21-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 20/31] target/sh4: Load/store Dr as 64-bit
 quantities
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

This enforces proper alignment and makes the register update
more natural.  Note that there is a more serious bug fix for
fmov {DX}Rn,@(R0,Rn) to use a store instead of a load.

Signed-off-by: Richard Henderson <rth@twiddle.net>

Message-Id: <20170718200255.31647-17-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 75 ++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 40724819e5..7dfe23d1f4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -992,12 +992,10 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf00a: /* fmov {F,D,X}Rm,@Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv addr_hi = tcg_temp_new();
-            int fr = XHACK(B7_4);
-	    tcg_gen_addi_i32(addr_hi, REG(B11_8), 4);
-            tcg_gen_qemu_st_i32(FREG(fr), REG(B11_8), ctx->memidx, MO_TEUL);
-            tcg_gen_qemu_st_i32(FREG(fr + 1), addr_hi, ctx->memidx, MO_TEUL);
-	    tcg_temp_free(addr_hi);
+            TCGv_i64 fp = tcg_temp_new_i64();
+            gen_load_fpr64(ctx, fp, XHACK(B7_4));
+            tcg_gen_qemu_st_i64(fp, REG(B11_8), ctx->memidx, MO_TEQ);
+            tcg_temp_free_i64(fp);
 	} else {
             tcg_gen_qemu_st_i32(FREG(B7_4), REG(B11_8), ctx->memidx, MO_TEUL);
 	}
@@ -1005,12 +1003,10 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf008: /* fmov @Rm,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv addr_hi = tcg_temp_new();
-            int fr = XHACK(B11_8);
-	    tcg_gen_addi_i32(addr_hi, REG(B7_4), 4);
-            tcg_gen_qemu_ld_i32(FREG(fr), REG(B7_4), ctx->memidx, MO_TEUL);
-            tcg_gen_qemu_ld_i32(FREG(fr + 1), addr_hi, ctx->memidx, MO_TEUL);
-	    tcg_temp_free(addr_hi);
+            TCGv_i64 fp = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(fp, REG(B7_4), ctx->memidx, MO_TEQ);
+            gen_store_fpr64(ctx, fp, XHACK(B11_8));
+            tcg_temp_free_i64(fp);
 	} else {
             tcg_gen_qemu_ld_i32(FREG(B11_8), REG(B7_4), ctx->memidx, MO_TEUL);
 	}
@@ -1018,13 +1014,11 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf009: /* fmov @Rm+,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv addr_hi = tcg_temp_new();
-            int fr = XHACK(B11_8);
-	    tcg_gen_addi_i32(addr_hi, REG(B7_4), 4);
-            tcg_gen_qemu_ld_i32(FREG(fr), REG(B7_4), ctx->memidx, MO_TEUL);
-            tcg_gen_qemu_ld_i32(FREG(fr + 1), addr_hi, ctx->memidx, MO_TEUL);
-	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 8);
-	    tcg_temp_free(addr_hi);
+            TCGv_i64 fp = tcg_temp_new_i64();
+            tcg_gen_qemu_ld_i64(fp, REG(B7_4), ctx->memidx, MO_TEQ);
+            gen_store_fpr64(ctx, fp, XHACK(B11_8));
+            tcg_temp_free_i64(fp);
+            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 8);
 	} else {
             tcg_gen_qemu_ld_i32(FREG(B11_8), REG(B7_4), ctx->memidx, MO_TEUL);
 	    tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
@@ -1032,18 +1026,21 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0xf00b: /* fmov {F,D,X}Rm,@-Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
-        TCGv addr = tcg_temp_new_i32();
-        tcg_gen_subi_i32(addr, REG(B11_8), 4);
-        if (ctx->tbflags & FPSCR_SZ) {
-            int fr = XHACK(B7_4);
-            tcg_gen_qemu_st_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
-	    tcg_gen_subi_i32(addr, addr, 4);
-            tcg_gen_qemu_st_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
-	} else {
-            tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
-	}
-        tcg_gen_mov_i32(REG(B11_8), addr);
-        tcg_temp_free(addr);
+        {
+            TCGv addr = tcg_temp_new_i32();
+            if (ctx->tbflags & FPSCR_SZ) {
+                TCGv_i64 fp = tcg_temp_new_i64();
+                gen_load_fpr64(ctx, fp, XHACK(B7_4));
+                tcg_gen_subi_i32(addr, REG(B11_8), 8);
+                tcg_gen_qemu_st_i64(fp, addr, ctx->memidx, MO_TEQ);
+                tcg_temp_free_i64(fp);
+            } else {
+                tcg_gen_subi_i32(addr, REG(B11_8), 4);
+                tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
+            }
+            tcg_gen_mov_i32(REG(B11_8), addr);
+            tcg_temp_free(addr);
+        }
 	return;
     case 0xf006: /* fmov @(R0,Rm),{F,D,X}Rm - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
@@ -1051,10 +1048,10 @@ static void _decode_opc(DisasContext * ctx)
 	    TCGv addr = tcg_temp_new_i32();
 	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
-                int fr = XHACK(B11_8);
-                tcg_gen_qemu_ld_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
-		tcg_gen_addi_i32(addr, addr, 4);
-                tcg_gen_qemu_ld_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
+                TCGv_i64 fp = tcg_temp_new_i64();
+                tcg_gen_qemu_ld_i64(fp, addr, ctx->memidx, MO_TEQ);
+                gen_store_fpr64(ctx, fp, XHACK(B11_8));
+                tcg_temp_free_i64(fp);
 	    } else {
                 tcg_gen_qemu_ld_i32(FREG(B11_8), addr, ctx->memidx, MO_TEUL);
 	    }
@@ -1067,10 +1064,10 @@ static void _decode_opc(DisasContext * ctx)
 	    TCGv addr = tcg_temp_new();
 	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
-                int fr = XHACK(B7_4);
-                tcg_gen_qemu_ld_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
-		tcg_gen_addi_i32(addr, addr, 4);
-                tcg_gen_qemu_ld_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
+                TCGv_i64 fp = tcg_temp_new_i64();
+                gen_load_fpr64(ctx, fp, XHACK(B7_4));
+                tcg_gen_qemu_st_i64(fp, addr, ctx->memidx, MO_TEQ);
+                tcg_temp_free_i64(fp);
 	    } else {
                 tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
 	    }
-- 
2.11.0
