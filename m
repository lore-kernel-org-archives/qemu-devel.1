Received: from eggs.gnu.org ([2001:4830:134:3::10]:46163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7f-0007tx-1W
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7e-0008S2-2B
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:20 +1100
Message-Id: <20170301044405.1792-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/50] target/ppc: introduce
 helper_update_ov_legacy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Removes duplicate code and will be useful for consolidating flags

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
