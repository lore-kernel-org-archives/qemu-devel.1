Received: from eggs.gnu.org ([2001:4830:134:3::10]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXF2-0004fu-If
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXF1-0003ik-Q7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:04 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 06:53:00 +0000
Message-ID: <20181127064101.25887-6-Bharat.Bhushan@nxp.com>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH RFC v5 5/5] virtio-iommu: handle IOMMU Notifier
 flag changes
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

Finally handle the IOMMU Notifier flag changes
for the iommu-memory region.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v4->v5:
 - Rebase to v9 version from Eric (no change)

 hw/virtio/trace-events   |  2 ++
 hw/virtio/virtio-iommu.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index f29a027258..8c1d77b0c2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -75,3 +75,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags,=
 uint32_t endpoint, uin
 virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, u=
int64_t map_size) "mr=3D%s iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"=
PRIx64""
 virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_si=
ze) "mr=3D%s iova=3D0x%"PRIx64" size=3D0x%"PRIx64""
 virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=3D0x%"=
PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
+virtio_iommu_notify_flag_add(const char *iommu) "Add virtio-iommu notifier=
 node for memory region %s"
+virtio_iommu_notify_flag_del(const char *iommu) "Del virtio-iommu notifier=
 node for memory region %s"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index c9d8b3aa4c..adc37ddf1b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1052,6 +1052,36 @@ unlock:
     qemu_mutex_unlock(&s->mutex);
 }
=20
+static void virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
+                                             IOMMUNotifierFlag old,
+                                             IOMMUNotifierFlag new)
+{
+    IOMMUDevice *sdev =3D container_of(iommu_mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s =3D sdev->viommu;
+    VirtioIOMMUNotifierNode *node =3D NULL;
+    VirtioIOMMUNotifierNode *next_node =3D NULL;
+
+    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
+        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
+        node =3D g_malloc0(sizeof(*node));
+        node->iommu_dev =3D sdev;
+        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
+        return;
+    }
+
+    /* update notifier node with new flags */
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->iommu_dev =3D=3D sdev) {
+            if (new =3D=3D IOMMU_NOTIFIER_NONE) {
+                trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.na=
me);
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+            return;
+        }
+    }
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -1167,6 +1197,7 @@ static void virtio_iommu_memory_region_class_init(Obj=
ectClass *klass,
=20
     imrc->translate =3D virtio_iommu_translate;
     imrc->replay =3D virtio_iommu_replay;
+    imrc->notify_flag_changed =3D virtio_iommu_notify_flag_changed;
 }
=20
 static const TypeInfo virtio_iommu_info =3D {
--=20
2.19.1
