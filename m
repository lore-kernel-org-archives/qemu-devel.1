Received: from eggs.gnu.org ([2001:4830:134:3::10]:48473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJKv-0001Ds-QZ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJKu-00055z-HQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:00:21 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 12 Feb 2018 18:58:16 +0000
Message-Id: <1518461904-5305-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 14/22] virtio-iommu: Add an msi_bypass property
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

In case the msi_bypass property is set, it means we need
to register the IOAPIC MSI window as a reserved region:
0xFEE00000 - 0xFEEFFFFF.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/virtio/virtio-iommu.c         | 52 ++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-iommu.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 85c5b95..c81a24b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -43,6 +43,9 @@
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 #define VIOMMU_PROBE_SIZE 512
 
+#define IOAPIC_RANGE_START      (0xfee00000)
+#define IOAPIC_RANGE_SIZE       (0x100000)
+
 #define SUPPORTED_PROBE_PROPERTIES (\
     VIRTIO_IOMMU_PROBE_T_NONE | \
     VIRTIO_IOMMU_PROBE_T_RESV_MEM)
@@ -105,6 +108,25 @@ static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
     ep->domain = NULL;
 }
 
+static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
+                                              uint8_t subtype,
+                                              uint64_t addr, uint64_t size)
+{
+    viommu_interval *interval;
+    struct virtio_iommu_probe_resv_mem *reg;
+
+    interval = g_malloc0(sizeof(*interval));
+    interval->low = addr;
+    interval->high = addr + size - 1;
+
+    reg = g_malloc0(sizeof(*reg));
+    reg->subtype = subtype;
+    reg->addr = cpu_to_le64(addr);
+    reg->size = cpu_to_le64(size);
+
+    g_tree_insert(ep->reserved_regions, interval, reg);
+}
+
 static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
                                                   uint32_t ep_id)
 {
@@ -122,6 +144,12 @@ static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
     ep->reserved_regions = g_tree_new_full((GCompareDataFunc)interval_cmp,
                                             NULL, (GDestroyNotify)g_free,
                                             (GDestroyNotify)g_free);
+    if (s->msi_bypass) {
+        virtio_iommu_register_resv_region(ep, VIRTIO_IOMMU_RESV_MEM_T_MSI,
+                                          IOAPIC_RANGE_START,
+                                          IOAPIC_RANGE_SIZE);
+    }
+
     return ep;
 }
 
@@ -854,8 +882,32 @@ static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
     trace_virtio_iommu_device_status(status);
 }
 
+static bool virtio_iommu_get_msi_bypass(Object *obj, Error **errp)
+{
+    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
+
+    return s->msi_bypass;
+}
+
+static void virtio_iommu_set_msi_bypass(Object *obj, bool value, Error **errp)
+{
+    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
+
+    s->msi_bypass = value;
+}
+
 static void virtio_iommu_instance_init(Object *obj)
 {
+    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
+
+    object_property_add_bool(obj, "msi_bypass", virtio_iommu_get_msi_bypass,
+                             virtio_iommu_set_msi_bypass, NULL);
+    object_property_set_description(obj, "msi_bypass",
+                                    "Indicates whether msis are bypassed by "
+                                    "the IOMMU. Default is YES",
+                                    NULL);
+
+    s->msi_bypass = true;
 }
 
 static const VMStateDescription vmstate_virtio_iommu = {
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 0b6b3f2..458b2a0 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -57,6 +57,7 @@ typedef struct VirtIOIOMMU {
     GTree *domains;
     QemuMutex mutex;
     GTree *endpoints;
+    bool msi_bypass;
 } VirtIOIOMMU;
 
 #endif
-- 
1.9.1
