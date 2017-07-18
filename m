Received: from eggs.gnu.org ([2001:4830:134:3::10]:48598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPl-0005jP-6r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaPk-0003zc-8a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Uw-3K
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:52:20 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:40 +0200
Message-Id: <20170718215050.3812-22-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 21/31] target/sh4: Simplify 64-bit fp reg-reg
 move
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

We do not need to form full 64-bit quantities in order to perform
the move.  This reduces code expansion on 64-bit hosts.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170718200255.31647-18-rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 7dfe23d1f4..792a46804b 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -981,10 +981,10 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf00c: /* fmov {F,D,X}Rm,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv_i64 fp = tcg_temp_new_i64();
-            gen_load_fpr64(ctx, fp, XHACK(B7_4));
-            gen_store_fpr64(ctx, fp, XHACK(B11_8));
-	    tcg_temp_free_i64(fp);
+            int xsrc = XHACK(B7_4);
+            int xdst = XHACK(B11_8);
+            tcg_gen_mov_i32(FREG(xdst), FREG(xsrc));
+            tcg_gen_mov_i32(FREG(xdst + 1), FREG(xsrc + 1));
 	} else {
             tcg_gen_mov_i32(FREG(B11_8), FREG(B7_4));
 	}
-- 
2.11.0
