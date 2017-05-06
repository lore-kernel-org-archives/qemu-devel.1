Received: from eggs.gnu.org ([2001:4830:134:3::10]:50858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xfg-00030R-9l
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xff-0003vn-1g
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:44 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6xfe-0003uM-QQ
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:42 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 13:14:29 +0200
Message-Id: <20170506111431.12548-13-aurelien@aurel32.net>
In-Reply-To: <20170506111431.12548-1-aurelien@aurel32.net>
References: <20170506111431.12548-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 12/14] target/sh4: implement tas.b using
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

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9fe2e2d4d9..d86fd29264 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1635,19 +1635,14 @@ static void _decode_opc(DisasContext * ctx)
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
