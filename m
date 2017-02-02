Received: from eggs.gnu.org ([2001:4830:134:3::10]:52442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kB-0007pm-5F
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k4-0004AL-3b
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:25 +1100
Message-Id: <20170202051445.5735-88-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 087/107] target-ppc: Use ppc_vsr_t.f128 in
 xscmp[o, u, exp]qp
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

xscmpoqp, xscmpuqp & xscmpexpqp were added before f128 field was
introduced in ppc_vsr_t. Now that we have it, use it instead of
generating the 128 bit float using two 64bit fields.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
