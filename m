Received: from eggs.gnu.org ([2001:4830:134:3::10]:48455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCl-00052A-5o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCi-0001FH-DR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:31 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCi-0001CA-20
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:28 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:50:58 +1000
Message-Id: <20170921085110.25598-7-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 06/18] memory: Switch memory from using
 AddressSpace to FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

FlatView's will be shared between AddressSpace's and subpage_t
and MemoryRegionSection cannot store AS anymore, hence this change.

In particular, for:

 typedef struct subpage_t {
     MemoryRegion iomem;
-    AddressSpace *as;
+    FlatView *fv;
     hwaddr base;
     uint16_t sub_section[];
 } subpage_t;

  struct MemoryRegionSection {
     MemoryRegion *mr;
-    AddressSpace *address_space;
+    FlatView *fv;
     hwaddr offset_within_region;
     Int128 size;
     hwaddr offset_within_address_space;
     bool readonly;
 };

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* fixed compile warning/error about duplicated "typedef struct FlatView
FlatView"
---
 include/exec/memory-internal.h |   2 +-
 include/exec/memory.h          |  51 ++++++++----
 exec.c                         | 180 ++++++++++++++++++++++++-----------------
 hw/intc/openpic_kvm.c          |   2 +-
 memory.c                       |  29 +++----
 5 files changed, 157 insertions(+), 107 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 6e08eda256..1cf8ad9869 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -27,7 +27,7 @@ extern const MemoryRegionOps unassigned_mem_ops;
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
-void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section);
+void mem_add(FlatView *fv, MemoryRegionSection *section);
 AddressSpaceDispatch *mem_begin(AddressSpace *as);
 void mem_commit(AddressSpaceDispatch *d);
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2346f8b863..7816e5d655 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -48,6 +48,7 @@
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
+typedef struct FlatView FlatView;
 
 struct MemoryRegionMmio {
     CPUReadMemoryFunc *read[3];
@@ -320,6 +321,8 @@ struct AddressSpace {
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 };
 
+FlatView *address_space_to_flatview(AddressSpace *as);
+
 /**
  * MemoryRegionSection: describes a fragment of a #MemoryRegion
  *
@@ -333,7 +336,7 @@ struct AddressSpace {
  */
 struct MemoryRegionSection {
     MemoryRegion *mr;
-    AddressSpace *address_space;
+    FlatView *fv;
     hwaddr offset_within_region;
     Int128 size;
     hwaddr offset_within_address_space;
@@ -1842,9 +1845,17 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
  * @len: pointer to length
  * @is_write: indicates the transfer direction
  */
-MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
-                                      hwaddr *xlat, hwaddr *len,
-                                      bool is_write);
+MemoryRegion *flatview_translate(FlatView *fv,
+                                 hwaddr addr, hwaddr *xlat,
+                                 hwaddr *len, bool is_write);
+
+static inline MemoryRegion *address_space_translate(AddressSpace *as,
+                                                    hwaddr addr, hwaddr *xlat,
+                                                    hwaddr *len, bool is_write)
+{
+    return flatview_translate(address_space_to_flatview(as),
+                              addr, xlat, len, is_write);
+}
 
 /* address_space_access_valid: check for validity of accessing an address
  * space range
@@ -1895,12 +1906,13 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 
 /* Internal functions, part of the implementation of address_space_read.  */
-MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
-                                        MemTxAttrs attrs, uint8_t *buf,
-                                        int len, hwaddr addr1, hwaddr l,
-					MemoryRegion *mr);
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len);
+MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
+                                   MemTxAttrs attrs, uint8_t *buf,
+                                   int len, hwaddr addr1, hwaddr l,
+                                   MemoryRegion *mr);
+
+MemTxResult flatview_read_full(FlatView *fv, hwaddr addr,
+                               MemTxAttrs attrs, uint8_t *buf, int len);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
@@ -1927,8 +1939,8 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * @buf: buffer with the data transferred
  */
 static inline __attribute__((__always_inline__))
