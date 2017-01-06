Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoV-0006sD-Ky
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoS-0002oy-FH
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNoS-0002oc-4U
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066DvrU135323
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:15:39 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27t2haefwn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:15:38 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:15:36 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:45 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 03/14] target-ppc: Use float64 arg in
 helper_compute_fprf()
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

Use float64 argument instead of unit64_t in helper_compute_fprf()
This allows code in helper_compute_fprf() to be reused later to
work with float128 argument too.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
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
2.7.4
