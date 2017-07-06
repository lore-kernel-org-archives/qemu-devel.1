Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSub9-0007co-Mw
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSub8-0002SL-Lh
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:47 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSub8-0002SD-HP
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:46 -0400
Received: by mail-qt0-x243.google.com with SMTP id c20so651276qte.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:23:58 -1000
Message-Id: <20170706002401.10507-9-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 08/11] target/sh4: Pass DisasContext to fpr64
 routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, bruno@clisp.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index e4fd6f2..05657a9 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -359,12 +359,12 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
     gen_jump(ctx);
 }
 
-static inline void gen_load_fpr64(TCGv_i64 t, int reg)
+static inline void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
     tcg_gen_concat_i32_i64(t, cpu_fregs[reg + 1], cpu_fregs[reg]);
 }
 
-static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
+static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 {
     tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);
 }
@@ -1006,8 +1006,8 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, XHACK(B7_4));
-	    gen_store_fpr64(fp, XHACK(B11_8));
+	    gen_load_fpr64(ctx, fp, XHACK(B7_4));
+	    gen_store_fpr64(ctx, fp, XHACK(B11_8));
 	    tcg_temp_free_i64(fp);
 	} else {
 	    tcg_gen_mov_i32(FREG(B11_8), FREG(B7_4));
@@ -1116,8 +1116,8 @@ static void _decode_opc(DisasContext * ctx)
 		    break; /* illegal instruction */
 		fp0 = tcg_temp_new_i64();
 		fp1 = tcg_temp_new_i64();
-		gen_load_fpr64(fp0, DREG(B11_8));
-		gen_load_fpr64(fp1, DREG(B7_4));
+		gen_load_fpr64(ctx, fp0, DREG(B11_8));
+		gen_load_fpr64(ctx, fp1, DREG(B7_4));
                 switch (ctx->opcode & 0xf00f) {
                 case 0xf000:		/* fadd Rm,Rn */
                     gen_helper_fadd_DT(fp0, cpu_env, fp0, fp1);
@@ -1138,7 +1138,7 @@ static void _decode_opc(DisasContext * ctx)
                     gen_helper_fcmp_gt_DT(cpu_env, fp0, fp1);
                     return;
                 }
-		gen_store_fpr64(fp0, DREG(B11_8));
+		gen_store_fpr64(ctx, fp0, DREG(B11_8));
                 tcg_temp_free_i64(fp0);
                 tcg_temp_free_i64(fp1);
 	    } else {
@@ -1728,7 +1728,7 @@ static void _decode_opc(DisasContext * ctx)
 		break; /* illegal instruction */
 	    fp = tcg_temp_new_i64();
             gen_helper_float_DT(fp, cpu_env, cpu_fpul);
-	    gen_store_fpr64(fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, DREG(B11_8));
 	    tcg_temp_free_i64(fp);
 	}
 	else {
@@ -1742,7 +1742,7 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, DREG(B11_8));
             gen_helper_ftrc_DT(cpu_fpul, cpu_env, fp);
 	    tcg_temp_free_i64(fp);
 	}
@@ -1762,9 +1762,9 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, DREG(B11_8));
 	    gen_helper_fabs_DT(fp, fp);
-	    gen_store_fpr64(fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, DREG(B11_8));
 	    tcg_temp_free_i64(fp);
 	} else {
 	    gen_helper_fabs_FT(FREG(B11_8), FREG(B11_8));
@@ -1776,9 +1776,9 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, DREG(B11_8));
             gen_helper_fsqrt_DT(fp, cpu_env, fp);
-	    gen_store_fpr64(fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, DREG(B11_8));
 	    tcg_temp_free_i64(fp);
 	} else {
             gen_helper_fsqrt_FT(FREG(B11_8), cpu_env, FREG(B11_8));
@@ -1804,7 +1804,7 @@ static void _decode_opc(DisasContext * ctx)
 	{
 	    TCGv_i64 fp = tcg_temp_new_i64();
             gen_helper_fcnvsd_FT_DT(fp, cpu_env, cpu_fpul);
-	    gen_store_fpr64(fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, DREG(B11_8));
 	    tcg_temp_free_i64(fp);
 	}
 	return;
@@ -1812,7 +1812,7 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
 	{
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, DREG(B11_8));
             gen_helper_fcnvds_DT_FT(cpu_fpul, cpu_env, fp);
 	    tcg_temp_free_i64(fp);
 	}
-- 
2.9.4
