Received: from eggs.gnu.org ([209.51.188.92]:34905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlMG-00017B-QB
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlME-0008IF-QO
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:48 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:45 +0100
Message-Id: <20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 14/14] target/ppc: improve VSX_FMADD with new
 GEN_VSX_HELPER_VSX_MADD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

Introduce a new GEN_VSX_HELPER_VSX_MADD macro for the generator function which
enables the source and destination registers to be decoded at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             |  12 +----
 target/ppc/helper.h                 |  64 +++++++++++------------
 target/ppc/translate/vsx-impl.inc.c | 101 ++++++++++++++++++++++++------------
 3 files changed, 101 insertions(+), 76 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 357be25867..6b5293495f 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2270,19 +2270,11 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23)
  */
 #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)              \
 void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
-                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                 \
+                 ppc_vsr_t *xt, ppc_vsr_t *xa,                                \
+                 ppc_vsr_t *b, ppc_vsr_t *c)                                  \
 {                                                                             \
-    ppc_vsr_t *b, *c;                                                         \
     int i;                                                                    \
                                                                               \
-    if (afrm) { /* AxB + T */                                                 \
-        b = xb;                                                               \
-        c = xt;                                                               \
-    } else { /* AxT + B */                                                    \
-        b = xt;                                                               \
-        c = xb;                                                               \
-    }                                                                         \
-                                                                              \
     helper_reset_fpstatus(env);                                               \
                                                                               \
     for (i = 0; i < nels; i++) {                                              \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cd97fae438..5db6dc0797 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -389,14 +389,14 @@ DEF_HELPER_4(xssqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrsqrtedp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xstsqrtdp, void, env, i32, vsr)
-DEF_HELPER_5(xsmaddadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsmaddmdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsmsubadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsmsubmdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmaddadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmaddmdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmsubadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmsubmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_6(xsmaddadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsmaddmdp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsmsubadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsmsubmdp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmaddadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmaddmdp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmsubadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmsubmdp, void, env, i32, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xscmpeqdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xscmpgtdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xscmpgedp, void, env, i32, vsr, vsr, vsr)
@@ -456,14 +456,14 @@ DEF_HELPER_4(xsresp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xsrsp, i64, env, i64)
 DEF_HELPER_4(xssqrtsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrsqrtesp, void, env, i32, vsr, vsr)
-DEF_HELPER_5(xsmaddasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsmaddmsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsmsubasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsmsubmsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmaddasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmaddmsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmsubasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xsnmsubmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_6(xsmaddasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsmaddmsp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsmsubasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsmsubmsp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmaddasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmaddmsp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmsubasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xsnmsubmsp, void, env, i32, vsr, vsr, vsr, vsr)
 
 DEF_HELPER_5(xvadddp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvsubdp, void, env, i32, vsr, vsr, vsr)
@@ -474,14 +474,14 @@ DEF_HELPER_4(xvsqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrsqrtedp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xvtsqrtdp, void, env, i32, vsr)
-DEF_HELPER_5(xvmaddadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvmaddmdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvmsubadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvmsubmdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmaddadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmaddmdp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmsubadp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmsubmdp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_6(xvmaddadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvmaddmdp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvmsubadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvmsubmdp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmaddadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmaddmdp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmsubadp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmsubmdp, void, env, i32, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvmaxdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmindp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpeqdp, void, env, i32, vsr, vsr, vsr)
@@ -512,14 +512,14 @@ DEF_HELPER_4(xvsqrtsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrsqrtesp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
 DEF_HELPER_3(xvtsqrtsp, void, env, i32, vsr)
-DEF_HELPER_5(xvmaddasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvmaddmsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvmsubasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvmsubmsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmaddasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmaddmsp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmsubasp, void, env, i32, vsr, vsr, vsr)
-DEF_HELPER_5(xvnmsubmsp, void, env, i32, vsr, vsr, vsr)
+DEF_HELPER_6(xvmaddasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvmaddmsp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvmsubasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvmsubmsp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmaddasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmaddmsp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmsubasp, void, env, i32, vsr, vsr, vsr, vsr)
+DEF_HELPER_6(xvnmsubmsp, void, env, i32, vsr, vsr, vsr, vsr)
 DEF_HELPER_5(xvmaxsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvminsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvcmpeqsp, void, env, i32, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 03b342a2fb..18b5f5a917 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1090,14 +1090,6 @@ GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
@@ -1140,12 +1132,10 @@ GEN_VSX_HELPER_X2(xsrdpim, 0x12, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
-
 GEN_VSX_HELPER_R2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_R2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_R3(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
-
 GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
@@ -1153,14 +1143,6 @@ GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X1(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
@@ -1176,14 +1158,6 @@ GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpeqdp, 0x0C, 0x0C, 0, PPC2_VSX)
@@ -1214,14 +1188,6 @@ GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X1(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
-GEN_VSX_HELPER_X3(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvcmpeqsp, 0x0C, 0x08, 0, PPC2_VSX)
@@ -1249,6 +1215,73 @@ GEN_VSX_HELPER_X2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
 
+#define GEN_VSX_HELPER_VSX_MADD(name, op1, op2, inval, type)                  \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xt, xa, b, c;                                                    \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
+    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
+    if (ctx->opcode & PPC_BIT(25)) {                                          \
+        /*                                                                    \
+         * AxT + B                                                            \
+         */                                                                   \
+        b = gen_vsr_ptr(xT(ctx->opcode));                                     \
+        c = gen_vsr_ptr(xB(ctx->opcode));                                     \
+    } else {                                                                  \
+        /*                                                                    \
+         * AxB + T                                                            \
+         */                                                                   \
+        b = gen_vsr_ptr(xB(ctx->opcode));                                     \
+        c = gen_vsr_ptr(xT(ctx->opcode));                                     \
+    }                                                                         \
+    gen_helper_##name(cpu_env, opc, xt, xa, b, c);                            \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xt);                                                    \
+    tcg_temp_free_ptr(xa);                                                    \
+    tcg_temp_free_ptr(b);                                                     \
+    tcg_temp_free_ptr(c);                                                     \
+}
+
+GEN_VSX_HELPER_VSX_MADD(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
+
+GEN_VSX_HELPER_VSX_MADD(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
+GEN_VSX_HELPER_VSX_MADD(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_VSX_MADD(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
+
 static void gen_xxbrd(DisasContext *ctx)
 {
     TCGv_i64 xth;
-- 
2.11.0
