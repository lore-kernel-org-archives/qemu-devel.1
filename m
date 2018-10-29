Received: from eggs.gnu.org ([2001:4830:134:3::10]:34404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lg-0008Ss-EU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lc-0003QB-FS
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39510 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9Lb-0003IB-Sb
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:20:07 +0100
Message-Id: <1540826418-5501-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 16/27] target/mips: Add emulation of MXU
 instruction D16MUL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Craig Janeczek <jancraig@amazon.com>

Add support for emulating the D16MUL MXU instruction.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index cb7a24b..dbcb69b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24175,6 +24175,68 @@ static void gen_mxu_s8ldd(DisasContext *ctx)
     tcg_temp_free(t1);
 }
 
+/*
+ * D16MUL XRa, XRb, XRc, XRd, optn2 - Signed 16 bit pattern multiplication
+ */
+static void gen_mxu_d16mul(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3;
+    TCGLabel *l0;
+    uint32_t XRa, XRb, XRc, XRd, optn2;
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
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXU_CR_MXU_EN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXU_CR_MXU_EN, l0);
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_sextract_tl(t0, t1, 0, 16);
+    tcg_gen_sextract_tl(t1, t1, 16, 16);
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
@@ -25139,9 +25201,7 @@ static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_mxu__pool02(env, ctx);
         break;
     case OPC_MXU_D16MUL:
-        /* TODO: Implement emulation of D16MUL instruction. */
-        MIPS_INVAL("OPC_MXU_D16MUL");
-        generate_exception_end(ctx, EXCP_RI);
+        gen_mxu_d16mul(ctx);
         break;
     case OPC_MXU__POOL03:
         decode_opc_mxu__pool03(env, ctx);
-- 
2.7.4
