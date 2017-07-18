Received: from eggs.gnu.org ([2001:4830:134:3::10]:48521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPi-0005hE-P4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPh-0003xM-O1
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003VB-4R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:17 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:38 +0200
Message-Id: <20170718215050.3812-20-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 19/31] target/sh4: Merge DREG into fpr64 routines
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

Also add a debugging assert that we did signal illegal opc
for odd double-precision registers.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-16-rth@twiddle.net>
[aurel32: fix whitespace issues]
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index e5b88ac568..40724819e5 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -334,11 +334,17 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
 
 static inline void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
+    /* We have already signaled illegal instruction for odd Dr.  */
+    tcg_debug_assert((reg & 1) == 0);
+    reg ^= ctx->fbank;
     tcg_gen_concat_i32_i64(t, cpu_fregs[reg + 1], cpu_fregs[reg]);
 }
 
 static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
+    /* We have already signaled illegal instruction for odd Dr.  */
+    tcg_debug_assert((reg & 1) == 0);
+    reg ^= ctx->fbank;
     tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);
 }
 
@@ -357,8 +363,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define FREG(x)    cpu_fregs[(x) ^ ctx->fbank]
 
 #define XHACK(x) ((((x) & 1 ) << 4) | ((x) & 0xe))
-/* Assumes lsb of (x) is always 0 */
-#define DREG(x)  ((x) ^ ctx->fbank)
 
 #define CHECK_NOT_DELAY_SLOT \
     if (ctx->envflags & DELAY_SLOT_MASK) {                           \
@@ -1088,8 +1092,8 @@ static void _decode_opc(DisasContext * ctx)
 		    break; /* illegal instruction */
 		fp0 = tcg_temp_new_i64();
 		fp1 = tcg_temp_new_i64();
-                gen_load_fpr64(ctx, fp0, DREG(B11_8));
-                gen_load_fpr64(ctx, fp1, DREG(B7_4));
+                gen_load_fpr64(ctx, fp0, B11_8);
+                gen_load_fpr64(ctx, fp1, B7_4);
                 switch (ctx->opcode & 0xf00f) {
                 case 0xf000:		/* fadd Rm,Rn */
                     gen_helper_fadd_DT(fp0, cpu_env, fp0, fp1);
@@ -1110,7 +1114,7 @@ static void _decode_opc(DisasContext * ctx)
                     gen_helper_fcmp_gt_DT(cpu_sr_t, cpu_env, fp0, fp1);
                     return;
                 }
-                gen_store_fpr64(ctx, fp0, DREG(B11_8));
+                gen_store_fpr64(ctx, fp0, B11_8);
                 tcg_temp_free_i64(fp0);
                 tcg_temp_free_i64(fp1);
 	    } else {
@@ -1689,7 +1693,7 @@ static void _decode_opc(DisasContext * ctx)
 		break; /* illegal instruction */
 	    fp = tcg_temp_new_i64();
             gen_helper_float_DT(fp, cpu_env, cpu_fpul);
-            gen_store_fpr64(ctx, fp, DREG(B11_8));
+            gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	}
 	else {
@@ -1703,7 +1707,7 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    fp = tcg_temp_new_i64();
-            gen_load_fpr64(ctx, fp, DREG(B11_8));
+            gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_ftrc_DT(cpu_fpul, cpu_env, fp);
 	    tcg_temp_free_i64(fp);
 	}
@@ -1725,9 +1729,9 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    TCGv_i64 fp = tcg_temp_new_i64();
-            gen_load_fpr64(ctx, fp, DREG(B11_8));
+            gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fsqrt_DT(fp, cpu_env, fp);
-            gen_store_fpr64(ctx, fp, DREG(B11_8));
+            gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	} else {
             gen_helper_fsqrt_FT(FREG(B11_8), cpu_env, FREG(B11_8));
@@ -1753,7 +1757,7 @@ static void _decode_opc(DisasContext * ctx)
 	{
 	    TCGv_i64 fp = tcg_temp_new_i64();
             gen_helper_fcnvsd_FT_DT(fp, cpu_env, cpu_fpul);
-            gen_store_fpr64(ctx, fp, DREG(B11_8));
+            gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	}
 	return;
@@ -1761,7 +1765,7 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
 	{
 	    TCGv_i64 fp = tcg_temp_new_i64();
-            gen_load_fpr64(ctx, fp, DREG(B11_8));
+            gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fcnvds_DT_FT(cpu_fpul, cpu_env, fp);
 	    tcg_temp_free_i64(fp);
 	}
-- 
2.11.0
