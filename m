Received: from eggs.gnu.org ([2001:4830:134:3::10]:56675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB4-00013p-RD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB4-0002MG-0j
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:27 +0000
Message-Id: <1512503192-2239-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/12] target/arm: Convert
 get_phys_addr_pmsav7() to not return FSC values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefano Stabellini <sstabellini@kernel.org>

Make get_phys_addr_pmsav7() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 57286a7..0f5b161 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9126,7 +9126,8 @@ static inline bool m_is_system_region(CPUARMState *env, uint32_t address)
 
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 hwaddr *phys_ptr, int *prot, uint32_t *fsr)
+                                 hwaddr *phys_ptr, int *prot,
+                                 ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     int n;
@@ -9221,7 +9222,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
         if (n == -1) { /* no hits */
             if (!pmsav7_use_background_region(cpu, mmu_idx, is_user)) {
                 /* background fault */
-                *fsr = 0;
+                fi->type = ARMFault_Background;
                 return true;
             }
             get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
@@ -9279,7 +9280,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
         }
     }
 
-    *fsr = 0x00d; /* Permission fault */
+    fi->type = ARMFault_Permission;
+    fi->level = 1;
     return !(*prot & (1 << access_type));
 }
 
@@ -9824,7 +9826,8 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
-                                       phys_ptr, prot, fsr);
+                                       phys_ptr, prot, fi);
+            *fsr = arm_fi_to_sfsc(fi);
         } else {
             /* Pre-v7 MPU */
             ret = get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
-- 
2.7.4
