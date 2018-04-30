Received: from eggs.gnu.org ([2001:4830:134:3::10]:49573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOP-00033Q-PT
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDDOM-0007JX-Qf
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDDOM-0007IT-I9
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:19:14 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 19:18:55 +0100
Message-Id: <20180430181905.32327-2-peter.maydell@linaro.org>
In-Reply-To: <20180430181905.32327-1-peter.maydell@linaro.org>
References: <20180430181905.32327-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH 01/11] Make address_space_translate() take
 a MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_translate().
Its callers either have an attrs value to hand, or don't care
and can use MEMTXATTRS_UNSPECIFIED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h     |  4 +++-
 accel/tcg/translate-all.c |  2 +-
 exec.c                    |  6 ++++--
 hw/vfio/common.c          |  3 ++-
 memory_ldst.inc.c         | 18 +++++++++---------
 target/riscv/helper.c     |  2 +-
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e62965a0c8..f416d1e985 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1909,6 +1909,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  * #MemoryRegion.
  * @len: pointer to length
  * @is_write: indicates the transfer direction
+ * @attrs: memory attributes
  */
 MemoryRegion *flatview_translate(FlatView *fv,
                                  hwaddr addr, hwaddr *xlat,
@@ -1916,7 +1917,8 @@ MemoryRegion *flatview_translate(FlatView *fv,
 
 static inline MemoryRegion *address_space_translate(AddressSpace *as,
                                                     hwaddr addr, hwaddr *xlat,
-                                                    hwaddr *len, bool is_write)
+                                                    hwaddr *len, bool is_write,
+                                                    MemTxAttrs attrs)
 {
     return flatview_translate(address_space_to_flatview(as),
                               addr, xlat, len, is_write);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f04a922ef7..52f7bd59a9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1679,7 +1679,7 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
     hwaddr l = 1;
 
     rcu_read_lock();
-    mr = address_space_translate(as, addr, &addr, &l, false);
+    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
     if (!(memory_region_is_ram(mr)
           || memory_region_is_romd(mr))) {
         rcu_read_unlock();
diff --git a/exec.c b/exec.c
index df35e6dd85..a0f27b7b8c 100644
--- a/exec.c
+++ b/exec.c
@@ -3287,7 +3287,8 @@ static inline void cpu_physical_memory_write_rom_internal(AddressSpace *as,
     rcu_read_lock();
     while (len > 0) {
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true);
+        mr = address_space_translate(as, addr, &addr1, &l, true,
+                                     MEMTXATTRS_UNSPECIFIED);
 
         if (!(memory_region_is_ram(mr) ||
               memory_region_is_romd(mr))) {
@@ -3716,7 +3717,8 @@ bool cpu_physical_memory_is_io(hwaddr phys_addr)
 
     rcu_read_lock();
     mr = address_space_translate(&address_space_memory,
-                                 phys_addr, &phys_addr, &l, false);
+                                 phys_addr, &phys_addr, &l, false,
+                                 MEMTXATTRS_UNSPECIFIED);
 
     res = !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
     rcu_read_unlock();
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 07ffa0ba10..8e57265edf 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -324,7 +324,8 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
      */
     mr = address_space_translate(&address_space_memory,
                                  iotlb->translated_addr,
-                                 &xlat, &len, writable);
+                                 &xlat, &len, writable,
+                                 MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
         error_report("iommu map to non memory area %"HWADDR_PRIx"",
                      xlat);
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 5dbff9cef8..860ba31ac8 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -33,7 +33,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false);
+    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (l < 4 || !IS_DIRECT(mr, false)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -127,7 +127,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false);
+    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (l < 8 || !IS_DIRECT(mr, false)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -219,7 +219,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false);
+    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (!IS_DIRECT(mr, false)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -261,7 +261,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, false);
+    mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (l < 2 || !IS_DIRECT(mr, false)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -356,7 +356,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true);
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !IS_DIRECT(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -399,7 +399,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true);
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !IS_DIRECT(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -489,7 +489,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true);
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!IS_DIRECT(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
         r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
@@ -528,7 +528,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true);
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 2 || !IS_DIRECT(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
@@ -619,7 +619,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     bool release_lock = false;
 
     RCU_READ_LOCK();
-    mr = TRANSLATE(addr, &addr1, &l, true);
+    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 8 || !IS_DIRECT(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 02cbcea2b7..d7023ad78e 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -210,7 +210,7 @@ restart:
                 MemoryRegion *mr;
                 hwaddr l = sizeof(target_ulong), addr1;
                 mr = address_space_translate(cs->as, pte_addr,
-                    &addr1, &l, false);
+                    &addr1, &l, false, MEMTXATTRS_UNSPECIFIED);
                 if (memory_access_is_direct(mr, true)) {
                     target_ulong *pte_pa =
                         qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.17.0
