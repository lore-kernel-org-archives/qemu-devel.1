Received: from eggs.gnu.org ([209.51.188.92]:58810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0v-000632-B4
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0t-00057R-NC
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:45 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:38 +0100
Message-Id: <20190428143845.11810-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 07/14] target/ppc: introduce GEN_VSX_HELPER_X1
 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X1 macro which performs the decode based
upon xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/fpu_helper.c             |  6 ++----
 target/ppc/helper.h                 |  8 ++++----
 target/ppc/translate/vsx-impl.inc.c | 24 ++++++++++++++++++++----
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index a2ff71e379..4b4bc229b5 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2221,9 +2221,8 @@ VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127, 23)
  *   nbits - number of fraction bits
  */
 #define VSX_TSQRT(op, nels, tp, fld, emin, nbits)                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
+void helper_##op(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)      \
 {                                                                       \
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                              \
     int i;                                                              \
     int fe_flag = 0;                                                    \
     int fg_flag = 0;                                                    \
@@ -3230,9 +3229,8 @@ VSX_TEST_DC(xvtstdcsp, 4, xB(opcode), float32, VsrW(i), VsrW(i), UINT32_MAX, 0)
 VSX_TEST_DC(xststdcdp, 1, xB(opcode), float64, VsrD(0), VsrD(0), 0, 1)
 VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), float128, f128, VsrD(0), 0, 1)
 
-void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
+void helper_xststdcsp(CPUPPCState *env, uint32_t opcode, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xb = &env->vsr[xB(opcode)];
     uint32_t dcmx, sign, exp;
     uint32_t cc, match = 0, not_sp = 0;
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 9c236f016e..cb6b7a55c1 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -388,7 +388,7 @@ DEF_HELPER_4(xsredp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xssqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsrsqrtedp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xstsqrtdp, void, env, i32)
+DEF_HELPER_3(xstsqrtdp, void, env, i32, vsr)
 DEF_HELPER_5(xsmaddadp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmaddmdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xsmsubadp, void, env, i32, vsr, vsr, vsr)
@@ -435,7 +435,7 @@ DEF_HELPER_4(xscvuxdsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscvsxdsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscvudqp, void, env, i32)
 DEF_HELPER_4(xscvuxddp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xststdcsp, void, env, i32)
+DEF_HELPER_3(xststdcsp, void, env, i32, vsr)
 DEF_HELPER_2(xststdcdp, void, env, i32)
 DEF_HELPER_2(xststdcqp, void, env, i32)
 DEF_HELPER_4(xsrdpi, void, env, i32, vsr, vsr)
@@ -473,7 +473,7 @@ DEF_HELPER_4(xvredp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvsqrtdp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrsqrtedp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtsqrtdp, void, env, i32)
+DEF_HELPER_3(xvtsqrtdp, void, env, i32, vsr)
 DEF_HELPER_5(xvmaddadp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmaddmdp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmsubadp, void, env, i32, vsr, vsr, vsr)
@@ -511,7 +511,7 @@ DEF_HELPER_4(xvresp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvsqrtsp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvrsqrtesp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xvtsqrtsp, void, env, i32)
+DEF_HELPER_3(xvtsqrtsp, void, env, i32, vsr)
 DEF_HELPER_5(xvmaddasp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmaddmsp, void, env, i32, vsr, vsr, vsr)
 DEF_HELPER_5(xvmsubasp, void, env, i32, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index fed56fce69..a30e22a852 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -987,6 +987,22 @@ static void gen_##name(DisasContext *ctx)                                     \
     tcg_temp_free_ptr(xb);                                                    \
 }
 
+#define GEN_VSX_HELPER_X1(name, op1, op2, inval, type)                        \
+static void gen_##name(DisasContext *ctx)                                     \
+{                                                                             \
+    TCGv_i32 opc;                                                             \
+    TCGv_ptr xb;                                                              \
+    if (unlikely(!ctx->vsx_enabled)) {                                        \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
+        return;                                                               \
+    }                                                                         \
+    opc = tcg_const_i32(ctx->opcode);                                         \
+    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
+    gen_helper_##name(cpu_env, opc, xb);                                      \
+    tcg_temp_free_i32(opc);                                                   \
+    tcg_temp_free_ptr(xb);                                                    \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1016,7 +1032,7 @@ GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
@@ -1090,7 +1106,7 @@ GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_X2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X1(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
 
@@ -1102,7 +1118,7 @@ GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
@@ -1140,7 +1156,7 @@ GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X1(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
-- 
2.11.0
