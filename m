Received: from eggs.gnu.org ([2001:4830:134:3::10]:49837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYj9-0006Ve-MD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYj8-0004lx-Tc
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:15 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYj8-0004lt-PD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:14 -0400
Received: by mail-qk0-x241.google.com with SMTP id u126so2856422qka.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:42 -1000
Message-Id: <20170718200255.31647-18-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 17/30] target/sh4: Simplify 64-bit fp
 reg-reg move
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

We do not need to form full 64-bit quantities in order to perform
the move.  This reduces code expansion on 64-bit hosts.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bda6fa7..1164f73 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -987,10 +987,10 @@ static void _decode_opc(DisasContext * ctx)
     case 0xf00c: /* fmov {F,D,X}Rm,{F,D,X}Rn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
         if (ctx->tbflags & FPSCR_SZ) {
-	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(ctx, fp, XHACK(B7_4));
-	    gen_store_fpr64(ctx, fp, XHACK(B11_8));
-	    tcg_temp_free_i64(fp);
+            int xsrc = XHACK(B7_4);
+            int xdst = XHACK(B11_8);
+            tcg_gen_mov_i32(FREG(xdst), FREG(xsrc));
+            tcg_gen_mov_i32(FREG(xdst + 1), FREG(xsrc + 1));
 	} else {
 	    tcg_gen_mov_i32(FREG(B11_8), FREG(B7_4));
 	}
-- 
2.9.4
