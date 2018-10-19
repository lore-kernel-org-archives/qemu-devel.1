Received: from eggs.gnu.org ([2001:4830:134:3::10]:48937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8D-0003e8-Ud
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY8C-0005GF-VR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY8C-0002Jh-DU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5y-0006jH-UX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:07 +0100
Message-Id: <20181019165735.22511-18-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/45] target/arm: Implement HCR.PTW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the HCR_EL2 PTW virtualizaiton configuration register bit
is set, then this means that a stage 2 Permission fault must
be generated if a stage 1 translation table access is made
to an address that is mapped as Device memory in stage 2.
Implement this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181012144235.19646-8-peter.maydell@linaro.org
---
 target/arm/helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index af2f63c31b0..1928d3fadd9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9141,9 +9141,20 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
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
@@ -9151,6 +9162,14 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
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
2.19.1
