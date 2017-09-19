Received: from eggs.gnu.org ([2001:4830:134:3::10]:47507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDGV-0008Ne-Jn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1duDGU-0000v2-GS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:48:19 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 19 Sep 2017 09:46:38 +0200
Message-Id: <1505807208-9063-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 06/16] virtio-iommu: Register attached devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This patch introduce address space and device internal
datatypes. Both are stored in RB trees. The address space
owns a list of devices attached to it.

It is assumed the devid corresponds to the PCI BDF.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- new separate patch
---
 hw/virtio/trace-events   |   4 ++
 hw/virtio/virtio-iommu.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index bc65356..74b92d3 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -38,3 +38,7 @@ virtio_iommu_map(uint32_t as, uint64_t phys_addr, uint64_t virt_addr, uint64_t s
 virtio_iommu_unmap(uint32_t as, uint64_t virt_addr, uint64_t size) "as= %d virt_addr=0x%"PRIx64" size=0x%"PRIx64
 virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int flag) "mr=%s rid=%d addr=0x%"PRIx64" flag=%d"
 virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
+virtio_iommu_get_dev(uint32_t devid) "Alloc devid=%d"
+virtio_iommu_put_dev(uint32_t devid) "Free devid=%d"
+virtio_iommu_get_as(uint32_t asid) "Alloc asid=%d"
+virtio_iommu_put_as(uint32_t asid) "Free asid=%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index f4cb76f..41a4bbc 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -32,15 +32,116 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci.h"
 
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 
+typedef struct viommu_as {
+    uint32_t id;
+    GTree *mappings;
+    QLIST_HEAD(, viommu_dev) device_list;
+} viommu_as;
+
+typedef struct viommu_dev {
+    uint32_t id;
+    viommu_as *as;
+    QLIST_ENTRY(viommu_dev) next;
+    VirtIOIOMMU *viommu;
+} viommu_dev;
+
+typedef struct viommu_interval {
+    uint64_t low;
+    uint64_t high;
+} viommu_interval;
+
 static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
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
+static void virtio_iommu_detach_dev_from_as(viommu_dev *dev)
+{
+    QLIST_REMOVE(dev, next);
+    dev->as = NULL;
+}
+
+static viommu_dev *virtio_iommu_get_dev(VirtIOIOMMU *s, uint32_t devid)
+{
+    viommu_dev *dev;
+
+    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
+    if (dev) {
+        return dev;
+    }
+    dev = g_malloc0(sizeof(*dev));
+    dev->id = devid;
+    dev->viommu = s;
+    trace_virtio_iommu_get_dev(devid);
+    g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);
+    return dev;
+}
+
+static void virtio_iommu_put_dev(gpointer data)
+{
+    viommu_dev *dev = (viommu_dev *)data;
+
+    if (dev->as) {
+        virtio_iommu_detach_dev_from_as(dev);
+        g_tree_unref(dev->as->mappings);
+    }
+
+    trace_virtio_iommu_put_dev(dev->id);
+    g_free(dev);
+}
+
+viommu_as *virtio_iommu_get_as(VirtIOIOMMU *s, uint32_t asid);
+viommu_as *virtio_iommu_get_as(VirtIOIOMMU *s, uint32_t asid)
+{
+    viommu_as *as;
+
+    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
+    if (as) {
+        return as;
+    }
+    as = g_malloc0(sizeof(*as));
+    as->id = asid;
+    as->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
+                                   NULL, (GDestroyNotify)g_free,
+                                   (GDestroyNotify)g_free);
+    g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
+    trace_virtio_iommu_get_as(asid);
+    return as;
+}
+
+static void virtio_iommu_put_as(gpointer data)
+{
+    viommu_as *as = (viommu_as *)data;
+    viommu_dev *iter, *tmp;
+
+    QLIST_FOREACH_SAFE(iter, &as->device_list, next, tmp) {
+        virtio_iommu_detach_dev_from_as(iter);
+    }
+    g_tree_destroy(as->mappings);
+    trace_virtio_iommu_put_as(as->id);
+    g_free(as);
+}
+
 static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
                                               int devfn)
 {
@@ -70,6 +171,8 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
         sdev->bus = bus;
         sdev->devfn = devfn;
 
+        virtio_iommu_get_dev(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
+
         trace_virtio_iommu_init_iommu_mr(name);
 
         memory_region_init_iommu(&sdev->iommu_mr, sizeof(sdev->iommu_mr),
@@ -360,6 +463,12 @@ static inline guint as_uint64_hash(gconstpointer v)
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
@@ -375,17 +484,28 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->config.page_size_mask = TARGET_PAGE_MASK;
     s->config.input_range.end = -1UL;
 
+    qemu_mutex_init(&s->mutex);
+
     memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
     s->as_by_busptr = g_hash_table_new_full(as_uint64_hash,
                                             as_uint64_equal,
                                             g_free, g_free);
 
+    s->address_spaces = g_tree_new_full((GCompareDataFunc)int_cmp,
+                                         NULL, NULL, virtio_iommu_put_as);
+    s->devices = g_tree_new_full((GCompareDataFunc)int_cmp,
+                                 NULL, NULL, virtio_iommu_put_dev);
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
