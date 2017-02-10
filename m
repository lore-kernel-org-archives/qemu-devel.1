Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZK-0007QI-Ld
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZH-0000PB-Fw
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cc5ZH-0000Oo-6L
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:31 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A7NbVq009887
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:30 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28h2df52y8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:29 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 17:24:27 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2017 12:53:11 +0530
In-Reply-To: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486711391-12247-8-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 7/7] target-s390: Use float128_to_uint[64/32]
 where required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

Use float126_to_uint[64/32] instead of using int versions of the same.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/fpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index e604e9f..9aa94d9 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -515,8 +515,7 @@ uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
     int hold = swap_round_mode(env, m3);
     float128 v2 = make_float128(h, l);
-    /* ??? Not 100% correct.  */
-    uint64_t ret = float128_to_int64(v2, &env->fpu_status);
+    uint64_t ret = float128_to_uint64(v2, &env->fpu_status);
     set_float_rounding_mode(hold, &env->fpu_status);
     handle_exceptions(env, GETPC());
     return ret;
@@ -547,8 +546,7 @@ uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
 {
     int hold = swap_round_mode(env, m3);
     float128 v2 = make_float128(h, l);
-    /* Not 100% correct.  */
-    uint32_t ret = float128_to_int64(v2, &env->fpu_status);
+    uint32_t ret = float128_to_uint32(v2, &env->fpu_status);
     set_float_rounding_mode(hold, &env->fpu_status);
     handle_exceptions(env, GETPC());
     return ret;
-- 
2.7.4
