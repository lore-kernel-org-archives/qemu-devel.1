Received: from eggs.gnu.org ([2001:4830:134:3::10]:56775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB8-00018s-Q2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB7-0002OV-QD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:54 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:24 +0000
Message-Id: <1512503192-2239-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 04/12] target/arm: Convert get_phys_addr_v6()
 to not return FSC values
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

Make get_phys_addr_v6() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6aed681..1e95e3d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8460,11 +8460,10 @@ do_fault:
 static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
-                             target_ulong *page_size, uint32_t *fsr,
-                             ARMMMUFaultInfo *fi)
+                             target_ulong *page_size, ARMMMUFaultInfo *fi)
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
-    int code;
+    int level = 1;
     uint32_t table;
     uint32_t desc;
     uint32_t xn;
@@ -8481,7 +8480,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
     /* Lookup l1 descriptor.  */
     if (!get_level1_table_address(env, mmu_idx, &table, address)) {
         /* Section translation fault if page walk is disabled by PD0 or PD1 */
-        code = 5;
+        fi->type = ARMFault_Translation;
         goto do_fault;
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
@@ -8491,7 +8490,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         /* Section translation fault, or attempt to use the encoding
          * which is Reserved on implementations without PXN.
          */
-        code = 5;
+        fi->type = ARMFault_Translation;
         goto do_fault;
     }
     if ((type == 1) || !(desc & (1 << 18))) {
@@ -8503,13 +8502,13 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
     } else {
         dacr = env->cp15.dacr_s;
     }
+    if (type == 1) {
+        level = 2;
+    }
     domain_prot = (dacr >> (domain * 2)) & 3;
     if (domain_prot == 0 || domain_prot == 2) {
-        if (type != 1) {
-            code = 9; /* Section domain fault.  */
-        } else {
-            code = 11; /* Page domain fault.  */
-        }
+        /* Section or Page domain fault */
+        fi->type = ARMFault_Domain;
         goto do_fault;
     }
     if (type != 1) {
@@ -8527,7 +8526,6 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         ap = ((desc >> 10) & 3) | ((desc >> 13) & 4);
         xn = desc & (1 << 4);
         pxn = desc & 1;
-        code = 13;
         ns = extract32(desc, 19, 1);
     } else {
         if (arm_feature(env, ARM_FEATURE_PXN)) {
@@ -8541,7 +8539,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         ap = ((desc >> 4) & 3) | ((desc >> 7) & 4);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
-            code = 7;
+            fi->type = ARMFault_Translation;
             goto do_fault;
         case 1: /* 64k page.  */
             phys_addr = (desc & 0xffff0000) | (address & 0xffff);
@@ -8557,7 +8555,6 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
             /* Never happens, but compiler isn't smart enough to tell.  */
             abort();
         }
-        code = 15;
     }
     if (domain_prot == 3) {
         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -8565,15 +8562,17 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         if (pxn && !regime_is_user(env, mmu_idx)) {
             xn = 1;
         }
-        if (xn && access_type == MMU_INST_FETCH)
+        if (xn && access_type == MMU_INST_FETCH) {
+            fi->type = ARMFault_Permission;
             goto do_fault;
+        }
 
         if (arm_feature(env, ARM_FEATURE_V6K) &&
                 (regime_sctlr(env, mmu_idx) & SCTLR_AFE)) {
             /* The simplified model uses AP[0] as an access control bit.  */
             if ((ap & 1) == 0) {
                 /* Access flag fault.  */
-                code = (code == 15) ? 6 : 3;
+                fi->type = ARMFault_AccessFlag;
                 goto do_fault;
             }
             *prot = simple_ap_to_rw_prot(env, mmu_idx, ap >> 1);
@@ -8585,6 +8584,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         }
         if (!(*prot & (1 << access_type))) {
             /* Access permission fault.  */
+            fi->type = ARMFault_Permission;
             goto do_fault;
         }
     }
@@ -8598,7 +8598,8 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
     *phys_ptr = phys_addr;
     return false;
 do_fault:
-    *fsr = code | (domain << 4);
+    fi->domain = domain;
+    fi->level = level;
     return true;
 }
 
@@ -9860,8 +9861,11 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         return get_phys_addr_lpae(env, address, access_type, mmu_idx, phys_ptr,
                                   attrs, prot, page_size, fsr, fi, cacheattrs);
     } else if (regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-        return get_phys_addr_v6(env, address, access_type, mmu_idx, phys_ptr,
-                                attrs, prot, page_size, fsr, fi);
+        bool ret = get_phys_addr_v6(env, address, access_type, mmu_idx,
+                                    phys_ptr, attrs, prot, page_size, fi);
+
+        *fsr = arm_fi_to_sfsc(fi);
+        return ret;
     } else {
         bool ret = get_phys_addr_v5(env, address, access_type, mmu_idx,
                                     phys_ptr, prot, page_size, fi);
-- 
2.7.4
