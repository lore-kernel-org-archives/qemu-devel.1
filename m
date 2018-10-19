Received: from eggs.gnu.org ([2001:4830:134:3::10]:38745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXjc-0005Qh-FJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXjY-0007kJ-Ep
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:34:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56814 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXjY-0007hP-1m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:34:44 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:37 +0200
Message-Id: <1539966828-20947-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 03/14] target/mips: Add and integrate MXU
 decoding engine placeholder
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

Provide the placeholder and add the invocation logic for MXU
decoding engine.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ef7ad62..dc72f76 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23311,6 +23311,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
+{
+    MIPS_INVAL("decode_opc_mxu");
+    generate_exception_end(ctx, EXCP_RI);
+}
+
 static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd;
@@ -25292,7 +25298,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
-        decode_opc_special2_legacy(env, ctx);
+        if (ctx->insn_flags & ASE_MXU) {
+            decode_opc_mxu(env, ctx);
+        } else {
+            decode_opc_special2_legacy(env, ctx);
+        }
         break;
     case OPC_SPECIAL3:
         decode_opc_special3(env, ctx);
-- 
2.7.4
