Received: from eggs.gnu.org ([2001:4830:134:3::10]:52377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMS-0004ei-4k
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMR-0007P5-8z
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43484 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMR-0007OM-14
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:02:52 +0200
Message-Id: <1534514633-13725-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 04/65] target/mips: Add placeholder and
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
 target/mips/translate.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4f95b9a..b71d3fe 100644
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
@@ -21841,8 +21857,8 @@ void cpu_state_reset(CPUMIPSState *env)
         env->CP0_Status |= (1 << CP0St_FR);
     }
 
-    if (env->CP0_Config3 & (1 << CP0C3_ISA)) {
-        /*  microMIPS on reset when Config3.ISA == {1, 3} */
+    if (env->CP0_Config3 & (1 << (CP0C3_ISA + 1))) {
+        /*  microMIPS on reset when Config3.ISA == 3  */
         env->hflags |= MIPS_HFLAG_M16;
     }
 
-- 
2.7.4
