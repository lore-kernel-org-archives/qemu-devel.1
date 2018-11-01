Received: from eggs.gnu.org ([2001:4830:134:3::10]:41119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGsa-0002uD-6X
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGsN-0001Pi-C2
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:29 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:1289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIGsL-0001Ca-Ao
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:23 -0400
Date: Thu, 1 Nov 2018 18:35:11 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <dd7cd1ea341cfa4252f86876e044936f31c6e7b0.1541093316.git.noring@nocrew.org>
References: <cover.1541093316.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541093316.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 05/12] target/mips: Support R5900
 three-operand MADD1 and MADDU1
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
index 4808cb49c3..57b17ad8f6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5021,7 +5021,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
  *
  * and
  *
- *     MADD[U]    rd, rs, rt
+ *     MADD[U][1] rd, rs, rt
  *
  * such that
  *
@@ -5083,6 +5083,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case TX79_MMI_MADD1:
+        acc = 1;
+        /* Fall through */
     case TX79_MMI_MADD:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -5102,6 +5105,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i64(t2);
         }
         break;
+    case TX79_MMI_MADDU1:
+        acc = 1;
+        /* Fall through */
     case TX79_MMI_MADDU:
         {
             TCGv_i64 t2 = tcg_temp_new_i64();
@@ -26640,6 +26646,8 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MULTU1:
     case TX79_MMI_MADD:
     case TX79_MMI_MADDU:
+    case TX79_MMI_MADD1:
+    case TX79_MMI_MADDU1:
         gen_mul_txx9(ctx, opc, rd, rs, rt);
         break;
     case TX79_MMI_DIV1:
@@ -26655,8 +26663,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
         gen_HILO1_tx79(ctx, opc, rd);
         break;
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
-    case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
     case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
     case TX79_MMI_PSLLH:         /* TODO: TX79_MMI_PSLLH */
-- 
2.18.1
