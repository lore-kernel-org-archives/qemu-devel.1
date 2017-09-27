Received: from eggs.gnu.org ([2001:4830:134:3::10]:35553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xS-00019p-31
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dx5xQ-0008E2-NV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 02:36:34 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Wed, 27 Sep 2017 12:03:17 +0530
Message-ID: <1506494000-31982-3-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/5] virtio-iommu: Add iommu notifier for
 map/unmap
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

This patch extends VIRTIO_IOMMU_T_MAP/UNMAP request to
notify registered iommu-notifier.
This is needed for VFIO support,

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
v3->v4:
 Follwoig fixes by Eric
 - Calling virtio_iommu_notify_map() for all device in AS
 - virtio_iommu_notify_unmap() moved to a function,
   This is needed as per changes in base framework (v4)

 hw/virtio/trace-events           |  2 ++
 hw/virtio/virtio-iommu.c         | 69 ++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-iommu.h |  6 ++++
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 2793604..251b595 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -49,3 +49,5 @@ virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid)
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t addr, uint64_t size, uint32_t flags, size_t filled) "dev= %d, subtype=%d addr=0x%"PRIx64" size=0x%"PRIx64" flags=%d filled=0x%lx"
 virtio_iommu_fill_none_property(uint32_t devid) "devid=%d"
 virtio_iommu_set_page_size_mask(const char *iommu_mr, uint64_t mask) "mr=%s page_size_mask=0x%"PRIx64
+virtio_iommu_notify_map(const char *name, hwaddr iova, hwaddr paddr, hwaddr map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
+virtio_iommu_notify_unmap(const char *name, hwaddr iova, hwaddr map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64""
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1873b9a..085e972 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -95,6 +95,38 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     }
 }
 
+static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr iova,
+                                    hwaddr paddr, hwaddr size)
+{
+    IOMMUTLBEntry entry;
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = size - 1;
+
+    entry.iova = iova;
+    trace_virtio_iommu_notify_map(mr->parent_obj.name, iova, paddr, size);
+    entry.perm = IOMMU_RW;
+    entry.translated_addr = paddr;
+
+    memory_region_notify_iommu(mr, entry);
+}
+
+static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
+                                      hwaddr size)
+{
+    IOMMUTLBEntry entry;
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = size - 1;
+
+    entry.iova = iova;
+    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, iova, size);
+    entry.perm = IOMMU_NONE;
+    entry.translated_addr = 0;
+
+    memory_region_notify_iommu(mr, entry);
+}
+
 static void virtio_iommu_detach_dev_from_as(viommu_dev *dev)
 {
     QLIST_REMOVE(dev, next);
@@ -291,6 +323,8 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     viommu_as *as;
     viommu_interval *interval;
     viommu_mapping *mapping;
+    VirtioIOMMUNotifierNode *node;
+    viommu_dev *dev;
 
     interval = g_malloc0(sizeof(*interval));
 
@@ -318,9 +352,37 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
 
     g_tree_insert(as->mappings, interval, mapping);
 
+    /* All devices in an address-space share mapping */
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        QLIST_FOREACH(dev, &as->device_list, next) {
+            if (dev->id == node->iommu_dev->devfn) {
+                virtio_iommu_notify_map(&node->iommu_dev->iommu_mr,
+                                        virt_addr, phys_addr, size);
+            }
+        }
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
 
+static void virtio_iommu_remove_mapping(VirtIOIOMMU *s, viommu_as *as,
+                                        viommu_interval *interval)
+{
+    VirtioIOMMUNotifierNode *node;
+    viommu_dev *dev;
+
+    g_tree_remove(as->mappings, (gpointer)(interval));
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        QLIST_FOREACH(dev, &as->device_list, next) {
+            if (dev->id == node->iommu_dev->devfn) {
+                virtio_iommu_notify_unmap(&node->iommu_dev->iommu_mr,
+                                          interval->low,
+                                          interval->high - interval->low + 1);
+            }
+        }
+    }
+}
+
 static int virtio_iommu_unmap(VirtIOIOMMU *s,
                               struct virtio_iommu_req_unmap *req)
 {
@@ -352,18 +414,18 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
         current.high = high;
 
         if (low == interval.low && size >= mapping->size) {
-            g_tree_remove(as->mappings, (gpointer)(&current));
+            virtio_iommu_remove_mapping(s, as, &current);
             interval.low = high + 1;
             trace_virtio_iommu_unmap_left_interval(current.low, current.high,
                 interval.low, interval.high);
         } else if (high == interval.high && size >= mapping->size) {
             trace_virtio_iommu_unmap_right_interval(current.low, current.high,
                 interval.low, interval.high);
-            g_tree_remove(as->mappings, (gpointer)(&current));
+            virtio_iommu_remove_mapping(s, as, &current);
             interval.high = low - 1;
         } else if (low > interval.low && high < interval.high) {
             trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
-            g_tree_remove(as->mappings, (gpointer)(&current));
+            virtio_iommu_remove_mapping(s, as, &current);
         } else {
             break;
         }
@@ -806,6 +868,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
+    QLIST_INIT(&s->notifiers_list);
     virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
                 sizeof(struct virtio_iommu_config));
 
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index f9c988f..7e04184 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -46,6 +46,11 @@ typedef struct IOMMUPciBus {
     IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
 } IOMMUPciBus;
 
+typedef struct VirtioIOMMUNotifierNode {
+    IOMMUDevice *iommu_dev;
+    QLIST_ENTRY(VirtioIOMMUNotifierNode) next;
+} VirtioIOMMUNotifierNode;
+
 typedef struct VirtIOIOMMU {
     VirtIODevice parent_obj;
     VirtQueue *vq;
@@ -56,6 +61,7 @@ typedef struct VirtIOIOMMU {
     GTree *address_spaces;
     QemuMutex mutex;
     GTree *devices;
+    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
 } VirtIOIOMMU;
 
 #endif
-- 
1.9.3
