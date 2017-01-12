Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk9-00039w-VD
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk7-0006hj-W3
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:57 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:11 +1100
Message-Id: <20170112020327.24882-52-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 51/67] target-ppc: Use float64 arg in
 helper_compute_fprf()
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

Use float64 argument instead of unit64_t in helper_compute_fprf()
This allows code in helper_compute_fprf() to be reused later to
work with float128 argument too.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 1ccd5e6..4da991a 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -66,23 +66,21 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
     return ((f >> 52) & 0x7FF) - 1023;
 }
 
-void helper_compute_fprf(CPUPPCState *env, uint64_t arg)
+void helper_compute_fprf(CPUPPCState *env, float64 arg)
 {
-    CPU_DoubleU farg;
     int isneg;
     int fprf;
 
-    farg.ll = arg;
-    isneg = float64_is_neg(farg.d);
-    if (unlikely(float64_is_any_nan(farg.d))) {
-        if (float64_is_signaling_nan(farg.d, &env->fp_status)) {
+    isneg = float64_is_neg(arg);
+    if (unlikely(float64_is_any_nan(arg))) {
+        if (float64_is_signaling_nan(arg, &env->fp_status)) {
             /* Signaling NaN: flags are undefined */
             fprf = 0x00;
         } else {
             /* Quiet NaN */
             fprf = 0x11;
         }
-    } else if (unlikely(float64_is_infinity(farg.d))) {
+    } else if (unlikely(float64_is_infinity(arg))) {
         /* +/- infinity */
         if (isneg) {
             fprf = 0x09;
@@ -90,7 +88,7 @@ void helper_compute_fprf(CPUPPCState *env, uint64_t arg)
             fprf = 0x05;
         }
     } else {
-        if (float64_is_zero(farg.d)) {
+        if (float64_is_zero(arg)) {
             /* +/- zero */
             if (isneg) {
                 fprf = 0x12;
@@ -98,7 +96,7 @@ void helper_compute_fprf(CPUPPCState *env, uint64_t arg)
                 fprf = 0x02;
             }
         } else {
-            if (isden(farg.d)) {
+            if (isden(arg)) {
                 /* Denormalized numbers */
                 fprf = 0x10;
             } else {
-- 
2.9.3
