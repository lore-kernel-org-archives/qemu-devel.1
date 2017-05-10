Received: from eggs.gnu.org ([2001:4830:134:3::10]:35124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJz-0003Et-K4
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJy-0000Hq-Es
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:47 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8WJy-0000GS-6y
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:46 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 May 2017 20:26:33 +0200
Message-Id: <20170510182636.17791-13-aurelien@aurel32.net>
In-Reply-To: <20170510182636.17791-1-aurelien@aurel32.net>
References: <20170510182636.17791-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v3 12/15] target/sh4: implement tas.b using
 atomic helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

We only emulate UP SH4, however as the tas.b instruction is used in the GNU
libc, this improve linux-user emulation.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d61b176a7d..baed19bdac 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1634,19 +1634,14 @@ static void _decode_opc(DisasContext * ctx)
 	tcg_gen_shri_i32(REG(B11_8), REG(B11_8), 16);
 	return;
     case 0x401b:		/* tas.b @Rn */
-	{
-	    TCGv addr, val;
-	    addr = tcg_temp_local_new();
-	    tcg_gen_mov_i32(addr, REG(B11_8));
-	    val = tcg_temp_local_new();
-            tcg_gen_qemu_ld_i32(val, addr, ctx->memidx, MO_UB);
+        {
+            TCGv val = tcg_const_i32(0x80);
+            tcg_gen_atomic_fetch_or_i32(val, REG(B11_8), val,
+                                        ctx->memidx, MO_UB);
             tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_sr_t, val, 0);
-	    tcg_gen_ori_i32(val, val, 0x80);
-            tcg_gen_qemu_st_i32(val, addr, ctx->memidx, MO_UB);
-	    tcg_temp_free(val);
-	    tcg_temp_free(addr);
-	}
-	return;
+            tcg_temp_free(val);
+        }
+        return;
     case 0xf00d: /* fsts FPUL,FRn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
 	tcg_gen_mov_i32(cpu_fregs[FREG(B11_8)], cpu_fpul);
-- 
2.11.0
