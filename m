Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jy-0007ZL-QB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9ju-0003z7-Tb
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:50 +1100
Message-Id: <20170202051445.5735-53-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 052/107] target-ppc: Replace isden by
 float64_is_zero_or_denormal
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

Replace isden() by float64_is_zero_or_denormal() so that code in
helper_compute_fprf() can be reused to work with float128 argument.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
