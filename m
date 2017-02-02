Received: from eggs.gnu.org ([2001:4830:134:3::10]:52894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kL-00083L-Jf
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kD-0004Lw-2Q
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:21 +1100
Message-Id: <20170202051445.5735-84-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 083/107] target-ppc: Add xscvqps[d,
 w]z instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xscvqpsdz: VSX Scalar truncate & Convert Quad-Precision format to
           Signed Doubleword format
xscvqpswz: VSX Scalar truncate & Convert Quad-Precision format to
           Signed Word format

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 40 +++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  2 ++
 target/ppc/translate/vsx-ops.inc.c  |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4da83d9..ae57272 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2878,6 +2878,46 @@ VSX_CVT_FP_TO_INT(xvcvspsxws, 4, float32, int32, VsrW(i), VsrW(i), 0x80000000U)
 VSX_CVT_FP_TO_INT(xvcvspuxds, 2, float32, uint64, VsrW(2*i), VsrD(i), 0ULL)
 VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32, VsrW(i), VsrW(i), 0U)
 
+/* VSX_CVT_FP_TO_INT_VECTOR - VSX floating point to integer conversion
+ *   op    - instruction mnemonic
+ *   stp   - source type (float32 or float64)
+ *   ttp   - target type (int32, uint32, int64 or uint64)
+ *   sfld  - source vsr_t field
+ *   tfld  - target vsr_t field
+ *   rnan  - resulting NaN
+ */
+#define VSX_CVT_FP_TO_INT_VECTOR(op, stp, ttp, sfld, tfld, rnan)             \
+void helper_##op(CPUPPCState *env, uint32_t opcode)                          \
+{                                                                            \
+    ppc_vsr_t xt, xb;                                                        \
+                                                                             \
+    getVSR(rB(opcode) + 32, &xb, env);                                       \
+    memset(&xt, 0, sizeof(xt));                                              \
+                                                                             \
+    if (unlikely(stp##_is_any_nan(xb.sfld))) {                               \
+        if (stp##_is_signaling_nan(xb.sfld, &env->fp_status)) {              \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 0);           \
+        }                                                                    \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);                \
+        xt.tfld = rnan;                                                      \
+    } else {                                                                 \
+        xt.tfld = stp##_to_##ttp##_round_to_zero(xb.sfld,                    \
+                      &env->fp_status);                                      \
+        if (env->fp_status.float_exception_flags & float_flag_invalid) {     \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXCVI, 0);            \
+        }                                                                    \
+    }                                                                        \
+                                                                             \
+    putVSR(rD(opcode) + 32, &xt, env);                                       \
+    float_check_status(env);                                                 \
+}
+
+VSX_CVT_FP_TO_INT_VECTOR(xscvqpsdz, float128, int64, f128, VsrD(0),          \
+                  0x8000000000000000ULL)
+
+VSX_CVT_FP_TO_INT_VECTOR(xscvqpswz, float128, int32, f128, VsrD(0),          \
+                  0xffffffff80000000ULL)
+
 /* VSX_CVT_INT_TO_FP - VSX integer to floating point conversion
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ae14da4..96d8cae 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -432,6 +432,8 @@ DEF_HELPER_2(xscvdpqp, void, env, i32)
 DEF_HELPER_2(xscvdpsp, void, env, i32)
 DEF_HELPER_2(xscvdpspn, i64, env, i64)
 DEF_HELPER_2(xscvqpdp, void, env, i32)
+DEF_HELPER_2(xscvqpsdz, void, env, i32)
+DEF_HELPER_2(xscvqpswz, void, env, i32)
 DEF_HELPER_2(xscvhpdp, void, env, i32)
 DEF_HELPER_2(xscvspdp, void, env, i32)
 DEF_HELPER_2(xscvspdpn, i64, env, i64)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7e068a4..3c924ba 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -811,6 +811,8 @@ GEN_VSX_HELPER_2(xscvdpsp, 0x12, 0x10, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscvdpqp, 0x04, 0x1A, 0x16, PPC2_ISA300)
 GEN_VSX_HELPER_XT_XB_ENV(xscvdpspn, 0x16, 0x10, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvqpdp, 0x04, 0x1A, 0x14, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvqpsdz, 0x04, 0x1A, 0x19, PPC2_ISA300)
+GEN_VSX_HELPER_2(xscvqpswz, 0x04, 0x1A, 0x09, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvhpdp, 0x16, 0x15, 0x10, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscvspdp, 0x12, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_XT_XB_ENV(xscvspdpn, 0x16, 0x14, 0, PPC2_VSX207)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index 367fd38..297c317 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -114,6 +114,8 @@ GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
 GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvdpqp, 0x04, 0x1A, 0x16, 0x00000001),
 GEN_VSX_XFORM_300_EO(xscvqpdp, 0x04, 0x1A, 0x14, 0x0),
+GEN_VSX_XFORM_300_EO(xscvqpsdz, 0x04, 0x1A, 0x19, 0x00000001),
+GEN_VSX_XFORM_300_EO(xscvqpswz, 0x04, 0x1A, 0x09, 0x00000001),
 
 #ifdef TARGET_PPC64
 GEN_XX2FORM_EO(xsxexpdp, 0x16, 0x15, 0x00, PPC2_ISA300),
-- 
2.9.3
