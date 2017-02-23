Received: from eggs.gnu.org ([2001:4830:134:3::10]:41124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVj-0005GV-8z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVf-0001iZ-8l
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVf-0001i1-0C
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:03 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJrc1Z112040
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:01 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t4yqkq43-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:01 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:26:57 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:26 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 01/15] target/ppc: introduce
 helper_update_ov_legacy
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

Removes duplicate code and will be useful for consolidating flags

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/int_helper.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index dd0a892..da4e1a6 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -28,6 +28,15 @@
 /*****************************************************************************/
 /* Fixed point operations helpers */
 
+static inline void helper_update_ov_legacy(CPUPPCState *env, int ov)
+{
+    if (unlikely(ov)) {
+        env->so = env->ov = 1;
+    } else {
+        env->ov = 0;
+    }
+}
+
 target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
                            uint32_t oe)
 {
@@ -49,11 +58,7 @@ target_ulong helper_divweu(CPUPPCState *env, target_ulong ra, target_ulong rb,
     }
 
     if (oe) {
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
+        helper_update_ov_legacy(env, overflow);
     }
 
     return (target_ulong)rt;
@@ -81,11 +86,7 @@ target_ulong helper_divwe(CPUPPCState *env, target_ulong ra, target_ulong rb,
     }
 
     if (oe) {
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
+        helper_update_ov_legacy(env, overflow);
     }
 
     return (target_ulong)rt;
@@ -105,11 +106,7 @@ uint64_t helper_divdeu(CPUPPCState *env, uint64_t ra, uint64_t rb, uint32_t oe)
     }
 
     if (oe) {
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
+        helper_update_ov_legacy(env, overflow);
     }
 
     return rt;
@@ -127,12 +124,7 @@ uint64_t helper_divde(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
     }
 
     if (oe) {
-
-        if (unlikely(overflow)) {
-            env->so = env->ov = 1;
-        } else {
-            env->ov = 0;
-        }
+        helper_update_ov_legacy(env, overflow);
     }
 
     return rt;
-- 
2.7.4
