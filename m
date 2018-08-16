Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJl3-0005NC-7L
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJkt-0000cf-3K
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43006 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJks-0000aR-Hn
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:12 +0200
Message-Id: <1534431497-1385-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 19/84] target/mips: Add placeholder and
 invocation of decode_nanomips_opc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add empty body and invocation of decode_nanomips_opc() if the bit
ISA_NANOMIPS32 is set in ctx->insn_flags.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4f95b9a..2682ede 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16586,6 +16586,19 @@ enum {
     NM_EVP      = 0x01,
 };
 
+
+/*
+ *
+ * nanoMIPS decoding engine
+ *
+ */
+
+static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
+{
+    return 2;
+}
+
+
 /* SmartMIPS extension to MIPS32 */
 
 #if defined(TARGET_MIPS64)
@@ -21406,6 +21419,9 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
         insn_bytes = 4;
         decode_opc(env, ctx);
+    } else if (ctx->insn_flags & ISA_NANOMIPS32) {
+        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+        insn_bytes = decode_nanomips_opc(env, ctx);
     } else if (ctx->insn_flags & ASE_MICROMIPS) {
         ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
         insn_bytes = decode_micromips_opc(env, ctx);
-- 
2.7.4
