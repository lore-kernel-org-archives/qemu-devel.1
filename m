Received: from eggs.gnu.org ([2001:4830:134:3::10]:57253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpsza-0001Gn-Si
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszW-0007iX-Tq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:58 -0400
Received: from ozlabs.ru ([107.173.13.209]:51582)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszW-0007gt-CV
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:54 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  7 Sep 2017 19:20:08 +1000
Message-Id: <20170907092010.3605-3-aik@ozlabs.ru>
In-Reply-To: <20170907092010.3605-1-aik@ozlabs.ru>
References: <20170907092010.3605-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 2/4] memory: Prepare for shared flat
 views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

We are going to share flat views and dispatch trees between address
spaces. This moves bits around but no change in behaviour is expected
here. The following patch will implement sharing.

This switches from AddressSpace to AddressSpaceDispatch as in many
places this is what is used actually. Also, since multiple address
spaces will be sharing a flat view, MemoryRegionSection cannot store
the address space pointer, this changes it to AddressSpaceDispatch
as well. As a not very obvious result, IOMMUTLBEntry also switched
from AddressSpace to AddressSpaceDispatch to make
address_space_get_iotlb_entry() work.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory.h   |  79 +++++++++++++++++++++++-------
 exec.c                  | 128 +++++++++++++++++++++++++++---------------------
 hw/alpha/typhoon.c      |   2 +-
 hw/dma/rc4030.c         |   4 +-
 hw/i386/amd_iommu.c     |   2 +-
 hw/i386/intel_iommu.c   |   9 ++--
 hw/intc/openpic_kvm.c   |   2 +-
 hw/pci-host/apb.c       |   2 +-
 hw/ppc/spapr_iommu.c    |   4 +-
 hw/s390x/s390-pci-bus.c |   2 +-
 hw/vfio/common.c        |   6 +--
 hw/virtio/vhost.c       |   6 +--
 memory.c                |  26 ++++++----
 13 files changed, 170 insertions(+), 102 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 400dd4491b..83e82e90d5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -48,6 +48,7 @@
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
+typedef struct AddressSpaceDispatch AddressSpaceDispatch;
 
 struct MemoryRegionMmio {
     CPUReadMemoryFunc *read[3];
@@ -67,7 +68,7 @@ typedef enum {
 #define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : 0))
 
 struct IOMMUTLBEntry {
-    AddressSpace    *target_as;
+    AddressSpaceDispatch *target_dispatch;
     hwaddr           iova;
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff = 4k translation */
@@ -310,6 +311,8 @@ struct MemoryListener {
     QTAILQ_ENTRY(MemoryListener) link_as;
 };
 
+AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
+
 /**
  * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
@@ -346,7 +349,7 @@ struct AddressSpace {
  */
 struct MemoryRegionSection {
     MemoryRegion *mr;
-    AddressSpace *address_space;
+    AddressSpaceDispatch *dispatch;
     hwaddr offset_within_region;
     Int128 size;
     hwaddr offset_within_address_space;
@@ -1635,10 +1638,19 @@ void address_space_destroy(AddressSpace *as);
  * @buf: buffer with the data transferred
  * @is_write: indicates the transfer direction
  */
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_dispatch_rw(AddressSpaceDispatch *d, hwaddr addr,
                              MemTxAttrs attrs, uint8_t *buf,
                              int len, bool is_write);
 
+static inline MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
+                                           MemTxAttrs attrs, uint8_t *buf,
+                                           int len, bool is_write)
+{
+    return address_space_dispatch_rw(address_space_to_dispatch(as),
+                                     addr, attrs, buf, len, is_write);
+}
+
+
 /**
  * address_space_write: write to address space.
  *
@@ -1651,10 +1663,18 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  * @attrs: memory transaction attributes
  * @buf: buffer with the data transferred
  */
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_dispatch_write(AddressSpaceDispatch *d, hwaddr addr,
                                 MemTxAttrs attrs,
                                 const uint8_t *buf, int len);
 
+static inline MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                MemTxAttrs attrs,
+                                const uint8_t *buf, int len)
+{
+    return address_space_dispatch_write(address_space_to_dispatch(as),
+                                        addr, attrs, buf, len);
+}
+
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
  *
@@ -1840,8 +1860,8 @@ void stq_be_phys_cached(MemoryRegionCache *cache, hwaddr addr, uint64_t val);
 /* address_space_get_iotlb_entry: translate an address into an IOTLB
  * entry. Should be called from an RCU critical section.
  */
-IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
-                                            bool is_write);
+IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpaceDispatch *d,
+                                            hwaddr addr, bool is_write);
 
 /* address_space_translate: translate an address range into an address space
  * into a MemoryRegion and an address range into that section.  Should be
@@ -1855,9 +1875,17 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  * @len: pointer to length
  * @is_write: indicates the transfer direction
  */
-MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
-                                      hwaddr *xlat, hwaddr *len,
-                                      bool is_write);
+MemoryRegion *address_space_dispatch_translate(AddressSpaceDispatch *d,
+                                               hwaddr addr, hwaddr *xlat,
+                                               hwaddr *len, bool is_write);
+
+static inline MemoryRegion *address_space_translate(AddressSpace *as,
+                                                    hwaddr addr, hwaddr *xlat,
+                                                    hwaddr *len, bool is_write)
+{
+    return address_space_dispatch_translate(address_space_to_dispatch(as),
+                                            addr, xlat, len, is_write);
+}
 
 /* address_space_access_valid: check for validity of accessing an address
  * space range
@@ -1874,7 +1902,15 @@ MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
  * @len: length of the area to be checked
  * @is_write: indicates the transfer direction
  */
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_write);
+bool address_space_dispatch_access_valid(AddressSpaceDispatch *d, hwaddr addr,
+                                         int len, bool is_write);
+
+static inline bool address_space_access_valid(AddressSpace *as, hwaddr addr,
+                                              int len, bool is_write)
+{
+    return address_space_dispatch_access_valid(address_space_to_dispatch(as),
+                                               addr, len, is_write);
+}
 
 /* address_space_map: map a physical memory region into a host virtual address
  *
@@ -1908,11 +1944,11 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 
 /* Internal functions, part of the implementation of address_space_read.  */
-MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_continue(AddressSpaceDispatch *d, hwaddr addr,
                                         MemTxAttrs attrs, uint8_t *buf,
                                         int len, hwaddr addr1, hwaddr l,
 					MemoryRegion *mr);
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(AddressSpaceDispatch *d, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, int len);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
@@ -1940,8 +1976,9 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * @buf: buffer with the data transferred
  */
 static inline __attribute__((__always_inline__))
-MemTxResult address_space_read(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                               uint8_t *buf, int len)
+MemTxResult address_space_dispatch_read(AddressSpaceDispatch *d, hwaddr addr,
+                                        MemTxAttrs attrs, uint8_t *buf,
+                                        int len)
 {
     MemTxResult result = MEMTX_OK;
     hwaddr l, addr1;
@@ -1952,22 +1989,30 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
         if (len) {
             rcu_read_lock();
             l = len;
-            mr = address_space_translate(as, addr, &addr1, &l, false);
+            mr = address_space_dispatch_translate(d, addr, &addr1, &l, false);
             if (len == l && memory_access_is_direct(mr, false)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                 memcpy(buf, ptr, len);
             } else {
-                result = address_space_read_continue(as, addr, attrs, buf, len,
+                result = address_space_read_continue(d, addr, attrs, buf, len,
                                                      addr1, l, mr);
             }
             rcu_read_unlock();
         }
     } else {
-        result = address_space_read_full(as, addr, attrs, buf, len);
+        result = address_space_read_full(d, addr, attrs, buf, len);
     }
     return result;
 }
 
