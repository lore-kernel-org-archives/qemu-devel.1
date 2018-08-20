Received: from eggs.gnu.org ([2001:4830:134:3::10]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froyA-0000xb-Fl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froks-0001U0-Nd
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51262 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1froko-0001Ms-Mh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:16 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:13 +0200
Message-Id: <1534789014-8310-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 05/46] target/mips: Add placeholder and
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
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add empty body and invocation of decode_nanomips_opc() if the bit
ISA_NANOMIPS32 is set in ctx->insn_flags.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7fb322b..4184d91 100644
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
@@ -21402,7 +21415,10 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     int is_slot;
 
     is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
-    if (!(ctx->hflags & MIPS_HFLAG_M16)) {
+    if (ctx->insn_flags & ISA_NANOMIPS32) {
+        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+        insn_bytes = decode_nanomips_opc(env, ctx);
+    } else if (!(ctx->hflags & MIPS_HFLAG_M16)) {
         ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
         insn_bytes = 4;
         decode_opc(env, ctx);
-- 
2.7.4
