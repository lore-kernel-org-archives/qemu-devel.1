Received: from eggs.gnu.org ([2001:4830:134:3::10]:48620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPl-0005k1-TK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-00040l-Hh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003V6-4n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:44 +0200
Message-Id: <20170718215050.3812-26-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/31] target/sh4: Tidy misc illegal insn checks
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

Now that we have a do_illegal label, use goto in order
to self-document the forcing of the exception.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-22-rth@twiddle.net>
[aurel32: fix whitespace issues]
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b90719717e..b16df1e70a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1068,8 +1068,9 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1131,7 +1132,7 @@ static void _decode_opc(DisasContext * ctx)
         {
             CHECK_FPU_ENABLED
             if (ctx->tbflags & FPSCR_PR) {
-                break; /* illegal instruction */
+                goto do_illegal;
             } else {
                 gen_helper_fmac_FT(FREG(B11_8), cpu_env,
                                    FREG(0), FREG(B7_4), FREG(B11_8));
@@ -1669,8 +1670,9 @@ static void _decode_opc(DisasContext * ctx)
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
@@ -1684,8 +1686,9 @@ static void _decode_opc(DisasContext * ctx)
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
 	    TCGv_i64 fp;
-	    if (ctx->opcode & 0x0100)
-		break; /* illegal instruction */
+            if (ctx->opcode & 0x0100) {
+                goto do_illegal;
+            }
 	    fp = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_ftrc_DT(cpu_fpul, cpu_env, fp);
@@ -1706,8 +1709,9 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf06d: /* fsqrt FRn */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_PR) {
-	    if (ctx->opcode & 0x0100)
-		break; /* illegal instruction */
+            if (ctx->opcode & 0x0100) {
+                goto do_illegal;
+            }
 	    TCGv_i64 fp = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp, B11_8);
             gen_helper_fsqrt_DT(fp, cpu_env, fp);
-- 
2.11.0
