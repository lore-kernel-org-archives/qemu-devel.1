Received: from eggs.gnu.org ([2001:4830:134:3::10]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8W2-0003G5-JH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8TG-0004KT-EX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55309 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8TG-0004Je-1S
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:55:50 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:36 +0200
Message-Id: <1532004912-13899-5-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 04/40] target/mips: Add
 decode_nanomips_opc() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add empty body and invocation of decode_nanomips_opc() if the bit
ISA_NANOMIPS32 is set in env->insn_flags.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 227b2c0..67a0f70 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -16458,6 +16458,19 @@ enum {
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
@@ -21263,8 +21276,13 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         insn_bytes = 4;
         decode_opc(env, ctx);
     } else if (ctx->insn_flags & ASE_MICROMIPS) {
-        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
-        insn_bytes = decode_micromips_opc(env, ctx);
+        if (env->insn_flags & ISA_NANOMIPS32) {
+            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+            insn_bytes = decode_nanomips_opc(env, ctx);
+        } else {
+            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+            insn_bytes = decode_micromips_opc(env, ctx);
+        }
     } else if (ctx->insn_flags & ASE_MIPS16) {
         ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
         insn_bytes = decode_mips16_opc(env, ctx);
-- 
2.7.4
