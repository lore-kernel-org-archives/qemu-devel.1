Received: from eggs.gnu.org ([2001:4830:134:3::10]:55141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazt-0003SN-HP
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazn-000822-41
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqazm-000819-Oo
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:23 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:52:07 +0100
Message-Id: <20180227085209.19151-6-kraxel@redhat.com>
In-Reply-To: <20180227085209.19151-1-kraxel@redhat.com>
References: <20180227085209.19151-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/7] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

Infrastructure for display support.  Adds a new vfio-pci-display device,
which will export a display and is not hotpluggable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h         |  3 +++
 hw/vfio/display.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c         | 30 ++++++++++++++++++++++++++++++
 hw/vfio/Makefile.objs |  2 +-
 4 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/display.c

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f4aa13e021..fe2a7aeb4c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -133,6 +133,7 @@ typedef struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+    bool display;
     int32_t bootindex;
     uint32_t igd_gms;
     OffAutoPCIBAR msix_relo;
@@ -174,4 +175,6 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
 
+int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
new file mode 100644
index 0000000000..d9b4d07f20
--- /dev/null
+++ b/hw/vfio/display.c
@@ -0,0 +1,47 @@
+/*
+ * display support for mdev based vgpu devices
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Authors:
+ *    Gerd Hoffmann
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "sysemu/sysemu.h"
+#include "ui/console.h"
+#include "qapi/error.h"
+#include "pci.h"
+
+int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
+{
+    struct vfio_device_gfx_plane_info probe;
+    int ret;
+
+    memset(&probe, 0, sizeof(probe));
+    probe.argsz = sizeof(probe);
+    probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_DMABUF;
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
+    if (ret == 0) {
+        error_setg(errp, "vfio-display: dmabuf support not implemented yet");
+        return -1;
+    }
+
+    memset(&probe, 0, sizeof(probe));
+    probe.argsz = sizeof(probe);
+    probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_REGION;
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
+    if (ret == 0) {
+        error_setg(errp, "vfio-display: region support not implemented yet");
+        return -1;
+    }
+
+    error_setg(errp, "vfio: device doesn't support any (known) display method");
+    return -1;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 033cc8dea1..d9d668a12b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3015,6 +3015,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (vdev->display) {
+        ret = vfio_display_probe(vdev, errp);
+        if (ret) {
+            goto out_teardown;
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3120,6 +3127,13 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
+static void vfio_display_instance_init(Object *obj)
+{
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, PCI_DEVICE(obj));
+
+    vdev->display = true;
+}
+
 static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
@@ -3178,6 +3192,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     pdc->config_write = vfio_pci_write_config;
 }
 
+static void vfio_pci_display_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->hotpluggable = false;
+}
+
 static const TypeInfo vfio_pci_dev_info = {
     .name = "vfio-pci",
     .parent = TYPE_PCI_DEVICE,
@@ -3192,9 +3213,18 @@ static const TypeInfo vfio_pci_dev_info = {
     },
 };
 
+static const TypeInfo vfio_pci_display_dev_info = {
+    .name = "vfio-pci-display",
+    .parent = "vfio-pci",
+    .instance_size = sizeof(VFIOPCIDevice),
+    .class_init = vfio_pci_display_dev_class_init,
+    .instance_init = vfio_display_instance_init,
+};
+
 static void register_vfio_pci_dev_type(void)
 {
     type_register_static(&vfio_pci_dev_info);
+    type_register_static(&vfio_pci_display_dev_info);
 }
 
 type_init(register_vfio_pci_dev_type)
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index c3ab9097f1..a2e7a0a7cf 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,6 +1,6 @@
 ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
-obj-$(CONFIG_PCI) += pci.o pci-quirks.o
+obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
 obj-$(CONFIG_SOFTMMU) += platform.o
 obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
-- 
2.9.3