-MemTxResult address_space_read(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                               uint8_t *buf, int len)
+MemTxResult flatview_read(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
+                          uint8_t *buf, int len)
 {
     MemTxResult result = MEMTX_OK;
     hwaddr l, addr1;
@@ -1939,22 +1951,29 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
         if (len) {
             rcu_read_lock();
             l = len;
-            mr = address_space_translate(as, addr, &addr1, &l, false);
+            mr = flatview_translate(fv, addr, &addr1, &l, false);
             if (len == l && memory_access_is_direct(mr, false)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                 memcpy(buf, ptr, len);
             } else {
-                result = address_space_read_continue(as, addr, attrs, buf, len,
-                                                     addr1, l, mr);
+                result = flatview_read_continue(fv, addr, attrs, buf, len,
+                                                addr1, l, mr);
             }
             rcu_read_unlock();
         }
     } else {
-        result = address_space_read_full(as, addr, attrs, buf, len);
+        result = flatview_read_full(fv, addr, attrs, buf, len);
     }
     return result;
 }
 
+static inline MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
+                                             MemTxAttrs attrs, uint8_t *buf,
+                                             int len)
+{
+    return flatview_read(address_space_to_flatview(as), addr, attrs, buf, len);
+}
+
 /**
  * address_space_read_cached: read from a cached RAM region
  *
diff --git a/exec.c b/exec.c
index a54dde7835..d2b9f60494 100644
--- a/exec.c
+++ b/exec.c
@@ -198,7 +198,7 @@ struct AddressSpaceDispatch {
 #define SUBPAGE_IDX(addr) ((addr) & ~TARGET_PAGE_MASK)
 typedef struct subpage_t {
     MemoryRegion iomem;
-    AddressSpace *as;
+    FlatView *fv;
     hwaddr base;
     uint16_t sub_section[];
 } subpage_t;
@@ -468,13 +468,13 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
 }
 
 /* Called from RCU critical section */
-static MemoryRegionSection address_space_do_translate(AddressSpace *as,
-                                                      hwaddr addr,
-                                                      hwaddr *xlat,
-                                                      hwaddr *plen,
-                                                      bool is_write,
-                                                      bool is_mmio,
-                                                      AddressSpace **target_as)
+static MemoryRegionSection flatview_do_translate(FlatView *fv,
+                                                 hwaddr addr,
+                                                 hwaddr *xlat,
+                                                 hwaddr *plen,
+                                                 bool is_write,
+                                                 bool is_mmio,
+                                                 AddressSpace **target_as)
 {
     IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
@@ -482,8 +482,9 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
     IOMMUMemoryRegionClass *imrc;
 
     for (;;) {
-        AddressSpaceDispatch *d = address_space_to_dispatch(as);
-        section = address_space_translate_internal(d, addr, &addr, plen, is_mmio);
+        section = address_space_translate_internal(
+                flatview_to_dispatch(fv), addr, &addr,
+                plen, is_mmio);
 
         iommu_mr = memory_region_get_iommu(section->mr);
         if (!iommu_mr) {
@@ -500,7 +501,7 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
             goto translate_fail;
         }
 
-        as = iotlb.target_as;
+        fv = address_space_to_flatview(iotlb.target_as);
         *target_as = iotlb.target_as;
     }
 
@@ -523,8 +524,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     plen = (hwaddr)-1;
 
     /* This can never be MMIO. */
-    section = address_space_do_translate(as, addr, &xlat, &plen,
-                                         is_write, false, &as);
+    section = flatview_do_translate(address_space_to_flatview(as), addr,
+                                    &xlat, &plen, is_write, false, &as);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -560,16 +561,15 @@ iotlb_fail:
 }
 
 /* Called from RCU critical section */
-MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
-                                      hwaddr *xlat, hwaddr *plen,
-                                      bool is_write)
+MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
+                                 hwaddr *plen, bool is_write)
 {
     MemoryRegion *mr;
     MemoryRegionSection section;
+    AddressSpace *as = NULL;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = address_space_do_translate(as, addr, xlat, plen, is_write, true,
-                                         &as);
+    section = flatview_do_translate(fv, addr, xlat, plen, is_write, true, &as);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
@@ -1219,7 +1219,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     } else {
         AddressSpaceDispatch *d;
 
-        d = address_space_to_dispatch(section->address_space);
+        d = flatview_to_dispatch(section->fv);
         iotlb = section - d->map.sections;
         iotlb += xlat;
     }
@@ -1245,7 +1245,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 
 static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
                              uint16_t section);
-static subpage_t *subpage_init(AddressSpace *as, hwaddr base);
+static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 
 static void *(*phys_mem_alloc)(size_t size, uint64_t *align) =
                                qemu_anon_ram_alloc;
