Received: from eggs.gnu.org ([2001:4830:134:3::10]:49136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5i7-0001tn-2H
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5i4-0005KO-Px
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34947 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5i4-00057d-8v
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:52 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:21 +0100
Message-Id: <1540812328-16163-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 13/20] target/mips: Move MUL, S32M2I,
 S32I2M handling out of main MXU switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Move MUL, S32M2I, S32I2M handling out of switch. These are all
instructions that do not depend on MXU_EN flag of MXU_CR.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8b91676..fb3bfaf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24997,6 +24997,29 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
      */
     uint32_t opcode = extract32(ctx->opcode, 0, 6);
 
+    if (opcode == OPC__MXU_MUL) {
+        uint32_t  rs, rt, rd, op1;
+
+        rs = extract32(ctx->opcode, 21, 5);
+        rt = extract32(ctx->opcode, 16, 5);
+        rd = extract32(ctx->opcode, 11, 5);
+        op1 = MASK_SPECIAL2(ctx->opcode);
+
+        gen_arith(ctx, op1, rd, rs, rt);
+
+        return;
+    }
+
+    if (opcode == OPC_MXU_S32M2I) {
+        gen_mxu_s32m2i(ctx);
+        return;
+    }
+
+    if (opcode == OPC_MXU_S32I2M) {
+        gen_mxu_s32i2m(ctx);
+        return;
+    }
+
     switch (opcode) {
     case OPC_MXU_S32MADD:
         /* TODO: Implement emulation of S32MADD instruction. */
@@ -25008,18 +25031,6 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         MIPS_INVAL("OPC_MXU_S32MADDU");
         generate_exception_end(ctx, EXCP_RI);
         break;
-    case OPC__MXU_MUL:     /* 0x2 - unused in MXU specs */
-        {
-            uint32_t  rs, rt, rd, op1;
-
-            rs = extract32(ctx->opcode, 21, 5);
-            rt = extract32(ctx->opcode, 16, 5);
-            rd = extract32(ctx->opcode, 11, 5);
-            op1 = MASK_SPECIAL2(ctx->opcode);
-
-            gen_arith(ctx, op1, rd, rs, rt);
-        }
-        break;
     case OPC_MXU__POOL00:
         decode_opc_mxu__pool00(env, ctx);
         break;
@@ -25171,12 +25182,6 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         MIPS_INVAL("OPC_MXU_S16SDI");
         generate_exception_end(ctx, EXCP_RI);
         break;
-    case OPC_MXU_S32M2I:
-        gen_mxu_s32m2i(ctx);
-        break;
-    case OPC_MXU_S32I2M:
-        gen_mxu_s32i2m(ctx);
-        break;
     case OPC_MXU_D32SLL:
         /* TODO: Implement emulation of D32SLL instruction. */
         MIPS_INVAL("OPC_MXU_D32SLL");
-- 
2.7.4
