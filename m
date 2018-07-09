Received: from eggs.gnu.org ([2001:4830:134:3::10]:49298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcYYa-00024M-Ea
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcYYZ-0003XT-BH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:58:32 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcYYZ-0003XD-3D
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:58:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 16:58:26 +0100
Message-Id: <20180709155826.18993-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] exec.c: Replace memory_region_is_unassigned()
 with memory_region_is_ram_backed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

The function memory_region_is_unassigned() is rather misnamed, because
what it is actually testing is whether the memory region is backed
by host RAM, and so whether get_page_addr_code() can find a ram_addr_t
corresponding to the guest address.

Replace it with memory_region_is_ram_backed(), which has a name
better matching its actual semantics.  (We invert the sense of the
return value to avoid having a _not_ in the function name.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The difference between this and memory_region_is_ram() is pretty
subtle, to the extent I'm not completely sure exactly what it is;
io_mem_notdirty and io_mem_watch at least won't be considered as
"ram" by memory_region_is_ram(), though. Somebody with a better
grasp of the various different kinds of memory regions might be
able to suggest better documentation and/or a way to avoid this
oddball TCG-only function?

 include/exec/exec-all.h | 9 ++++++++-
 accel/tcg/cputlb.c      | 2 +-
 exec.c                  | 6 +++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index da73e3bfed2..7de4e4646f6 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -502,7 +502,14 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        hwaddr paddr, hwaddr xlat,
                                        int prot,
                                        target_ulong *address);
-bool memory_region_is_unassigned(MemoryRegion *mr);
+/**
+ * memory_region_is_ram_backed:
+ * @mr: Memory region
+ *
+ * Return true if this memory region is backed by host RAM that we
+ * can directly execute guest code from.
+ */
+bool memory_region_is_ram_backed(MemoryRegion *mr);
 
 #endif
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 20c147d6554..e5e3bf76298 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1001,7 +1001,7 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     iotlbentry = &env->iotlb[mmu_idx][index];
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
-    if (memory_region_is_unassigned(mr)) {
+    if (!memory_region_is_ram_backed(mr)) {
         qemu_mutex_lock_iothread();
         if (memory_region_request_mmio_ptr(mr, addr)) {
             qemu_mutex_unlock_iothread();
diff --git a/exec.c b/exec.c
index 4f5df07b6a2..6aea975c266 100644
--- a/exec.c
+++ b/exec.c
@@ -402,10 +402,10 @@ static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwaddr addr)
     }
 }
 
-bool memory_region_is_unassigned(MemoryRegion *mr)
+bool memory_region_is_ram_backed(MemoryRegion *mr)
 {
-    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
-        && mr != &io_mem_watch;
+    return !(mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
+             && mr != &io_mem_watch);
 }
 
 /* Called from RCU critical section */
-- 
2.17.1
