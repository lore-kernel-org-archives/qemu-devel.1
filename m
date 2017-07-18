Received: from eggs.gnu.org ([2001:4830:134:3::10]:49835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYj9-0006Va-Ka
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYj6-0004lO-Ts
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:15 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYj6-0004lF-OD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:12 -0400
Received: by mail-qt0-x241.google.com with SMTP id 19so3681847qty.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:12 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:41 -1000
Message-Id: <20170718200255.31647-17-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 16/30] target/sh4: Load/store Dr as 64-bit
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
Cc: aurelien@aurel32.net

This enforces proper alignment and makes the register update
more natural.  Note that there is a more serious bug fix for
fmov {DX}Rn,@(R0,Rn) to use a store instead of a load.

Signed-off-by: Richard Henderson <rth@twiddle.net>

---
V2: Fix pre-dec address error.
---
 target/sh4/translate.c | 75 ++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9c320e4..bda6fa7 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -998,12 +998,10 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf00a: /* fmov {F,D,X}Rm,@Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv addr_hi = tcg_temp_new();
-	    int fr = XHACK(B7_4);
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
@@ -1011,12 +1009,10 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf008: /* fmov @Rm,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv addr_hi = tcg_temp_new();
-	    int fr = XHACK(B11_8);
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
@@ -1024,13 +1020,11 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf009: /* fmov @Rm+,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv addr_hi = tcg_temp_new();
-	    int fr = XHACK(B11_8);
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
@@ -1038,18 +1032,21 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0xf00b: /* fmov {F,D,X}Rm,@-Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
-        TCGv addr = tcg_temp_new_i32();
-        tcg_gen_subi_i32(addr, REG(B11_8), 4);
-        if (ctx->tbflags & FPSCR_SZ) {
-	    int fr = XHACK(B7_4);
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
@@ -1057,10 +1054,10 @@ static void _decode_opc(DisasContext * ctx)
 	    TCGv addr = tcg_temp_new_i32();
 	    tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
-		int fr = XHACK(B11_8);
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
@@ -1073,10 +1070,10 @@ static void _decode_opc(DisasContext * ctx)
 	    TCGv addr = tcg_temp_new();
 	    tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             if (ctx->tbflags & FPSCR_SZ) {
-		int fr = XHACK(B7_4);
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
2.9.4
