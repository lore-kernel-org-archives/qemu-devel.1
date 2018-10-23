Received: from eggs.gnu.org ([2001:4830:134:3::10]:57129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzQA-0006xV-J7
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzQ9-0001dZ-DZ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46459 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEzQ8-0001bN-VP
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:41 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 18:18:24 +0200
Message-Id: <1540311509-23970-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 13/18] target/mips: Move MUL, S32M2I,
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

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c8c71c4..111affb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24859,6 +24859,29 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
 {
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
@@ -24870,18 +24893,6 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
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
@@ -25033,12 +25044,6 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
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
