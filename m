Received: from eggs.gnu.org ([2001:4830:134:3::10]:51685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWj-0004td-Tv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWi-00085s-Vr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:05 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWi-00084T-On
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:04 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWh-0007mL-PM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:28 +0000
Message-Id: <1513188761-20784-31-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 30/43] target/arm: Convert
 get_phys_addr_pmsav5() to not return FSC values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make get_phys_addr_pmsav5() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Note that PMSAv5 does not define any guest-visible fault status
register, so the different "fsr" values we were previously
returning are entirely arbitrary. So we can just switch to using
the most appropriae fi->type values without worrying that we
need to special-case FaultInfo->FSC conversion for PMSAv5.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Stefano Stabellini <sstabellini@kernel.org>
Message-id: 1512503192-2239-7-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce9cb6f..b08910b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9544,7 +9544,8 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
 
 static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                                 hwaddr *phys_ptr, int *prot, uint32_t *fsr)
+                                 hwaddr *phys_ptr, int *prot,
+                                 ARMMMUFaultInfo *fi)
 {
     int n;
     uint32_t mask;
@@ -9573,7 +9574,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
         }
     }
     if (n < 0) {
-        *fsr = 2;
+        fi->type = ARMFault_Background;
         return true;
     }
 
@@ -9585,11 +9586,13 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
     mask = (mask >> (n * 4)) & 0xf;
     switch (mask) {
     case 0:
-        *fsr = 1;
+        fi->type = ARMFault_Permission;
+        fi->level = 1;
         return true;
     case 1:
         if (is_user) {
-            *fsr = 1;
+            fi->type = ARMFault_Permission;
+            fi->level = 1;
             return true;
         }
         *prot = PAGE_READ | PAGE_WRITE;
@@ -9605,7 +9608,8 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
         break;
     case 5:
         if (is_user) {
-            *fsr = 1;
+            fi->type = ARMFault_Permission;
+            fi->level = 1;
             return true;
         }
         *prot = PAGE_READ;
@@ -9615,7 +9619,8 @@ static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
         break;
     default:
         /* Bad permission.  */
-        *fsr = 1;
+        fi->type = ARMFault_Permission;
+        fi->level = 1;
         return true;
     }
     *prot |= PAGE_EXEC;
@@ -9820,7 +9825,8 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         } else {
             /* Pre-v7 MPU */
             ret = get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
-                                       phys_ptr, prot, fsr);
+                                       phys_ptr, prot, fi);
+            *fsr = arm_fi_to_sfsc(fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
                       " mmu_idx %u -> %s (prot %c%c%c)\n",
-- 
2.7.4
