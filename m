Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLls-0004FD-7V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLln-0007sD-UD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:7314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLln-0007fT-Lj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:03 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:31:57 +0800
Message-Id: <1519900322-30263-8-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 07/12] vfio/pci: register sva notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch shows how sva notifier is registered. And provided
an example by registering notify func for tlb flush propagation.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/pci.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a60a4d7..b7297cc 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2775,6 +2775,26 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static VFIOContainer *vfio_get_container_from_busdev(PCIBus *bus,
+                                                     int32_t devfn)
+{
+    VFIOGroup *group;
+    VFIOPCIDevice *vdev_iter;
+    VFIODevice *vbasedev_iter;
+    PCIDevice *pdev_iter;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
+            vdev_iter = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
+            pdev_iter = &vdev_iter->pdev;
+            if (pci_get_bus(pdev_iter) == bus && pdev_iter->devfn == devfn) {
+                return group->container;
+            }
+        }
+    }
+    return NULL;
+}
+
 static void vfio_pci_device_sva_bind_pasid_table(PCIBus *bus,
                  int32_t devfn, uint64_t pasidt_addr, uint32_t size)
 {
@@ -2783,11 +2803,42 @@ static void vfio_pci_device_sva_bind_pasid_table(PCIBus *bus,
     So far, Intel VT-d and AMD IOMMU requires it. */
 }
 
+static void vfio_iommu_sva_tlb_invalidate_notify(IOMMUSVANotifier *n,
+                                                 IOMMUSVAEventData *event_data)
+{
+/*  Sample code, would be detailed in coming virt-SVA patchset.
+    VFIOGuestIOMMUSVAContext *gsva_ctx;
+    IOMMUSVAContext *sva_ctx;
+    VFIOContainer *container;
+
+    gsva_ctx = container_of(n, VFIOGuestIOMMUSVAContext, n);
+    container = gsva_ctx->container;
+
+    TODO: forward to host through VFIO IOCTL
+*/
+}
+
 static void vfio_pci_device_sva_register_notifier(PCIBus *bus,
                           int32_t devfn, IOMMUSVAContext *sva_ctx)
 {
-    /* Register notifier for TLB invalidation propagation
-       */
+    VFIOContainer *container = vfio_get_container_from_busdev(bus, devfn);
+
+    if (container != NULL) {
+        VFIOGuestIOMMUSVAContext *gsva_ctx;
+        gsva_ctx = g_malloc0(sizeof(*gsva_ctx));
+        gsva_ctx->sva_ctx = sva_ctx;
+        gsva_ctx->container = container;
+        QLIST_INSERT_HEAD(&container->gsva_ctx_list,
+                          gsva_ctx,
+                          gsva_ctx_next);
+       /* Register vfio_iommu_sva_tlb_invalidate_notify with event flag
+           IOMMU_SVA_EVENT_TLB_INV */
+        iommu_sva_notifier_register(sva_ctx,
+                                    &gsva_ctx->n,
+                                    vfio_iommu_sva_tlb_invalidate_notify,
+                                    IOMMU_SVA_EVENT_TLB_INV);
+        return;
+    }
 }
 
 static void vfio_pci_device_sva_unregister_notifier(PCIBus *bus,
-- 
1.9.1
