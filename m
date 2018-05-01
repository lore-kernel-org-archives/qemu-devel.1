Received: from eggs.gnu.org ([2001:4830:134:3::10]:46144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8X-0003XR-HR
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8W-0007ru-1E
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDR8V-0007p3-P1
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 09:59:28 +0100
Message-Id: <20180501085939.6201-2-peter.maydell@linaro.org>
In-Reply-To: <20180501085939.6201-1-peter.maydell@linaro.org>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH v2 01/12] Make tb_invalidate_phys_addr()
 take a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

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
index c7fcefa851..df35e6dd85 100644
--- a/exec.c
+++ b/exec.c
@@ -863,7 +863,7 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
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
