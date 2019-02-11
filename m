Received: from eggs.gnu.org ([209.51.188.92]:37689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05w-0005yH-Oo
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gt05s-00008Z-EZ
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:12 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gt05s-0008T0-1d
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 20:09:08 -0500
Received: by mail-pl1-x644.google.com with SMTP id e5so4510889plb.5
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 17:09:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 10 Feb 2019 17:08:27 -0800
Message-Id: <20190211010829.29869-25-richard.henderson@linaro.org>
In-Reply-To: <20190211010829.29869-1-richard.henderson@linaro.org>
References: <20190211010829.29869-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 24/26] target/arm: Add allocation tag
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/mte_helper.c | 96 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index ad2902472d..3abed62018 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -53,19 +53,19 @@ static uint64_t strip_tbi(CPUARMState *env, uint64_t ptr)
 static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
                                    bool write, uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
     ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
     uint64_t clean_ptr = strip_tbi(env, ptr);
     uint8_t *tags;
     uintptr_t index;
-    int flags;
 
-    flags = page_get_flags(clean_ptr);
+#ifdef CONFIG_USER_ONLY
+    int flags = page_get_flags(clean_ptr);
 
     if (!(flags & PAGE_VALID) || !(flags & (write ? PAGE_WRITE : PAGE_READ))) {
         /* SIGSEGV */
         env->exception.vaddress = ptr;
-        cpu_restore_state(CPU(cpu), ra, true);
+        cpu_restore_state(cs, ra, true);
         raise_exception(env, EXCP_DATA_ABORT, 0, 1);
     }
 
@@ -82,16 +82,94 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
     if (tags == NULL) {
         size_t alloc_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
         tags = page_alloc_target_data(clean_ptr, alloc_size);
-        assert(tags != NULL);
+    }
+#else
+    int mmu_idx;
+    AddressSpace *as;
+    CPUTLBEntry *te;
+    CPUIOTLBEntry *iotlbentry;
+    MemoryRegionSection *section;
+    MemoryRegion *mr;
+    FlatView *fv;
+    hwaddr physaddr, tag_physaddr, tag_len, xlat;
+
+    /*
+     * Find the TLB entry for this access.
+     * As a side effect, this also raises an exception for invalid access.
+     */
+    mmu_idx = cpu_mmu_index(env, false);
+    index = tlb_index(env, mmu_idx, clean_ptr);
+    te = tlb_entry(env, mmu_idx, clean_ptr);
+    if (!tlb_hit(write ? tlb_addr_write(te) : te->addr_read, clean_ptr)) {
+        /* ??? Expose VICTIM_TLB_HIT from accel/tcg/cputlb.c.  */
+        tlb_fill(cs, ptr, 16, write ? MMU_DATA_STORE : MMU_DATA_LOAD,
+                 mmu_idx, ra);
+        index = tlb_index(env, mmu_idx, clean_ptr);
+        te = tlb_entry(env, mmu_idx, clean_ptr);
     }
 
+    /* If the virtual page MemAttr != Tagged, nothing to do.  */
+    iotlbentry = &env->iotlb[mmu_idx][index];
+    if (!iotlbentry->attrs.target_tlb_bit1) {
+        return NULL;
+    }
+
+    /* If the board did not allocate tag memory, nothing to do.  */
+    as = cpu_get_address_space(cs, ARMASIdx_TAG);
+    if (!as) {
+        return NULL;
+    }
+
+    /* Find the physical address for the virtual access.  */
+    section = iotlb_to_section(cs, iotlbentry->addr, iotlbentry->attrs);
+    physaddr = ((iotlbentry->addr & TARGET_PAGE_MASK) + clean_ptr
+                + section->offset_within_address_space
+                - section->offset_within_region);
+
+    /* Convert to the physical address in tag space.  */
+    tag_physaddr = physaddr >> (LOG2_TAG_GRANULE + 1);
+    tag_len = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
+
+    /*
+     * Find the tag physical address within the tag address space.
+     *
+     * ??? Create a new mmu_idx to cache the rest of this.
+     *
+     * ??? If we were assured of exactly one block of normal ram,
+     * and thus exactly one block of tag ram, then we could validate
+     * section->mr as ram, use the section offset vs cpu->tag_memory,
+     * and finish with memory_region_get_ram_ptr.
+     */
+    rcu_read_lock();
+    fv = address_space_to_flatview(as);
+    mr = flatview_translate(fv, tag_physaddr, &xlat, &tag_len,
+                            write, MEMTXATTRS_UNSPECIFIED);
+    if (!memory_access_is_direct(mr, write)) {
+        /*
+         * This would seem to imply that the guest has marked a
+         * virtual page as Tagged when the physical page is not RAM.
+         * Should this raise some sort of bus error?
+         */
+        rcu_read_unlock();
+        qemu_log_mask(LOG_GUEST_ERROR, "Tagged virtual page 0x%" PRIx64
+                      " maps to physical page 0x%" PRIx64 " without RAM\n",
+                      clean_ptr, physaddr);
+        return NULL;
+    }
+    rcu_read_unlock();
+
+    /* The board should have created tag ram sized correctly.  */
+    assert(tag_len == TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1));
+
+    /* FIXME: Mark the tag page dirty for migration.  */
+
+    tags = qemu_map_ram_ptr(mr->ram_block, xlat);
+#endif
+
+    assert(tags != NULL);
     index = extract32(clean_ptr, LOG2_TAG_GRANULE + 1,
                       TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
     return tags + index;
-#else
-    /* Tag storage not implemented.  */
-    return NULL;
-#endif
 }
 
 static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
-- 
2.17.2
