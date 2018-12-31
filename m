Received: from eggs.gnu.org ([208.118.235.92]:57116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0y-0005Sy-AA
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz0x-0003qc-6m
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:00 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60613 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz0w-0003oq-Sr
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:57:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:09 +0100
Message-Id: <1546268200-26966-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 13/44] target/mips: Support R5900
 three-operand MADD1 and MADDU1 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

The three-operand MADD and MADDU are specific to R5900 cores.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6c2d6fd..c4fed8d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5045,7 +5045,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
  *
  * and
  *
- *     MADD[U]    rd, rs, rt
+ *     MADD[U][1] rd, rs, rt
  *
  * such that
  *
@@ -5107,6 +5107,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case MMI_OPC_MADD1:
+        acc = 1;
+        /* Fall through */
     case MMI_OPC_MADD:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -5126,6 +5129,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i64(t2);
         }
         break;
+    case MMI_OPC_MADDU1:
+        acc = 1;
+        /* Fall through */
     case MMI_OPC_MADDU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -27368,6 +27374,8 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_MULTU1:
     case MMI_OPC_MADD:
     case MMI_OPC_MADDU:
+    case MMI_OPC_MADD1:
+    case MMI_OPC_MADDU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case MMI_OPC_DIV1:
@@ -27383,8 +27391,6 @@ static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
         gen_HILO1_tx79(ctx, opc, rd);
         break;
     case MMI_OPC_PLZCW:         /* TODO: MMI_OPC_PLZCW */
-    case MMI_OPC_MADD1:         /* TODO: MMI_OPC_MADD1 */
-    case MMI_OPC_MADDU1:        /* TODO: MMI_OPC_MADDU1 */
     case MMI_OPC_PMFHL:         /* TODO: MMI_OPC_PMFHL */
     case MMI_OPC_PMTHL:         /* TODO: MMI_OPC_PMTHL */
     case MMI_OPC_PSLLH:         /* TODO: MMI_OPC_PSLLH */
-- 
2.7.4
