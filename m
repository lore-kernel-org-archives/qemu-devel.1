Received: from eggs.gnu.org ([2001:4830:134:3::10]:39024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkO-00061O-Rg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkM-00010T-Ev
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58311 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXkM-0000vr-5R
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:42 +0200
Message-Id: <1539966828-20947-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 08/14] target/mips: Add emulation of non-MXU
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
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Craig Janeczek <jancraig@amazon.com>

Add emulation of non-MXU MULL within MXU decoding engine.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5b7e6f3..191aeab 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1654,7 +1654,7 @@ enum {
 enum {
     OPC_MXU_S32MADD  = 0x00,
     OPC_MXU_S32MADDU = 0x01,
-    /* not assigned 0x02 */
+    OPC__MXU_MUL     = 0x02,
     OPC_MXU__POOL00  = 0x03,
     OPC_MXU_S32MSUB  = 0x04,
     OPC_MXU_S32MSUBU = 0x05,
@@ -24276,6 +24276,18 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
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
