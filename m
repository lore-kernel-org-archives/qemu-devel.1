Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAl-0006HH-Mk
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwh-0003xD-Cq
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:51 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:40 +0100
Message-Id: <20181113165247.4806-7-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/13] target: arm: Make ARM TLB filling
 routine static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org

It's only used in op_helper.c, it does not need to be exported and
moreover it should only be build when TCG is enabled.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
---
 target/arm/internals.h |  5 -----
 target/arm/helper.c    | 37 -------------------------------------
 target/arm/op_helper.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ffb5091b1f..06439467d2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -741,11 +741,6 @@ static inline bool arm_extabort_type(MemTxResult result)
     return result != MEMTX_DECODE_ERROR;
 }
 
-/* Do a page table walk and add page to TLB if possible */
-bool arm_tlb_fill(CPUState *cpu, vaddr address,
-                  MMUAccessType access_type, int mmu_idx,
-                  ARMMMUFaultInfo *fi);
-
 /* Return true if the stage 1 translation regime is using LPAE format page
  * tables */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bc2c8cdb67..689879c23a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8855,43 +8855,6 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 }
 
-/* Walk the page table and (if the mapping exists) add the page
- * to the TLB. Return false on success, or true on failure. Populate
- * fsr with ARM DFSR/IFSR fault register format value on failure.
- */
-bool arm_tlb_fill(CPUState *cs, vaddr address,
-                  MMUAccessType access_type, int mmu_idx,
-                  ARMMMUFaultInfo *fi)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    hwaddr phys_addr;
-    target_ulong page_size;
-    int prot;
-    int ret;
-    MemTxAttrs attrs = {};
-
-    ret = get_phys_addr(env, address, access_type,
-                        core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
-                        &attrs, &prot, &page_size, fi, NULL);
-    if (!ret) {
-        /*
-         * Map a single [sub]page. Regions smaller than our declared
-         * target page size are handled specially, so for those we
-         * pass in the exact addresses.
-         */
-        if (page_size >= TARGET_PAGE_SIZE) {
-            phys_addr &= TARGET_PAGE_MASK;
-            address &= TARGET_PAGE_MASK;
-        }
-        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
-                                prot, mmu_idx, page_size);
-        return 0;
-    }
-
-    return ret;
-}
-
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 44a74cb296..3b0459db50 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -179,6 +179,44 @@ static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
     raise_exception(env, exc, syn, target_el);
 }
 
+/* Walk the page table and (if the mapping exists) add the page
+ * to the TLB. Return false on success, or true on failure. Populate
+ * fsr with ARM DFSR/IFSR fault register format value on failure.
+ */
+static bool arm_tlb_fill(CPUState *cs, vaddr address,
+                         MMUAccessType access_type, int mmu_idx,
+                         ARMMMUFaultInfo *fi)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    hwaddr phys_addr;
+    target_ulong page_size;
+    int prot;
+    int ret;
+    MemTxAttrs attrs = {};
+
+    ret = get_phys_addr(env, address, access_type,
+                        core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
+                        &attrs, &prot, &page_size, fi, NULL);
+    if (!ret) {
+        /*
+         * Map a single [sub]page. Regions smaller than our declared
+         * target page size are handled specially, so for those we
+         * pass in the exact addresses.
+         */
+        if (page_size >= TARGET_PAGE_SIZE) {
+            phys_addr &= TARGET_PAGE_MASK;
+            address &= TARGET_PAGE_MASK;
+        }
+        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
+                                prot, mmu_idx, page_size);
+        return 0;
+    }
+
+    return ret;
+}
+
+
 /* try to fill the TLB and return an exception if error. If retaddr is
  * NULL, it means that the function was called in C code (i.e. not
  * from generated code or from helper.c)
-- 
2.19.1
