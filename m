Received: from eggs.gnu.org ([2001:4830:134:3::10]:50896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xfg-00030W-SC
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6xff-0003w5-6x
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:44 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6xff-0003ul-0z
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:14:43 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat,  6 May 2017 13:14:30 +0200
Message-Id: <20170506111431.12548-14-aurelien@aurel32.net>
In-Reply-To: <20170506111431.12548-1-aurelien@aurel32.net>
References: <20170506111431.12548-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/14] target/sh4: movua.l is an SH4-A only
 instruction
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

At the same time change the comment describing the instruction the same
way than other instruction, so that the code is easier to read and search.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d86fd29264..29ea506c1d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1502,17 +1502,21 @@ static void _decode_opc(DisasContext * ctx)
         }
         ctx->has_movcal = 1;
 	return;
-    case 0x40a9:
-	/* MOVUA.L @Rm,R0 (Rm) -> R0
-	   Load non-boundary-aligned data */
-        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
-	return;
-    case 0x40e9:
-	/* MOVUA.L @Rm+,R0   (Rm) -> R0, Rm + 4 -> Rm
-	   Load non-boundary-aligned data */
-        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
-	tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
-	return;
+    case 0x40a9:                /* movua.l @Rm,R0 */
+        /* Load non-boundary-aligned data */
+        if (ctx->features & SH_FEATURE_SH4A) {
+            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+            return;
+        }
+        break;
+    case 0x40e9:                /* movua.l @Rm+,R0 */
+        /* Load non-boundary-aligned data */
+        if (ctx->features & SH_FEATURE_SH4A) {
+            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
+            return;
+        }
+        break;
     case 0x0029:		/* movt Rn */
         tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
 	return;
-- 
2.11.0
