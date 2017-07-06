Received: from eggs.gnu.org ([2001:4830:134:3::10]:59825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSubJ-0007mB-Ff
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSubI-0002VE-Hp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:57 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSubI-0002V8-Cw
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 20:24:56 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so651639qte.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 17:24:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  5 Jul 2017 14:24:01 -1000
Message-Id: <20170706002401.10507-12-rth@twiddle.net>
In-Reply-To: <20170706002401.10507-1-rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 11/11] target/sh4: Eliminate DREG macro
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
 target/sh4/translate.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a45d0ee..7e3de74 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -398,7 +398,6 @@ static void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
 #define FREG(x)    ctx->fregs[x]
 #define XHACK(x)   ((((x) & 1 ) << 4) | ((x) & 0xe))
 #define XREG(x)    FREG(XHACK(x))
-#define DREG(x)    (x)
 
 #define CHECK_NOT_DELAY_SLOT \
     if (ctx->envflags & DELAY_SLOT_MASK) {                           \
@@ -1128,8 +1127,8 @@ static void _decode_opc(DisasContext * ctx)
 		    break; /* illegal instruction */
 		fp0 = tcg_temp_new_i64();
 		fp1 = tcg_temp_new_i64();
-		gen_load_fpr64(ctx, fp0, DREG(B11_8));
-		gen_load_fpr64(ctx, fp1, DREG(B7_4));
+		gen_load_fpr64(ctx, fp0, B11_8);
+		gen_load_fpr64(ctx, fp1, B7_4);
                 switch (ctx->opcode & 0xf00f) {
                 case 0xf000:		/* fadd Rm,Rn */
                     gen_helper_fadd_DT(fp0, cpu_env, fp0, fp1);
@@ -1150,7 +1149,7 @@ static void _decode_opc(DisasContext * ctx)
                     gen_helper_fcmp_gt_DT(cpu_env, fp0, fp1);
                     return;
                 }
-		gen_store_fpr64(ctx, fp0, DREG(B11_8));
+		gen_store_fpr64(ctx, fp0, B11_8);
                 tcg_temp_free_i64(fp0);
                 tcg_temp_free_i64(fp1);
 	    } else {
@@ -1740,7 +1739,7 @@ static void _decode_opc(DisasContext * ctx)
 		break; /* illegal instruction */
 	    fp = tcg_temp_new_i64();
             gen_helper_float_DT(fp, cpu_env, cpu_fpul);
-	    gen_store_fpr64(ctx, fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	}
 	else {
@@ -1754,7 +1753,7 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    fp = tcg_temp_new_i64();
-	    gen_load_fpr64(ctx, fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_ftrc_DT(cpu_fpul, cpu_env, fp);
 	    tcg_temp_free_i64(fp);
 	}
@@ -1774,9 +1773,9 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(ctx, fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, B11_8);
 	    gen_helper_fabs_DT(fp, fp);
-	    gen_store_fpr64(ctx, fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	} else {
 	    gen_helper_fabs_FT(FREG(B11_8), FREG(B11_8));
@@ -1788,9 +1787,9 @@ static void _decode_opc(DisasContext * ctx)
 	    if (ctx->opcode & 0x0100)
 		break; /* illegal instruction */
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(ctx, fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fsqrt_DT(fp, cpu_env, fp);
-	    gen_store_fpr64(ctx, fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	} else {
             gen_helper_fsqrt_FT(FREG(B11_8), cpu_env, FREG(B11_8));
@@ -1816,7 +1815,7 @@ static void _decode_opc(DisasContext * ctx)
 	{
 	    TCGv_i64 fp = tcg_temp_new_i64();
             gen_helper_fcnvsd_FT_DT(fp, cpu_env, cpu_fpul);
-	    gen_store_fpr64(ctx, fp, DREG(B11_8));
+	    gen_store_fpr64(ctx, fp, B11_8);
 	    tcg_temp_free_i64(fp);
 	}
 	return;
@@ -1824,7 +1823,7 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
 	{
 	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(ctx, fp, DREG(B11_8));
+	    gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fcnvds_DT_FT(cpu_fpul, cpu_env, fp);
 	    tcg_temp_free_i64(fp);
 	}
-- 
2.9.4