+static inline MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+                                             MemTxAttrs attrs, uint8_t *buf,
+                                             int len)
+{
+    return address_space_dispatch_read(address_space_to_dispatch(as),
+                                       addr, attrs, buf, len);
+}
+
 /**
  * address_space_read_cached: read from a cached RAM region
  *
diff --git a/exec.c b/exec.c
index d20c34ca83..66f01f5fce 100644
--- a/exec.c
+++ b/exec.c
@@ -199,10 +199,12 @@ struct AddressSpaceDispatch {
     AddressSpace *as;
 };
 
+typedef struct AddressSpaceDispatch AddressSpaceDispatch;
+
 #define SUBPAGE_IDX(addr) ((addr) & ~TARGET_PAGE_MASK)
 typedef struct subpage_t {
     MemoryRegion iomem;
-    AddressSpace *as;
+    AddressSpaceDispatch *d;
     hwaddr base;
     uint16_t sub_section[];
 } subpage_t;
@@ -238,6 +240,11 @@ struct DirtyBitmapSnapshot {
     unsigned long dirty[];
 };
 
+AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
+{
+    return atomic_rcu_read(&as->dispatch);
+}
+
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
@@ -437,8 +444,9 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
 
 /* Called from RCU critical section */
 static MemoryRegionSection *
-address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *xlat,
-                                 hwaddr *plen, bool resolve_subpage)
+address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr,
+                                 hwaddr *xlat, hwaddr *plen,
+                                 bool resolve_subpage)
 {
     MemoryRegionSection *section;
     MemoryRegion *mr;
@@ -472,7 +480,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
 }
 
 /* Called from RCU critical section */
-static MemoryRegionSection address_space_do_translate(AddressSpace *as,
+static MemoryRegionSection address_space_do_translate(AddressSpaceDispatch *d,
                                                       hwaddr addr,
                                                       hwaddr *xlat,
                                                       hwaddr *plen,
@@ -485,8 +493,8 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
     IOMMUMemoryRegionClass *imrc;
 
     for (;;) {
-        AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
-        section = address_space_translate_internal(d, addr, &addr, plen, is_mmio);
+        section = address_space_translate_internal(d, addr, &addr,
+                                                   plen, is_mmio);
 
         iommu_mr = memory_region_get_iommu(section->mr);
         if (!iommu_mr) {
@@ -503,7 +511,7 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
             goto translate_fail;
         }
 
-        as = iotlb.target_as;
+        d = atomic_rcu_read(&iotlb.target_dispatch);
     }
 
     *xlat = addr;
@@ -515,8 +523,8 @@ translate_fail:
 }
 
 /* Called from RCU critical section */
-IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
-                                            bool is_write)
+IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpaceDispatch *d,
+                                            hwaddr addr, bool is_write)
 {
     MemoryRegionSection section;
     hwaddr xlat, plen;
@@ -525,7 +533,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     plen = (hwaddr)-1;
 
     /* This can never be MMIO. */
-    section = address_space_do_translate(as, addr, &xlat, &plen,
+    section = address_space_do_translate(d, addr, &xlat, &plen,
                                          is_write, false);
 
     /* Illegal translation */
@@ -549,7 +557,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     plen -= 1;
 
     return (IOMMUTLBEntry) {
-        .target_as = section.address_space,
+        .target_dispatch = section.dispatch,
         .iova = addr & ~plen,
         .translated_addr = xlat & ~plen,
         .addr_mask = plen,
@@ -562,15 +570,15 @@ iotlb_fail:
 }
 
 /* Called from RCU critical section */
-MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
-                                      hwaddr *xlat, hwaddr *plen,
-                                      bool is_write)
+MemoryRegion *address_space_dispatch_translate(AddressSpaceDispatch *d,
+                                               hwaddr addr, hwaddr *xlat,
+                                               hwaddr *plen, bool is_write)
 {
     MemoryRegion *mr;
     MemoryRegionSection section;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = address_space_do_translate(as, addr, xlat, plen, is_write, true);
+    section = address_space_do_translate(d, addr, xlat, plen, is_write, true);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
@@ -587,7 +595,8 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
                                   hwaddr *xlat, hwaddr *plen)
 {
     MemoryRegionSection *section;
-    AddressSpaceDispatch *d = atomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
+    AddressSpaceDispatch *d =
+            atomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
 
     section = address_space_translate_internal(d, addr, xlat, plen, false);
 
@@ -1220,7 +1229,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     } else {
         AddressSpaceDispatch *d;
 
-        d = atomic_rcu_read(&section->address_space->dispatch);
+        d = atomic_rcu_read(&section->dispatch);
         iotlb = section - d->map.sections;
         iotlb += xlat;
     }
@@ -1246,7 +1255,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 
 static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
                              uint16_t section);
