Received: from eggs.gnu.org ([2001:4830:134:3::10]:38409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dcTa9-00081X-0l
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dcTa5-0002Nl-Na
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:35:17 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  1 Aug 2017 11:33:12 +0200
Message-Id: <1501579994-3320-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1501579994-3320-1-git-send-email-eric.auger@redhat.com>
References: <1501579994-3320-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 6/8] virtio-iommu: Implement the translation
 and commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

This patch adds the actual implementation for the translation routine
and the virtio-iommu commands.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v2 -> v3:
- init the mutex
- return VIRTIO_IOMMU_S_INVAL is reserved field is not null on
  attach/detach commands
- on attach, when the device is already attached to an address space,
  detach it first instead of returning an error
- remove nr_devices and use g_tree_ref/unref to destroy the as->mappings
  on last device detach
- map/unmap: return NOENT instead of INVAL error if as does not exist
- remove flags argument from attach/detach trace functions

v1 -> v2:
- fix compilation issue reported by autobuild system
---
 hw/virtio/trace-events   |  10 +-
 hw/virtio/virtio-iommu.c | 232 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 232 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 341dbdf..8db3d91 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -28,8 +28,14 @@ virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: %
 
 # hw/virtio/virtio-iommu.c
 #
-virtio_iommu_attach(uint32_t as, uint32_t dev, uint32_t flags) "as=%d dev=%d flags=%d"
-virtio_iommu_detach(uint32_t dev, uint32_t flags) "dev=%d flags=%d"
+virtio_iommu_attach(uint32_t as, uint32_t dev) "as=%d dev=%d"
+virtio_iommu_detach(uint32_t dev) "dev=%d"
 virtio_iommu_map(uint32_t as, uint64_t phys_addr, uint64_t virt_addr, uint64_t size, uint32_t flags) "as= %d phys_addr=0x%"PRIx64" virt_addr=0x%"PRIx64" size=0x%"PRIx64" flags=%d"
 virtio_iommu_unmap(uint32_t as, uint64_t virt_addr, uint64_t size, uint32_t reserved) "as= %d virt_addr=0x%"PRIx64" size=0x%"PRIx64" reserved=%d"
 virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int flag) "mr=%s rid=%d addr=0x%"PRIx64" flag=%d"
+virtio_iommu_new_asid(uint32_t asid) "Allocate a new asid=%d"
+virtio_iommu_new_devid(uint32_t devid) "Allocate a new devid=%d"
+virtio_iommu_unmap_left_interval(uint64_t low, uint64_t high, uint64_t next_low, uint64_t next_high) "Unmap left [0x%"PRIx64",0x%"PRIx64"], new interval=[0x%"PRIx64",0x%"PRIx64"]"
+virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"], new interval=[0x%"PRIx64",0x%"PRIx64"]"
+virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc [0x%"PRIx64",0x%"PRIx64"]"
+virtio_iommu_translate_result(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index e663d9e..9217587 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -32,10 +32,36 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci.h"
 
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 
+typedef struct viommu_as viommu_as;
+
+typedef struct viommu_mapping {
+    uint64_t virt_addr;
+    uint64_t phys_addr;
+    uint64_t size;
+    uint32_t flags;
+} viommu_mapping;
+
+typedef struct viommu_interval {
+    uint64_t low;
+    uint64_t high;
+} viommu_interval;
+
+typedef struct viommu_dev {
+    uint32_t id;
+    viommu_as *as;
+} viommu_dev;
+
+struct viommu_as {
+    uint32_t id;
+    GTree *mappings;
+};
+
 static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -93,6 +119,29 @@ static void virtio_iommu_init_as(VirtIOIOMMU *s)
     }
 }
 
