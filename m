Received: from eggs.gnu.org ([2001:4830:134:3::10]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egN1l-0007Jh-9t
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1egN1h-0002Bo-Cp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:56:09 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 30 Jan 2018 14:55:26 +1100
Message-Id: <20180130035527.47336-2-aik@ozlabs.ru>
In-Reply-To: <20180130035527.47336-1-aik@ozlabs.ru>
References: <20180130035527.47336-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 1/2] vfio/common: Add 'p2p' property to
 enable DMA mapping of MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>

At the moment we map all RAM memory regions for possible DMA including
MMIO regions of passed through device as this might be used for P2P PCI.
However if DMA map fails for whatever reason, we fail and exit QEMU.
Since P2P is not widely used and tested, it makes sense to exclude
MMIO regions from DMA mapping by default and add a flag to enable these
when needed.

This adds a "p2p" option for "vfio-pci" device and
vfio_listener_skipped_section() checks for it so region_add/del() skip
these by default. The MMIO region needs initialized mr::owner which
is set anyway.

This avoids DMA map when start and/or size of the area is not aligned
to the minimal IOMMU page size as it is known to fail; the diagnostic
message is printed in this case.

This avoids exiting QEMU if QEMU tried DMA map and failed for some other
reason that misalignment; this should allow to experiment when needed.

This adds necessary checks to the vfio_listener_region_del() hook.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 59 ++++++++++++++++++++++++++++++++++++++-----
 hw/vfio/pci.c                 |  1 +
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9..8c7ba75 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -121,6 +121,7 @@ typedef struct VFIODevice {
     bool reset_works;
     bool needs_reset;
     bool no_mmap;
+    bool p2p;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3d652c8..8aaed8d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -305,7 +305,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
             * are never accessed by the CPU and beyond the address width of
             * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
             */
-           section->offset_within_address_space & (1ULL << 63);
+           section->offset_within_address_space & (1ULL << 63) ||
+           /*
+            * Allow mapping of MMIO only if the device has p2p=true.
+            */
+           (memory_region_is_ram_device(section->mr) &&
+            (!section->mr->owner ||
+             !object_property_get_bool(section->mr->owner, "p2p", NULL)));
 }
 
 /* Called with rcu_read_lock held.  */
@@ -508,6 +514,18 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     /* Here we assume that memory_region_is_ram(section->mr)==true */
+    if (memory_region_is_ram_device(section->mr)) {
+        hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
+
+        if ((section->offset_within_region & pgmask) ||
+            (int128_getlo(section->size) & pgmask)) {
+            error_report("Region %"HWADDR_PRIx"..%"HWADDR_PRIx" is not aligned to %"HWADDR_PRIx" and cannot be mapped for DMA",
+                         section->offset_within_region,
+                         int128_getlo(section->size),
+                         pgmask + 1);
+            return;
+        }
+    }
 
     vaddr = memory_region_get_ram_ptr(section->mr) +
             section->offset_within_region +
@@ -523,6 +541,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
         error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
                      "0x%"HWADDR_PRIx", %p) = %d (%m)",
                      container, iova, int128_get64(llsize), vaddr, ret);
+        if (memory_region_is_ram_device(section->mr)) {
+            return;
+        }
         goto fail;
     }
 
@@ -550,6 +571,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
+    bool try_unmap = true;
 
     if (vfio_listener_skipped_section(section)) {
         trace_vfio_listener_region_del_skip(
@@ -602,13 +624,36 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     trace_vfio_listener_region_del(iova, end);
 
-    ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
+    if (memory_region_is_ram_device(section->mr)) {
+        hwaddr pgmask;
+        VFIOHostDMAWindow *hostwin;
+        bool hostwin_found;
+
+        hostwin_found = false;
+        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+            if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
+                hostwin_found = true;
+                break;
+            }
+        }
+        assert(hostwin_found);
+
+        pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
+
+        try_unmap = !(section->offset_within_region & pgmask) &&
+            !(int128_getlo(section->size) & pgmask);
+    }
+
+    if (try_unmap) {
+        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
+        if (ret) {
+            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
+                         "0x%"HWADDR_PRIx") = %d (%m)",
+                         container, iova, int128_get64(llsize), ret);
+        }
+    }
+
     memory_region_unref(section->mr);
-    if (ret) {
-        error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                     "0x%"HWADDR_PRIx") = %d (%m)",
-                     container, iova, int128_get64(llsize), ret);
-    }
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
         vfio_spapr_remove_window(container,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2c71295..5b20620 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2999,6 +2999,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
+    DEFINE_PROP_BOOL("p2p", VFIOPCIDevice, vbasedev.p2p, false),
     /*
      * TODO - support passed fds... is this necessary?
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
-- 
2.11.0
