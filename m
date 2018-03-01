Received: from eggs.gnu.org ([2001:4830:134:3::10]:53164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnN-0005co-C3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLnK-0000Bn-Mu
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:7359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLnK-00006Y-Dk
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:50:38 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:33:29 +0800
Message-Id: <1519900415-30314-7-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 06/12] vfio/pci: provide vfio_pci_sva_ops
 instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

VFIO is the bridge for vIOMMU and host IOMMU. Needs to provide API
for vIOMMU emulator to set configs to host IOMMU. In this patchset,
such API is exposed in hw/pci.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/pci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 033cc8d..a60a4d7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2775,6 +2775,34 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static void vfio_pci_device_sva_bind_pasid_table(PCIBus *bus,
+                 int32_t devfn, uint64_t pasidt_addr, uint32_t size)
+{
+ /* Propagate the guest pasid table pointer to host IOMMU, and
+    enable nested translation accordingly. Depends on HW design.
+    So far, Intel VT-d and AMD IOMMU requires it. */
+}
+
+static void vfio_pci_device_sva_register_notifier(PCIBus *bus,
+                          int32_t devfn, IOMMUSVAContext *sva_ctx)
+{
+    /* Register notifier for TLB invalidation propagation
+       */
+}
+
+static void vfio_pci_device_sva_unregister_notifier(PCIBus *bus,
+                          int32_t devfn, IOMMUSVAContext *sva_ctx)
+{
+    /* Unregister notifier for TLB invalidation propagation
+       */
+}
+
+static PCISVAOps vfio_pci_sva_ops = {
+    .sva_bind_pasid_table = vfio_pci_device_sva_bind_pasid_table,
+    .sva_register_notifier = vfio_pci_device_sva_register_notifier,
+    .sva_unregister_notifier = vfio_pci_device_sva_unregister_notifier,
+};
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
@@ -3019,6 +3047,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    pci_setup_sva_ops(pdev, &vfio_pci_sva_ops);
+
     return;
 
 out_teardown:
-- 
1.9.1
