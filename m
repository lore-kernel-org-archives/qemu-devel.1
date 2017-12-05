Received: from eggs.gnu.org ([2001:4830:134:3::10]:56797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB9-00019n-IV
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJB8-0002PC-JX
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:55 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:23 +0000
Message-Id: <1512503192-2239-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/12] target/arm: Convert get_phys_addr_v5()
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

Make get_phys_addr_v5() return a fault type in the ARMMMUFaultInfo
structure, which we convert to the FSC at the callsite.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 30616d9..6aed681 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8344,11 +8344,11 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
 static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              hwaddr *phys_ptr, int *prot,
-                             target_ulong *page_size, uint32_t *fsr,
+                             target_ulong *page_size,
                              ARMMMUFaultInfo *fi)
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
-    int code;
+    int level = 1;
     uint32_t table;
     uint32_t desc;
     int type;
@@ -8362,7 +8362,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
     /* Lookup l1 descriptor.  */
     if (!get_level1_table_address(env, mmu_idx, &table, address)) {
         /* Section translation fault if page walk is disabled by PD0 or PD1 */
-        code = 5;
+        fi->type = ARMFault_Translation;
         goto do_fault;
     }
     desc = arm_ldl_ptw(cs, table, regime_is_secure(env, mmu_idx),
@@ -8377,21 +8377,20 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
     domain_prot = (dacr >> (domain * 2)) & 3;
     if (type == 0) {
         /* Section translation fault.  */
-        code = 5;
+        fi->type = ARMFault_Translation;
         goto do_fault;
     }
+    if (type != 2) {
+        level = 2;
+    }
     if (domain_prot == 0 || domain_prot == 2) {
-        if (type == 2)
-            code = 9; /* Section domain fault.  */
-        else
-            code = 11; /* Page domain fault.  */
+        fi->type = ARMFault_Domain;
         goto do_fault;
     }
     if (type == 2) {
         /* 1Mb section.  */
         phys_addr = (desc & 0xfff00000) | (address & 0x000fffff);
         ap = (desc >> 10) & 3;
-        code = 13;
         *page_size = 1024 * 1024;
     } else {
         /* Lookup l2 entry.  */
@@ -8406,7 +8405,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
                            mmu_idx, fi);
         switch (desc & 3) {
         case 0: /* Page translation fault.  */
-            code = 7;
+            fi->type = ARMFault_Translation;
             goto do_fault;
         case 1: /* 64k page.  */
             phys_addr = (desc & 0xffff0000) | (address & 0xffff);
@@ -8429,7 +8428,7 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
                     /* UNPREDICTABLE in ARMv5; we choose to take a
                      * page translation fault.
                      */
-                    code = 7;
+                    fi->type = ARMFault_Translation;
                     goto do_fault;
                 }
             } else {
@@ -8442,18 +8441,19 @@ static bool get_phys_addr_v5(CPUARMState *env, uint32_t address,
             /* Never happens, but compiler isn't smart enough to tell.  */
             abort();
         }
-        code = 15;
     }
     *prot = ap_to_rw_prot(env, mmu_idx, ap, domain_prot);
     *prot |= *prot ? PAGE_EXEC : 0;
     if (!(*prot & (1 << access_type))) {
         /* Access permission fault.  */
+        fi->type = ARMFault_Permission;
         goto do_fault;
     }
     *phys_ptr = phys_addr;
     return false;
 do_fault:
-    *fsr = code | (domain << 4);
+    fi->domain = domain;
+    fi->level = level;
     return true;
 }
 
@@ -9863,8 +9863,11 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         return get_phys_addr_v6(env, address, access_type, mmu_idx, phys_ptr,
                                 attrs, prot, page_size, fsr, fi);
     } else {
-        return get_phys_addr_v5(env, address, access_type, mmu_idx, phys_ptr,
-                                prot, page_size, fsr, fi);
+        bool ret = get_phys_addr_v5(env, address, access_type, mmu_idx,
+                                    phys_ptr, prot, page_size, fi);
+
+        *fsr = arm_fi_to_sfsc(fi);
+        return ret;
     }
 }
 
-- 
2.7.4
