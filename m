Received: from eggs.gnu.org ([209.51.188.92]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wSW-0006jg-Gs
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wSS-0005H2-G2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:26 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wSL-0004sR-Ph
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:05:20 -0500
Received: by mail-pf1-x42a.google.com with SMTP id i19so11905557pfd.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:05:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:39 -0800
Message-Id: <20190307170440.3113-22-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 21/22] target/arm: Add allocation tag
 storage for system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 6d0f82eb99..6657f57ca6 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -28,8 +28,64 @@
 static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
                                    bool write, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
     /* Tag storage not implemented.  */
     return NULL;
+#else
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    uintptr_t index;
+    int mmu_idx;
+    CPUTLBEntry *te;
+    CPUIOTLBEntry *iotlbentry;
+    MemoryRegionSection *section;
+    hwaddr physaddr, tag_physaddr;
+
+    /*
+     * Find the TLB entry for this access.
+     * As a side effect, this also raises an exception for invalid access.
+     */
+    mmu_idx = cpu_mmu_index(env, false);
+    index = tlb_index(env, mmu_idx, ptr);
+    te = tlb_entry(env, mmu_idx, ptr);
+    if (!tlb_hit(write ? tlb_addr_write(te) : te->addr_read, ptr)) {
+        /* ??? Expose VICTIM_TLB_HIT from accel/tcg/cputlb.c.  */
+        tlb_fill(cs, ptr, 16, write ? MMU_DATA_STORE : MMU_DATA_LOAD,
+                 mmu_idx, ra);
+        index = tlb_index(env, mmu_idx, ptr);
+        te = tlb_entry(env, mmu_idx, ptr);
+    }
+
+    /* If the virtual page MemAttr != Tagged, nothing to do.  */
+    iotlbentry = &env->iotlb[mmu_idx][index];
+    if (!iotlbentry->attrs.target_tlb_bit1) {
+        return NULL;
+    }
+
+    /* If the board did not allocate tag memory, nothing to do.  */
+    if (!cpu_get_address_space(cs, ARMASIdx_TAG)) {
+        return NULL;
+    }
+
+    /* Find the physical address for the virtual access.  */
+    section = iotlb_to_section(cs, iotlbentry->addr, iotlbentry->attrs);
+    physaddr = ((iotlbentry->addr & TARGET_PAGE_MASK) + ptr
+                + section->offset_within_address_space
+                - section->offset_within_region);
+    tag_physaddr = physaddr >> (LOG2_TAG_GRANULE + 1);
+
+    /* Find the memory backing the tag address in tag address space.  */
+    mmu_idx = arm_to_core_mmu_idx(ARMMMUIdx_TagNS);
+    te = tlb_entry(env, mmu_idx, tag_physaddr);
+    if (!tlb_hit(write ? tlb_addr_write(te) : te->addr_read, tag_physaddr)) {
+        /* ??? Expose VICTIM_TLB_HIT from accel/tcg/cputlb.c.  */
+        tlb_fill(cs, tag_physaddr, 1, write ? MMU_DATA_STORE : MMU_DATA_LOAD,
+                 mmu_idx, ra);
+        te = tlb_entry(env, mmu_idx, tag_physaddr);
+    }
+
+    return (void *)(tag_physaddr + te->addend);
+#endif
 }
 
 static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
-- 
2.17.2
