Received: from eggs.gnu.org ([2001:4830:134:3::10]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyJ3-0004Nk-As
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyJ2-000636-Ac
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVyJ2-000631-56
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:26:28 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 24 Jan 2017 18:25:54 +0800
Message-Id: <1485253571-19058-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1485253571-19058-1-git-send-email-peterx@redhat.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 01/18] vfio: trace map/unmap for notify as
 well
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

We traces its range, but we don't know whether it's a MAP/UNMAP. Let's
dump it as well.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c     | 3 ++-
 hw/vfio/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 801578b..174f351 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -305,7 +305,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     void *vaddr;
     int ret;
 
-    trace_vfio_iommu_map_notify(iova, iova + iotlb->addr_mask);
+    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
+                                iova, iova + iotlb->addr_mask);
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ef81609..7ae8233 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -84,7 +84,7 @@ vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
 # hw/vfio/common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-vfio_iommu_map_notify(uint64_t iova_start, uint64_t iova_end) "iommu map @ %"PRIx64" - %"PRIx64
+vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ %"PRIx64" - %"PRIx64
 vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add %"PRIx64" - %"PRIx64
 vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] %"PRIx64" - %"PRIx64
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] %"PRIx64" - %"PRIx64" [%p]"
-- 
2.7.4
