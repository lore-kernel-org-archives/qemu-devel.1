Received: from eggs.gnu.org ([2001:4830:134:3::10]:60578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et9GA-00009d-Pt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et9G8-0004yN-3h
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:51:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et9G7-0004xe-TF
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:51:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 10:51:35 +0100
Message-Id: <20180306095135.21285-10-kraxel@redhat.com>
In-Reply-To: <20180306095135.21285-1-kraxel@redhat.com>
References: <20180306095135.21285-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v7 9/9] vfio/display: adding dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: intel-gvt-dev@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>

Wire up dmabuf-based display.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/vfio/vfio-common.h |  14 ++++
 hw/vfio/display.c             | 185 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fc8ae14fb7..c5efa32750 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -26,6 +26,7 @@
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "qemu/notify.h"
+#include "ui/console.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
@@ -142,12 +143,25 @@ typedef struct VFIOGroup {
     QLIST_ENTRY(VFIOGroup) container_next;
 } VFIOGroup;
 
+typedef struct VFIODMABuf {
+    QemuDmaBuf buf;
+    uint32_t pos_x, pos_y, pos_updates;
+    uint32_t hot_x, hot_y, hot_updates;
+    int dmabuf_id;
+    QTAILQ_ENTRY(VFIODMABuf) next;
+} VFIODMABuf;
+
 typedef struct VFIODisplay {
     QemuConsole *con;
     struct {
         VFIORegion buffer;
         DisplaySurface *surface;
     } region;
+    struct {
+        QTAILQ_HEAD(, VFIODMABuf) bufs;
+        VFIODMABuf *primary;
+        VFIODMABuf *cursor;
+    } dmabuf;
 } VFIODisplay;
 
 void vfio_put_base_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index f6acbacc79..7d727ce910 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -19,6 +19,184 @@
 #include "qapi/error.h"
 #include "pci.h"
 
