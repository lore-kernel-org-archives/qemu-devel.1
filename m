Received: from eggs.gnu.org ([2001:4830:134:3::10]:35669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xb-0001Fc-N1
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xa-0008Ks-QH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:43 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Wed, 27 Sep 2017 12:03:19 +0530
Message-ID: <1506494000-31982-5-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 4/5] virtio-iommu: add iommu replay
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

Default replay does not work with virtio-iommu,
so this patch provide virtio-iommu replay functionality.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v3->v4:
 - Replay functionality moved in separate patch
 - No other changes

 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 251b595..840d54f 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -51,3 +51,4 @@ virtio_iommu_fill_none_property(uint32_t devid) "devid=%d"
 virtio_iommu_set_page_size_mask(const char *iommu_mr, uint64_t mask) "mr=%s page_size_mask=0x%"PRIx64
 virtio_iommu_notify_map(const char *name, hwaddr iova, hwaddr paddr, hwaddr map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
 virtio_iommu_notify_unmap(const char *name, hwaddr iova, hwaddr map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64""
+virtio_iommu_remap(hwaddr iova, hwaddr pa, hwaddr size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index ff91bce..d4d34cf 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -906,6 +906,43 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     return (ua > ub) - (ua < ub);
 }
 
+static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
+{
+    viommu_mapping *mapping = (viommu_mapping *) value;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    trace_virtio_iommu_remap(mapping->virt_addr, mapping->phys_addr,
+                             mapping->size);
+    /* unmap previous entry and map again */
+    virtio_iommu_notify_unmap(mr, mapping->virt_addr, mapping->size);
+
+    virtio_iommu_notify_map(mr, mapping->virt_addr, mapping->phys_addr,
+                            mapping->size);
+    return false;
+}
+
+static void virtio_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint32_t sid;
+    viommu_dev *dev;
+
+    sid = virtio_iommu_get_sid(sdev);
+
+    qemu_mutex_lock(&s->mutex);
+
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
+    if (!dev || !dev->as) {
+        goto unlock;
+    }
+
+    g_tree_foreach(dev->as->mappings, virtio_iommu_remap, mr);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1003,6 +1040,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = virtio_iommu_translate;
     imrc->set_page_size_mask = virtio_iommu_set_page_size_mask;
+    imrc->replay = virtio_iommu_replay;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
1.9.3
