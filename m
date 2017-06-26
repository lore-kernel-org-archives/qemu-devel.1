Received: from eggs.gnu.org ([2001:4830:134:3::10]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPlS-0006yI-9a
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPlN-00027V-Ig
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:52:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:30767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPlN-00026t-9J
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:52:53 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301634-24228-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC 2/5] vfio: Add struct vfio_vmstate_info to
 introduce vfio device put/get funtion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:52:59 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

Introduce vfio_device_put/vfio_device_get funtion for vfio device state
save/restore usage. And vfio device unmigratable flag will be set to false
during initialization if device flag VFIO_DEVICE_FLAGS_MIGRATABLE is set.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf2e0ff..7de4eb4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -37,6 +37,7 @@
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
+static VMStateDescription vfio_pci_vmstate;
 
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
@@ -2375,6 +2376,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
 
         QLIST_INIT(&vdev->device_state.quirks);
+        vfio_pci_vmstate.unmigratable = 0;
     }
 
     ret = vfio_get_region_info(vbasedev,
@@ -2946,6 +2948,17 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
+static int vfio_device_put(QEMUFile *f, void *pv, size_t size, VMStateField *field,
+                            QJSON *vmdesc)
+{
+    return 0;
+}
+
+static int vfio_device_get(QEMUFile *f, void *pv, size_t size, VMStateField *field)
+{
+    return 0;
+}
+
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
@@ -2990,9 +3003,29 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const VMStateDescription vfio_pci_vmstate = {
+static VMStateInfo vfio_vmstate_info = {
+    .name = "vfio-state",
+    .get = vfio_device_get,
+    .put = vfio_device_put,
+};
+
+static VMStateDescription vfio_pci_vmstate = {
     .name = "vfio-pci",
     .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        {
+            .name         = "vfio dev",
+            .version_id   = 0,
+            .field_exists = NULL,
+            .size         = 0,
+            .info         = &vfio_vmstate_info,
+            .flags        = VMS_SINGLE,
+            .offset       = 0,
+         },
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
-- 
2.7.4
