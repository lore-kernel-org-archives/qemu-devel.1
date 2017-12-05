Received: from eggs.gnu.org ([2001:4830:134:3::10]:56677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB4-00013v-Ti
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB3-0002M5-SP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:28 +0000
Message-Id: <1512503192-2239-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/12] target/arm: Convert
 get_phys_addr_pmsav8() to not return FSC values
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

Make get_phys_addr_pmsav8() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0f5b161..fad4923 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9367,7 +9367,7 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
 static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                               MMUAccessType access_type, ARMMMUIdx mmu_idx,
                               hwaddr *phys_ptr, MemTxAttrs *txattrs,
-                              int *prot, uint32_t *fsr, uint32_t *mregion)
+                              int *prot, ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /* Perform a PMSAv8 MPU lookup (without also doing the SAU check
      * that a full phys-to-virt translation does).
@@ -9423,7 +9423,8 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                 /* Multiple regions match -- always a failure (unlike
                  * PMSAv7 where highest-numbered-region wins)
                  */
-                *fsr = 0x00d; /* permission fault */
+                fi->type = ARMFault_Permission;
+                fi->level = 1;
                 return true;
             }
 
@@ -9451,7 +9452,7 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
     if (!hit) {
         /* background fault */
-        *fsr = 0;
+        fi->type = ARMFault_Background;
         return true;
     }
 
@@ -9479,7 +9480,8 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
         }
     }
 
-    *fsr = 0x00d; /* Permission fault */
+    fi->type = ARMFault_Permission;
+    fi->level = 1;
     return !(*prot & (1 << access_type));
 }
 
@@ -9487,7 +9489,7 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, MemTxAttrs *txattrs,
-                                 int *prot, uint32_t *fsr)
+                                 int *prot, ARMMMUFaultInfo *fi)
 {
     uint32_t secure = regime_is_secure(env, mmu_idx);
     V8M_SAttributes sattrs = {};
@@ -9513,7 +9515,11 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
              * (including possibly emulating an SG instruction).
              */
             if (sattrs.ns != !secure) {
-                *fsr = sattrs.nsc ? M_FAKE_FSR_NSC_EXEC : M_FAKE_FSR_SFAULT;
+                if (sattrs.nsc) {
+                    fi->type = ARMFault_QEMU_NSCExec;
+                } else {
+                    fi->type = ARMFault_QEMU_SFault;
+                }
                 *phys_ptr = address;
                 *prot = 0;
                 return true;
@@ -9535,7 +9541,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
                  * If we added it we would need to do so as a special case
                  * for M_FAKE_FSR_SFAULT in arm_v7m_cpu_do_interrupt().
                  */
-                *fsr = M_FAKE_FSR_SFAULT;
+                fi->type = ARMFault_QEMU_SFault;
                 *phys_ptr = address;
                 *prot = 0;
                 return true;
@@ -9544,7 +9550,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env, uint32_t address,
     }
 
     return pmsav8_mpu_lookup(env, address, access_type, mmu_idx, phys_ptr,
-                             txattrs, prot, fsr, NULL);
+                             txattrs, prot, fi, NULL);
 }
 
 static bool get_phys_addr_pmsav5(CPUARMState *env, uint32_t address,
@@ -9822,7 +9828,8 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
             ret = get_phys_addr_pmsav8(env, address, access_type, mmu_idx,
-                                       phys_ptr, attrs, prot, fsr);
+                                       phys_ptr, attrs, prot, fi);
+            *fsr = arm_fi_to_sfsc(fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
@@ -10183,9 +10190,9 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     uint32_t tt_resp;
     bool r, rw, nsr, nsrw, mrvalid;
     int prot;
+    ARMMMUFaultInfo fi = {};
     MemTxAttrs attrs = {};
     hwaddr phys_addr;
-    uint32_t fsr;
     ARMMMUIdx mmu_idx;
     uint32_t mregion;
     bool targetpriv;
@@ -10219,7 +10226,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     if (arm_current_el(env) != 0 || alt) {
         /* We can ignore the return value as prot is always set */
         pmsav8_mpu_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
-                          &phys_addr, &attrs, &prot, &fsr, &mregion);
+                          &phys_addr, &attrs, &prot, &fi, &mregion);
         if (mregion == -1) {
             mrvalid = false;
             mregion = 0;
-- 
2.7.4
