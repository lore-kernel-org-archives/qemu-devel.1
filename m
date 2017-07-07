Received: from eggs.gnu.org ([2001:4830:134:3::10]:35318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIxF-0003p4-Sa
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIxC-0001P9-Nb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:13 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIxC-0001OZ-K0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:10 -0400
Received: by mail-qk0-x241.google.com with SMTP id v143so2748930qkb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:25:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:06 -1000
Message-Id: <20170707022111.21836-23-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 22/27] target/sh4: Introduce CHECK_FPSCR_PR_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 57 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 06cf649..3d8ac59 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -391,6 +391,16 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
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
@@ -1140,16 +1150,11 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1750,16 +1755,14 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1780,10 +1783,10 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1792,10 +1795,12 @@ static void _decode_opc(DisasContext * ctx)
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
