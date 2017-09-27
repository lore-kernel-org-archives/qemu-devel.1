Received: from eggs.gnu.org ([2001:4830:134:3::10]:35739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xl-0001Z3-DE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xk-0008Pg-DI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:53 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Wed, 27 Sep 2017 12:03:20 +0530
Message-ID: <1506494000-31982-6-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 5/5] virtio-iommu: add iommu notifier
 memory-region
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

Finally add notify_flag_changed() to for memory-region
access flag iommu flag change notifier

Finally add the memory notifier

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v3->v4:
 - notify_flag_changed functionality moved in separate patch
 - No other changes

 hw/virtio/trace-events   |  2 ++
 hw/virtio/virtio-iommu.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 840d54f..a9de0d4 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -52,3 +52,5 @@ virtio_iommu_set_page_size_mask(const char *iommu_mr, uint64_t mask) "mr=%s page
 virtio_iommu_notify_map(const char *name, hwaddr iova, hwaddr paddr, hwaddr map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
 virtio_iommu_notify_unmap(const char *name, hwaddr iova, hwaddr map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64""
 virtio_iommu_remap(hwaddr iova, hwaddr pa, hwaddr size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
+virtio_iommu_notify_flag_add(const char *iommu) "Add virtio-iommu notifier node for memory region %s"
+virtio_iommu_notify_flag_del(const char *iommu) "Del virtio-iommu notifier node for memory region %s"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index d4d34cf..a9b0d72 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -764,6 +764,36 @@ push:
     }
 }
 
+static void virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
+                                             IOMMUNotifierFlag old,
+                                             IOMMUNotifierFlag new)
+{
+    IOMMUDevice *sdev = container_of(iommu_mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    VirtioIOMMUNotifierNode *node = NULL;
+    VirtioIOMMUNotifierNode *next_node = NULL;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
+        node = g_malloc0(sizeof(*node));
+        node->iommu_dev = sdev;
+        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
+        return;
+    }
+
+    /* update notifier node with new flags */
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->iommu_dev == sdev) {
+            if (new == IOMMU_NOTIFIER_NONE) {
+                trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.name);
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+            return;
+        }
+    }
+}
+
 static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                             IOMMUAccessFlags flag)
 {
@@ -1041,6 +1071,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = virtio_iommu_translate;
     imrc->set_page_size_mask = virtio_iommu_set_page_size_mask;
     imrc->replay = virtio_iommu_replay;
+    imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
1.9.3