-static subpage_t *subpage_init(AddressSpace *as, hwaddr base);
+static subpage_t *subpage_init(AddressSpaceDispatch *d, hwaddr base);
 
 static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
                                qemu_anon_ram_alloc;
@@ -1318,8 +1327,8 @@ static void register_subpage(AddressSpaceDispatch *d, MemoryRegionSection *secti
     assert(existing->mr->subpage || existing->mr == &io_mem_unassigned);
 
     if (!(existing->mr->subpage)) {
-        subpage = subpage_init(d->as, base);
-        subsection.address_space = d->as;
+        subpage = subpage_init(d, base);
+        subsection.dispatch = d;
         subsection.mr = &subpage->iomem;
         phys_page_set(d, base >> TARGET_PAGE_BITS, 1,
                       phys_section_add(&d->map, &subsection));
@@ -2512,7 +2521,7 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     printf("%s: subpage %p len %u addr " TARGET_FMT_plx "\n", __func__,
            subpage, len, addr);
 #endif
-    res = address_space_read(subpage->as, addr + subpage->base,
+    res = address_space_dispatch_read(subpage->d, addr + subpage->base,
                              attrs, buf, len);
     if (res) {
         return res;
@@ -2562,7 +2571,7 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
     default:
         abort();
     }
-    return address_space_write(subpage->as, addr + subpage->base,
+    return address_space_dispatch_write(subpage->d, addr + subpage->base,
                                attrs, buf, len);
 }
 
@@ -2575,8 +2584,8 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
            __func__, subpage, is_write ? 'w' : 'r', len, addr);
 #endif
 
-    return address_space_access_valid(subpage->as, addr + subpage->base,
-                                      len, is_write);
+    return address_space_dispatch_access_valid(subpage->d, addr + subpage->base,
+                                               len, is_write);
 }
 
 static const MemoryRegionOps subpage_ops = {
@@ -2610,12 +2619,12 @@ static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
     return 0;
 }
 
-static subpage_t *subpage_init(AddressSpace *as, hwaddr base)
+static subpage_t *subpage_init(AddressSpaceDispatch *d, hwaddr base)
 {
     subpage_t *mmio;
 
     mmio = g_malloc0(sizeof(subpage_t) + TARGET_PAGE_SIZE * sizeof(uint16_t));
-    mmio->as = as;
+    mmio->d = d;
     mmio->base = base;
     memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
                           NULL, TARGET_PAGE_SIZE);
@@ -2629,12 +2638,12 @@ static subpage_t *subpage_init(AddressSpace *as, hwaddr base)
     return mmio;
 }
 
