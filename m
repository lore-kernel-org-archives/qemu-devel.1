Received: from eggs.gnu.org ([2001:4830:134:3::10]:37158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQD-0005B4-04
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001MS-Sc
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001H2-Hg
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:46 +0200
Message-Id: <20170513093248.18230-14-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/15] target/sh4: movua.l is an SH4-A only
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

At the same time change the comment describing the instruction the same
way than other instruction, so that the code is easier to read and search.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index baed19bdac..4bb9105865 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1501,17 +1501,21 @@ static void _decode_opc(DisasContext * ctx)
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
