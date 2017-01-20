Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYx8-00021a-DE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYx6-0002iS-CI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:10:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYx6-0002iA-2s
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:10:00 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jan 2017 21:08:55 +0800
Message-Id: <1484917736-32056-20-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4 19/20] intel_iommu: unmap existing pages
 before replay
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

Previous replay works for domain switch only if the original domain does
not have mapped pages. For example, if we switch domain from A to B, it
will only work if A has no existing mapping. If there is, then there's
problem - current replay didn't make sure the old mappings are cleared
before replaying the new one.

This patch let the replay go well even if original domain A has existing
mappings.

The idea is, when we replay, we unmap the whole address space first, no
matter what. Then, we replay the region, rebuild the pages.

We are leveraging the feature provided by vfio driver that it allows to
unmap a very big range of region, even if it is bigger than the mapped
area. It'll free all the mapped pages within the range. Here, we
choosed (0, 1ULL << VTD_MGAW) as the range to make sure every mapped
pages are unmapped.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 64 ++++++++++++++++++++++++++++++++++++++++--
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/trace-events           |  1 +
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7cbf057..a038651 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2696,6 +2696,63 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+/*
+ * Unmap the whole range in the notifier's scope. If we have recorded
+ * any high watermark (VTDAddressSpace.iova_max), we use it to limit
+ * the n->end as well.
+ */
+static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
+{
+    IOMMUTLBEntry entry;
+    hwaddr size;
+    hwaddr start = n->start;
+    hwaddr end = n->end;
+
+    /*
+     * Note: all the codes in this function has a assumption that IOVA
+     * bits are no more than VTD_MGAW bits (which is restricted by
+     * VT-d spec), otherwise we need to consider overflow of 64 bits.
+     */
+
+    if (end > VTD_ADDRESS_SIZE) {
+        /*
+         * Don't need to unmap regions that is bigger than the whole
+         * VT-d supported address space size
+         */
+        end = VTD_ADDRESS_SIZE;
+    }
+
+    assert(start <= end);
+    size = end - start;
+
+    if (ctpop64(size) != 1) {
+        /*
+         * This size cannot format a correct mask. Let's enlarge it to
+         * suite the minimum available mask.
+         */
+        int n = 64 - clz64(size);
+        if (n > VTD_MGAW) {
+            /* should not happen, but in case it happens, limit it */
+            trace_vtd_err("Address space unmap found size too big");
+            n = VTD_MGAW;
+        }
+        size = 1ULL << n;
+    }
+
+    entry.target_as = &address_space_memory;
+    entry.iova = n->start;
+    entry.translated_addr = 0;  /* useless for unmap */
+    entry.perm = IOMMU_NONE;
+    entry.addr_mask = size - 1;
+
+    trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
+                             VTD_PCI_SLOT(as->devfn),
+                             VTD_PCI_FUNC(as->devfn),
+                             entry.iova, size);
+
+    memory_region_notify_one(n, &entry);
+}
+
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
     memory_region_notify_one((IOMMUNotifier *)private, entry);
@@ -2711,13 +2768,16 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
 
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         /*
-         * Scanned a valid context entry, walk over the pages and
-         * notify when needed.
+         * Scanned a valid context entry, we first make sure to remove
+         * all existing mappings in old domain, by sending UNMAP to
+         * all the notifiers. Then, we walk over the pages and notify
+         * with existing mapped new entries in the new domain.
          */
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn),
                                   VTD_CONTEXT_ENTRY_DID(ce.hi),
                                   ce.hi, ce.lo);
+        vtd_address_space_unmap(vtd_as, n);
         vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n, false);
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 4104121..29d6707 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -197,6 +197,7 @@
 #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
 #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
 #define VTD_MGAW                    39  /* Maximum Guest Address Width */
+#define VTD_ADDRESS_SIZE            (1ULL << VTD_MGAW)
 #define VTD_CAP_MGAW                (((VTD_MGAW - 1) & 0x3fULL) << 16)
 #define VTD_MAMV                    18ULL
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index bd57b0a..ef725ca 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -38,6 +38,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
 vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
+vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.7.4
