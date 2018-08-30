Received: from eggs.gnu.org ([208.118.235.92]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSt3-00014z-M3
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSeD-0006pW-P4
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:30:33 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSeD-0006pC-I9
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:30:29 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:17 -0400
Message-Id: <20180830193019.20104-8-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 7/9] target/mips: Add MXU instruction D16MAC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

Adds support for emulating the D16MAC instruction.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - initial patch
 v2
    - changed bitfield usage to extract32
    - used sextract_tl instructions instead of shift and ext
 v3
    - Split gen_mxu function into command specific gen_mxu_<ins> functions
 v4
    - Use MXU_OPTN2_ #defines
    - Add and use MXU_APTN2_ #defines
    - correct multi line comment format
    - Add check for MXUEN

 target/mips/translate.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 0241f1fca4..ea6484e2db 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3855,6 +3855,12 @@ static void gen_cl (DisasContext *ctx, uint32_t opc,
 #define MXU_OPTN2_HW    2
 #define MXU_OPTN2_XW    3
 
+/* MXU acumulate patterns */
+#define MXU_APTN2_AA    0
+#define MXU_APTN2_AS    1
+#define MXU_APTN2_SA    2
+#define MXU_APTN2_SS    3
+
 /* S32I2M XRa, rb - Register move from GRF to XRF */
 static void gen_mxu_s32i2m(DisasContext *ctx, uint32_t opc)
 {
@@ -4040,6 +4046,91 @@ static void gen_mxu_d16mul(DisasContext *ctx, uint32_t opc)
     tcg_temp_free(t3);
 }
 
+/*
+ * D16MAC XRa, XRb, XRc, XRd, APTN2, OPTN2
+ * Signed 16 bit pattern multiply and accumulate
+ */
+static void gen_mxu_d16mac(DisasContext *ctx, uint32_t opc)
+{
+    TCGv t0, t1, t2, t3;
+    TCGLabel *l0;
+    uint32_t xra, xrb, xrc, xrd, optn2, aptn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+
+    l0 = gen_new_label();
+
+    xra = extract32(ctx->opcode, 6, 4);
+    xrb = extract32(ctx->opcode, 10, 4);
+    xrc = extract32(ctx->opcode, 14, 4);
+    xrd = extract32(ctx->opcode, 18, 4);
+    optn2 = extract32(ctx->opcode, 22, 2);
+    aptn2 = extract32(ctx->opcode, 24, 2);
+
+    gen_load_mxu_cr(t0);
+    tcg_gen_andi_tl(t0, t0, MXUEN);
+    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXUEN, l0);
+
+    gen_load_mxu_gpr(t1, xrb);
+    tcg_gen_sextract_tl(t0, t1, 0, 16);
+    tcg_gen_sextract_tl(t1, t1, 16, 16);
+    gen_load_mxu_gpr(t3, xrc);
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
+    gen_load_mxu_gpr(t0, xra);
+    gen_load_mxu_gpr(t1, xrd);
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
+    gen_store_mxu_gpr(t3, xra);
+    gen_store_mxu_gpr(t2, xrd);
+
+    gen_set_label(l0);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    tcg_temp_free(t3);
+}
+
 /* Godson integer instructions */
 static void gen_loongson_integer(DisasContext *ctx, uint32_t opc,
                                  int rd, int rs, int rt)
@@ -18120,6 +18211,10 @@ static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext *ctx)
         gen_mxu_d16mul(ctx, op1);
         break;
 
+    case OPC_MXU_D16MAC:
+        gen_mxu_d16mac(ctx, op1);
+        break;
+
     default:            /* Invalid */
         MIPS_INVAL("special2_mxu");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.18.0
