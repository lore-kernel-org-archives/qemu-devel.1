Received: from eggs.gnu.org ([2001:4830:134:3::10]:41160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVk-0005JT-1Q
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVh-0001jl-BC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVh-0001jC-2u
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJrbcY051262
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:04 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t61r0t18-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:03 -0500
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:26:59 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:28 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 03/15] target/ppc: introduce
 helper_update_ca_legacy
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

Update the environment carry variable in the helper.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/int_helper.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b376860..d7af671 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -37,6 +37,11 @@ static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
     }
 }
 
+static inline void helper_update_ca(CPUPPCState *env, int ca)
+{
+    env->ca = ca;
+}
+
 target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
                            uint32_t oe)
 {
@@ -213,24 +218,26 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
                          target_ulong shift)
 {
     int32_t ret;
+    int ca;
 
     if (likely(!(shift & 0x20))) {
         if (likely((uint32_t)shift != 0)) {
             shift &= 0x1f;
             ret = (int32_t)value >> shift;
             if (likely(ret >= 0 || (value & ((1 << shift) - 1)) == 0)) {
-                env->ca = 0;
+                ca = 0;
             } else {
-                env->ca = 1;
+                ca = 1;
             }
         } else {
             ret = (int32_t)value;
-            env->ca = 0;
+            ca = 0;
         }
     } else {
         ret = (int32_t)value >> 31;
-        env->ca = (ret != 0);
+        ca = (ret != 0);
     }
+    helper_update_ca(env, ca);
     return (target_long)ret;
 }
 
@@ -239,24 +246,26 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
                          target_ulong shift)
 {
     int64_t ret;
+    int ca;
 
     if (likely(!(shift & 0x40))) {
         if (likely((uint64_t)shift != 0)) {
             shift &= 0x3f;
             ret = (int64_t)value >> shift;
             if (likely(ret >= 0 || (value & ((1ULL << shift) - 1)) == 0)) {
-                env->ca = 0;
+                ca = 0;
             } else {
-                env->ca = 1;
+                ca = 1;
             }
         } else {
             ret = (int64_t)value;
-            env->ca = 0;
+            ca = 0;
         }
     } else {
         ret = (int64_t)value >> 63;
-        env->ca = (ret != 0);
+        ca = (ret != 0);
     }
+    helper_update_ca(env, ca);
     return ret;
 }
 #endif
-- 
2.7.4
