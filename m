Received: from eggs.gnu.org ([2001:4830:134:3::10]:50284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqNZ-0005rP-TA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqNW-00045w-Mh
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evqNW-000457-EV
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0294C057F85
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 20:18:33 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 13 Mar 2018 14:18:30 -0600
Message-ID: <20180313201830.2327.63596.stgit@gimli.home>
In-Reply-To: <20180313201415.2327.62402.stgit@gimli.home>
References: <20180313201415.2327.62402.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 06/11] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Gerd Hoffmann <kraxel@redhat.com>

Infrastructure for display support.  Must be enabled
using 'display' property.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed By: Kirti Wankhede <kwankhede@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/Makefile.objs |    2 +-
 hw/vfio/display.c     |   56 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c         |   10 +++++++++
 hw/vfio/pci.h         |    4 ++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/display.c

diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index c3ab9097f160..a2e7a0a7cf02 100644
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
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
new file mode 100644
index 000000000000..3e997f8a44f2
--- /dev/null
+++ b/hw/vfio/display.c
@@ -0,0 +1,56 @@
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
+    if (vdev->display == ON_OFF_AUTO_AUTO) {
+        /* not an error in automatic mode */
+        return 0;
+    }
+
+    error_setg(errp, "vfio: device doesn't support any (known) display method");
+    return -1;
+}
+
+void vfio_display_finalize(VFIOPCIDevice *vdev)
+{
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3ba3cbc1460b..b9d2c12b8273 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3015,6 +3015,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    if (vdev->display != ON_OFF_AUTO_OFF) {
+        ret = vfio_display_probe(vdev, errp);
+        if (ret) {
+            goto out_teardown;
+        }
+    }
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3035,6 +3042,7 @@ static void vfio_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pci_dev);
     VFIOGroup *group = vdev->vbasedev.group;
 
+    vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
@@ -3123,6 +3131,8 @@ static void vfio_instance_init(Object *obj)
 static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
+                            display, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
     DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f4aa13e021fa..a846cf62374a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -133,6 +133,7 @@ typedef struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT 2
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
+    OnOffAuto display;
     int32_t bootindex;
     uint32_t igd_gms;
     OffAutoPCIBAR msix_relo;
@@ -174,4 +175,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
 
+int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
+void vfio_display_finalize(VFIOPCIDevice *vdev);
+
 #endif /* HW_VFIO_VFIO_PCI_H */
