Received: from eggs.gnu.org ([2001:4830:134:3::10]:49792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPsbE-0005XO-7c
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gPsbB-0006l2-4h
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 12:17:08 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 22 Nov 2018 18:15:32 +0100
Message-Id: <20181122171538.12359-12-eric.auger@redhat.com>
In-Reply-To: <20181122171538.12359-1-eric.auger@redhat.com>
References: <20181122171538.12359-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v9 11/17] virtio-iommu: Expose the IOAPIC MSI
 reserved region when relevant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: kevin.tian@intel.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

We introduce a new msi_bypass field which indicates whether
the IOAPIC MSI window [0xFEE00000 - 0xFEEFFFFF] must be exposed
as a reserved region. By default the field is set to true at
instantiation time. Later on we will introduce a property at
virtio pci proxy level to turn it off.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v8 -> v9:
- pass IOAPIC_RANGE_END to virtio_iommu_register_resv_region
- take into account the change in the struct virtio_iommu_probe_resv_mem
  definition
- We just introduce the field here. A property will be introduced later on
  at pci proxy level.
---
 hw/virtio/virtio-iommu.c         | 36 ++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4fc43494d9..324518c300 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -41,6 +41,9 @@
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 #define VIOMMU_PROBE_SIZE 512
 
+#define IOAPIC_RANGE_START      (0xfee00000)
+#define IOAPIC_RANGE_END        (0xfeefffff)
+
 #define SUPPORTED_PROBE_PROPERTIES (\
     1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
 
@@ -102,6 +105,30 @@ static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
     ep->domain = NULL;
 }
 
+static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
+                                              uint8_t subtype,
+                                              uint64_t start, uint64_t end)
+{
+    viommu_interval *interval;
+    struct virtio_iommu_probe_resv_mem *resv_reg_prop;
+    size_t prop_size = sizeof(struct virtio_iommu_probe_resv_mem);
+    size_t value_size = prop_size -
+                sizeof(struct virtio_iommu_probe_property);
+
+    interval = g_malloc0(sizeof(*interval));
+    interval->low = start;
+    interval->high = end;
+
+    resv_reg_prop = g_malloc0(prop_size);
+    resv_reg_prop->head.type = VIRTIO_IOMMU_PROBE_T_RESV_MEM;
+    resv_reg_prop->head.length = cpu_to_le64(value_size);
+    resv_reg_prop->subtype = cpu_to_le64(subtype);
+    resv_reg_prop->start = cpu_to_le64(start);
+    resv_reg_prop->end = cpu_to_le64(end);
+
+    g_tree_insert(ep->reserved_regions, interval, resv_reg_prop);
+}
+
 static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
                                                   uint32_t ep_id)
 {
@@ -119,6 +146,12 @@ static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
     ep->reserved_regions = g_tree_new_full((GCompareDataFunc)interval_cmp,
                                             NULL, (GDestroyNotify)g_free,
                                             (GDestroyNotify)g_free);
+    if (s->msi_bypass) {
+        virtio_iommu_register_resv_region(ep, VIRTIO_IOMMU_RESV_MEM_T_MSI,
+                                          IOAPIC_RANGE_START,
+                                          IOAPIC_RANGE_END);
+    }
+
     return ep;
 }
 
@@ -858,6 +891,9 @@ static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
 
 static void virtio_iommu_instance_init(Object *obj)
 {
+    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
+
+    s->msi_bypass = true;
 }
 
 static const VMStateDescription vmstate_virtio_iommu = {
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index f55f48d304..56c8b4e57f 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -59,6 +59,7 @@ typedef struct VirtIOIOMMU {
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
+    bool msi_bypass;
 } VirtIOIOMMU;
 
 #endif
-- 
2.17.2