+static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
+{
+    viommu_interval *inta = (viommu_interval *)a;
+    viommu_interval *intb = (viommu_interval *)b;
+
+    if (inta->high <= intb->low) {
+        return -1;
+    } else if (intb->high <= inta->low) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static void virtio_iommu_detach_dev(VirtIOIOMMU *s, viommu_dev *dev)
+{
+    viommu_as *as = dev->as;
+
+    trace_virtio_iommu_detach(dev->id);
+
+    g_tree_remove(s->devices, GUINT_TO_POINTER(dev->id));
+    g_tree_unref(as->mappings);
+}
 
 static int virtio_iommu_attach(VirtIOIOMMU *s,
                                struct virtio_iommu_req_attach *req)
@@ -100,10 +149,42 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     uint32_t asid = le32_to_cpu(req->address_space);
     uint32_t devid = le32_to_cpu(req->device);
     uint32_t reserved = le32_to_cpu(req->reserved);
+    viommu_as *as;
+    viommu_dev *dev;
+
+    trace_virtio_iommu_attach(asid, devid);
+
+    if (reserved) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
+    if (dev) {
+        /*
+         * the device is already attached to an address space,
+         * detach it first
+         */
+         virtio_iommu_detach_dev(s, dev);
+    }
 
-    trace_virtio_iommu_attach(asid, devid, reserved);
+    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
+    if (!as) {
+        as = g_malloc0(sizeof(*as));
+        as->id = asid;
+        as->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
+                                         NULL, NULL, (GDestroyNotify)g_free);
+        g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
+        trace_virtio_iommu_new_asid(asid);
+    }
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    dev = g_malloc0(sizeof(*dev));
+    dev->as = as;
+    dev->id = devid;
+    trace_virtio_iommu_new_devid(devid);
+    g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);
+    g_tree_ref(as->mappings);
+
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_detach(VirtIOIOMMU *s,
@@ -111,10 +192,20 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t devid = le32_to_cpu(req->device);
     uint32_t reserved = le32_to_cpu(req->reserved);
+    viommu_dev *dev;
+
+    if (reserved) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
+    if (!dev) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
 
-    trace_virtio_iommu_detach(devid, reserved);
+    virtio_iommu_detach_dev(s, dev);
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_map(VirtIOIOMMU *s,
@@ -125,10 +216,37 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     uint64_t virt_addr = le64_to_cpu(req->virt_addr);
     uint64_t size = le64_to_cpu(req->size);
     uint32_t flags = le32_to_cpu(req->flags);
+    viommu_as *as;
+    viommu_interval *interval;
+    viommu_mapping *mapping;
+
+    interval = g_malloc0(sizeof(*interval));
+
+    interval->low = virt_addr;
+    interval->high = virt_addr + size - 1;
+
+    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
+    if (!as) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    mapping = g_tree_lookup(as->mappings, (gpointer)interval);
+    if (mapping) {
+        g_free(interval);
+        return VIRTIO_IOMMU_S_INVAL;
+    }
 
     trace_virtio_iommu_map(asid, phys_addr, virt_addr, size, flags);
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    mapping = g_malloc0(sizeof(*mapping));
+    mapping->virt_addr = virt_addr;
+    mapping->phys_addr = phys_addr;
+    mapping->size = size;
+    mapping->flags = flags;
+
+    g_tree_insert(as->mappings, interval, mapping);
+
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_unmap(VirtIOIOMMU *s,
@@ -138,10 +256,64 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     uint64_t virt_addr = le64_to_cpu(req->virt_addr);
     uint64_t size = le64_to_cpu(req->size);
     uint32_t flags = le32_to_cpu(req->flags);
+    viommu_mapping *mapping;
+    viommu_interval interval;
+    viommu_as *as;
 
     trace_virtio_iommu_unmap(asid, virt_addr, size, flags);
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
+    if (!as) {
+        error_report("%s: no as", __func__);
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+    interval.low = virt_addr;
+    interval.high = virt_addr + size - 1;
+
+    mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
+
+    while (mapping) {
+        viommu_interval current;
+        uint64_t low  = mapping->virt_addr;
+        uint64_t high = mapping->virt_addr + mapping->size - 1;
+
+        current.low = low;
+        current.high = high;
+
+        if (low == interval.low && size >= mapping->size) {
+            g_tree_remove(as->mappings, (gpointer)&current);
+            interval.low = high + 1;
+            trace_virtio_iommu_unmap_left_interval(current.low, current.high,
+                interval.low, interval.high);
+        } else if (high == interval.high && size >= mapping->size) {
+            trace_virtio_iommu_unmap_right_interval(current.low, current.high,
+                interval.low, interval.high);
+            g_tree_remove(as->mappings, (gpointer)&current);
+            interval.high = low - 1;
+        } else if (low > interval.low && high < interval.high) {
+            trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
+            g_tree_remove(as->mappings, (gpointer)&current);
+        } else {
+            break;
+        }
+        if (interval.low >= interval.high) {
+            return VIRTIO_IOMMU_S_OK;
+        } else {
+            mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
+        }
+    }
+
+    if (mapping) {
+        error_report("****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
+                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported",
+                     __func__, interval.low, size,
+                     mapping->virt_addr, mapping->size);
+    } else {
+        error_report("****** %s: no mapping for [0x%"PRIx64",0x%"PRIx64"]",
+                     __func__, interval.low, interval.high);
+    }
+
+    return VIRTIO_IOMMU_S_INVAL;
 }
 
 #define get_payload_size(req) (\
@@ -271,19 +443,46 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                             IOMMUAccessFlags flag)
 {
     IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
     uint32_t sid;
+    viommu_dev *dev;
+    viommu_mapping *mapping;
+    viommu_interval interval;
+
+    interval.low = addr;
+    interval.high = addr + 1;
 
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
         .iova = addr,
         .translated_addr = addr,
-        .addr_mask = ~(hwaddr)0,
-        .perm = IOMMU_NONE,
+        .addr_mask = (1 << 12) - 1, /* TODO */
+        .perm = 3,
     };
 
     sid = virtio_iommu_get_sid(sdev);
 
     trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
+    qemu_mutex_lock(&s->mutex);
+
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
+    if (!dev) {
+        /* device cannot be attached to another as */
+        printf("%s sid=%d is not known!!\n", __func__, sid);
+        goto unlock;
+    }
+
+    mapping = g_tree_lookup(dev->as->mappings, (gpointer)&interval);
+    if (!mapping) {
+        printf("%s no mapping for 0x%"PRIx64" for sid=%d\n", __func__,
+               addr, sid);
+        goto unlock;
+    }
+    entry.translated_addr = addr - mapping->virt_addr + mapping->phys_addr,
+    trace_virtio_iommu_translate_result(addr, entry.translated_addr, sid);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
     return entry;
 }
 
@@ -347,6 +546,12 @@ static inline guint as_uint64_hash(gconstpointer v)
     return (guint)*(const uint64_t *)v;
 }
 
+static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
+{
+    uint ua = GPOINTER_TO_UINT(a);
+    uint ub = GPOINTER_TO_UINT(b);
+    return (ua > ub) - (ua < ub);
+}
 
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
@@ -362,17 +567,28 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->config.page_sizes = TARGET_PAGE_MASK;
     s->config.input_range.end = -1UL;
 
+    qemu_mutex_init(&s->mutex);
+
     memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
     s->as_by_busptr = g_hash_table_new_full(as_uint64_hash,
                                             as_uint64_equal,
                                             g_free, g_free);
 
+    s->address_spaces = g_tree_new_full((GCompareDataFunc)int_cmp,
+                                         NULL, NULL, (GDestroyNotify)g_free);
+    s->devices = g_tree_new_full((GCompareDataFunc)int_cmp,
+                                         NULL, NULL, (GDestroyNotify)g_free);
+
     virtio_iommu_init_as(s);
 }
 
 static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
+
+    g_tree_destroy(s->address_spaces);
+    g_tree_destroy(s->devices);
 
     virtio_cleanup(vdev);
 }
-- 
2.5.5
