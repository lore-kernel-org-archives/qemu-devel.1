Received: from eggs.gnu.org ([2001:4830:134:3::10]:54459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVXoX-0001OD-RI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVXoT-0004tp-40
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:41:29 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Thu, 13 Jul 2017 12:08:42 +0530
Message-ID: <1499927922-32303-3-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1499927922-32303-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1499927922-32303-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 2/2] virtio-iommu: vfio integration with
 virtio-iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org, Bharat Bhushan <Bharat.Bhushan@nxp.com>

This patch allows virtio-iommu protection for PCI
device-passthrough.

MSI region is mapped by current version of virtio-iommu driver.
This MSI region mapping in not getting pushed on hw iommu
vfio_get_vaddr() allows only ram-region. This RFC patch needed
to be improved.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 hw/virtio/virtio-iommu.c         | 127 +++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |   6 ++
 2 files changed, 133 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index cd188fc..08d5a2f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -129,6 +129,46 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     }
 }
 
+static void virtio_iommu_map_region(VirtIOIOMMU *s, hwaddr iova, hwaddr paddr,
+                                    hwaddr size, int map)
+{
+    VirtioIOMMUNotifierNode *node;
+    IOMMUTLBEntry entry;
+    uint64_t map_size = (1 << 12);
+    int npages;
+    int i;
+
+    npages = size / map_size;
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = map_size - 1;
+
+    for (i = 0; i < npages; i++) {
+        entry.iova = iova + (i * map_size);
+        if (map) {
+                entry.perm = IOMMU_RW;
+                entry.translated_addr = paddr + (i * map_size);
+        } else {
+                entry.perm = IOMMU_NONE;
+                entry.translated_addr = 0;
+        }
+
+        QLIST_FOREACH(node, &s->notifiers_list, next) {
+            memory_region_notify_iommu(&node->iommu_dev->iommu_mr, entry);
+        }
+    }
+}
+
+static gboolean virtio_iommu_unmap_single(gpointer key, gpointer value,
+                                          gpointer data)
+{
+    viommu_mapping *mapping = (viommu_mapping *) value;
+    VirtIOIOMMU *s = (VirtIOIOMMU *) data;
+
+    virtio_iommu_map_region(s, mapping->virt_addr, 0, mapping->size, 0);
+
+    return true;
+}
+
 static int virtio_iommu_attach(VirtIOIOMMU *s,
                                struct virtio_iommu_req_attach *req)
 {
@@ -170,10 +210,26 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t devid = le32_to_cpu(req->device);
     uint32_t reserved = le32_to_cpu(req->reserved);
+    viommu_dev *dev;
     int ret;
 
     trace_virtio_iommu_detach(devid, reserved);
 
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
+    if (!dev || !dev->as) {
+        return -EINVAL;
+    }
+
+    dev->as->nr_devices--;
+
+    /* Unmap all if this is last device detached */
+    if (dev->as->nr_devices == 0) {
+        g_tree_foreach(dev->as->mappings, virtio_iommu_unmap_single, s);
+
+        g_tree_remove(s->address_spaces, GUINT_TO_POINTER(dev->as->id));
+        g_tree_destroy(dev->as->mappings);
+    }
+
     ret = g_tree_remove(s->devices, GUINT_TO_POINTER(devid));
 
     return ret ? VIRTIO_IOMMU_S_OK : VIRTIO_IOMMU_S_INVAL;
@@ -217,6 +273,7 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
 
     g_tree_insert(as->mappings, interval, mapping);
 
+    virtio_iommu_map_region(s, virt_addr, phys_addr, size, 1);
     return VIRTIO_IOMMU_S_OK;
 }
 
@@ -267,7 +324,9 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
         } else {
             break;
         }
+
         if (interval.low >= interval.high) {
+            virtio_iommu_map_region(s, virt_addr, 0, size, 0);
             return VIRTIO_IOMMU_S_OK;
         } else {
             mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
@@ -410,6 +469,35 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void virtio_iommu_notify_flag_changed(MemoryRegion *iommu,
+                                          IOMMUNotifierFlag old,
+                                          IOMMUNotifierFlag new)
+{
+    IOMMUDevice *sdev = container_of(iommu, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    VirtioIOMMUNotifierNode *node = NULL;
+    VirtioIOMMUNotifierNode *next_node = NULL;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
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
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+            return;
+        }
+    }
+}
+
+
 static IOMMUTLBEntry virtio_iommu_translate(MemoryRegion *mr, hwaddr addr,
                                             IOMMUAccessFlags flag)
 {
@@ -523,11 +611,48 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     return (ua > ub) - (ua < ub);
 }
 
+static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
+{
+    viommu_mapping *mapping = (viommu_mapping *) value;
+    VirtIOIOMMU *s = (VirtIOIOMMU *) data;
+
+    /* unmap previous entry and map again */
+    virtio_iommu_map_region(s, mapping->virt_addr, 0, mapping->size, 0);
+
+    virtio_iommu_map_region(s, mapping->virt_addr, mapping->phys_addr,
+                            mapping->size, 1);
+    return true;
+}
+
+static void virtio_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint32_t sid;
+    viommu_dev *dev;
+
+    sid = smmu_get_sid(sdev);
+
+    qemu_mutex_lock(&s->mutex);
+
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
+    if (!dev) {
+        goto unlock;
+    }
+
+    g_tree_foreach(dev->as->mappings, virtio_iommu_remap, s);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
+    return;
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
 
+    QLIST_INIT(&s->notifiers_list);
     virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
                 sizeof(struct virtio_iommu_config));
 
@@ -538,6 +663,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->config.input_range.end = -1UL;
 
     s->iommu_ops.translate = virtio_iommu_translate;
+    s->iommu_ops.notify_flag_changed = virtio_iommu_notify_flag_changed;
+    s->iommu_ops.replay = virtio_iommu_replay;
     memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
     s->as_by_busptr = g_hash_table_new_full(as_uint64_hash,
                                             as_uint64_equal,
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 2259413..76c758d 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -44,6 +44,11 @@ typedef struct IOMMUPciBus {
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
@@ -55,6 +60,7 @@ typedef struct VirtIOIOMMU {
     GTree *address_spaces;
     QemuMutex mutex;
     GTree *devices;
+    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
 } VirtIOIOMMU;
 
 #endif
-- 
1.9.3
