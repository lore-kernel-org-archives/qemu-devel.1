Received: from eggs.gnu.org ([2001:4830:134:3::10]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoa-0006wb-Vr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPNoX-0002sq-QX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPNoX-0002sM-Jp
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 01:15:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v066Du4q082763
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 01:15:45 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27t1hv8mwt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 01:15:44 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 16:15:42 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri,  6 Jan 2017 11:44:46 +0530
In-Reply-To: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1483683296-32568-5-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 04/14] target-ppc: Replace isden by
 float64_is_zero_or_denormal
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

Replace isden() by float64_is_zero_or_denormal() so that code in
helper_compute_fprf() can be reused to work with float128 argument.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 4da991a..5a7aa75 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -47,15 +47,6 @@ uint32_t helper_float64_to_float32(CPUPPCState *env, uint64_t arg)
     return f.l;
 }
 
-static inline int isden(float64 d)
-{
-    CPU_DoubleU u;
-
-    u.d = d;
-
-    return ((u.ll >> 52) & 0x7FF) == 0;
-}
-
 static inline int ppc_float32_get_unbiased_exp(float32 f)
 {
     return ((f >> 23) & 0xFF) - 127;
@@ -96,7 +87,7 @@ void helper_compute_fprf(CPUPPCState *env, float64 arg)
                 fprf = 0x02;
             }
         } else {
-            if (isden(arg)) {
+            if (float64_is_zero_or_denormal(arg)) {
                 /* Denormalized numbers */
                 fprf = 0x10;
             } else {
-- 
2.7.4
