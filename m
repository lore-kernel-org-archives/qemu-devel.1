Received: from eggs.gnu.org ([2001:4830:134:3::10]:43729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fdzhh-0000hP-RY
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fdzhg-0000y9-AX
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:09:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 16:09:45 +0100
Message-Id: <20180713150945.12348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] accel/tcg: Check whether TLB entry is RAM
 consistently with how we set it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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
---
This patch is based on:
 * [PATCH for-3.0 0/2] accel/tcg: fix get_page_addr_code() victim TLB lookups
 * [PATCH 0/6] accel/tcg: Support execution from MMIO and small MMU regions
Based-on: <20180713141636.18665-1-peter.maydell@linaro.org>
Based-on: <20180710160013.26559-1-peter.maydell@linaro.org>

It would be possible to fix the 'bad ram pointer' in a more
minimalist way (by making memory_region_is_unassigned()
check "!memory_region_is_romd(mr)" rather than "!mr->rom_device")
but since for 3.0 the only thing this does is turn that assert
failure into the "can't execute from non-ram" error-exit it
doesn't seem worth fixing for 3.0. After 3.0 the small-MMU-region
exec support makes it more interesting. NB that if your
rom-device is pflash then being able to execute from it when
it's not in romd mode is not likely to actually help you, since
pflash status code returns are seldom valid instructions :-)

Philippe: you might like to try this lot with your MIPS
code that was getting the bad ram addr error?
---
 include/exec/exec-all.h |  2 --
 accel/tcg/cputlb.c      | 30 +++++++++---------------------
 exec.c                  |  6 ------
 3 files changed, 9 insertions(+), 29 deletions(-)

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
index 754795ff253..5e5a2a2616c 100644
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
@@ -939,29 +935,21 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
         }
         assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
     }
+    assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
 
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
2.17.1
