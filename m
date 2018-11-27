Received: from eggs.gnu.org ([2001:4830:134:3::10]:39363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEw-0004b2-Ty
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEt-0003gx-Op
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:52:58 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 06:52:50 +0000
Message-ID: <20181127064101.25887-3-Bharat.Bhushan@nxp.com>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH RFC v5 2/5] virtio-iommu: Add iommu notifier
 for iommu-map/unmap
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

This patch extends VIRTIO_IOMMU_T_MAP/UNMAP request
handling to notify registered iommu-notifier. These
iommu-notifier maps the requested region in IOMMU using vfio.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v4->v5:
 - Rebase to v9 version from Eric
 - PCIe device hotplug fix

 hw/virtio/trace-events           |  2 +
 hw/virtio/virtio-iommu.c         | 74 ++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-iommu.h |  6 +++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 053a07b3fc..420b1e471b 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -72,3 +72,5 @@ virtio_iommu_translate_out(uint64_t virt_addr, uint64_t p=
hys_addr, uint32_t sid)
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t =
start, uint64_t end, uint32_t flags, size_t filled) "dev=3D %d, subtype=3D%=
d start=3D0x%"PRIx64" end=3D0x%"PRIx64" flags=3D%d filled=3D0x%lx"
 virtio_iommu_fill_none_property(uint32_t devid) "devid=3D%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoin=
t, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D0x=
%"PRIx64
+virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, u=
int64_t map_size) "mr=3D%s iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"=
PRIx64""
+virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_si=
ze) "mr=3D%s iova=3D0x%"PRIx64" size=3D0x%"PRIx64""
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2ec01f3b9e..613a77521d 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -99,6 +99,38 @@ static gint interval_cmp(gconstpointer a, gconstpointer =
b, gpointer user_data)
     }
 }
=20
+static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr iova,
+                                    hwaddr paddr, hwaddr size)
+{
+    IOMMUTLBEntry entry;
+
+    trace_virtio_iommu_notify_map(mr->parent_obj.name, iova, paddr, size);
+
+    entry.target_as =3D &address_space_memory;
+    entry.addr_mask =3D size - 1;
+    entry.iova =3D iova;
+    entry.perm =3D IOMMU_RW;
+    entry.translated_addr =3D paddr;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
+static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
+                                      hwaddr size)
+{
+    IOMMUTLBEntry entry;
+
+    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, iova, size);
+
+    entry.target_as =3D &address_space_memory;
+    entry.addr_mask =3D size - 1;
+    entry.iova =3D iova;
+    entry.perm =3D IOMMU_NONE;
+    entry.translated_addr =3D 0;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
 {
     QLIST_REMOVE(ep, next);
@@ -301,9 +333,12 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     uint64_t virt_start =3D le64_to_cpu(req->virt_start);
     uint64_t virt_end =3D le64_to_cpu(req->virt_end);
     uint32_t flags =3D le32_to_cpu(req->flags);
+    VirtioIOMMUNotifierNode *node;
+    viommu_endpoint *ep;
     viommu_domain *domain;
     viommu_interval *interval;
     viommu_mapping *mapping;
+    uint32_t sid;
=20
     interval =3D g_malloc0(sizeof(*interval));
=20
@@ -331,9 +366,40 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
=20
     g_tree_insert(domain->mappings, interval, mapping);
=20
+    /* All devices in an address-space share mapping */
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+            sid =3D virtio_iommu_get_sid(node->iommu_dev);
+            if (ep->id =3D=3D sid) {
+                virtio_iommu_notify_map(&node->iommu_dev->iommu_mr,
+                                        virt_start, phys_start, mapping->s=
ize);
+            }
+        }
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
=20
+static void virtio_iommu_remove_mapping(VirtIOIOMMU *s, viommu_domain *dom=
ain,
+                                        viommu_interval *interval)
+{
+    VirtioIOMMUNotifierNode *node;
+    viommu_endpoint *ep;
+    uint32_t sid;
+
+    g_tree_remove(domain->mappings, (gpointer)(interval));
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+            sid =3D virtio_iommu_get_sid(node->iommu_dev);
+            if (ep->id =3D=3D sid) {
+                virtio_iommu_notify_unmap(&node->iommu_dev->iommu_mr,
+                                          interval->low,
+                                          interval->high - interval->low +=
 1);
+            }
+        }
+    }
+}
+
 static int virtio_iommu_unmap(VirtIOIOMMU *s,
                               struct virtio_iommu_req_unmap *req)
 {
@@ -366,18 +432,18 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
         current.high =3D high;
=20
         if (low =3D=3D interval.low && size >=3D mapping->size) {
-            g_tree_remove(domain->mappings, (gpointer)(&current));
+            virtio_iommu_remove_mapping(s, domain, &current);
             interval.low =3D high + 1;
             trace_virtio_iommu_unmap_left_interval(current.low, current.hi=
gh,
                 interval.low, interval.high);
         } else if (high =3D=3D interval.high && size >=3D mapping->size) {
             trace_virtio_iommu_unmap_right_interval(current.low, current.h=
igh,
                 interval.low, interval.high);
-            g_tree_remove(domain->mappings, (gpointer)(&current));
+            virtio_iommu_remove_mapping(s, domain, &current);
             interval.high =3D low - 1;
         } else if (low > interval.low && high < interval.high) {
             trace_virtio_iommu_unmap_inc_interval(current.low, current.hig=
h);
-            g_tree_remove(domain->mappings, (gpointer)(&current));
+            virtio_iommu_remove_mapping(s, domain, &current);
         } else {
             break;
         }
@@ -907,6 +973,8 @@ static void virtio_iommu_device_realize(DeviceState *de=
v, Error **errp)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
=20
+    QLIST_INIT(&s->notifiers_list);
+
     virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
                 sizeof(struct virtio_iommu_config));
=20
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-io=
mmu.h
index 56c8b4e57f..65bda6d6fe 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -46,6 +46,11 @@ typedef struct IOMMUPciBus {
     IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically allo=
c */
 } IOMMUPciBus;
=20
+typedef struct VirtioIOMMUNotifierNode {
+    IOMMUDevice *iommu_dev;
+    QLIST_ENTRY(VirtioIOMMUNotifierNode) next;
+} VirtioIOMMUNotifierNode;
+
 typedef struct VirtIOIOMMU {
     VirtIODevice parent_obj;
     VirtQueue *req_vq;
@@ -60,6 +65,7 @@ typedef struct VirtIOIOMMU {
     QemuMutex mutex;
     GTree *endpoints;
     bool msi_bypass;
+    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
 } VirtIOIOMMU;
=20
 #endif
--=20
2.19.1
