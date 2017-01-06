Received: from eggs.gnu.org ([2001:4830:134:3::10]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNok-00072w-R8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoh-0002us-KQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNoh-0002un-Bl
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:55 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066Du9M049578
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:15:54 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27t21gyjmt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:15:54 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:15:51 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:48 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 06/14] target-ppc: Add xsaddqp instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

xsaddqp:  VSX Scalar Add Quad-Precision

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c             | 36 ++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |  1 +
 target/ppc/internal.h               |  2 ++
 target/ppc/translate/vsx-impl.inc.c |  1 +
 target/ppc/translate/vsx-ops.inc.c  |  1 +
 5 files changed, 41 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 913d54e..d48cf51 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -108,6 +108,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
 }
 
 COMPUTE_FPRF(float64)
+COMPUTE_FPRF(float128)
 
 /* Floating-point invalid operations exception */
 static inline __attribute__((__always_inline__))
@@ -1827,6 +1828,41 @@ VSX_ADD_SUB(xssubsp, sub, 1, float64, VsrD(0), 1, 1)
 VSX_ADD_SUB(xvsubdp, sub, 2, float64, VsrD(i), 0, 0)
 VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0, 0)
 
+void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
+{
+    ppc_vsr_t xt, xa, xb;
+    float_status tstat;
+
+    getVSR(xA(opcode), &xa, env);
+    getVSR(xB(opcode), &xb, env);
+    getVSR(xT(opcode), &xt, env);
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
+    putVSR(xT(opcode), &xt, env);
+    float_check_status(env);
+}
+
 /* VSX_MUL - VSX floating point multiply
  *   op    - instruction mnemonic
  *   nels  - number of elements (1, 2 or 4)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 04e688d..cd7b608 100644
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
index 66cde46..f4f02e5 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -206,6 +206,7 @@ typedef union _ppc_vsr_t {
     uint64_t u64[2];
     float32 f32[4];
     float64 f64[2];
+    float128 f128;
     Int128  s128;
 } ppc_vsr_t;
 
@@ -241,4 +242,5 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
     }
 }
 
+void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index c9ba0f5..51ac183 100644
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
index 096d358..1155765 100644
--- a/target/ppc/translate/vsx-ops.inc.c
+++ b/target/ppc/translate/vsx-ops.inc.c
@@ -123,6 +123,7 @@ GEN_XX2FORM(xvnegsp, 0x12, 0x1B, PPC2_VSX),
 GEN_XX3FORM(xvcpsgnsp, 0x00, 0x1A, PPC2_VSX),
 
 GEN_XX3FORM(xsadddp, 0x00, 0x04, PPC2_VSX),
+GEN_VSX_XFORM_300(xsaddqp, 0x04, 0x00, 0x0),
 GEN_XX3FORM(xssubdp, 0x00, 0x05, PPC2_VSX),
 GEN_XX3FORM(xsmuldp, 0x00, 0x06, PPC2_VSX),
 GEN_XX3FORM(xsdivdp, 0x00, 0x07, PPC2_VSX),
-- 
2.7.4