@@ -1302,7 +1302,7 @@ static void phys_sections_free(PhysPageMap *map)
     g_free(map->nodes);
 }
 
-static void register_subpage(AddressSpace *as, AddressSpaceDispatch *d,
+static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
                              MemoryRegionSection *section)
 {
     subpage_t *subpage;
@@ -1318,8 +1318,8 @@ static void register_subpage(AddressSpace *as, AddressSpaceDispatch *d,
     assert(existing->mr->subpage || existing->mr == &io_mem_unassigned);
 
     if (!(existing->mr->subpage)) {
-        subpage = subpage_init(as, base);
-        subsection.address_space = as;
+        subpage = subpage_init(fv, base);
+        subsection.fv = fv;
         subsection.mr = &subpage->iomem;
         phys_page_set(d, base >> TARGET_PAGE_BITS, 1,
                       phys_section_add(&d->map, &subsection));
@@ -1345,7 +1345,7 @@ static void register_multipage(AddressSpaceDispatch *d,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section)
+void mem_add(FlatView *fv, MemoryRegionSection *section)
 {
     AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     MemoryRegionSection now = *section, remain = *section;
@@ -1356,7 +1356,7 @@ void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
-        register_subpage(as, d, &now);
+        register_subpage(fv, d, &now);
     } else {
         now.size = int128_zero();
     }
@@ -1366,10 +1366,10 @@ void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section)
         remain.offset_within_region += int128_get64(now.size);
         now = remain;
         if (int128_lt(remain.size, page_size)) {
-            register_subpage(as, d, &now);
+            register_subpage(fv, d, &now);
         } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
             now.size = page_size;
-            register_subpage(as, d, &now);
+            register_subpage(fv, d, &now);
         } else {
             now.size = int128_and(now.size, int128_neg(page_size));
             register_multipage(d, &now);
@@ -2500,6 +2500,11 @@ static const MemoryRegionOps watch_mem_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
+                                  const uint8_t *buf, int len);
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+                                  bool is_write);
+
 static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
                                 unsigned len, MemTxAttrs attrs)
 {
@@ -2511,8 +2516,7 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     printf("%s: subpage %p len %u addr " TARGET_FMT_plx "\n", __func__,
            subpage, len, addr);
 #endif
-    res = address_space_read(subpage->as, addr + subpage->base,
-                             attrs, buf, len);
+    res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
     if (res) {
         return res;
     }
@@ -2561,8 +2565,7 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
     default:
         abort();
     }
-    return address_space_write(subpage->as, addr + subpage->base,
-                               attrs, buf, len);
+    return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
 }
 
 static bool subpage_accepts(void *opaque, hwaddr addr,
@@ -2574,8 +2577,8 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
            __func__, subpage, is_write ? 'w' : 'r', len, addr);
 #endif
 
-    return address_space_access_valid(subpage->as, addr + subpage->base,
-                                      len, is_write);
+    return flatview_access_valid(subpage->fv, addr + subpage->base,
+                                 len, is_write);
 }
 
 static const MemoryRegionOps subpage_ops = {
@@ -2609,12 +2612,12 @@ static int subpage_register (subpage_t *mmio, uint32_t start, uint32_t end,
     return 0;
 }
 
-static subpage_t *subpage_init(AddressSpace *as, hwaddr base)
+static subpage_t *subpage_init(FlatView *fv, hwaddr base)
 {
     subpage_t *mmio;
 
     mmio = g_malloc0(sizeof(subpage_t) + TARGET_PAGE_SIZE * sizeof(uint16_t));
-    mmio->as = as;
+    mmio->fv = fv;
     mmio->base = base;
     memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
                           NULL, TARGET_PAGE_SIZE);
@@ -2628,12 +2631,11 @@ static subpage_t *subpage_init(AddressSpace *as, hwaddr base)
     return mmio;
 }
 
