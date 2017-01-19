Received: from eggs.gnu.org ([2001:4830:134:3::10]:39571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU8yY-0006Ew-N1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU8yX-0008Hu-Ac
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cU8yX-0008HD-5D
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51A477E9C1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:25:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Jan 2017 17:25:30 +0800
Message-Id: <1484817932-14452-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1484817932-14452-1-git-send-email-peterx@redhat.com>
References: <1484817932-14452-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/3] vfio: trace map/unmap for notify as
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
Cc: Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com

We traces its range, but we don't know whether it's a MAP/UNMAP. Let's
dump it as well.

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
