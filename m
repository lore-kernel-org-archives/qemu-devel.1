Received: from eggs.gnu.org ([2001:4830:134:3::10]:51839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDq-0002tW-00
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDm-0007pa-Pn
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRsDm-0007p3-Hc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:06 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 13 Jan 2017 11:06:37 +0800
Message-Id: <1484276800-26814-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-1-git-send-email-peterx@redhat.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 11/14] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

The default replay() don't work for VT-d since vt-d will have a huge
default memory region which covers address range 0-(2^64-1). This will
normally bring a dead loop when guest starts.

The solution is simple - we don't walk over all the regions. Instead, we
jump over the regions when we found that the page directories are empty.
It'll greatly reduce the time to walk the whole region.

To achieve this, we provided a page walk helper to do that, invoking
corresponding hook function when we found an page we are interested in.
vtd_page_walk_level() is the core logic for the page walking. It's
interface is designed to suite further use case, e.g., to invalidate a
range of addresses.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/i386/trace-events  |   8 ++
 include/exec/memory.h |   2 +
 3 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b4019d0..59bf683 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -600,6 +600,22 @@ static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
     return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
 }
 
+static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
+{
+    uint32_t ce_agaw = vtd_get_agaw_from_context_entry(ce);
+    return 1ULL << MIN(ce_agaw, VTD_MGAW);
+}
+
+/* Return true if IOVA passes range check, otherwise false. */
+static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce)
+{
+    /*
+     * Check if @iova is above 2^X-1, where X is the minimum of MGAW
+     * in CAP_REG and AW in context-entry.
+     */
+    return !(iova & ~(vtd_iova_limit(ce) - 1));
+}
+
 static const uint64_t vtd_paging_entry_rsvd_field[] = {
     [0] = ~0ULL,
     /* For not large page */
@@ -635,13 +651,9 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
     uint32_t level = vtd_get_level_from_context_entry(ce);
     uint32_t offset;
     uint64_t slpte;
-    uint32_t ce_agaw = vtd_get_agaw_from_context_entry(ce);
     uint64_t access_right_check;
 
-    /* Check if @iova is above 2^X-1, where X is the minimum of MGAW
-     * in CAP_REG and AW in context-entry.
-     */
-    if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
+    if (!vtd_iova_range_check(iova, ce)) {
         error_report("IOVA 0x%"PRIx64 " exceeds limits", iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
@@ -689,6 +701,166 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
     }
 }
 
+typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
+
+/**
+ * vtd_page_walk_level - walk over specific level for IOVA range
+ *
+ * @addr: base GPA addr to start the walk
+ * @start: IOVA range start address
+ * @end: IOVA range end address (start <= addr < end)
+ * @hook_fn: hook func to be called when detected page
+ * @private: private data to be passed into hook func
+ * @read: whether parent level has read permission
+ * @write: whether parent level has write permission
+ * @skipped: accumulated skipped ranges
+ * @notify_unmap: whether we should notify invalid entries
+ */
+static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
+                               uint64_t end, vtd_page_walk_hook hook_fn,
+                               void *private, uint32_t level,
+                               bool read, bool write, uint64_t *skipped,
+                               bool notify_unmap)
+{
+    bool read_cur, write_cur, entry_valid;
+    uint32_t offset;
+    uint64_t slpte;
+    uint64_t subpage_size, subpage_mask;
+    IOMMUTLBEntry entry;
+    uint64_t iova = start;
+    uint64_t iova_next;
+    uint64_t skipped_local = 0;
+    int ret = 0;
+
+    trace_vtd_page_walk_level(addr, level, start, end);
+
+    subpage_size = 1ULL << vtd_slpt_level_shift(level);
+    subpage_mask = vtd_slpt_level_page_mask(level);
+
+    while (iova < end) {
+        iova_next = (iova & subpage_mask) + subpage_size;
+
+        offset = vtd_iova_level_offset(iova, level);
+        slpte = vtd_get_slpte(addr, offset);
+
+        /*
+         * When one of the following case happens, we assume the whole
+         * range is invalid:
+         *
+         * 1. read block failed
+         * 3. reserved area non-zero
+         * 2. both read & write flag are not set
+         */
+
+        if (slpte == (uint64_t)-1) {
+            trace_vtd_page_walk_skip_read(iova, iova_next);
+            skipped_local++;
+            goto next;
+        }
+
+        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
+            trace_vtd_page_walk_skip_reserve(iova, iova_next);
+            skipped_local++;
+            goto next;
+        }
+
+        /* Permissions are stacked with parents' */
+        read_cur = read && (slpte & VTD_SL_R);
+        write_cur = write && (slpte & VTD_SL_W);
+
+        /*
+         * As long as we have either read/write permission, this is
+         * a valid entry. The rule works for both page or page tables.
+         */
+        entry_valid = read_cur | write_cur;
+
+        if (vtd_is_last_slpte(slpte, level)) {
+            entry.target_as = &address_space_memory;
+            entry.iova = iova & subpage_mask;
+            /*
+             * This might be meaningless addr if (!read_cur &&
+             * !write_cur), but after all this field will be
+             * meaningless in that case, so let's share the code to
+             * generate the IOTLBs no matter it's an MAP or UNMAP
+             */
+            entry.translated_addr = vtd_get_slpte_addr(slpte);
+            entry.addr_mask = ~subpage_mask;
+            entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
+            if (!entry_valid && !notify_unmap) {
+                trace_vtd_page_walk_skip_perm(iova, iova_next);
+                skipped_local++;
+                goto next;
+            }
+            trace_vtd_page_walk_one(level, entry.iova, entry.translated_addr,
+                                    entry.addr_mask, entry.perm);
+            if (hook_fn) {
+                ret = hook_fn(&entry, private);
+                if (ret < 0) {
+                    error_report("Detected error in page walk hook "
+                                 "function, stop walk.");
+                    return ret;
+                }
+            }
+        } else {
+            if (!entry_valid) {
+                trace_vtd_page_walk_skip_perm(iova, iova_next);
+                skipped_local++;
+                goto next;
+            }
+            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte), iova,
+                                      MIN(iova_next, end), hook_fn, private,
+                                      level - 1, read_cur, write_cur,
+                                      &skipped_local, notify_unmap);
+            if (ret < 0) {
+                error_report("Detected page walk error on addr 0x%"PRIx64
+                             " level %"PRIu32", stop walk.", addr, level - 1);
+                return ret;
+            }
+        }
+
+next:
+        iova = iova_next;
+    }
+
+    if (skipped) {
+        *skipped += skipped_local;
+    }
+
+    return 0;
+}
+
+/**
+ * vtd_page_walk - walk specific IOVA range, and call the hook
+ *
+ * @ce: context entry to walk upon
+ * @start: IOVA address to start the walk
+ * @end: IOVA range end address (start <= addr < end)
+ * @hook_fn: the hook that to be called for each detected area
+ * @private: private data for the hook function
+ */
+static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
+                         vtd_page_walk_hook hook_fn, void *private)
+{
+    dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
+    uint32_t level = vtd_get_level_from_context_entry(ce);
+
+    if (!vtd_iova_range_check(start, ce)) {
+        error_report("IOVA start 0x%"PRIx64 " end 0x%"PRIx64" exceeds limits",
+                     start, end);
+        return -VTD_FR_ADDR_BEYOND_MGAW;
+    }
+
+    if (!vtd_iova_range_check(end, ce)) {
+        /* Fix end so that it reaches the maximum */
+        end = vtd_iova_limit(ce);
+    }
+
+    trace_vtd_page_walk(ce->hi, ce->lo, start, end);
+
+    return vtd_page_walk_level(addr, start, end, hook_fn, private,
+                               level, true, true, NULL, false);
+}
+
 /* Map a device to its corresponding domain (context-entry) */
 static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
                                     uint8_t devfn, VTDContextEntry *ce)
