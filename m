Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8Q-0001kS-KO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8K-000495-Js
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1v8K-00048n-CA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:44 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:03:32 +0200
Message-Id: <20171010140334.8231-5-kraxel@redhat.com>
In-Reply-To: <20171010140334.8231-1-kraxel@redhat.com>
References: <20171010140334.8231-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 4/6] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Infrastructure for display support.  Must be enabled
using x-display property for now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h         |  4 ++++
 hw/vfio/display.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c         |  9 +++++++++
 hw/vfio/Makefile.objs |  2 +-
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/display.c

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 502a5755b9..3c1b0a33ab 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -132,6 +132,8 @@ typedef struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+#define VFIO_FEATURE_ENABLE_DISPLAY_BIT 3
+#define VFIO_FEATURE_ENABLE_DISPLAY (1 << VFIO_FEATURE_ENABLE_DISPLAY_BIT)
     int32_t bootindex;
     uint32_t igd_gms;
     uint8_t pm_cap;
@@ -171,4 +173,6 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
 
+int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
new file mode 100644
index 0000000000..064ec95f3e
--- /dev/null
+++ b/hw/vfio/display.c
@@ -0,0 +1,46 @@
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
index 9e86db7c3b..91ac7258a3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2873,6 +2873,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (vdev->features & VFIO_FEATURE_ENABLE_DISPLAY) {
+        ret = vfio_display_probe(vdev, errp);
+        if (ret) {
+            goto out_teardown;
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -2985,6 +2992,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_REQ_BIT, true),
     DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BIT("x-display", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_DISPLAY_BIT, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
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
