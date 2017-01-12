Received: from eggs.gnu.org ([2001:4830:134:3::10]:45028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiB6-0005Sf-PP
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRiB2-0007K4-GC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRiB2-0007Gp-72
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:24:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CGJUck139503
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:35 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27x9h8jant-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:24:35 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 21:54:31 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 21:54:05 +0530
In-Reply-To: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484238251-8096-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484238251-8096-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/7] target-ppc: Use ppc_vsr_t.f128 in xscmp[o,
 u, exp]qp
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

xscmpoqp, xscmpuqp & xscmpexpqp were added before f128 field was
introduced in ppc_vsr_t. Now that we have it, use it instead of
generating the 128 bit float using two 64bit fields.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/fpu_helper.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ae57272..d648234 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2452,8 +2452,8 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
     exp_a = extract64(xa.VsrD(0), 48, 15);
     exp_b = extract64(xb.VsrD(0), 48, 15);
 
-    if (unlikely(float128_is_any_nan(make_float128(xa.VsrD(0), xa.VsrD(1))) ||
-                 float128_is_any_nan(make_float128(xb.VsrD(0), xb.VsrD(1))))) {
+    if (unlikely(float128_is_any_nan(xa.f128) ||
+                 float128_is_any_nan(xb.f128))) {
         cc = CRF_SO;
     } else {
         if (exp_a < exp_b) {
@@ -2528,24 +2528,20 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
     ppc_vsr_t xa, xb;                                                   \
     uint32_t cc = 0;                                                    \
     bool vxsnan_flag = false, vxvc_flag = false;                        \
-    float128 a, b;                                                      \
                                                                         \
     helper_reset_fpstatus(env);                                         \
     getVSR(rA(opcode) + 32, &xa, env);                                  \
     getVSR(rB(opcode) + 32, &xb, env);                                  \
                                                                         \
-    a = make_float128(xa.VsrD(0), xa.VsrD(1));                          \
-    b = make_float128(xb.VsrD(0), xb.VsrD(1));                          \
-                                                                        \
-    if (float128_is_signaling_nan(a, &env->fp_status) ||                \
-        float128_is_signaling_nan(b, &env->fp_status)) {                \
+    if (float128_is_signaling_nan(xa.f128, &env->fp_status) ||          \
+        float128_is_signaling_nan(xb.f128, &env->fp_status)) {          \
         vxsnan_flag = true;                                             \
         cc = CRF_SO;                                                    \
         if (fpscr_ve == 0 && ordered) {                                 \
             vxvc_flag = true;                                           \
         }                                                               \
-    } else if (float128_is_quiet_nan(a, &env->fp_status) ||             \
-               float128_is_quiet_nan(b, &env->fp_status)) {             \
+    } else if (float128_is_quiet_nan(xa.f128, &env->fp_status) ||       \
+               float128_is_quiet_nan(xb.f128, &env->fp_status)) {       \
         cc = CRF_SO;                                                    \
         if (ordered) {                                                  \
             vxvc_flag = true;                                           \
@@ -2558,9 +2554,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)                     \
         float_invalid_op_excp(env, POWERPC_EXCP_FP_VXVC, 0);            \
     }                                                                   \
                                                                         \
-    if (float128_lt(a, b, &env->fp_status)) {                           \
+    if (float128_lt(xa.f128, xb.f128, &env->fp_status)) {               \
         cc |= CRF_LT;                                                   \
-    } else if (!float128_le(a, b, &env->fp_status)) {                   \
+    } else if (!float128_le(xa.f128, xb.f128, &env->fp_status)) {       \
         cc |= CRF_GT;                                                   \
     } else {                                                            \
         cc |= CRF_EQ;                                                   \
-- 
2.7.4