-static uint16_t dummy_section(PhysPageMap *map, AddressSpace *as,
+static uint16_t dummy_section(PhysPageMap *map, AddressSpaceDispatch *d,
                               MemoryRegion *mr)
 {
-    assert(as);
+    assert(d);
     MemoryRegionSection section = {
-        .address_space = as,
+        .dispatch = d,
         .mr = mr,
         .offset_within_address_space = 0,
         .offset_within_region = 0,
@@ -2677,17 +2686,16 @@ static void mem_begin(MemoryListener *listener)
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
-    n = dummy_section(&d->map, as, &io_mem_unassigned);
+    n = dummy_section(&d->map, d, &io_mem_unassigned);
     assert(n == PHYS_SECTION_UNASSIGNED);
-    n = dummy_section(&d->map, as, &io_mem_notdirty);
+    n = dummy_section(&d->map, d, &io_mem_notdirty);
     assert(n == PHYS_SECTION_NOTDIRTY);
-    n = dummy_section(&d->map, as, &io_mem_rom);
+    n = dummy_section(&d->map, d, &io_mem_rom);
     assert(n == PHYS_SECTION_ROM);
-    n = dummy_section(&d->map, as, &io_mem_watch);
+    n = dummy_section(&d->map, d, &io_mem_watch);
     assert(n == PHYS_SECTION_WATCH);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
-    d->as = as;
     as->next_dispatch = d;
 }
 
@@ -2900,7 +2908,8 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 }
 
 /* Called within RCU critical section.  */
-static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
+static MemTxResult address_space_write_continue(AddressSpaceDispatch *d,
+                                                hwaddr addr,
                                                 MemTxAttrs attrs,
                                                 const uint8_t *buf,
                                                 int len, hwaddr addr1,
@@ -2966,14 +2975,15 @@ static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
         }
 
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true);
+        mr = address_space_dispatch_translate(d, addr, &addr1, &l, true);
     }
 
     return result;
 }
 
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                                const uint8_t *buf, int len)
+MemTxResult address_space_dispatch_write(AddressSpaceDispatch *d, hwaddr addr,
+                                         MemTxAttrs attrs, const uint8_t *buf,
+                                         int len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -2983,8 +2993,8 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     if (len > 0) {
         rcu_read_lock();
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true);
-        result = address_space_write_continue(as, addr, attrs, buf, len,
+        mr = address_space_dispatch_translate(d, addr, &addr1, &l, true);
+        result = address_space_write_continue(d, addr, attrs, buf, len,
                                               addr1, l, mr);
         rcu_read_unlock();
     }
@@ -2993,7 +3003,7 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
 }
 
 /* Called within RCU critical section.  */
-MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_continue(AddressSpaceDispatch *d, hwaddr addr,
                                         MemTxAttrs attrs, uint8_t *buf,
                                         int len, hwaddr addr1, hwaddr l,
                                         MemoryRegion *mr)
@@ -3056,13 +3066,13 @@ MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
         }
 
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, false);
+        mr = address_space_dispatch_translate(d, addr, &addr1, &l, false);
     }
 
     return result;
 }
 
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+MemTxResult address_space_read_full(AddressSpaceDispatch *d, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, int len)
 {
     hwaddr l;
@@ -3073,8 +3083,8 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
     if (len > 0) {
         rcu_read_lock();
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, false);
-        result = address_space_read_continue(as, addr, attrs, buf, len,
+        mr = address_space_dispatch_translate(d, addr, &addr1, &l, false);
+        result = address_space_read_continue(d, addr, attrs, buf, len,
                                              addr1, l, mr);
         rcu_read_unlock();
     }
@@ -3082,13 +3092,14 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
     return result;
 }
 
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, int len, bool is_write)
+MemTxResult address_space_dispatch_rw(AddressSpaceDispatch *d, hwaddr addr,
+                                      MemTxAttrs attrs, uint8_t *buf,
+                                      int len, bool is_write)
 {
     if (is_write) {
-        return address_space_write(as, addr, attrs, (uint8_t *)buf, len);
+        return address_space_dispatch_write(d, addr, attrs, buf, len);
     } else {
-        return address_space_read(as, addr, attrs, (uint8_t *)buf, len);
+        return address_space_dispatch_read(d, addr, attrs, buf, len);
     }
 }
 
