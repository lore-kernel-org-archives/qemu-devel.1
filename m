Received: from eggs.gnu.org ([2001:4830:134:3::10]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWk-0004ud-RF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWj-00086z-Ul
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWj-00084T-NI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:05 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWi-0007mc-FF
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:29 +0000
Message-Id: <1513188761-20784-32-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 31/43] target/arm: Convert
 get_phys_addr_pmsav7() to not return FSC values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make get_phys_addr_pmsav7() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Message-id: 1512503192-2239-8-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b08910b..2752d9e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9123,7 +9123,8 @@ static inline bool m_is_system_region(CPUARMState *env, uint32_t address)
 
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 hwaddr *phys_ptr, int *prot, uint32_t *fsr)
+                                 hwaddr *phys_ptr, int *prot,
+                                 ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
     int n;
@@ -9218,7 +9219,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
         if (n == -1) { /* no hits */
             if (!pmsav7_use_background_region(cpu, mmu_idx, is_user)) {
                 /* background fault */
-                *fsr = 0;
+                fi->type = ARMFault_Background;
                 return true;
             }
             get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
@@ -9276,7 +9277,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
         }
     }
 
-    *fsr = 0x00d; /* Permission fault */
+    fi->type = ARMFault_Permission;
+    fi->level = 1;
     return !(*prot & (1 << access_type));
 }
 
@@ -9821,7 +9823,8 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
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
