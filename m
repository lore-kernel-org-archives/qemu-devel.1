Received: from eggs.gnu.org ([2001:4830:134:3::10]:41364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dIWSU-0003Zt-Uc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dIWSP-000162-Tz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:36:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed,  7 Jun 2017 10:35:53 +0200
Message-Id: <1496824556-1883-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1496824556-1883-1-git-send-email-eric.auger@redhat.com>
References: <1496824556-1883-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 5/8] virtio_iommu: Add the iommu regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, robin.murphy@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com

This patch initializes the iommu memory regions so that
PCIe end point transactions get translated. The translation function
is not yet implemented at that stage.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index fba1da6..341dbdf 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -32,3 +32,4 @@ virtio_iommu_attach(uint32_t as, uint32_t dev, uint32_t flags) "as=%d dev=%d fla
 virtio_iommu_detach(uint32_t dev, uint32_t flags) "dev=%d flags=%d"
 virtio_iommu_map(uint32_t as, uint64_t phys_addr, uint64_t virt_addr, uint64_t size, uint32_t flags) "as= %d phys_addr=0x%"PRIx64" virt_addr=0x%"PRIx64" size=0x%"PRIx64" flags=%d"
 virtio_iommu_unmap(uint32_t as, uint64_t virt_addr, uint64_t size, uint32_t reserved) "as= %d virt_addr=0x%"PRIx64" size=0x%"PRIx64" reserved=%d"
+virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, int flag) "mr=%s rid=%d addr=0x%"PRIx64" flag=%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index ea1caa7..902c779 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -23,6 +23,7 @@
 #include "hw/virtio/virtio.h"
 #include "sysemu/kvm.h"
 #include "qapi-event.h"
+#include "qemu/error-report.h"
 #include "trace.h"
 
 #include "standard-headers/linux/virtio_ids.h"
@@ -35,6 +36,59 @@
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 
+static inline uint16_t smmu_get_sid(IOMMUDevice *dev)
+{
+    return  ((pci_bus_num(dev->bus) & 0xff) << 8) | dev->devfn;
+}
+
+static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
+                                              int devfn)
+{
+    VirtIOIOMMU *s = opaque;
+    uintptr_t key = (uintptr_t)bus;
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, &key);
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        uintptr_t *new_key = g_malloc(sizeof(*new_key));
+
+        *new_key = (uintptr_t)bus;
+        sbus = g_malloc0(sizeof(IOMMUPciBus) +
+                         sizeof(IOMMUDevice *) * IOMMU_PCI_DEVFN_MAX);
+        sbus->bus = bus;
+        g_hash_table_insert(s->as_by_busptr, new_key, sbus);
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(IOMMUDevice));
+
+        sdev->viommu = s;
+        sdev->bus = bus;
+        sdev->devfn = devfn;
+
+        memory_region_init_iommu(&sdev->iommu_mr, OBJECT(s),
+                                 &s->iommu_ops, TYPE_VIRTIO_IOMMU,
+                                 UINT64_MAX);
+        address_space_init(&sdev->as, &sdev->iommu_mr, TYPE_VIRTIO_IOMMU);
+    }
+
+    return &sdev->as;
+
+}
+
+static void virtio_iommu_init_as(VirtIOIOMMU *s)
+{
+    PCIBus *pcibus = pci_find_primary_bus();
+
+    if (pcibus) {
+        pci_setup_iommu(pcibus, virtio_iommu_find_add_as, s);
+    } else {
+        error_report("No PCI bus, virtio-iommu is not registered");
+    }
+}
+
+
 static int virtio_iommu_attach(VirtIOIOMMU *s,
                                struct virtio_iommu_req_attach *req)
 {
@@ -208,6 +262,26 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static IOMMUTLBEntry virtio_iommu_translate(MemoryRegion *mr, hwaddr addr,
+                                            IOMMUAccessFlags flag)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    uint32_t sid;
+
+    IOMMUTLBEntry entry = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = addr,
+        .addr_mask = ~(hwaddr)0,
+        .perm = IOMMU_NONE,
+    };
+
+    sid = smmu_get_sid(sdev);
+
+    trace_virtio_iommu_translate(mr->name, sid, addr, flag);
+    return entry;
+}
+
 static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOIOMMU *dev = VIRTIO_IOMMU(vdev);
@@ -253,6 +327,21 @@ static const VMStateDescription vmstate_virtio_iommu_device = {
     },
 };
 
+/*****************************
+ * Hash Table
+ *****************************/
+
+static inline gboolean as_uint64_equal(gconstpointer v1, gconstpointer v2)
+{
+    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
+}
+
+static inline guint as_uint64_hash(gconstpointer v)
+{
+    return (guint)*(const uint64_t *)v;
+}
+
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -266,6 +355,14 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 
     s->config.page_sizes = ~((1ULL << 12) - 1);
     s->config.input_range.end = -1UL;
+
+    s->iommu_ops.translate = virtio_iommu_translate;
+    memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
+    s->as_by_busptr = g_hash_table_new_full(as_uint64_hash,
+                                            as_uint64_equal,
+                                            g_free, g_free);
+
+    virtio_iommu_init_as(s);
 }
 
 static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
-- 
2.5.5
