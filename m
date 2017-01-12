Received: from eggs.gnu.org ([2001:4830:134:3::10]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkH-0003H5-Ip
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkD-0006pT-UW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:23 +1100
Message-Id: <20170112020327.24882-64-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 63/67] target-ppc: Add xsaddqp instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xsaddqp:  VSX Scalar Add Quad-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 36 ++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/internal.h               |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 5 files changed, 41 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 01b335f..6e7279c 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -111,6 +111,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
 COMPUTE_FPRF(float16)
 COMPUTE_FPRF(float32)
 COMPUTE_FPRF(float64)
+COMPUTE_FPRF(float128)
 
 /* Floating-point invalid operations exception */
 static inline __attribute__((__always_inline__))
@@ -1830,6 +1831,41 @@ VSX_ADD_SUB(xssubsp, sub, 1, float64, VsrD(0), 1, 1)
 VSX_ADD_SUB(xvsubdp, sub, 2, float64, VsrD(i), 0, 0)
 VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0, 0)
 
+void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xa, xb;
+    float_status tstat;
+
+    getVSR(rA(opcode) + 32, &xa, env);
+    getVSR(rB(opcode) + 32, &xb, env);
+    getVSR(rD(opcode) + 32, &xt, env);
+    helper_reset_fpstatus(env);
+
+    if (unlikely(Rc(opcode) != 0)) {
+        /* TODO: Support xsadddpo after round-to-odd is implemented */
+        abort();
+    }
+
+    tstat = env->fp_status;
+    set_float_exception_flags(0, &tstat);
+    xt.f128 = float128_add(xa.f128, xb.f128, &tstat);
+    env->fp_status.float_exception_flags |= tstat.float_exception_flags;
+
+    if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
+        if (float128_is_infinity(xa.f128) && float128_is_infinity(xb.f128)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
+        } else if (float128_is_signaling_nan(xa.f128, &tstat) ||
+                   float128_is_signaling_nan(xb.f128, &tstat)) {
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+        }
+    }
+
+    helper_compute_fprf_float128(env, xt.f128);
+
+    putVSR(rD(opcode) + 32, &xt, env);
+    float_check_status(env);
+}
+
 /* VSX_MUL - VSX floating point multiply
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5f290c6..889fe55 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -400,6 +400,7 @@ DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
 DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
+DEF_HELPER_2(xsaddqp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
 DEF_HELPER_2(xsmuldp, void, env, i32)
 DEF_HELPER_2(xsdivdp, void, env, i32)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 187f024..c22d74e 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -206,6 +206,7 @@ typedef union _ppc_vsr_t {
     uint64_t u64[2];
     float32 f32[4];
     float64 f64[2];
+    float128 f128;
     Int128  s128;
 } ppc_vsr_t;
 
@@ -245,4 +246,5 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
+void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 33e934f..113ccf3 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -777,6 +777,7 @@ static void gen_##name(DisasContext * ctx)                    \
 }
 
 GEN_VSX_HELPER_2(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_2(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
index bfcd09e..882e11b 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -130,6 +130,7 @@ GEN_XX2FORM(xvnegsp, 0x12, 0x1B, PPC2_VSX),
 GEN_XX3FORM(xvcpsgnsp, 0x00, 0x1A, PPC2_VSX),
 
 GEN_XX3FORM(xsadddp, 0x00, 0x04, PPC2_VSX),
+GEN_VSX_XFORM_300(xsaddqp, 0x04, 0x00, 0x0),
 GEN_XX3FORM(xssubdp, 0x00, 0x05, PPC2_VSX),
 GEN_XX3FORM(xsmuldp, 0x00, 0x06, PPC2_VSX),
 GEN_XX3FORM(xsdivdp, 0x00, 0x07, PPC2_VSX),
-- 
2.9.3
