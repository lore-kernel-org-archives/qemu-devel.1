Received: from eggs.gnu.org ([209.51.188.92]:55741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gw198-0002yM-He
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gw197-0001DQ-LU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:27178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gw197-0001CV-Be
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:57 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
Date: Tue, 19 Feb 2019 16:52:51 +0800
Message-Id: <1550566371-3743-1-git-send-email-yan.y.zhao@intel.com>
In-Reply-To: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
Subject: [Qemu-devel] [PATCH 4/5] vfio/migration: turn on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, qemu-devel@nongnu.org
Cc: intel-gvt-dev@lists.freedesktop.org, Zhengxiao.zx@Alibaba-inc.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, kwankhede@nvidia.com, kevin.tian@intel.com, cjia@nvidia.com, arei.gonglei@huawei.com, kvm@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>

init vfio migration in vfio_realize() and register migraton blocker if
failure met.
finalize all migration resources when vfio_instance_finalize().

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b8e006b..8bf625e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3068,6 +3068,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    vfio_migration_init(vdev, errp);
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3089,6 +3091,7 @@ static void vfio_instance_finalize(Object *obj)
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
+    vfio_migration_finalize(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
     /*
@@ -3221,11 +3224,6 @@ static Property vfio_pci_dev_properties[] = {
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
@@ -3233,7 +3231,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vfio_pci_reset;
     dc->props = vfio_pci_dev_properties;
-    dc->vmsd = &vfio_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-- 
2.7.4