-static uint16_t dummy_section(PhysPageMap *map, AddressSpace *as,
-                              MemoryRegion *mr)
+static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
 {
-    assert(as);
+    assert(fv);
     MemoryRegionSection section = {
-        .address_space = as,
+        .fv = fv,
         .mr = mr,
         .offset_within_address_space = 0,
         .offset_within_region = 0,
@@ -2672,16 +2674,17 @@ static void io_mem_init(void)
 
 AddressSpaceDispatch *mem_begin(AddressSpace *as)
 {
+    FlatView *fv = address_space_to_flatview(as);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
-    n = dummy_section(&d->map, as, &io_mem_unassigned);
+    n = dummy_section(&d->map, fv, &io_mem_unassigned);
     assert(n == PHYS_SECTION_UNASSIGNED);
-    n = dummy_section(&d->map, as, &io_mem_notdirty);
+    n = dummy_section(&d->map, fv, &io_mem_notdirty);
     assert(n == PHYS_SECTION_NOTDIRTY);
-    n = dummy_section(&d->map, as, &io_mem_rom);
+    n = dummy_section(&d->map, fv, &io_mem_rom);
     assert(n == PHYS_SECTION_ROM);
-    n = dummy_section(&d->map, as, &io_mem_watch);
+    n = dummy_section(&d->map, fv, &io_mem_watch);
     assert(n == PHYS_SECTION_WATCH);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
@@ -2861,11 +2864,11 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 }
 
 /* Called within RCU critical section.  */
-static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
-                                                MemTxAttrs attrs,
-                                                const uint8_t *buf,
-                                                int len, hwaddr addr1,
-                                                hwaddr l, MemoryRegion *mr)
+static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
+                                           MemTxAttrs attrs,
+                                           const uint8_t *buf,
+                                           int len, hwaddr addr1,
+                                           hwaddr l, MemoryRegion *mr)
 {
     uint8_t *ptr;
     uint64_t val;
@@ -2927,14 +2930,14 @@ static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
         }
 
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true);
+        mr = flatview_translate(fv, addr, &addr1, &l, true);
     }
 
     return result;
 }
 
-MemTxResult address_space_write(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                                const uint8_t *buf, int len)
+static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
+                                  const uint8_t *buf, int len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -2944,20 +2947,27 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     if (len > 0) {
         rcu_read_lock();
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, true);
-        result = address_space_write_continue(as, addr, attrs, buf, len,
-                                              addr1, l, mr);
+        mr = flatview_translate(fv, addr, &addr1, &l, true);
+        result = flatview_write_continue(fv, addr, attrs, buf, len,
+                                         addr1, l, mr);
         rcu_read_unlock();
     }
 
     return result;
 }
 
+MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                              MemTxAttrs attrs,
+                                              const uint8_t *buf, int len)
+{
+    return flatview_write(address_space_to_flatview(as), addr, attrs, buf, len);
+}
+
 /* Called within RCU critical section.  */
-MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
-                                        MemTxAttrs attrs, uint8_t *buf,
-                                        int len, hwaddr addr1, hwaddr l,
-                                        MemoryRegion *mr)
+MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
+                                   MemTxAttrs attrs, uint8_t *buf,
+                                   int len, hwaddr addr1, hwaddr l,
+                                   MemoryRegion *mr)
 {
     uint8_t *ptr;
     uint64_t val;
@@ -3017,14 +3027,14 @@ MemTxResult address_space_read_continue(AddressSpace *as, hwaddr addr,
         }
 
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, false);
+        mr = flatview_translate(fv, addr, &addr1, &l, false);
     }
 
     return result;
 }
 
-MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, uint8_t *buf, int len)
+MemTxResult flatview_read_full(FlatView *fv, hwaddr addr,
+                               MemTxAttrs attrs, uint8_t *buf, int len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3034,25 +3044,33 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
     if (len > 0) {
         rcu_read_lock();
         l = len;
-        mr = address_space_translate(as, addr, &addr1, &l, false);
-        result = address_space_read_continue(as, addr, attrs, buf, len,
-                                             addr1, l, mr);
+        mr = flatview_translate(fv, addr, &addr1, &l, false);
+        result = flatview_read_continue(fv, addr, attrs, buf, len,
+                                        addr1, l, mr);
         rcu_read_unlock();
     }
 
     return result;
 }
 
-MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
-                             uint8_t *buf, int len, bool is_write)
+static MemTxResult flatview_rw(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
+                               uint8_t *buf, int len, bool is_write)
 {
     if (is_write) {
-        return address_space_write(as, addr, attrs, (uint8_t *)buf, len);
+        return flatview_write(fv, addr, attrs, (uint8_t *)buf, len);
     } else {
-        return address_space_read(as, addr, attrs, (uint8_t *)buf, len);
+        return flatview_read(fv, addr, attrs, (uint8_t *)buf, len);
     }
 }
 
+MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
+                             MemTxAttrs attrs, uint8_t *buf,
+                             int len, bool is_write)
+{
+    return flatview_rw(address_space_to_flatview(as),
+                       addr, attrs, buf, len, is_write);
+}
+
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write)
 {
@@ -3210,7 +3228,8 @@ static void cpu_notify_map_clients(void)
     qemu_mutex_unlock(&map_client_list_lock);
 }
 
-bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_write)
+static bool flatview_access_valid(FlatView *fv, hwaddr addr, int len,
+                                  bool is_write)
 {
     MemoryRegion *mr;
     hwaddr l, xlat;
@@ -3218,7 +3237,7 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
     rcu_read_lock();
     while (len > 0) {
         l = len;
-        mr = address_space_translate(as, addr, &xlat, &l, is_write);
+        mr = flatview_translate(fv, addr, &xlat, &l, is_write);
         if (!memory_access_is_direct(mr, is_write)) {
             l = memory_access_size(mr, l, addr);
             if (!memory_region_access_valid(mr, xlat, l, is_write)) {
@@ -3234,8 +3253,16 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr, int len, bool is_
     return true;
 }
 
+bool address_space_access_valid(AddressSpace *as, hwaddr addr,
+                                int len, bool is_write)
+{
+    return flatview_access_valid(address_space_to_flatview(as),
+                                 addr, len, is_write);
+}
+
 static hwaddr
-address_space_extend_translation(AddressSpace *as, hwaddr addr, hwaddr target_len,
+flatview_extend_translation(FlatView *fv, hwaddr addr,
+                                 hwaddr target_len,
                                  MemoryRegion *mr, hwaddr base, hwaddr len,
                                  bool is_write)
 {
@@ -3252,7 +3279,8 @@ address_space_extend_translation(AddressSpace *as, hwaddr addr, hwaddr target_le
         }
 
         len = target_len;
-        this_mr = address_space_translate(as, addr, &xlat, &len, is_write);
+        this_mr = flatview_translate(fv, addr, &xlat,
+                                                   &len, is_write);
         if (this_mr != mr || xlat != base + done) {
             return done;
         }
@@ -3275,6 +3303,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr l, xlat;
     MemoryRegion *mr;
     void *ptr;
+    FlatView *fv = address_space_to_flatview(as);
 
     if (len == 0) {
         return NULL;
@@ -3282,7 +3311,7 @@ void *address_space_map(AddressSpace *as,
 
     l = len;
     rcu_read_lock();
-    mr = address_space_translate(as, addr, &xlat, &l, is_write);
+    mr = flatview_translate(fv, addr, &xlat, &l, is_write);
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
@@ -3298,7 +3327,7 @@ void *address_space_map(AddressSpace *as,
         memory_region_ref(mr);
         bounce.mr = mr;
         if (!is_write) {
-            address_space_read(as, addr, MEMTXATTRS_UNSPECIFIED,
+            flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
                                bounce.buffer, l);
         }
 
@@ -3309,7 +3338,8 @@ void *address_space_map(AddressSpace *as,
 
 
     memory_region_ref(mr);
-    *plen = address_space_extend_translation(as, addr, len, mr, xlat, l, is_write);
+    *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
+                                             l, is_write);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
     rcu_read_unlock();
 
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 0518e017c4..fa83420254 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -124,7 +124,7 @@ static void kvm_openpic_region_add(MemoryListener *listener,
     uint64_t reg_base;
     int ret;
 
-    if (section->address_space != &address_space_memory) {
+    if (section->fv != address_space_to_flatview(&address_space_memory)) {
         abort();
     }
 
diff --git a/memory.c b/memory.c
index 27d7aeffc2..1364500eb6 100644
--- a/memory.c
+++ b/memory.c
@@ -154,7 +154,8 @@ enum ListenerDirection { Forward, Reverse };
 /* No need to ref/unref .mr, the FlatRange keeps it alive.  */
 #define MEMORY_LISTENER_UPDATE_REGION(fr, as, dir, callback, _args...)  \
     do {                                                                \
-        MemoryRegionSection mrs = section_from_flat_range(fr, as);      \
+        MemoryRegionSection mrs = section_from_flat_range(fr,           \
+                address_space_to_flatview(as));                         \
         MEMORY_LISTENER_CALL(as, callback, dir, &mrs, ##_args);         \
     } while(0)
 
@@ -208,7 +209,6 @@ static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
 }
 
 typedef struct FlatRange FlatRange;
-typedef struct FlatView FlatView;
 
 /* Range of memory in the global map.  Addresses are absolute. */
 struct FlatRange {
@@ -238,11 +238,11 @@ typedef struct AddressSpaceOps AddressSpaceOps;
     for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
 
 static inline MemoryRegionSection
-section_from_flat_range(FlatRange *fr, AddressSpace *as)
+section_from_flat_range(FlatRange *fr, FlatView *fv)
 {
     return (MemoryRegionSection) {
         .mr = fr->mr,
-        .address_space = as,
+        .fv = fv,
         .offset_within_region = fr->offset_in_region,
         .size = fr->addr.size,
         .offset_within_address_space = int128_get64(fr->addr.start),
@@ -312,7 +312,7 @@ static void flatview_unref(FlatView *view)
     }
 }
 
-static FlatView *address_space_to_flatview(AddressSpace *as)
+FlatView *address_space_to_flatview(AddressSpace *as)
 {
     return atomic_rcu_read(&as->current_map);
 }
@@ -760,7 +760,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
                                                   fds_new[inew]))) {
             fd = &fds_old[iold];
             section = (MemoryRegionSection) {
-                .address_space = as,
+                .fv = address_space_to_flatview(as),
                 .offset_within_address_space = int128_get64(fd->addr.start),
                 .size = fd->addr.size,
             };
@@ -773,7 +773,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
                                                          fds_old[iold]))) {
             fd = &fds_new[inew];
             section = (MemoryRegionSection) {
-                .address_space = as,
+                .fv = address_space_to_flatview(as),
                 .offset_within_address_space = int128_get64(fd->addr.start),
                 .size = fd->addr.size,
             };
@@ -908,8 +908,8 @@ static void address_space_update_topology(AddressSpace *as)
     new_view->dispatch = mem_begin(as);
     for (i = 0; i < new_view->nr; i++) {
         MemoryRegionSection mrs =
-            section_from_flat_range(&new_view->ranges[i], as);
-        mem_add(as, new_view, &mrs);
+            section_from_flat_range(&new_view->ranges[i], new_view);
+        mem_add(new_view, &mrs);
     }
     mem_commit(new_view->dispatch);
 
@@ -1865,7 +1865,7 @@ void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
         view = address_space_get_flatview(as);
         FOR_EACH_FLAT_RANGE(fr, view) {
             if (fr->mr == mr) {
-                MemoryRegionSection mrs = section_from_flat_range(fr, as);
+                MemoryRegionSection mrs = section_from_flat_range(fr, view);
                 listener->log_sync(listener, &mrs);
             }
         }
@@ -1968,7 +1968,7 @@ static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpa
     FOR_EACH_FLAT_RANGE(fr, view) {
         if (fr->mr == mr) {
             section = (MemoryRegionSection) {
-                .address_space = as,
+                .fv = view,
                 .offset_within_address_space = int128_get64(fr->addr.start),
                 .size = fr->addr.size,
             };
@@ -2330,7 +2330,7 @@ static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
     }
 
     ret.mr = fr->mr;
-    ret.address_space = as;
+    ret.fv = view;
     range = addrrange_intersection(range, fr->addr);
     ret.offset_within_region = fr->offset_in_region;
     ret.offset_within_region += int128_get64(int128_sub(range.start,
@@ -2379,7 +2379,8 @@ void memory_global_dirty_log_sync(void)
         view = address_space_get_flatview(as);
         FOR_EACH_FLAT_RANGE(fr, view) {
             if (fr->dirty_log_mask) {
-                MemoryRegionSection mrs = section_from_flat_range(fr, as);
+                MemoryRegionSection mrs = section_from_flat_range(fr, view);
+
                 listener->log_sync(listener, &mrs);
             }
         }
@@ -2464,7 +2465,7 @@ static void listener_add_address_space(MemoryListener *listener,
     FOR_EACH_FLAT_RANGE(fr, view) {
         MemoryRegionSection section = {
             .mr = fr->mr,
-            .address_space = as,
+            .fv = view,
             .offset_within_region = fr->offset_in_region,
             .size = fr->addr.size,
             .offset_within_address_space = int128_get64(fr->addr.start),
-- 
2.11.0
