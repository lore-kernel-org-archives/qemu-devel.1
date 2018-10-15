Received: from eggs.gnu.org ([2001:4830:134:3::10]:50774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nZ-00037S-AP
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nV-0003XY-TB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6nV-0003WE-Jy
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EFBA47D0F2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 17:36:52 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:36:46 -0600
Message-ID: <153962500631.21502.14652060861407982592.stgit@gimli.home>
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/6] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

So we have a boot display when using a vgpu as primary display.

ramfb depends on a fw_cfg file.  fw_cfg files can not be added and
removed at runtime, therefore a ramfb-enabled vfio device can't be
hotplugged.

Add a nohotplug variant of the vfio-pci device (as child class).  Add
the ramfb property to the nohotplug variant only.  So to enable the vgpu
display with boot support use this:

  -device vfio-pci-nohotplug,display=on,ramfb=on,sysfsdev=...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/display.c             |   12 ++++++++++++
 hw/vfio/pci.c                 |   25 +++++++++++++++++++++++++
 hw/vfio/pci.h                 |    1 +
 include/hw/vfio/vfio-common.h |    2 ++
 4 files changed, 40 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 59c0e5d1d7f3..dead30e626cb 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -124,6 +124,9 @@ static void vfio_display_dmabuf_update(void *opaque)
 
     primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
     if (primary == NULL) {
+        if (dpy->ramfb) {
+            ramfb_display_update(dpy->con, dpy->ramfb);
+        }
         return;
     }
 
@@ -181,6 +184,9 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
     vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
                                           &vfio_display_dmabuf_ops,
                                           vdev);
+    if (vdev->enable_ramfb) {
+        vdev->dpy->ramfb = ramfb_setup(errp);
+    }
     return 0;
 }
 
@@ -228,6 +234,9 @@ static void vfio_display_region_update(void *opaque)
         return;
     }
     if (!plane.drm_format || !plane.size) {
+        if (dpy->ramfb) {
+            ramfb_display_update(dpy->con, dpy->ramfb);
+        }
         return;
     }
     format = qemu_drm_format_to_pixman(plane.drm_format);
@@ -300,6 +309,9 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
     vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
                                           &vfio_display_region_ops,
                                           vdev);
+    if (vdev->enable_ramfb) {
+        vdev->dpy->ramfb = ramfb_setup(errp);
+    }
     return 0;
 }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 866f0deeb7eb..a0047f4942c8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3067,6 +3067,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             goto out_teardown;
         }
     }
+    if (vdev->enable_ramfb && vdev->dpy == NULL) {
+        error_setg(errp, "ramfb=on requires display=on");
+        goto out_teardown;
+    }
 
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
@@ -3258,9 +3262,30 @@ static const TypeInfo vfio_pci_dev_info = {
     },
 };
 
+static Property vfio_pci_dev_nohotplug_properties[] = {
+    DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = vfio_pci_dev_nohotplug_properties;
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo vfio_pci_nohotplug_dev_info = {
+    .name = "vfio-pci-nohotplug",
+    .parent = "vfio-pci",
+    .instance_size = sizeof(VFIOPCIDevice),
+    .class_init = vfio_pci_nohotplug_dev_class_init,
+};
+
 static void register_vfio_pci_dev_type(void)
 {
     type_register_static(&vfio_pci_dev_info);
+    type_register_static(&vfio_pci_nohotplug_dev_info);
 }
 
 type_init(register_vfio_pci_dev_type)
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 52b065421a68..b1ae4c07549a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -165,6 +165,7 @@ typedef struct VFIOPCIDevice {
     bool no_geforce_quirks;
     bool no_kvm_ioeventfd;
     bool no_vfio_ioeventfd;
+    bool enable_ramfb;
     VFIODisplay *dpy;
 } VFIOPCIDevice;
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6be9a93f611b..e46a28910ab5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -26,6 +26,7 @@
 #include "qemu/queue.h"
 #include "qemu/notify.h"
 #include "ui/console.h"
+#include "hw/display/ramfb.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
@@ -147,6 +148,7 @@ typedef struct VFIODMABuf {
 
 typedef struct VFIODisplay {
     QemuConsole *con;
+    RAMFBState *ramfb;
     struct {
         VFIORegion buffer;
         DisplaySurface *surface;
