Received: from eggs.gnu.org ([2001:4830:134:3::10]:55092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazp-0003QU-Rv
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqazn-00081o-0z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqazm-00080z-J4
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:52:22 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:52:08 +0100
Message-Id: <20180227085209.19151-7-kraxel@redhat.com>
In-Reply-To: <20180227085209.19151-1-kraxel@redhat.com>
References: <20180227085209.19151-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v5 6/7] vfio/display: adding region support
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
 hw/vfio/display.c             | 100 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index fe2a7aeb4c..3227f9f660 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -148,6 +148,7 @@ typedef struct VFIOPCIDevice {
     bool no_kvm_msi;
     bool no_kvm_msix;
     bool no_geforce_quirks;
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
index d9b4d07f20..8910f927e3 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -19,6 +19,103 @@
 #include "qapi/error.h"
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
+    pixman_format_code_t format;
+    int ret;
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &plane);
+    if (ret < 0) {
+        error_report("ioctl VFIO_DEVICE_QUERY_GFX_PLANE: %s",
+                     strerror(errno));
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
+        vfio_region_finalize(&dpy->region.buffer);
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
+            error_report("%s: vfio_region_setup(%d): %s",
+                         __func__, plane.region_index, strerror(-ret));
+            goto err;
+        }
+        ret = vfio_region_mmap(&dpy->region.buffer);
+        if (ret != 0) {
+            error_report("%s: vfio_region_mmap(%d): %s", __func__,
+                         plane.region_index, strerror(-ret));
+            goto err;
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
+err:
+    vfio_region_exit(&dpy->region.buffer);
+    vfio_region_finalize(&dpy->region.buffer);
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
+    return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_device_gfx_plane_info probe;
@@ -38,8 +135,7 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
     probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_REGION;
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
     if (ret == 0) {
-        error_setg(errp, "vfio-display: region support not implemented yet");
-        return -1;
+        return vfio_display_region_init(vdev, errp);
     }
 
     error_setg(errp, "vfio: device doesn't support any (known) display method");
-- 
2.9.3
