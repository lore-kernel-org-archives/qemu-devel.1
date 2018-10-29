Received: from eggs.gnu.org ([2001:4830:134:3::10]:49160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5i8-0001ua-09
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5i5-0005Ln-WA
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35350 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5i5-0005Jo-Af
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:27:53 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:25 +0100
Message-Id: <1540812328-16163-18-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 17/20] target/mips: Add emulation of MXU
 instructions Q8MUL and Q8MULSU
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

Adds support for emulating the Q8MUL and Q8MULSU MXU instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 101 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 7 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 031d4c2..14e19d8 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24321,6 +24321,99 @@ static void gen_mxu_d16mac(DisasContext *ctx)
     tcg_temp_free(t3);
 }
 
+/*
+ * Q8MUL   XRa, XRb, XRc, XRd - Parallel unsigned 8 bit pattern multiply
+ * Q8MULSU XRa, XRb, XRc, XRd - Parallel signed 8 bit pattern multiply
+ */
+static void gen_mxu_q8mul_q8mulsu(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
+    TCGLabel *l0;
+    uint32_t XRa, XRb, XRc, XRd, sel;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    t5 = tcg_temp_new();
+    t6 = tcg_temp_new();
+    t7 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    sel = extract32(ctx->opcode, 22, 2);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
+
+    gen_load_mxu_gpr(t3, XRb);
+    gen_load_mxu_gpr(t7, XRc);
+
+    if (sel == 0x2) {
+        /* Q8MULSU */
+        tcg_gen_ext8s_tl(t0, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8s_tl(t1, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8s_tl(t2, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8s_tl(t3, t3);
+    } else {
+        /* Q8MUL */
+        tcg_gen_ext8u_tl(t0, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8u_tl(t1, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8u_tl(t2, t3);
+        tcg_gen_shri_tl(t3, t3, 8);
+        tcg_gen_ext8u_tl(t3, t3);
+    }
+
+    tcg_gen_ext8u_tl(t4, t7);
+    tcg_gen_shri_tl(t7, t7, 8);
+    tcg_gen_ext8u_tl(t5, t7);
+    tcg_gen_shri_tl(t7, t7, 8);
+    tcg_gen_ext8u_tl(t6, t7);
+    tcg_gen_shri_tl(t7, t7, 8);
+    tcg_gen_ext8u_tl(t7, t7);
+
+    tcg_gen_mul_tl(t0, t0, t4);
+    tcg_gen_mul_tl(t1, t1, t5);
+    tcg_gen_mul_tl(t2, t2, t6);
+    tcg_gen_mul_tl(t3, t3, t7);
+
+    tcg_gen_andi_tl(t0, t0, 0xFFFF);
+    tcg_gen_andi_tl(t1, t1, 0xFFFF);
+    tcg_gen_andi_tl(t2, t2, 0xFFFF);
+    tcg_gen_andi_tl(t3, t3, 0xFFFF);
+
+    tcg_gen_shli_tl(t1, t1, 16);
+    tcg_gen_shli_tl(t3, t3, 16);
+
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_or_tl(t1, t2, t3);
+
+    gen_store_mxu_gpr(t0, XRd);
+    gen_store_mxu_gpr(t1, XRa);
+
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
+    tcg_temp_free(t4);
+    tcg_temp_free(t5);
+    tcg_temp_free(t6);
+    tcg_temp_free(t7);
+}
+
 
 /*
  * Decoding engine for MXU
@@ -25112,14 +25205,8 @@ static void decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext *ctx)
 
     switch (opcode) {
     case OPC_MXU_Q8MUL:
-        /* TODO: Implement emulation of Q8MUL instruction. */
-        MIPS_INVAL("OPC_MXU_Q8MUL");
-        generate_exception_end(ctx, EXCP_RI);
-        break;
     case OPC_MXU_Q8MULSU:
-        /* TODO: Implement emulation of Q8MULSU instruction. */
-        MIPS_INVAL("OPC_MXU_Q8MULSU");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_q8mul_q8mulsu(ctx);
         break;
     default:
         MIPS_INVAL("decode_opc_mxu");
-- 
2.7.4
