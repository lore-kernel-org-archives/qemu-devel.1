Received: from eggs.gnu.org ([2001:4830:134:3::10]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8R-0001lE-Ho
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8L-00049y-Gk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1v8L-000499-8m
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:03:34 +0200
Message-Id: <20171010140334.8231-7-kraxel@redhat.com>
In-Reply-To: <20171010140334.8231-1-kraxel@redhat.com>
References: <20171010140334.8231-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 6/6] vfio/display: add dmabuf support (v15)
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

Wire up dma-buf based display.

TODO: drop debug code and messages.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h     |  12 ++++
 hw/vfio/display.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c03c4b3eb0..1ab6f6abde 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -19,6 +19,7 @@
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
+#include "ui/console.h"
 
 #define PCI_ANY_ID (~0)
 
@@ -98,6 +99,14 @@ typedef struct VFIOMSIXInfo {
     unsigned long *pending;
 } VFIOMSIXInfo;
 
+typedef struct VFIODMABuf VFIODMABuf;
+struct VFIODMABuf {
+    QemuDmaBuf  buf;
+    uint32_t pos_x, pos_y;
+    int dmabuf_id;
+    QTAILQ_ENTRY(VFIODMABuf) next;
+};
+
 typedef struct VFIOPCIDevice {
     PCIDevice pdev;
     VFIODevice vbasedev;
@@ -152,6 +161,9 @@ typedef struct VFIOPCIDevice {
     uint32_t region_size;
     void *region_mmap;
     DisplaySurface *region_surface;
+    QTAILQ_HEAD(, VFIODMABuf) dmabufs;
+    VFIODMABuf *primary;
+    VFIODMABuf *cursor;
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 8211bcc6d4..f45fd1fb98 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -18,6 +18,186 @@
 #include "ui/console.h"
 #include "pci.h"
 
+/* FIXME */
+#ifndef DRM_PLANE_TYPE_PRIMARY
+# define DRM_PLANE_TYPE_PRIMARY 1
+# define DRM_PLANE_TYPE_CURSOR  2
+#endif
+
+static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
+                                           uint32_t plane_type)
+{
+    struct vfio_device_gfx_plane_info plane;
+    struct vfio_device_gfx_dmabuf_fd gfd;
+    VFIODMABuf *dmabuf;
+    static int errcnt;
+    int ret;
+
+    memset(&plane, 0, sizeof(plane));
+    plane.argsz = sizeof(plane);
+    plane.flags = VFIO_GFX_PLANE_TYPE_DMABUF;
+    plane.drm_plane_type = plane_type;
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &plane);
+    if (ret < 0) {
+        fprintf(stderr, "(%d) ioctl VFIO_DEVICE_QUERY_GFX_PLANE(%s): %s\r",
+                ++errcnt,
+                (plane_type == DRM_PLANE_TYPE_PRIMARY) ? "primary" : "cursor",
+                strerror(errno));
+        fflush(stderr);
+        return NULL;
+    }
+    if (!plane.drm_format || !plane.size) {
+        fprintf(stderr, "(%d) %s plane not initialized by guest\r",
+                ++errcnt,
+                (plane_type == DRM_PLANE_TYPE_PRIMARY) ? "primary" : "cursor");
+        fflush(stderr);
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(dmabuf, &vdev->dmabufs, next) {
+        if (dmabuf->dmabuf_id == plane.dmabuf_id) {
+            /* found in list, move to head, return it */
+            QTAILQ_REMOVE(&vdev->dmabufs, dmabuf, next);
+            QTAILQ_INSERT_HEAD(&vdev->dmabufs, dmabuf, next);
+            if (plane_type == DRM_PLANE_TYPE_CURSOR) {
+                dmabuf->pos_x      = plane.x_pos;
+                dmabuf->pos_y      = plane.y_pos;
+            }
+#if 1
+            if (plane.width != dmabuf->buf.width ||
+                plane.height != dmabuf->buf.height) {
+                fprintf(stderr, "%s: cached dmabuf mismatch: id %d, "
+                        "kernel %dx%d, cached %dx%d, plane %s\n",
+                        __func__, plane.dmabuf_id,
+                        plane.width, plane.height,
+                        dmabuf->buf.width, dmabuf->buf.height,
+                        (plane_type == DRM_PLANE_TYPE_PRIMARY)
+                        ? "primary" : "cursor");
+                abort();
+            }
+#endif
+            return dmabuf;
+        }
+    }
+
+    memset(&gfd, 0, sizeof(gfd));
+    gfd.argsz = sizeof(gfd);
+    gfd.dmabuf_id = plane.dmabuf_id;
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_GFX_DMABUF, &gfd);
+    if (ret < 0) {
+        fprintf(stderr, "(%d) ioctl VFIO_DEVICE_GET_GFX_DMABUF: %s\r",
+                ++errcnt, strerror(errno));
+        return NULL;
+    }
+
+    fprintf(stderr, "%s: new dmabuf: id %d, res %dx%d, "
+            "format %c%c%c%c, plane %s, fd %d, hot +%d+%d\n",
+            __func__, plane.dmabuf_id,
+            plane.width, plane.height,
+            (plane.drm_format >>  0) & 0xff,
+            (plane.drm_format >>  8) & 0xff,
+            (plane.drm_format >> 16) & 0xff,
+            (plane.drm_format >> 24) & 0xff,
+            (plane_type == DRM_PLANE_TYPE_PRIMARY) ? "primary" : "cursor",
+            gfd.dmabuf_fd,
+            plane.x_pos, plane.y_pos);
+
+    dmabuf = g_new0(VFIODMABuf, 1);
+    dmabuf->dmabuf_id  = plane.dmabuf_id;
+    dmabuf->buf.width  = plane.width;
+    dmabuf->buf.height = plane.height;
+    dmabuf->buf.stride = plane.stride;
+    dmabuf->buf.fourcc = plane.drm_format;
+    dmabuf->buf.fd     = gfd.dmabuf_fd;
+    if (plane_type == DRM_PLANE_TYPE_CURSOR) {
+        dmabuf->pos_x      = plane.x_pos;
+        dmabuf->pos_y      = plane.y_pos;
+    }
+
+    QTAILQ_INSERT_HEAD(&vdev->dmabufs, dmabuf, next);
+    return dmabuf;
+}
+
+static void vfio_display_free_dmabufs(VFIOPCIDevice *vdev)
+{
+    char log[128]; int pos = 0;
+    VFIODMABuf *dmabuf, *tmp;
+    uint32_t keep = 8;
+
+    QTAILQ_FOREACH_SAFE(dmabuf, &vdev->dmabufs, next, tmp) {
+        if (keep > 0) {
+            pos += sprintf(log + pos, " %d", dmabuf->buf.fd);
+            keep--;
+            continue;
+        }
+        assert(dmabuf != vdev->primary);
+        QTAILQ_REMOVE(&vdev->dmabufs, dmabuf, next);
+        fprintf(stderr, "%s: free dmabuf: fd %d (keep%s)\n",
+                __func__, dmabuf->buf.fd, log);
+        dpy_gl_release_dmabuf(vdev->display_con, &dmabuf->buf);
+        close(dmabuf->buf.fd);
+        g_free(dmabuf);
+    }
+}
+
+static void vfio_display_dmabuf_update(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODMABuf *primary, *cursor;
+    bool free_bufs = false;
+
+    primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
+    if (primary == NULL) {
+        return;
+    }
+
+    if (vdev->primary != primary) {
+        vdev->primary = primary;
+        qemu_console_resize(vdev->display_con,
+                            primary->buf.width, primary->buf.height);
+        dpy_gl_scanout_dmabuf(vdev->display_con,
+                              &primary->buf);
+        free_bufs = true;
+    }
+
+    cursor = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_CURSOR);
+    if (vdev->cursor != cursor) {
+        vdev->cursor = cursor;
+        free_bufs = true;
+    }
+    if (cursor != NULL) {
+        dpy_gl_cursor_dmabuf(vdev->display_con,
+                             &cursor->buf,
+                             cursor->pos_x,
+                             cursor->pos_y);
+    }
+
+    dpy_gl_update(vdev->display_con, 0, 0,
+                  primary->buf.width, primary->buf.height);
+
+    if (free_bufs) {
+        vfio_display_free_dmabufs(vdev);
+    }
+}
+
+static const GraphicHwOps vfio_display_dmabuf_ops = {
+    .gfx_update = vfio_display_dmabuf_update,
+};
+
+static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
+{
+    if (!display_opengl) {
+        error_setg(errp, "vfio-display-dmabuf: opengl not available");
+        return -1;
+    }
+
+    vdev->display_con = graphic_console_init(DEVICE(vdev), 0,
+                                             &vfio_display_dmabuf_ops,
+                                             vdev);
+    /* TODO: disable hotplug (there is no graphic_console_close) */
+    return 0;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static void vfio_display_region_update(void *opaque)
@@ -121,8 +301,7 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
     probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_DMABUF;
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
     if (ret == 0) {
-        error_setg(errp, "vfio-display: dmabuf support not implemented yet");
-        return -1;
+        return vfio_display_dmabuf_init(vdev, errp);
     }
 
     memset(&probe, 0, sizeof(probe));
-- 
2.9.3
