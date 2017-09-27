Received: from eggs.gnu.org ([2001:4830:134:3::10]:35699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xf-0001Mc-DP
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xa-0008Kl-Ok
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:47 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Wed, 27 Sep 2017 12:03:18 +0530
Message-ID: <1506494000-31982-4-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/5] virtio-iommu: Call iommu notifier for
 attach/detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org, bharatb.yadav@gmail.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>

iommu-notifier are called when a device is attached
or detached to as address-space.
This is needed for VFIO.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
v3->v4:
 Follwoig fixes by Eric
 - Return "false" from virtio_iommu_mapping_unmap/map()
 - Calling virtio_iommu_notify_unmap/map() for all device in as

 hw/virtio/virtio-iommu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 085e972..ff91bce 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -127,8 +127,42 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
     memory_region_notify_iommu(mr, entry);
 }
 
+static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
+                                           gpointer data)
+{
+    viommu_mapping *mapping = (viommu_mapping *) value;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_unmap(mr, mapping->virt_addr, mapping->size);
+
+    return false;
+}
+
+static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
+                                         gpointer data)
+{
+    viommu_mapping *mapping = (viommu_mapping *) value;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_map(mr, mapping->virt_addr, mapping->phys_addr,
+                            mapping->size);
+
+    return false;
+}
+
 static void virtio_iommu_detach_dev_from_as(viommu_dev *dev)
 {
+    VirtioIOMMUNotifierNode *node;
+    VirtIOIOMMU *s = dev->viommu;
+    viommu_as *as = dev->as;
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        if (dev->id == node->iommu_dev->devfn) {
+            g_tree_foreach(as->mappings, virtio_iommu_mapping_unmap,
+                           &node->iommu_dev->iommu_mr);
+        }
+    }
+
     QLIST_REMOVE(dev, next);
     dev->as = NULL;
 }
@@ -260,6 +294,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     uint32_t asid = le32_to_cpu(req->address_space);
     uint32_t devid = le32_to_cpu(req->device);
     uint32_t reserved = le32_to_cpu(req->reserved);
+    VirtioIOMMUNotifierNode *node;
     viommu_as *as;
     viommu_dev *dev;
 
@@ -284,6 +319,14 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     dev->as = as;
     g_tree_ref(as->mappings);
 
+    /* replay existing address space mappings on the associated mr */
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        if (devid == node->iommu_dev->devfn) {
+            g_tree_foreach(as->mappings, virtio_iommu_mapping_map,
+                           &node->iommu_dev->iommu_mr);
+        }
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
1.9.3
