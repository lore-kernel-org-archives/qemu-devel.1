Received: from eggs.gnu.org ([2001:4830:134:3::10]:44330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjUt-00082x-Nn
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjUq-0008Ti-KQ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:32:39 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:32965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjUq-0008Cc-BW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:32:36 -0400
Date: Thu, 25 Oct 2018 19:32:11 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <89b35f95776752890ea07028d6d393c652887c1c.1540487815.git.noring@nocrew.org>
References: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540487815.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 04/11] target/mips: Support R5900 three-operand
 MADD1 and MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index add6203c5a..208a15c0c1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4813,7 +4813,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
  *
  * and
  *
- *     MADD[U]    rd, rs, rt
+ *     MADD[U][1] rd, rs, rt
  *
  * such that
  *
@@ -4875,6 +4875,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case TX79_MMI_MADD1:
+        acc = 1;
+        /* Fall through */
     case TX79_MMI_MADD:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -4894,6 +4897,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i64(t2);
         }
         break;
+    case TX79_MMI_MADDU1:
+        acc = 1;
+        /* Fall through */
     case TX79_MMI_MADDU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -24749,6 +24755,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
     case TX79_MMI_MADD:
     case TX79_MMI_MADDU:
+    case TX79_MMI_MADD1:
+    case TX79_MMI_MADDU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case TX79_MMI_DIV1:
@@ -24764,8 +24772,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
         gen_HILO(ctx, opc, 1, rd);
         break;
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
-    case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
     case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
     case TX79_MMI_PSLLH:         /* TODO: TX79_MMI_PSLLH */
-- 
2.18.1
