Received: from eggs.gnu.org ([2001:4830:134:3::10]:46034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmp-0000Bk-K9
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmo-0008Bw-0U
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33434 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmk-00084d-IK
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:18 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:41 +0200
Message-Id: <1540213077-15211-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 18/34] target/mips: Support R5900 three-operand
 MULT1 and MULTU1 instructions
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

Add support for MULT1 and MULTU1 instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3dc6d80..6d89002 100644
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
2.7.4
