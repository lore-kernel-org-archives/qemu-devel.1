Received: from eggs.gnu.org ([2001:4830:134:3::10]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeT-00086J-SR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeS-00036D-UQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:32 +0100
Message-Id: <20181012144235.19646-8-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/10] target/arm: Implement HCR.PTW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

If the HCR_EL2 PTW virtualizaiton configuration register bit
is set, then this means that a stage 2 Permission fault must
be generated if a stage 1 translation table access is made
to an address that is mapped as Device memory in stage 2.
Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 78d05fe1e57..b5752d52dd1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9134,9 +9134,20 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
         hwaddr s2pa;
         int s2prot;
         int ret;
+        ARMCacheAttrs cacheattrs = {};
+        ARMCacheAttrs *pcacheattrs = NULL;
+
+        if (env->cp15.hcr_el2 & HCR_PTW) {
+            /*
+             * PTW means we must fault if this S1 walk touches S2 Device
+             * memory; otherwise we don't care about the attributes and can
+             * save the S2 translation the effort of computing them.
+             */
+            pcacheattrs = &cacheattrs;
+        }
 
         ret = get_phys_addr_lpae(env, addr, 0, ARMMMUIdx_S2NS, &s2pa,
-                                 &txattrs, &s2prot, &s2size, fi, NULL);
+                                 &txattrs, &s2prot, &s2size, fi, pcacheattrs);
         if (ret) {
             assert(fi->type != ARMFault_None);
             fi->s2addr = addr;
@@ -9144,6 +9155,14 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             fi->s1ptw = true;
             return ~0;
         }
+        if (pcacheattrs && (pcacheattrs->attrs & 0xf0) == 0) {
+            /* Access was to Device memory: generate Permission fault */
+            fi->type = ARMFault_Permission;
+            fi->s2addr = addr;
+            fi->stage2 = true;
+            fi->s1ptw = true;
+            return ~0;
+        }
         addr = s2pa;
     }
     return addr;
-- 
2.19.0
