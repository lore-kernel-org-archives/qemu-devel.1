Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjL-0006jT-1R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjI-0004vh-P6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:27 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYjI-0004ui-L9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:24 -0400
Received: by mail-qk0-x242.google.com with SMTP id t186so2153924qkf.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:46 -1000
Message-Id: <20170718200255.31647-22-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 21/30] target/sh4: Tidy misc illegal insn
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
Cc: aurelien@aurel32.net

Now that we have a do_illegal label, use goto in order
to self-document the forcing of the exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4c32248..09e4ace 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1074,8 +1074,9 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1137,7 +1138,7 @@ static void _decode_opc(DisasContext * ctx)
         {
             CHECK_FPU_ENABLED
             if (ctx->tbflags & FPSCR_PR) {
-                break; /* illegal instruction */
+                goto do_illegal;
             } else {
                 gen_helper_fmac_FT(FREG(B11_8), cpu_env,
                                    FREG(0), FREG(B7_4), FREG(B11_8));
@@ -1681,8 +1682,9 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1696,8 +1698,9 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1718,8 +1721,9 @@ static void _decode_opc(DisasContext * ctx)
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
