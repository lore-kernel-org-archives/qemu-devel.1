Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEz-0004dH-IV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEy-0003hl-NN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:01 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 06:52:57 +0000
Message-ID: <20181127064101.25887-5-Bharat.Bhushan@nxp.com>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH RFC v5 4/5] virtio-iommu: add virtio-iommu
 replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "drjones@redhat.com" <drjones@redhat.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>, Bharat Bhushan <bharat.bhushan@nxp.com>

For virtio-iommu, on replay first unmap any previous
iommu-mapping and then map in iommu as per guest iommu
mappings.

Also if virtual iommu do have it own replay then
memory_region_iommu_replay() calls "imrc->translate()",
While virtio-iommu translate() expects device to be
registered before it is called. So having replay of
virtio-iommu helps to take no action if device not yet
probed/attached.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v4->v5:
 - Rebase to v9 version from Eric (no change)

 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 420b1e471b..f29a027258 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -74,3 +74,4 @@ virtio_iommu_fill_none_property(uint32_t devid) "devid=3D=
%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoin=
t, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D0x=
%"PRIx64
 virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, u=
int64_t map_size) "mr=3D%s iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"=
PRIx64""
 virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_si=
ze) "mr=3D%s iova=3D0x%"PRIx64" size=3D0x%"PRIx64""
+virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=3D0x%"=
PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7e8149e719..c9d8b3aa4c 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1015,6 +1015,43 @@ static gint int_cmp(gconstpointer a, gconstpointer b=
, gpointer user_data)
     return (ua > ub) - (ua < ub);
 }
=20
+static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer =
data)
+{
+    viommu_mapping *mapping =3D (viommu_mapping *) value;
+    IOMMUMemoryRegion *mr =3D (IOMMUMemoryRegion *) data;
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
+    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s =3D sdev->viommu;
+    uint32_t sid;
+    viommu_endpoint *ep;
+
+    sid =3D virtio_iommu_get_sid(sdev);
+
+    qemu_mutex_lock(&s->mutex);
+
+    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
+    if (!ep || !ep->domain) {
+        goto unlock;
+    }
+
+    g_tree_foreach(ep->domain->mappings, virtio_iommu_remap, mr);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -1129,6 +1166,7 @@ static void virtio_iommu_memory_region_class_init(Obj=
ectClass *klass,
     IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
=20
     imrc->translate =3D virtio_iommu_translate;
+    imrc->replay =3D virtio_iommu_replay;
 }
=20
 static const TypeInfo virtio_iommu_info =3D {
--=20
2.19.1
