Received: from eggs.gnu.org ([2001:4830:134:3::10]:35136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIww-0003T2-IO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIwv-0001BH-Pn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:54 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIwv-0001B6-LW
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:24:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so2764838qkq.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:24:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:05 -1000
Message-Id: <20170707022111.21836-22-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 21/27] target/sh4: Tidy misc illegal insn
 checks
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

Now that we have a do_illegal label, use goto in order
to self-document the forcing of the exception.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a4370c6..06cf649 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1079,8 +1079,9 @@ static void _decode_opc(DisasContext * ctx)
             if (ctx->tbflags & FPSCR_PR) {
                 TCGv_i64 fp0, fp1;
 
-		if (ctx->opcode & 0x0110)
-		    break; /* illegal instruction */
+                if (ctx->opcode & 0x0110) {
+                    goto do_illegal;
+                }
 		fp0 = tcg_temp_new_i64();
 		fp1 = tcg_temp_new_i64();
 		gen_load_fpr64(ctx, fp0, B11_8);
@@ -1142,7 +1143,7 @@ static void _decode_opc(DisasContext * ctx)
         {
             CHECK_FPU_ENABLED
             if (ctx->tbflags & FPSCR_PR) {
-                break; /* illegal instruction */
+                goto do_illegal;
             } else {
                 gen_helper_fmac_FT(FREG(B11_8), cpu_env,
                                    FREG(0), FREG(B7_4), FREG(B11_8));
@@ -1693,8 +1694,9 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
 	    TCGv_i64 fp;
-	    if (ctx->opcode & 0x0100)
-		break; /* illegal instruction */
+            if (ctx->opcode & 0x0100) {
+                goto do_illegal;
+            }
 	    fp = tcg_temp_new_i64();
             gen_helper_float_DT(fp, cpu_env, cpu_fpul);
 	    gen_store_fpr64(ctx, fp, B11_8);
@@ -1708,8 +1710,9 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
 	    TCGv_i64 fp;
-	    if (ctx->opcode & 0x0100)
-		break; /* illegal instruction */
+            if (ctx->opcode & 0x0100) {
+		goto do_illegal;
+            }
 	    fp = tcg_temp_new_i64();
 	    gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_ftrc_DT(cpu_fpul, cpu_env, fp);
@@ -1730,8 +1733,9 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf06d: /* fsqrt FRn */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
-	    if (ctx->opcode & 0x0100)
-		break; /* illegal instruction */
+            if (ctx->opcode & 0x0100) {
+		goto do_illegal;
+            }
 	    TCGv_i64 fp = tcg_temp_new_i64();
 	    gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fsqrt_DT(fp, cpu_env, fp);
-- 
2.9.4
