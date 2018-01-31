Received: from eggs.gnu.org ([2001:4830:134:3::10]:39241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egrG1-0004qF-NG
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egrFr-00087u-Of
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egrFr-00087m-Gw
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 31 Jan 2018 13:12:17 +0100
Message-Id: <20180131121217.13557-6-kraxel@redhat.com>
In-Reply-To: <20180131121217.13557-1-kraxel@redhat.com>
References: <20180131121217.13557-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH v2 5/5] vfio/display: adding region support
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

Wire up region-based display.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h                 |   1 +
 include/hw/vfio/vfio-common.h |   8 ++++
 hw/vfio/display.c             | 102 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 8f3295188c..ca43e005a9 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -143,6 +143,7 @@ typedef struct VFIOPCIDevice {
     bool no_kvm_intx;
     bool no_kvm_msi;
     bool no_kvm_msix;
+    VFIODisplay *dpy;
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9fee..fc8ae14fb7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -142,6 +142,14 @@ typedef struct VFIOGroup {
     QLIST_ENTRY(VFIOGroup) container_next;
 } VFIOGroup;
 
+typedef struct VFIODisplay {
+    QemuConsole *con;
+    struct {
+        VFIORegion buffer;
+        DisplaySurface *surface;
+    } region;
+} VFIODisplay;
+
 void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 4ba93ea251..e48afbb7ec 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -18,6 +18,105 @@
 #include "ui/console.h"
 #include "pci.h"
 
+/* ---------------------------------------------------------------------- */
+
+static void vfio_display_region_update(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+    struct vfio_device_gfx_plane_info plane = {
+        .argsz = sizeof(plane),
+        .flags = VFIO_GFX_PLANE_TYPE_REGION
+    };
+    pixman_format_code_t format = PIXMAN_x8r8g8b8;
+    int ret;
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &plane);
+    if (ret < 0) {
+        fprintf(stderr, "ioctl VFIO_DEVICE_QUERY_GFX_PLANE: %s\n",
+                strerror(errno));
+        return;
+    }
+    if (!plane.drm_format || !plane.size) {
+        return;
+    }
+    format = qemu_drm_format_to_pixman(plane.drm_format);
+    if (!format) {
+        return;
+    }
+
+    if (dpy->region.buffer.size &&
+        dpy->region.buffer.nr != plane.region_index) {
+        /* region changed */
+        vfio_region_exit(&dpy->region.buffer);
+        memset(&dpy->region.buffer, 0, sizeof(dpy->region.buffer));
+        dpy->region.surface = NULL;
+    }
+
+    if (dpy->region.surface &&
+        (surface_width(dpy->region.surface) != plane.width ||
+         surface_height(dpy->region.surface) != plane.height ||
+         surface_format(dpy->region.surface) != format)) {
+        /* size changed */
+        dpy->region.surface = NULL;
+    }
+
+    if (!dpy->region.buffer.size) {
+        /* mmap region */
+        ret = vfio_region_setup(OBJECT(vdev), &vdev->vbasedev,
+                                &dpy->region.buffer,
+                                plane.region_index,
+                                "display");
+        if (ret != 0) {
+            fprintf(stderr, "%s: vfio_region_setup(%d): %s\n",
+                    __func__, plane.region_index, strerror(-ret));
+            goto err1;
+        }
+        ret = vfio_region_mmap(&dpy->region.buffer);
+        if (ret != 0) {
+            fprintf(stderr, "%s: vfio_region_mmap(%d): %s\n", __func__,
+                    plane.region_index, strerror(-ret));
+            goto err2;
+        }
+        assert(dpy->region.buffer.mmaps[0].mmap != NULL);
+    }
+
+    if (dpy->region.surface == NULL) {
+        /* create surface */
+        dpy->region.surface = qemu_create_displaysurface_from
+            (plane.width, plane.height, format,
+             plane.stride, dpy->region.buffer.mmaps[0].mmap);
+        dpy_gfx_replace_surface(dpy->con, dpy->region.surface);
+    }
+
+    /* full screen update */
+    dpy_gfx_update(dpy->con, 0, 0,
+                   surface_width(dpy->region.surface),
+                   surface_height(dpy->region.surface));
+    return;
+
+err2:
+    vfio_region_exit(&dpy->region.buffer);
+err1:
+    memset(&dpy->region.buffer, 0, sizeof(dpy->region.buffer));
+}
+
+static const GraphicHwOps vfio_display_region_ops = {
+    .gfx_update = vfio_display_region_update,
+};
+
+static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
+{
+    vdev->dpy = g_new0(VFIODisplay, 1);
+    vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
+                                          &vfio_display_region_ops,
+                                          vdev);
+    /* TODO: disable hotplug (there is no graphic_console_close) */
+    return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_device_gfx_plane_info probe;
@@ -37,8 +136,7 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
     probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_REGION;
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
     if (ret == 0) {
-        error_setg(errp, "vfio-display: region support not implemented yet");
-        return -1;
+        return vfio_display_region_init(vdev, errp);
     }
 
     if (vdev->display == ON_OFF_AUTO_AUTO) {
-- 
2.9.3
