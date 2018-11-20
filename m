Received: from eggs.gnu.org ([2001:4830:134:3::10]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPCqq-0006Lh-Ux
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gPCqc-00044a-Rn
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:42:23 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gPCqZ-0003yY-2D
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:42:12 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 21 Nov 2018 02:09:43 +0530
Message-ID: <1542746383-18288-6-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 5/5] Make vfio-pci device migration capable.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

Call vfio_migration_probe() and vfio_migration_finalize() functions for
vfio-pci device to enable migration for vfio PCI device.
Removed vfio_pci_vmstate structure.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 72daf1a358a0..0f9d06981b1b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2930,6 +2930,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
     vdev->vbasedev.dev = &vdev->pdev.qdev;
+    vdev->vbasedev.device_state = VFIO_DEVICE_STATE_NONE;
 
     tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
@@ -3141,10 +3142,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    ret = vfio_migration_probe(&vdev->vbasedev, errp);
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
-
     return;
 
 out_teardown:
@@ -3180,6 +3182,8 @@ static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
 
+    vdev->vbasedev.device_state = VFIO_DEVICE_STATE_NONE;
+
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
@@ -3189,6 +3193,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     }
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
+    vfio_migration_finalize(&vdev->vbasedev);
 }
 
 static void vfio_pci_reset(DeviceState *dev)
@@ -3294,11 +3299,6 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const VMStateDescription vfio_pci_vmstate = {
-    .name = "vfio-pci",
-    .unmigratable = 1,
-};
-
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3306,7 +3306,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vfio_pci_reset;
     dc->props = vfio_pci_dev_properties;
-    dc->vmsd = &vfio_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-- 
2.7.0
