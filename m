Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjhAb-000070-Lw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:58:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjhAX-0005vV-Pq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:58:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47099
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cjhAX-0005uF-Jf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:58:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v236nMhD002955
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 01:58:24 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28xs8f05g0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 01:58:24 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 3 Mar 2017 12:28:21 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  3 Mar 2017 12:28:07 +0530
In-Reply-To: <1488524289-5305-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1488524289-5305-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1488524289-5305-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/3] target/ppc: fmadd check for excp
 independently
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

Current order of checking does not confirm with the spec
(ISA 3.0: MultiplyAddDP page-469). Change the order and make them
independent of each other.

For example: a = infinity, b = zero, c = SNaN, this should set both
VXIMZ and VXNAN

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 0535ad0..a547f58 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -747,17 +747,21 @@ static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
                                         float64 arg2, float64 arg3,
                                         unsigned int madd_flags)
 {
+    if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
+                 float64_is_signaling_nan(arg2, &env->fp_status) ||
+                 float64_is_signaling_nan(arg3, &env->fp_status))) {
+        /* sNaN operation */
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
+    }
+
     if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
                  (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
         /* Multiplication of zero by infinity */
-        arg1 = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
-    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) ||
-                        float64_is_signaling_nan(arg2, &env->fp_status) ||
-                        float64_is_signaling_nan(arg3, &env->fp_status))) {
-        /* sNaN operation */
-        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
-    } else if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
-               float64_is_infinity(arg3)) {
+        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
+    }
+
+    if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) &&
+        float64_is_infinity(arg3)) {
         uint8_t aSign, bSign, cSign;
 
         aSign = float64_is_neg(arg1);
-- 
2.7.4
