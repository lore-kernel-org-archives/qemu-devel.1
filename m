Received: from eggs.gnu.org ([2001:4830:134:3::10]:37675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV3-0002yV-Qr
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV0-0007wc-Q9
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:09 +1100
Message-Id: <20170222063348.32176-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/43] ppc: implement xsrqpi[x] instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

xsrqpi[x]: VSX Scalar Round to Quad-Precision Integer
[with Inexact].

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 59 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/internal.h               |  1 +
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  | 12 ++++++++
 5 files changed, 75 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 9f5cafd..1ca384c 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -3277,3 +3277,62 @@ void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
     env->fpscr |= cc << FPSCR_FPRF;
     env->crf[BF(opcode)] = cc;
 }
+
+void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xb;
+    ppc_vsr_t xt;
+    uint8_t r = Rrm(opcode);
+    uint8_t ex = Rc(opcode);
+    uint8_t rmc = RMC(opcode);
+    uint8_t rmode = 0;
+    float_status tstat;
+
+    getVSR(rB(opcode) + 32, &xb, env);
+    memset(&xt, 0, sizeof(xt));
+    helper_reset_fpstatus(env);
+
+    if (r == 0 && rmc == 0) {
+        rmode = float_round_ties_away;
+    } else if (r == 0 && rmc == 0x3) {
+        rmode = fpscr_rn;
+    } else if (r == 1) {
+        switch (rmc) {
+        case 0:
+            rmode = float_round_nearest_even;
+            break;
+        case 1:
+            rmode = float_round_to_zero;
+            break;
+        case 2:
+            rmode = float_round_up;
+            break;
+        case 3:
+            rmode = float_round_down;
+            break;
+        default:
+            abort();
+        }
+    }
+
+    tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    set_float_rounding_mode(rmode, &tstat);
+    xt.f128 = float128_round_to_int(xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);
+            xt.f128 = float128_snan_to_qnan(xt.f128);
+        }
+    }
+
+    if (ex == 0 && (tstat.float_exception_flags & float_flag_inexact)) {
+        env->fp_status.float_exception_flags &= ~float_flag_inexact;
+    }
+
+    helper_compute_fprf_float128(env, xt.f128);
+    float_check_status(env);
+    putVSR(rD(opcode) + 32, &xt, env);
+}
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 85af9df..6a53ae0 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -459,6 +459,7 @@ DEF_HELPER_2(xsrdpic, void, env, i32)
 DEF_HELPER_2(xsrdpim, void, env, i32)
 DEF_HELPER_2(xsrdpip, void, env, i32)
 DEF_HELPER_2(xsrdpiz, void, env, i32)
+DEF_HELPER_2(xsrqpi, void, env, i32)
 
 DEF_HELPER_2(xsaddsp, void, env, i32)
 DEF_HELPER_2(xssubsp, void, env, i32)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 5a2fd68..5b5b180 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -186,6 +186,7 @@ EXTRACT_HELPER(DCM, 10, 6)
 
 /* DFP Z23-form */
 EXTRACT_HELPER(RMC, 9, 2)
+EXTRACT_HELPER(Rrm, 16, 1)
 
 EXTRACT_HELPER_SPLIT(DQxT, 3, 1, 21, 5);
 EXTRACT_HELPER_SPLIT(xT, 0, 1, 21, 5);
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index a44c003..9868f01 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -833,6 +833,8 @@ GEN_VSX_HELPER_2(xsrdpip, 0x12, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsrdpiz, 0x12, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xsrsp, 0x12, 0x11, 0, PPC2_VSX207)
 
+GEN_VSX_HELPER_2(xsrqpi, 0x05, 0x00, 0, PPC2_ISA300)
+
 GEN_VSX_HELPER_2(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 7dc9f6f..b095508 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -103,6 +103,18 @@ GEN_HANDLER_E(name, 0x3F, opc2, opc3, inval, PPC_NONE, PPC2_ISA300)
 #define GEN_VSX_XFORM_300_EO(name, opc2, opc3, opc4, inval)             \
 GEN_HANDLER_E_2(name, 0x3F, opc2, opc3, opc4, inval, PPC_NONE, PPC2_ISA300)
 
+#define GEN_VSX_Z23FORM_300(name, opc2, opc3, opc4, inval) \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x00, opc4 | 0x0, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x08, opc4 | 0x0, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x0, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x0, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x00, opc4 | 0x1, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x08, opc4 | 0x1, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x10, opc4 | 0x1, inval), \
+GEN_VSX_XFORM_300_EO(name, opc2, opc3 | 0x18, opc4 | 0x1, inval)
+
+GEN_VSX_Z23FORM_300(xsrqpi, 0x05, 0x0, 0x0, 0x0),
+
 GEN_XX2FORM(xsabsdp, 0x12, 0x15, PPC2_VSX),
 GEN_XX2FORM(xsnabsdp, 0x12, 0x16, PPC2_VSX),
 GEN_XX2FORM(xsnegdp, 0x12, 0x17, PPC2_VSX),
-- 
2.9.3
