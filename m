Received: from eggs.gnu.org ([2001:4830:134:3::10]:39369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEy-0004cR-Ir
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEv-0003hE-E9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:00 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 06:52:54 +0000
Message-ID: <20181127064101.25887-4-Bharat.Bhushan@nxp.com>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH RFC v5 3/5] virtio-iommu: Call iommu notifier
 on attach/detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "drjones@redhat.com" <drjones@redhat.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Eric Auger <eric.auger@redhat.com>

This patch extend the ATTACH/DETACH command handling to
call iommu-notifier to map/unmap the memory region in IOMMU
using vfio. This replay existing address space mappings on
attach command and remove existing address space mappings
on detach command.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
v4->v5:
 - Rebase to v9 version from Eric
 - PCIe device hotplug fix

 hw/virtio/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 613a77521d..7e8149e719 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -131,8 +131,44 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegio=
n *mr, hwaddr iova,
     memory_region_notify_iommu(mr, 0, entry);
 }
=20
+static gboolean virtio_iommu_mapping_unmap(gpointer key, gpointer value,
+                                           gpointer data)
+{
+    viommu_mapping *mapping =3D (viommu_mapping *) value;
+    IOMMUMemoryRegion *mr =3D (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_unmap(mr, mapping->virt_addr, mapping->size);
+
+    return false;
+}
+
+static gboolean virtio_iommu_mapping_map(gpointer key, gpointer value,
+                                         gpointer data)
+{
+    viommu_mapping *mapping =3D (viommu_mapping *) value;
+    IOMMUMemoryRegion *mr =3D (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_map(mr, mapping->virt_addr, mapping->phys_addr,
+                            mapping->size);
+
+    return false;
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
 {
+    VirtioIOMMUNotifierNode *node;
+    VirtIOIOMMU *s =3D ep->viommu;
+    viommu_domain *domain =3D ep->domain;
+    uint32_t sid;
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        sid =3D virtio_iommu_get_sid(node->iommu_dev);
+        if (ep->id =3D=3D sid) {
+            g_tree_foreach(domain->mappings, virtio_iommu_mapping_unmap,
+                           &node->iommu_dev->iommu_mr);
+        }
+    }
+
     QLIST_REMOVE(ep, next);
     ep->domain =3D NULL;
 }
@@ -280,8 +316,10 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 {
     uint32_t domain_id =3D le32_to_cpu(req->domain);
     uint32_t ep_id =3D le32_to_cpu(req->endpoint);
+    VirtioIOMMUNotifierNode *node;
     viommu_domain *domain;
     viommu_endpoint *ep;
+    uint32_t sid;
=20
     trace_virtio_iommu_attach(domain_id, ep_id);
=20
@@ -300,6 +338,15 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     ep->domain =3D domain;
     g_tree_ref(domain->mappings);
=20
+    /* replay existing address space mappings on the associated mr */
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        sid =3D virtio_iommu_get_sid(node->iommu_dev);
+        if (ep->id =3D=3D sid) {
+            g_tree_foreach(domain->mappings, virtio_iommu_mapping_map,
+                           &node->iommu_dev->iommu_mr);
+        }
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
=20
--=20
2.19.1