@@ -2426,6 +2598,35 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
+{
+    memory_region_notify_one((IOMMUNotifier *)private, entry);
+    return 0;
+}
+
+static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
+{
+    VTDAddressSpace *vtd_as = container_of(mr, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint8_t bus_n = pci_bus_num(vtd_as->bus);
+    VTDContextEntry ce;
+
+    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
+        /*
+         * Scanned a valid context entry, walk over the pages and
+         * notify when needed.
+         */
+        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
+                                  PCI_FUNC(vtd_as->devfn), ce.hi, ce.lo);
+        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
+    } else {
+        trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
+                                    PCI_FUNC(vtd_as->devfn));
+    }
+
+    return;
+}
+
 /* Do the initialization. It will also be called when reset, so pay
  * attention when adding new initialization stuff.
  */
@@ -2440,6 +2641,7 @@ static void vtd_init(IntelIOMMUState *s)
 
     s->iommu_ops.translate = vtd_iommu_translate;
     s->iommu_ops.notify_flag_changed = vtd_iommu_notify_flag_changed;
+    s->iommu_ops.replay = vtd_iommu_replay;
     s->root = 0;
     s->root_extended = false;
     s->dmar_enabled = false;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index eba9bf2..92d210d 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -29,6 +29,14 @@ vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t doma
 vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
 vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
 vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
+vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8" hi 0x%"PRIx64" lo 0x%"PRIx64
+vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
+vtd_page_walk(uint64_t hi, uint64_t lo, uint64_t start, uint64_t end) "Page walk for ce (0x%"PRIx64", 0x%"PRIx64") iova range 0x%"PRIx64" - 0x%"PRIx64
+vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "Page walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
+vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "Page walk detected map level 0x%"PRIx32" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
+vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
+vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
+vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
diff --git a/include/exec/memory.h b/include/exec/memory.h
index cff6958..49664f4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -59,6 +59,8 @@ typedef enum {
     IOMMU_RW   = 3,
 } IOMMUAccessFlags;
 
+#define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : 0))
+
 struct IOMMUTLBEntry {
     AddressSpace    *target_as;
     hwaddr           iova;
-- 
2.7.4
