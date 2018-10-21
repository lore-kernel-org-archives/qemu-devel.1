Received: from eggs.gnu.org ([2001:4830:134:3::10]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFoV-00044O-Do
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFoS-0003qX-7P
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:38:47 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFoR-0003mj-Sa
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:38:44 -0400
Date: Sun, 21 Oct 2018 17:38:36 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <47509b90d7d85f8e98c11db954563f1b60b41de2.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 18/38] target/mips: Support R5900
 three-operand MULT1 and MULTU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index eb7437cc09..df69fa0e9f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4771,7 +4771,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
  * Toshiba/Sony R5900 and the Toshiba TX19, TX39 and TX79 core
  * architectures are special three-operand variants with the syntax
  *
- *     MULT[U] rd, rs, rt
+ *     MULT[U][1] rd, rs, rt
  *
  * such that
  *
@@ -4795,6 +4795,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
     gen_load_gpr(t1, rt);
 
     switch (opc) {
+    case TX79_MMI_MULT1:
+        acc = 1;
+        /* Fall through */
     case OPC_MULT:
         {
             TCGv_i32 t2 = tcg_temp_new_i32();
@@ -4811,6 +4814,9 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_temp_free_i32(t3);
         }
         break;
+    case TX79_MMI_MULTU1:
+        acc = 1;
+        /* Fall through */
     case OPC_MULTU:
         {
             TCGv_i32 t2 = tcg_temp_new_i32();
@@ -24631,6 +24637,9 @@ static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
 static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_TX79_MMI(ctx->opcode);
+    int rs = extract32(ctx->opcode, 21, 5);
+    int rt = extract32(ctx->opcode, 16, 5);
+    int rd = extract32(ctx->opcode, 11, 5);
 
     switch (opc) {
     case TX79_MMI_CLASS_MMI0:
@@ -24645,6 +24654,10 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_CLASS_MMI3:
         decode_tx79_mmi3(env, ctx);
         break;
+    case TX79_MMI_MULT1:
+    case TX79_MMI_MULTU1:
+        gen_mul_txx9(ctx, opc, rd, rs, rt);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
@@ -24652,8 +24665,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_MTHI1:         /* TODO: TX79_MMI_MTHI1 */
     case TX79_MMI_MFLO1:         /* TODO: TX79_MMI_MFLO1 */
     case TX79_MMI_MTLO1:         /* TODO: TX79_MMI_MTLO1 */
-    case TX79_MMI_MULT1:         /* TODO: TX79_MMI_MULT1 */
-    case TX79_MMI_MULTU1:        /* TODO: TX79_MMI_MULTU1 */
     case TX79_MMI_DIV1:          /* TODO: TX79_MMI_DIV1 */
     case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
-- 
2.18.1