+#ifndef DRM_PLANE_TYPE_PRIMARY
+# define DRM_PLANE_TYPE_PRIMARY 1
+# define DRM_PLANE_TYPE_CURSOR  2
+#endif
+
+static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
+                                       struct vfio_device_gfx_plane_info *plane)
+{
+    if (dmabuf->pos_x != plane->x_pos || dmabuf->pos_y != plane->y_pos) {
+        dmabuf->pos_x      = plane->x_pos;
+        dmabuf->pos_y      = plane->y_pos;
+        dmabuf->pos_updates++;
+    }
+    if (dmabuf->hot_x != plane->x_hot || dmabuf->hot_y != plane->y_hot) {
+        dmabuf->hot_x      = plane->x_hot;
+        dmabuf->hot_y      = plane->y_hot;
+        dmabuf->hot_updates++;
+    }
+}
+
+static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
+                                           uint32_t plane_type)
+{
+    VFIODisplay *dpy = vdev->dpy;
+    struct vfio_device_gfx_plane_info plane;
+    VFIODMABuf *dmabuf;
+    int fd, ret;
+
+    memset(&plane, 0, sizeof(plane));
+    plane.argsz = sizeof(plane);
+    plane.flags = VFIO_GFX_PLANE_TYPE_DMABUF;
+    plane.drm_plane_type = plane_type;
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &plane);
+    if (ret < 0) {
+        return NULL;
+    }
+    if (!plane.drm_format || !plane.size) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(dmabuf, &dpy->dmabuf.bufs, next) {
+        if (dmabuf->dmabuf_id == plane.dmabuf_id) {
+            /* found in list, move to head, return it */
+            QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
+            QTAILQ_INSERT_HEAD(&dpy->dmabuf.bufs, dmabuf, next);
+            if (plane_type == DRM_PLANE_TYPE_CURSOR) {
+                vfio_display_update_cursor(dmabuf, &plane);
+            }
+            return dmabuf;
+        }
+    }
+
+    fd = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_GFX_DMABUF, &plane.dmabuf_id);
+    if (fd < 0) {
+        return NULL;
+    }
+
+    dmabuf = g_new0(VFIODMABuf, 1);
+    dmabuf->dmabuf_id  = plane.dmabuf_id;
+    dmabuf->buf.width  = plane.width;
+    dmabuf->buf.height = plane.height;
+    dmabuf->buf.stride = plane.stride;
+    dmabuf->buf.fourcc = plane.drm_format;
+    dmabuf->buf.fd     = fd;
+    if (plane_type == DRM_PLANE_TYPE_CURSOR) {
+        vfio_display_update_cursor(dmabuf, &plane);
+    }
+
+    QTAILQ_INSERT_HEAD(&dpy->dmabuf.bufs, dmabuf, next);
+    return dmabuf;
+}
+
+static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
+{
+    QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
+    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
+    close(dmabuf->buf.fd);
+    g_free(dmabuf);
+}
+
+static void vfio_display_free_dmabufs(VFIOPCIDevice *vdev)
+{
+    VFIODisplay *dpy = vdev->dpy;
+    VFIODMABuf *dmabuf, *tmp;
+    uint32_t keep = 5;
+
+    QTAILQ_FOREACH_SAFE(dmabuf, &dpy->dmabuf.bufs, next, tmp) {
+        if (keep > 0) {
+            keep--;
+            continue;
+        }
+        assert(dmabuf != dpy->dmabuf.primary);
+        vfio_display_free_one_dmabuf(dpy, dmabuf);
+    }
+}
+
+static void vfio_display_dmabuf_update(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+    VFIODMABuf *primary, *cursor;
+    bool free_bufs = false, new_cursor = false;;
+
+    primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
+    if (primary == NULL) {
+        return;
+    }
+
+    if (dpy->dmabuf.primary != primary) {
+        dpy->dmabuf.primary = primary;
+        qemu_console_resize(dpy->con,
+                            primary->buf.width, primary->buf.height);
+        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+        free_bufs = true;
+    }
+
+    cursor = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_CURSOR);
+    if (dpy->dmabuf.cursor != cursor) {
+        dpy->dmabuf.cursor = cursor;
+        new_cursor = true;
+        free_bufs = true;
+    }
+
+    if (cursor && (new_cursor || cursor->hot_updates)) {
+        bool have_hot = (cursor->hot_x != 0xffffffff &&
+                         cursor->hot_y != 0xffffffff);
+        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+                             cursor->hot_x, cursor->hot_y);
+        cursor->hot_updates = 0;
+    } else if (!cursor && new_cursor) {
+        dpy_gl_cursor_dmabuf(dpy->con, NULL, false, 0, 0);
+    }
+
+    if (cursor && cursor->pos_updates) {
+        dpy_gl_cursor_position(dpy->con,
+                               cursor->pos_x,
+                               cursor->pos_y);
+        cursor->pos_updates = 0;
+    }
+
+    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
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
+    vdev->dpy = g_new0(VFIODisplay, 1);
+    vdev->dpy->con = graphic_console_init(DEVICE(vdev), 0,
+                                          &vfio_display_dmabuf_ops,
+                                          vdev);
+    return 0;
+}
+
+static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
+{
+    VFIODMABuf *dmabuf;
+
+    if (QTAILQ_EMPTY(&dpy->dmabuf.bufs)) {
+        return;
+    }
+
+    while ((dmabuf = QTAILQ_FIRST(&dpy->dmabuf.bufs)) != NULL) {
+        vfio_display_free_one_dmabuf(dpy, dmabuf);
+    }
+}
+
 /* ---------------------------------------------------------------------- */
 
 static void vfio_display_region_update(void *opaque)
@@ -136,8 +314,7 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
     probe.flags = VFIO_GFX_PLANE_TYPE_PROBE | VFIO_GFX_PLANE_TYPE_DMABUF;
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_QUERY_GFX_PLANE, &probe);
     if (ret == 0) {
-        error_setg(errp, "vfio-display: dmabuf support not implemented yet");
-        return -1;
+        return vfio_display_dmabuf_init(vdev, errp);
     }
 
     memset(&probe, 0, sizeof(probe));
@@ -159,10 +336,12 @@ int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
 
 void vfio_display_finalize(VFIOPCIDevice *vdev)
 {
-    if (!vdev->dpy)
+    if (!vdev->dpy) {
         return;
+    }
 
     graphic_console_close(vdev->dpy->con);
+    vfio_display_dmabuf_exit(vdev->dpy);
     vfio_display_region_exit(vdev->dpy);
     g_free(vdev->dpy);
 }
-- 
2.9.3
