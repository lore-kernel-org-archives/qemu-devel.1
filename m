Received: from eggs.gnu.org ([2001:4830:134:3::10]:49944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjL-0006k2-M7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjK-0004yU-LS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:27 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjK-0004y8-IF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:26 -0400
Received: by mail-qk0-x241.google.com with SMTP id d136so3746991qkg.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:47 -1000
Message-Id: <20170718200255.31647-23-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 22/30] target/sh4: Introduce CHECK_FPSCR_PR_*
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

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 57 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 09e4ace..346f672 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -384,6 +384,16 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
         goto do_fpu_disabled;               \
     }
 
+#define CHECK_FPSCR_PR_0 \
+    if (ctx->tbflags & FPSCR_PR) {          \
+        goto do_illegal;                    \
+    }
+
+#define CHECK_FPSCR_PR_1 \
+    if (!(ctx->tbflags & FPSCR_PR)) {       \
+        goto do_illegal;                    \
+    }
+
 static void _decode_opc(DisasContext * ctx)
 {
     /* This code tries to make movcal emulation sufficiently
@@ -1135,16 +1145,11 @@ static void _decode_opc(DisasContext * ctx)
 	}
 	return;
     case 0xf00e: /* fmac FR0,RM,Rn */
-        {
-            CHECK_FPU_ENABLED
-            if (ctx->tbflags & FPSCR_PR) {
-                goto do_illegal;
-            } else {
-                gen_helper_fmac_FT(FREG(B11_8), cpu_env,
-                                   FREG(0), FREG(B7_4), FREG(B11_8));
-                return;
-            }
-        }
+        CHECK_FPU_ENABLED
+        CHECK_FPSCR_PR_0
+        gen_helper_fmac_FT(FREG(B11_8), cpu_env,
+                           FREG(0), FREG(B7_4), FREG(B11_8));
+        return;
     }
 
     switch (ctx->opcode & 0xff00) {
@@ -1738,16 +1743,14 @@ static void _decode_opc(DisasContext * ctx)
 	break;
     case 0xf08d: /* fldi0 FRn - FPSCR: R[PR] */
 	CHECK_FPU_ENABLED
-        if (!(ctx->tbflags & FPSCR_PR)) {
-	    tcg_gen_movi_i32(FREG(B11_8), 0);
-	}
-	return;
+        CHECK_FPSCR_PR_0
+        tcg_gen_movi_i32(FREG(B11_8), 0);
+        return;
     case 0xf09d: /* fldi1 FRn - FPSCR: R[PR] */
 	CHECK_FPU_ENABLED
-        if (!(ctx->tbflags & FPSCR_PR)) {
-	    tcg_gen_movi_i32(FREG(B11_8), 0x3f800000);
-	}
-	return;
+        CHECK_FPSCR_PR_0
+        tcg_gen_movi_i32(FREG(B11_8), 0x3f800000);
+        return;
     case 0xf0ad: /* fcnvsd FPUL,DRn */
 	CHECK_FPU_ENABLED
 	{
@@ -1768,10 +1771,10 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0xf0ed: /* fipr FVm,FVn */
         CHECK_FPU_ENABLED
-        if ((ctx->tbflags & FPSCR_PR) == 0) {
-            TCGv m, n;
-            m = tcg_const_i32((ctx->opcode >> 8) & 3);
-            n = tcg_const_i32((ctx->opcode >> 10) & 3);
+        CHECK_FPSCR_PR_1
+        {
+            TCGv m = tcg_const_i32((ctx->opcode >> 8) & 3);
+            TCGv n = tcg_const_i32((ctx->opcode >> 10) & 3);
             gen_helper_fipr(cpu_env, m, n);
             tcg_temp_free(m);
             tcg_temp_free(n);
@@ -1780,10 +1783,12 @@ static void _decode_opc(DisasContext * ctx)
         break;
     case 0xf0fd: /* ftrv XMTRX,FVn */
         CHECK_FPU_ENABLED
-        if ((ctx->opcode & 0x0300) == 0x0100 &&
-            (ctx->tbflags & FPSCR_PR) == 0) {
-            TCGv n;
-            n = tcg_const_i32((ctx->opcode >> 10) & 3);
+        CHECK_FPSCR_PR_1
+        {
+            if ((ctx->opcode & 0x0300) != 0x0100) {
+                goto do_illegal;
+            }
+            TCGv n = tcg_const_i32((ctx->opcode >> 10) & 3);
             gen_helper_ftrv(cpu_env, n);
             tcg_temp_free(n);
             return;
-- 
2.9.4
