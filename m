Received: from eggs.gnu.org ([2001:4830:134:3::10]:59712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFIAh-0002Hc-F0
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFIAc-0004H9-PB
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:21:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42293 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFIAc-0004EG-CH
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:21:54 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 14:18:43 +0200
Message-Id: <1540383527-7923-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 16/20] target/mips: Add emulation of MXU
 instruction D16MAC
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

Add support for emulating the D16MAC MXU instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index fec5163..4c66eae 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24102,6 +24102,92 @@ static void gen_mxu_d16mul(DisasContext *ctx)
     tcg_temp_free(t3);
 }
 
+/*
+ * D16MAC XRa, XRb, XRc, XRd, aptn2, optn2 - Signed 16 bit pattern multiply
+ *                                           and accumulate
+ */
+static void gen_mxu_d16mac(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3;
+    TCGLabel *l0;
+    uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    optn2 = extract32(ctx->opcode, 22, 2);
+    aptn2 = extract32(ctx->opcode, 24, 2);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_sextract_tl(t0, t1, 0, 16);
+    tcg_gen_sextract_tl(t1, t1, 16, 16);
+
+    gen_load_mxu_gpr(t3, XRc);
+    tcg_gen_sextract_tl(t2, t3, 0, 16);
+    tcg_gen_sextract_tl(t3, t3, 16, 16);
+
+    switch (optn2) {
+    case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    }
+    gen_load_mxu_gpr(t0, XRa);
+    gen_load_mxu_gpr(t1, XRd);
+
+    switch (aptn2) {
+    case MXU_APTN2_AA:
+        tcg_gen_add_tl(t3, t0, t3);
+        tcg_gen_add_tl(t2, t1, t2);
+        break;
+    case MXU_APTN2_AS:
+        tcg_gen_add_tl(t3, t0, t3);
+        tcg_gen_sub_tl(t2, t1, t2);
+        break;
+    case MXU_APTN2_SA:
+        tcg_gen_sub_tl(t3, t0, t3);
+        tcg_gen_add_tl(t2, t1, t2);
+        break;
+    case MXU_APTN2_SS:
+        tcg_gen_sub_tl(t3, t0, t3);
+        tcg_gen_sub_tl(t2, t1, t2);
+        break;
+    }
+    gen_store_mxu_gpr(t3, XRa);
+    gen_store_mxu_gpr(t2, XRd);
+
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
+}
+
 
 /*
  * Decoding engine for MXU
@@ -25067,9 +25153,7 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_mxu__pool03(env, ctx);
         break;
     case OPC_MXU_D16MAC:
-        /* TODO: Implement emulation of D16MAC instruction. */
-        MIPS_INVAL("OPC_MXU_D16MAC");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_d16mac(ctx);
         break;
     case OPC_MXU_D16MACF:
         /* TODO: Implement emulation of D16MACF instruction. */
-- 
2.7.4
