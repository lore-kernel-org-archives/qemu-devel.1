Received: from eggs.gnu.org ([2001:4830:134:3::10]:55061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2P-000800-7X
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fVd2N-0002mq-S5
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:06:18 +0100
Message-Id: <20180620130619.11362-3-peter.maydell@linaro.org>
In-Reply-To: <20180620130619.11362-1-peter.maydell@linaro.org>
References: <20180620130619.11362-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] target/arm: Set page (region) size in
 get_phys_addr_pmsav7()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

We want to handle small MPU region sizes for ARMv7M. To do this,
make get_phys_addr_pmsav7() set the page size to the region
size if it is less that TARGET_PAGE_SIZE, rather than working
only in TARGET_PAGE_SIZE chunks.

Since the core TCG code con't handle execution from small
MPU regions, we strip the exec permission from them so that
any execution attempts will cause an MPU exception, rather
than allowing it to end up with a cpu_abort() in
get_page_addr_code().

(The previous code's intention was to make any small page be
treated as having no permissions, but unfortunately errors
in the implementation meant that it didn't behave that way.
It's possible that some binaries using small regions were
accidentally working with our old behaviour and won't now.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1248d84e6fa..a7edeb66633 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9596,6 +9596,7 @@ static inline bool m_is_system_region(CPUARMState *env, uint32_t address)
 static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                                  MMUAccessType access_type, ARMMMUIdx mmu_idx,
                                  hwaddr *phys_ptr, int *prot,
+                                 target_ulong *page_size,
                                  ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -9603,6 +9604,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
     bool is_user = regime_is_user(env, mmu_idx);
 
     *phys_ptr = address;
+    *page_size = TARGET_PAGE_SIZE;
     *prot = 0;
 
     if (regime_translation_disabled(env, mmu_idx) ||
@@ -9675,16 +9677,12 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
                     rsize++;
                 }
             }
-            if (rsize < TARGET_PAGE_BITS) {
-                qemu_log_mask(LOG_UNIMP,
-                              "DRSR[%d]: No support for MPU (sub)region size of"
-                              " %" PRIu32 " bytes. Minimum is %d.\n",
-                              n, (1 << rsize), TARGET_PAGE_SIZE);
-                continue;
-            }
             if (srdis) {
                 continue;
             }
+            if (rsize < TARGET_PAGE_BITS) {
+                *page_size = 1 << rsize;
+            }
             break;
         }
 
@@ -9765,6 +9763,17 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
+    /*
+     * Core QEMU code can't handle execution from small pages yet, so
+     * don't try it. This way we'll get an MPU exception, rather than
+     * eventually causing QEMU to exit in get_page_addr_code().
+     */
+    if (*page_size < TARGET_PAGE_SIZE && (*prot & PAGE_EXEC)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "MPU: No support for execution from regions "
+                      "smaller than 1K\n");
+        *prot &= ~PAGE_EXEC;
+    }
     return !(*prot & (1 << access_type));
 }
 
@@ -10334,7 +10343,7 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
             ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
-                                       phys_ptr, prot, fi);
+                                       phys_ptr, prot, page_size, fi);
         } else {
             /* Pre-v7 MPU */
             ret = get_phys_addr_pmsav5(env, address, access_type, mmu_idx,
@@ -10396,9 +10405,15 @@ bool arm_tlb_fill(CPUState *cs, vaddr address,
                         core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
                         &attrs, &prot, &page_size, fi, NULL);
     if (!ret) {
-        /* Map a single [sub]page.  */
-        phys_addr &= TARGET_PAGE_MASK;
-        address &= TARGET_PAGE_MASK;
+        /*
+         * Map a single [sub]page. Regions smaller than our declared
+         * target page size are handled specially, so for those we
+         * pass in the exact addresses.
+         */
+        if (page_size >= TARGET_PAGE_SIZE) {
+            phys_addr &= TARGET_PAGE_MASK;
+            address &= TARGET_PAGE_MASK;
+        }
         tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
                                 prot, mmu_idx, page_size);
         return 0;
-- 
2.17.1
