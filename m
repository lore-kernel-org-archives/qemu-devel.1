Received: from eggs.gnu.org ([2001:4830:134:3::10]:58641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmluk-0006d9-Vq
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmluk-00074d-56
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:38 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:40 +0200
Message-Id: <1533586484-5737-13-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 12/16] virtio_iommu: Handle reserved regions
 in translation process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

When translating an address we need to check if it belongs to
a reserved virtual address range. If it does, there are 2 cases:

- it belongs to a RESERVED region: the guest should neither use
  this address in a MAP not instruct the end-point to DMA on
  them. We report an error

- It belongs to an MSI region: we bypass the translation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7b77b3b..6a1d214 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -749,6 +749,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     viommu_mapping *mapping;
     viommu_interval interval;
     bool read_fault, write_fault;
+    struct virtio_iommu_probe_resv_mem *reg;
 
     interval.low = addr;
     interval.high = addr + 1;
@@ -774,6 +775,21 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto unlock;
     }
 
+    reg = g_tree_lookup(ep->reserved_regions, (gpointer)(&interval));
+    if (reg) {
+        switch (reg->subtype) {
+        case VIRTIO_IOMMU_RESV_MEM_T_MSI:
+            entry.perm = flag;
+            break;
+        case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
+        default:
+            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                      0, sid, addr);
+            break;
+        }
+        goto unlock;
+    }
+
     if (!ep->domain) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s %02x:%02x.%01x not attached to any domain\n",
-- 
2.5.5
