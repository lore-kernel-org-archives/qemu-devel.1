Received: from eggs.gnu.org ([2001:4830:134:3::10]:54715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT1Lo-0005gx-JH
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT1Ln-00017S-P6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:41:56 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Jun 2018 10:41:49 +0200
Message-Id: <20180613084149.14523-4-kraxel@redhat.com>
In-Reply-To: <20180613084149.14523-1-kraxel@redhat.com>
References: <20180613084149.14523-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/3] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

So we have a boot display when using a vgpu as primary display.

Use vfio-pci-ramfb instead of vfio-pci to enable it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/display.c             | 10 ++++++++++
 hw/vfio/pci.c                 | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a9036929b2..a58d7e7e77 100644
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
@@ -143,6 +144,7 @@ typedef struct VFIODMABuf {
 
 typedef struct VFIODisplay {
     QemuConsole *con;
+    RAMFBState *ramfb;
     struct {
         VFIORegion buffer;
         DisplaySurface *surface;
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 59c0e5d1d7..409d5a2e3a 100644
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
 
@@ -181,6 +184,8 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
     vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
                                           &vfio_display_dmabuf_ops,
                                           vdev);
+    if (strcmp(object_get_typename(OBJECT(vdev)), "vfio-pci-ramfb") == 0)
+        vdev->dpy->ramfb = ramfb_setup(errp);
     return 0;
 }
 
@@ -228,6 +233,9 @@ static void vfio_display_region_update(void *opaque)
         return;
     }
     if (!plane.drm_format || !plane.size) {
+        if (dpy->ramfb) {
+            ramfb_display_update(dpy->con, dpy->ramfb);
+        }
         return;
     }
     format = qemu_drm_format_to_pixman(plane.drm_format);
@@ -300,6 +308,8 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
     vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
                                           &vfio_display_region_ops,
                                           vdev);
+    if (strcmp(object_get_typename(OBJECT(vdev)), "vfio-pci-ramfb") == 0)
+        vdev->dpy->ramfb = ramfb_setup(errp);
     return 0;
 }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 18c493b49e..6a2b42a595 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3234,9 +3234,24 @@ static const TypeInfo vfio_pci_dev_info = {
     },
 };
 
+static void vfio_pci_ramfb_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo vfio_pci_ramfb_dev_info = {
+    .name = "vfio-pci-ramfb",
+    .parent = "vfio-pci",
+    .instance_size = sizeof(VFIOPCIDevice),
+    .class_init = vfio_pci_ramfb_dev_class_init,
+};
+
 static void register_vfio_pci_dev_type(void)
 {
     type_register_static(&vfio_pci_dev_info);
+    type_register_static(&vfio_pci_ramfb_dev_info);
 }
 
 type_init(register_vfio_pci_dev_type)
-- 
2.9.3
