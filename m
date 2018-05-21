Received: from eggs.gnu.org ([2001:4830:134:3::10]:42708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQI-0002pm-6R
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQG-0000zZ-O7
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:37 +0100
Message-Id: <20180521140402.23318-3-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/27] Make tb_invalidate_phys_addr() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to tb_invalidate_phys_addr().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/exec-all.h   | 5 +++--
 accel/tcg/translate-all.c | 2 +-
 exec.c                    | 2 +-
 target/xtensa/op_helper.c | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bd68328ed9..4d09eaba72 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -255,7 +255,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 void tlb_set_page(CPUState *cpu, target_ulong vaddr,
                   hwaddr paddr, int prot,
                   int mmu_idx, target_ulong size);
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
                  uintptr_t retaddr);
 #else
@@ -303,7 +303,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
-static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
+static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr,
+                                           MemTxAttrs attrs)
 {
 }
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f409d42d54..f04a922ef7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1672,7 +1672,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
 {
     ram_addr_t ram_addr;
     MemoryRegion *mr;
diff --git a/exec.c b/exec.c
index ffa1099547..c3a197e67b 100644
--- a/exec.c
+++ b/exec.c
@@ -898,7 +898,7 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
     if (phys != -1) {
         /* Locks grabbed by tb_invalidate_phys_addr */
         tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
-                                phys | (pc & ~TARGET_PAGE_MASK));
+                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
     }
 }
 #endif
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index e3bcbe10d6..8a8c763c63 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -105,7 +105,8 @@ static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
     int ret = xtensa_get_physical_addr(env, false, vaddr, 2, 0,
             &paddr, &page_size, &access);
     if (ret == 0) {
-        tb_invalidate_phys_addr(&address_space_memory, paddr);
+        tb_invalidate_phys_addr(&address_space_memory, paddr,
+                                MEMTXATTRS_UNSPECIFIED);
     }
 }
 
-- 
2.17.0
