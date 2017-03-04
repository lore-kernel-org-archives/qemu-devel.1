Received: from eggs.gnu.org ([2001:4830:134:3::10]:41944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ckAGX-0005Xh-6i
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ckAGS-00043H-54
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:02:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ckAGR-00042j-S2
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 09:02:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v24DxPnY114335
	for <qemu-devel@nongnu.org>; Sat, 4 Mar 2017 09:02:26 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ytm2ge33-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 09:02:26 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Sat, 4 Mar 2017 19:32:23 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Sat,  4 Mar 2017 19:32:08 +0530
In-Reply-To: <1488636129-19409-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1488636129-19409-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1488636129-19409-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 2/3] target/ppc: fmadd: add macro for
 updating flags
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

Adds FPU_MADDSUB_UPDATE macro, this will be used for other routines
having float32/16

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c | 61 ++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index a547f58..13bd6ce 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -743,38 +743,37 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t arg)
     return do_fri(env, arg, float_round_down);
 }
 
-static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
-                                        float64 arg2, float64 arg3,
-                                        unsigned int madd_flags)
-{
-    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
-                 float64_is_signaling_nan(arg2, &env->fp_status) ||
-                 float64_is_signaling_nan(arg3, &env->fp_status))) {
-        /* sNaN operation */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-    }
-
-    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
-                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
-        /* Multiplication of zero by infinity */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    }
-
-    if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
-        float64_is_infinity(arg3)) {
-        uint8_t aSign, bSign, cSign;
-
-        aSign = float64_is_neg(arg1);
-        bSign = float64_is_neg(arg2);
-        cSign = float64_is_neg(arg3);
-        if (madd_flags & float_muladd_negate_c) {
-            cSign ^= 1;
-        }
-        if (aSign ^ bSign ^ cSign) {
-            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
-        }
-    }
+#define FPU_MADDSUB_UPDATE(NAME, TP)                                    \
+static void NAME(CPUPPCState *env, TP arg1, TP arg2, TP arg3,           \
+                 unsigned int madd_flags)                               \
+{                                                                       \
+    if (TP##_is_signaling_nan(arg1, &env->fp_status) ||                 \
+        TP##_is_signaling_nan(arg2, &env->fp_status) ||                 \
+        TP##_is_signaling_nan(arg3, &env->fp_status)) {                 \
+        /* sNaN operation */                                            \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);          \
+    }                                                                   \
+    if ((TP##_is_infinity(arg1) && TP##_is_zero(arg2)) ||               \
+        (TP##_is_zero(arg1) && TP##_is_infinity(arg2))) {               \
+        /* Multiplication of zero by infinity */                        \
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);           \
+    }                                                                   \
+    if ((TP##_is_infinity(arg1) || TP##_is_infinity(arg2)) &&           \
+        TP##_is_infinity(arg3)) {                                       \
+        uint8_t aSign, bSign, cSign;                                    \
+                                                                        \
+        aSign = TP##_is_neg(arg1);                                      \
+        bSign = TP##_is_neg(arg2);                                      \
+        cSign = TP##_is_neg(arg3);                                      \
+        if (madd_flags & float_muladd_negate_c) {                       \
+            cSign ^= 1;                                                 \
+        }                                                               \
+        if (aSign ^ bSign ^ cSign) {                                    \
+            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);       \
+        }                                                               \
+    }                                                                   \
 }
+FPU_MADDSUB_UPDATE(float64_maddsub_update_excp, float64)
 
 #define FPU_FMADD(op, madd_flags)                                       \
 uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
-- 
2.7.4
