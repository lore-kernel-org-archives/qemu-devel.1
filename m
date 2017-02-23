Received: from eggs.gnu.org ([2001:4830:134:3::10]:41128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVj-0005Gh-Ak
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVf-0001iX-8S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVf-0001i2-05
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:03 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJtFFT061362
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:01 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sp4jsshj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:01 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:26:58 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:27 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 02/15] target/ppc: update ov flag from
 remaining paths
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

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/int_helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index da4e1a6..b376860 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -320,22 +320,24 @@ target_ulong helper_divo(CPUPPCState *env, target_ulong arg1,
                          target_ulong arg2)
 {
     uint64_t tmp = (uint64_t)arg1 << 32 | env->spr[SPR_MQ];
+    int ov;
 
     if (((int32_t)tmp == INT32_MIN && (int32_t)arg2 == (int32_t)-1) ||
         (int32_t)arg2 == 0) {
-        env->so = env->ov = 1;
+        ov = 1;
         env->spr[SPR_MQ] = 0;
         return INT32_MIN;
     } else {
         env->spr[SPR_MQ] = tmp % arg2;
         tmp /= (int32_t)arg2;
         if ((int32_t)tmp != tmp) {
-            env->so = env->ov = 1;
+            ov = 1;
         } else {
-            env->ov = 0;
+            ov = 0;
         }
         return tmp;
     }
+    helper_update_ov_legacy(env, ov);
 }
 
 target_ulong helper_divs(CPUPPCState *env, target_ulong arg1,
@@ -356,11 +358,11 @@ target_ulong helper_divso(CPUPPCState *env, target_ulong arg1,
 {
     if (((int32_t)arg1 == INT32_MIN && (int32_t)arg2 == (int32_t)-1) ||
         (int32_t)arg2 == 0) {
-        env->so = env->ov = 1;
+        helper_update_ov_legacy(env, 1);
         env->spr[SPR_MQ] = 0;
         return INT32_MIN;
     } else {
-        env->ov = 0;
+        helper_update_ov_legacy(env, 0);
         env->spr[SPR_MQ] = (int32_t)arg1 % (int32_t)arg2;
         return (int32_t)arg1 / (int32_t)arg2;
     }
-- 
2.7.4
