Received: from eggs.gnu.org ([2001:4830:134:3::10]:34205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LR-0008JJ-Ib
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LN-0003J6-S7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39392 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9LL-0003Gx-NN
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:41 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:20:03 +0100
Message-Id: <1540826418-5501-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 12/27] target/mips: Add emulation of non-MXU
 MULL within MXU decoding engine
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

From: Craig Janeczek <jancraig@amazon.com>

Add emulation of non-MXU MULL within MXU decoding engine.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ccabd13..bdd46ed 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1648,7 +1648,7 @@ enum {
 enum {
     OPC_MXU_S32MADD  = 0x00,
     OPC_MXU_S32MADDU = 0x01,
-    /* not assigned 0x02 */
+    OPC__MXU_MUL     = 0x02,
     OPC_MXU__POOL00  = 0x03,
     OPC_MXU_S32MSUB  = 0x04,
     OPC_MXU_S32MSUBU = 0x05,
@@ -24909,6 +24909,11 @@ static void decode_opc_mxu__pool20(CPUMIPSState *env, DisasContext *ctx)
  */
 static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
 {
+    /*
+     * TODO: Investigate necessity of including handling of
+     * CLZ, CLO, SDBB in this function, as they belong to
+     * SPECIAL2 opcode space for regular pre-R6 MIPS ISAs.
+     */
     uint32_t opcode = extract32(ctx->opcode, 0, 6);
 
     switch (opcode) {
@@ -24922,6 +24927,18 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         MIPS_INVAL("OPC_MXU_S32MADDU");
         generate_exception_end(ctx, EXCP_RI);
         break;
+    case OPC__MXU_MUL:     /* 0x2 - unused in MXU specs */
+        {
+            uint32_t  rs, rt, rd, op1;
+
+            rs = extract32(ctx->opcode, 21, 5);
+            rt = extract32(ctx->opcode, 16, 5);
+            rd = extract32(ctx->opcode, 11, 5);
+            op1 = MASK_SPECIAL2(ctx->opcode);
+
+            gen_arith(ctx, op1, rd, rs, rt);
+        }
+        break;
     case OPC_MXU__POOL00:
         decode_opc_mxu__pool00(env, ctx);
         break;
-- 
2.7.4
