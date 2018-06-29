Received: from eggs.gnu.org ([2001:4830:134:3::10]:37331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZ14q-0007oe-Tg
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZ14l-0000kj-Ru
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:37:12 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZ14l-0000jP-It
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 17:37:07 -0400
Received: by mail-pg0-x244.google.com with SMTP id w8-v6so4516135pgp.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 14:37:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Jun 2018 14:37:03 -0700
Message-Id: <20180629213703.13833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] accel/tcg: Avoid caching overwritten tlb
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu

When installing a TLB entry, remove any cached version of the
same page in the VTLB.  If the existing TLB entry matches, do
not copy into the VTLB, but overwrite it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

This may fix some problems with Q800 that Laurent reported.

On IRC, Peter suggested that regardless of the m68k ptest insn, we
need to be more careful with installed TLB entries.

I added some temporary logging and concur.  This sort of overwrite
happens often when writable pages are marked read-only in order to
track a dirty bit.  After the dirty bit is set, we re-install the
TLB entry as read-write.

I'm mildly surprised we haven't run into problems before...


r~

---
 accel/tcg/cputlb.c | 60 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cc90a5fe92..250b024c5d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -235,17 +235,30 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     async_safe_run_on_cpu(src_cpu, fn, RUN_ON_CPU_HOST_INT(idxmap));
 }
 
-
-
-static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong addr)
+static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
+                                        target_ulong page)
 {
-    if (tlb_hit_page(tlb_entry->addr_read, addr) ||
-        tlb_hit_page(tlb_entry->addr_write, addr) ||
-        tlb_hit_page(tlb_entry->addr_code, addr)) {
+    return (tlb_hit_page(tlb_entry->addr_read, page) ||
+            tlb_hit_page(tlb_entry->addr_write, page) ||
+            tlb_hit_page(tlb_entry->addr_code, page));
+}
+
+static inline void tlb_flush_entry(CPUTLBEntry *tlb_entry, target_ulong page)
+{
+    if (tlb_hit_page_anyprot(tlb_entry, page)) {
         memset(tlb_entry, -1, sizeof(*tlb_entry));
     }
 }
 
+static inline void tlb_flush_vtlb_page(CPUArchState *env, int mmu_idx,
+                                       target_ulong page)
+{
+    int k;
+    for (k = 0; k < CPU_VTLB_SIZE; k++) {
+        tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], page);
+    }
+}
+
 static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
 {
     CPUArchState *env = cpu->env_ptr;
@@ -271,14 +284,7 @@ static void tlb_flush_page_async_work(CPUState *cpu, run_on_cpu_data data)
     i = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         tlb_flush_entry(&env->tlb_table[mmu_idx][i], addr);
-    }
-
-    /* check whether there are entries that need to be flushed in the vtlb */
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        int k;
-        for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_flush_entry(&env->tlb_v_table[mmu_idx][k], addr);
-        }
+        tlb_flush_vtlb_page(env, mmu_idx, addr);
     }
 
     tb_flush_jmp_cache(cpu, addr);
@@ -310,7 +316,6 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     unsigned long mmu_idx_bitmap = addr_and_mmuidx & ALL_MMUIDX_BITS;
     int page = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     int mmu_idx;
-    int i;
 
     assert_cpu_is_self(cpu);
 
@@ -320,11 +325,7 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
             tlb_flush_entry(&env->tlb_table[mmu_idx][page], addr);
-
-            /* check whether there are vltb entries that need to be flushed */
-            for (i = 0; i < CPU_VTLB_SIZE; i++) {
-                tlb_flush_entry(&env->tlb_v_table[mmu_idx][i], addr);
-            }
+            tlb_flush_vtlb_page(env, mmu_idx, addr);
         }
     }
 
@@ -609,10 +610,9 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     target_ulong address;
     target_ulong code_address;
     uintptr_t addend;
-    CPUTLBEntry *te, *tv, tn;
+    CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
     target_ulong vaddr_page;
-    unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
 
     assert_cpu_is_self(cpu);
@@ -654,19 +654,25 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
     }
 
+    /* Make sure there's no cached translation for the new page.  */
+    tlb_flush_vtlb_page(env, mmu_idx, vaddr_page);
+
     code_address = address;
     iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
                                             paddr_page, xlat, prot, &address);
 
     index = (vaddr_page >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     te = &env->tlb_table[mmu_idx][index];
-    /* do not discard the translation in te, evict it into a victim tlb */
-    tv = &env->tlb_v_table[mmu_idx][vidx];
 
-    /* addr_write can race with tlb_reset_dirty_range */
-    copy_tlb_helper(tv, te, true);
+    /* If the old entry matches the new page, just overwrite TE.  */
+    if (!tlb_hit_page_anyprot(te, vaddr_page)) {
+        unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
+        CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
 
-    env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
+        /* Evict the old entry into the victim tlb.  */
+        copy_tlb_helper(tv, te, true);
+        env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
+    }
 
     /* refill the tlb */
     /*
-- 
2.17.1