@@ -3249,7 +3260,8 @@ static void cpu_notify_map_clients(void)
     qemu_mutex_unlock(&map_client_list_lock);
 }
 
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_write)
+bool address_space_dispatch_access_valid(AddressSpaceDispatch *d, hwaddr addr,
+                                         int len, bool is_write)
 {
     MemoryRegion *mr;
     hwaddr l, xlat;
@@ -3257,7 +3269,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
     rcu_read_lock();
     while (len > 0) {
         l = len;
-        mr = address_space_translate(as, addr, &xlat, &l, is_write);
+        mr = address_space_dispatch_translate(d, addr, &xlat, &l, is_write);
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
@@ -3274,7 +3286,8 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
 }
 
 static hwaddr
-address_space_extend_translation(AddressSpace *as, hwaddr addr, hwaddr target_len,
+address_space_extend_translation(AddressSpaceDispatch *d, hwaddr addr,
+                                 hwaddr target_len,
                                  MemoryRegion *mr, hwaddr base, hwaddr len,
                                  bool is_write)
 {
@@ -3291,7 +3304,8 @@ address_space_extend_translation(AddressSpace *as, hwaddr addr, hwaddr target_le
         }
 
         len = target_len;
-        this_mr = address_space_translate(as, addr, &xlat, &len, is_write);
+        this_mr = address_space_dispatch_translate(d, addr, &xlat,
+                                                   &len, is_write);
         if (this_mr != mr || xlat != base + done) {
             return done;
         }
@@ -3314,6 +3328,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr l, xlat;
     MemoryRegion *mr;
     void *ptr;
+    AddressSpaceDispatch *d = address_space_to_dispatch(as);
 
     if (len == 0) {
         return NULL;
@@ -3321,7 +3336,7 @@ void *address_space_map(AddressSpace *as,
 
     l = len;
     rcu_read_lock();
-    mr = address_space_translate(as, addr, &xlat, &l, is_write);
+    mr = address_space_dispatch_translate(d, addr, &xlat, &l, is_write);
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
@@ -3337,7 +3352,7 @@ void *address_space_map(AddressSpace *as,
         memory_region_ref(mr);
         bounce.mr = mr;
         if (!is_write) {
-            address_space_read(as, addr, MEMTXATTRS_UNSPECIFIED,
+            address_space_dispatch_read(d, addr, MEMTXATTRS_UNSPECIFIED,
                                bounce.buffer, l);
         }
 
@@ -3348,7 +3363,8 @@ void *address_space_map(AddressSpace *as,
 
 
     memory_region_ref(mr);
-    *plen = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
+    *plen = address_space_extend_translation(d, addr, len, mr, xlat,
+                                             l, is_write);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
     rcu_read_unlock();
 
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index ae11e012c7..b3dedf5b74 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -604,7 +604,7 @@ static const MemoryRegionOps pchip_ops = {
 static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
 {
     *ret = (IOMMUTLBEntry) {
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
         .translated_addr = taddr,
         .addr_mask = mask,
         .perm = IOMMU_RW,
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5d4833eeca..d771020b78 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -495,7 +495,7 @@ static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
 {
     rc4030State *s = container_of(iommu, rc4030State, dma_mr);
     IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
         .iova = addr & ~(DMA_PAGESIZE - 1),
         .translated_addr = 0,
         .addr_mask = DMA_PAGESIZE - 1,
@@ -507,7 +507,7 @@ static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     i = addr / DMA_PAGESIZE;
     if (i < s->dma_tl_limit / sizeof(entry)) {
         entry_address = (s->dma_tl_base & 0x7fffffff) + i * sizeof(entry);
-        if (address_space_read(ret.target_as, entry_address,
+        if (address_space_dispatch_read(ret.target_dispatch, entry_address,
                                MEMTXATTRS_UNSPECIFIED, (unsigned char *)&entry,
                                sizeof(entry)) == MEMTX_OK) {
             ret.translated_addr = entry.frame & ~(DMA_PAGESIZE - 1);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 334938a280..dc3303fdad 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -993,7 +993,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
     AMDVIState *s = as->iommu_state;
     IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
         .iova = addr,
         .translated_addr = 0,
         .addr_mask = ~(hwaddr)0,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a7bf87a19e..b31fe2af75 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -787,7 +787,8 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
         entry_valid = read_cur | write_cur;
 
         if (vtd_is_last_slpte(slpte, level)) {
-            entry.target_as = &address_space_memory;
+            entry.target_dispatch =
+                    address_space_to_dispatch(&address_space_memory);
             entry.iova = iova & subpage_mask;
             /* NOTE: this is only meaningful if entry_valid == true */
             entry.translated_addr = vtd_get_slpte_addr(slpte);
@@ -1810,7 +1811,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
         sz = VTD_PAGE_SIZE;
     }
 
-    entry.target_as = &vtd_dev_as->as;
+    entry.target_dispatch = address_space_to_dispatch(&vtd_dev_as->as);
     entry.addr_mask = sz - 1;
     entry.iova = addr;
     entry.perm = IOMMU_NONE;
@@ -2270,7 +2271,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     IntelIOMMUState *s = vtd_as->iommu_state;
     IOMMUTLBEntry iotlb = {
         /* We'll fill in the rest later. */
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
     };
     bool success;
 
@@ -2781,7 +2782,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
         size = 1ULL << n;
     }
 
-    entry.target_as = &address_space_memory;
+    entry.target_dispatch = address_space_to_dispatch(&address_space_memory);
     /* Adjust iova for the size */
     entry.iova = n->start & ~(size - 1);
     /* This field is meaningless for unmap */
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 0518e017c4..99578e7f7a 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -124,7 +124,7 @@ static void kvm_openpic_region_add(MemoryListener *listener,
     uint64_t reg_base;
     int ret;
 
-    if (section->address_space != &address_space_memory) {
+    if (section->dispatch != address_space_to_dispatch(&address_space_memory)) {
         abort();
     }
 
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 96e5d0b60d..ecfc9060b9 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -218,7 +218,7 @@ static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwaddr addr,
     uint64_t tte;
     uint32_t tsbsize;
     IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
         .iova = 0,
         .translated_addr = 0,
         .addr_mask = ~(hwaddr)0,
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index ed2d53559a..566d7779bc 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -117,7 +117,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
     sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
     uint64_t tce;
     IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
         .iova = 0,
         .translated_addr = 0,
         .addr_mask = ~(hwaddr)0,
@@ -407,7 +407,7 @@ static target_ulong put_tce_emu(sPAPRTCETable *tcet, target_ulong ioba,
 
     tcet->table[index] = tce;
 
-    entry.target_as = &address_space_memory,
+    entry.target_dispatch = address_space_to_dispatch(&address_space_memory),
     entry.iova = (ioba - tcet->bus_offset) & page_mask;
     entry.translated_addr = tce & page_mask;
     entry.addr_mask = ~page_mask;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 61cfd2138f..2f667ddf07 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -363,7 +363,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     uint32_t flags;
     S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
     IOMMUTLBEntry ret = {
-        .target_as = &address_space_memory,
+        .target_dispatch = address_space_to_dispatch(&address_space_memory),
         .iova = 0,
         .translated_addr = 0,
         .addr_mask = ~(hwaddr)0,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef..04d21b92c1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -358,9 +358,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
                                 iova, iova + iotlb->addr_mask);
 
-    if (iotlb->target_as != &address_space_memory) {
-        error_report("Wrong target AS \"%s\", only system memory is allowed",
-                     iotlb->target_as->name ? iotlb->target_as->name : "none");
+    if (iotlb->target_dispatch !=
+            address_space_to_dispatch(&address_space_memory)) {
+        error_report("Wrong target, only system memory is allowed");
         return;
     }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6eddb099b0..ae2a3f5dd7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -976,12 +976,12 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
     IOMMUTLBEntry iotlb;
     uint64_t uaddr, len;
     int ret = -EFAULT;
+    AddressSpaceDispatch *d = address_space_to_dispatch(dev->vdev->dma_as);
 
     rcu_read_lock();
 
-    iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
-                                          iova, write);
-    if (iotlb.target_as != NULL) {
+    iotlb = address_space_get_iotlb_entry(d, iova, write);
+    if (iotlb.target_dispatch != NULL) {
         ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
                                          &uaddr, &len);
         if (ret) {
diff --git a/memory.c b/memory.c
index c0adc35410..c6904a7deb 100644
--- a/memory.c
+++ b/memory.c
@@ -154,7 +154,8 @@ enum ListenerDirection { Forward, Reverse };
 /* No need to ref/unref .mr, the FlatRange keeps it alive.  */
 #define MEMORY_LISTENER_UPDATE_REGION(fr, as, dir, callback, _args...)  \
     do {                                                                \
-        MemoryRegionSection mrs = section_from_flat_range(fr, as);      \
+        MemoryRegionSection mrs = section_from_flat_range(fr,           \
+                address_space_to_dispatch(as));                         \
         MEMORY_LISTENER_CALL(as, callback, dir, &mrs, ##_args);         \
     } while(0)
 
@@ -237,11 +238,11 @@ typedef struct AddressSpaceOps AddressSpaceOps;
     for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
 
 static inline MemoryRegionSection
-section_from_flat_range(FlatRange *fr, AddressSpace *as)
+section_from_flat_range(FlatRange *fr, AddressSpaceDispatch *d)
 {
     return (MemoryRegionSection) {
         .mr = fr->mr,
-        .address_space = as,
+        .dispatch = d,
         .offset_within_region = fr->offset_in_region,
         .size = fr->addr.size,
         .offset_within_address_space = int128_get64(fr->addr.start),
@@ -727,6 +728,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
     unsigned iold, inew;
     MemoryRegionIoeventfd *fd;
     MemoryRegionSection section;
+    AddressSpaceDispatch *d = address_space_to_dispatch(as);
 
     /* Generate a symmetric difference of the old and new fd sets, adding
      * and deleting as necessary.
@@ -740,7 +742,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
                                                   fds_new[inew]))) {
             fd = &fds_old[iold];
             section = (MemoryRegionSection) {
-                .address_space = as,
+                .dispatch = d,
                 .offset_within_address_space = int128_get64(fd->addr.start),
                 .size = fd->addr.size,
             };
@@ -753,7 +755,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
                                                          fds_old[iold]))) {
             fd = &fds_new[inew];
             section = (MemoryRegionSection) {
-                .address_space = as,
+                .dispatch = d,
                 .offset_within_address_space = int128_get64(fd->addr.start),
                 .size = fd->addr.size,
             };
@@ -1835,7 +1837,9 @@ void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
         view = address_space_get_flatview(as);
         FOR_EACH_FLAT_RANGE(fr, view) {
             if (fr->mr == mr) {
-                MemoryRegionSection mrs = section_from_flat_range(fr, as);
+                MemoryRegionSection mrs = section_from_flat_range(fr,
+                        address_space_to_dispatch(as));
+
                 listener->log_sync(listener, &mrs);
             }
         }
@@ -1938,7 +1942,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
     FOR_EACH_FLAT_RANGE(fr, view) {
         if (fr->mr == mr) {
             section = (MemoryRegionSection) {
-                .address_space = as,
+                .dispatch = address_space_to_dispatch(as),
                 .offset_within_address_space = int128_get64(fr->addr.start),
                 .size = fr->addr.size,
             };
@@ -2300,7 +2304,7 @@ static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
     }
 
     ret.mr = fr->mr;
-    ret.address_space = as;
+    ret.dispatch = address_space_to_dispatch(as);
     range = addrrange_intersection(range, fr->addr);
     ret.offset_within_region = fr->offset_in_region;
     ret.offset_within_region += int128_get64(int128_sub(range.start,
@@ -2349,7 +2353,9 @@ void memory_global_dirty_log_sync(void)
         view = address_space_get_flatview(as);
         FOR_EACH_FLAT_RANGE(fr, view) {
             if (fr->dirty_log_mask) {
-                MemoryRegionSection mrs = section_from_flat_range(fr, as);
+                MemoryRegionSection mrs = section_from_flat_range(fr,
+                        address_space_to_dispatch(as));
+
                 listener->log_sync(listener, &mrs);
             }
         }
@@ -2434,7 +2440,7 @@ static void listener_add_address_space(MemoryListener *listener,
     FOR_EACH_FLAT_RANGE(fr, view) {
         MemoryRegionSection section = {
             .mr = fr->mr,
-            .address_space = as,
+            .dispatch = address_space_to_dispatch(as),
             .offset_within_region = fr->offset_in_region,
             .size = fr->addr.size,
             .offset_within_address_space = int128_get64(fr->addr.start),
-- 
2.11.0
