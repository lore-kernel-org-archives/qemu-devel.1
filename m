Received: from eggs.gnu.org ([2001:4830:134:3::10]:52450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdv4-0004aG-Dd
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtp-0006bJ-AK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:50 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdto-0006ag-Pg
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtn-0007Br-97
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:31 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:41 +0100
Message-Id: <20180814181815.23348-12-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/45] accel/tcg: Check whether TLB entry is RAM
 consistently with how we set it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We set up TLB entries in tlb_set_page_with_attrs(), where we have
some logic for determining whether the TLB entry is considered
to be RAM-backed, and thus has a valid addend field. When we
look at the TLB entry in get_page_addr_code(), we use different
logic for determining whether to treat the page as RAM-backed
and use the addend field. This is confusing, and in fact buggy,
because the code in tlb_set_page_with_attrs() correctly decides
that rom_device memory regions not in romd mode are not RAM-backed,
but the code in get_page_addr_code() thinks they are RAM-backed.
This typically results in "Bad ram pointer" assertion if the
guest tries to execute from such a memory region.

Fix this by making get_page_addr_code() just look at the
TLB_MMIO bit in the code_address field of the TLB, which
tlb_set_page_with_attrs() sets if and only if the addend
field is not valid for code execution.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180713150945.12348-1-peter.maydell@linaro.org
---
 include/exec/exec-all.h |  2 --
 accel/tcg/cputlb.c      | 29 ++++++++---------------------
 exec.c                  |  6 ------
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index da73e3bfed2..5f781255826 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -502,8 +502,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        hwaddr paddr, hwaddr xlat,
                                        int prot,
                                        target_ulong *address);
-bool memory_region_is_unassigned(MemoryRegion *mr);
-
 #endif
 
 /* vl.c */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 754795ff253..f4702ce91f6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -926,10 +926,6 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 {
     int mmu_idx, index;
     void *p;
-    MemoryRegion *mr;
-    MemoryRegionSection *section;
-    CPUState *cpu = ENV_GET_CPU(env);
-    CPUIOTLBEntry *iotlbentry;
 
     index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     mmu_idx = cpu_mmu_index(env, true);
@@ -940,28 +936,19 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
     }
 
-    if (unlikely(env->tlb_table[mmu_idx][index].addr_code & TLB_RECHECK)) {
+    if (unlikely(env->tlb_table[mmu_idx][index].addr_code &
+                 (TLB_RECHECK | TLB_MMIO))) {
         /*
-         * This is a TLB_RECHECK access, where the MMU protection
-         * covers a smaller range than a target page. Return -1 to
-         * indicate that we cannot simply execute from RAM here;
-         * we will perform the necessary repeat of the MMU check
-         * when the "execute a single insn" code performs the
-         * load of the guest insn.
+         * Return -1 if we can't translate and execute from an entire
+         * page of RAM here, which will cause us to execute by loading
+         * and translating one insn at a time, without caching:
+         *  - TLB_RECHECK: means the MMU protection covers a smaller range
+         *    than a target page, so we must redo the MMU check every insn
+         *  - TLB_MMIO: region is not backed by RAM
          */
         return -1;
     }
 
-    iotlbentry = &env->iotlb[mmu_idx][index];
-    section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
-    mr = section->mr;
-    if (memory_region_is_unassigned(mr)) {
-        /*
-         * Not guest RAM, so there is no ram_addr_t for it. Return -1,
-         * and we will execute a single insn from this device.
-         */
-        return -1;
-    }
     p = (void *)((uintptr_t)addr + env->tlb_table[mmu_idx][index].addend);
     return qemu_ram_addr_from_host_nofail(p);
 }
diff --git a/exec.c b/exec.c
index 4f5df07b6a2..e7be0761c28 100644
--- a/exec.c
+++ b/exec.c
@@ -402,12 +402,6 @@ static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwaddr addr)
     }
 }
 
-bool memory_region_is_unassigned(MemoryRegion *mr)
-{
-    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
-        && mr != &io_mem_watch;
-}
-
 /* Called from RCU critical section */
 static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
                                                         hwaddr addr,
-- 
2.18.0
