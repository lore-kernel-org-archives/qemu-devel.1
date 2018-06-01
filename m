Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmug-0003TW-Go
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmud-0007wh-Az
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOmud-0007wS-50
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD3DD8A3B7
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 16:28:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  1 Jun 2018 18:27:48 +0200
Message-Id: <20180601162749.27406-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180601162749.27406-1-marcandre.lureau@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 11/12] Add virtio-gpu vhost-user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add to virtio-gpu devices a "vhost-user" property. When set, the
associated vhost-user backend is used to handle the virtio rings.

For now, a socketpair is created for the backend to share the rendering
results with qemu via a simple VHOST_GPU protocol.

Example usage:
-object vhost-user-backend,id=3Dvug,cmd=3D"./vhost-user-gpu"
-device virtio-vga,virgl=3Dtrue,vhost-user=3Dvug

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |   9 +
 include/ui/console.h           |   1 +
 hw/display/vhost-gpu.c         | 290 +++++++++++++++++++++++++++++++++
 hw/display/virtio-gpu-3d.c     |   8 +-
 hw/display/virtio-gpu-pci.c    |   5 +
 hw/display/virtio-gpu.c        |  77 ++++++++-
 hw/display/virtio-vga.c        |   5 +
 ui/spice-display.c             |   3 +-
 hw/display/Makefile.objs       |   2 +-
 9 files changed, 393 insertions(+), 7 deletions(-)
 create mode 100644 hw/display/vhost-gpu.c

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 79bb3fb3dd..7cd514175a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -19,6 +19,7 @@
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/log.h"
+#include "sysemu/vhost-user-backend.h"
=20
 #include "standard-headers/linux/virtio_gpu.h"
 #define TYPE_VIRTIO_GPU "virtio-gpu-device"
@@ -88,6 +89,9 @@ struct virtio_gpu_ctrl_command {
 typedef struct VirtIOGPU {
     VirtIODevice parent_obj;
=20
+    VhostUserBackend *vhost;
+    CharBackend vhost_chr;
+
     QEMUBH *ctrl_bh;
     QEMUBH *cursor_bh;
     VirtQueue *ctrl_vq;
@@ -103,6 +107,7 @@ typedef struct VirtIOGPU {
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
=20
     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
+    QemuDmaBuf dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     struct virtio_gpu_requested_state req_state[VIRTIO_GPU_MAX_SCANOUTS]=
;
=20
     struct virtio_gpu_conf conf;
@@ -171,4 +176,8 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g);
 void virtio_gpu_gl_block(void *opaque, bool block);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+
+/* vhost-gpu.c */
+int vhost_gpu_init(VirtIOGPU *g, Error **errp);
+
 #endif
diff --git a/include/ui/console.h b/include/ui/console.h
index 981b519dde..fb969caf70 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -186,6 +186,7 @@ struct QemuDmaBuf {
     uint32_t  stride;
     uint32_t  fourcc;
     uint32_t  texture;
+    bool      y0_top;
 };
=20
 typedef struct DisplayChangeListenerOps {
diff --git a/hw/display/vhost-gpu.c b/hw/display/vhost-gpu.c
new file mode 100644
index 0000000000..42d9143d3d
--- /dev/null
+++ b/hw/display/vhost-gpu.c
@@ -0,0 +1,290 @@
+/*
+ * Virtio vhost GPU Device
+ *
+ * Copyright Red Hat, Inc. 2016
+ *
+ * Authors:
+ *     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio-gpu.h"
+#include "chardev/char-fe.h"
+#include "qapi/error.h"
+
+typedef enum VhostGpuRequest {
+    VHOST_GPU_NONE =3D 0,
+    VHOST_GPU_CURSOR_POS,
+    VHOST_GPU_CURSOR_POS_HIDE,
+    VHOST_GPU_CURSOR_UPDATE,
+    VHOST_GPU_SCANOUT,
+    VHOST_GPU_UPDATE,
+    VHOST_GPU_GL_SCANOUT,
+    VHOST_GPU_GL_UPDATE,
+} VhostGpuRequest;
+
+typedef struct VhostGpuCursorPos {
+    uint32_t scanout_id;
+    uint32_t x;
+    uint32_t y;
+} QEMU_PACKED VhostGpuCursorPos;
+
+typedef struct VhostGpuCursorUpdate {
+    VhostGpuCursorPos pos;
+    uint32_t hot_x;
+    uint32_t hot_y;
+    uint32_t data[64 * 64];
+} QEMU_PACKED VhostGpuCursorUpdate;
+
+typedef struct VhostGpuScanout {
+    uint32_t scanout_id;
+    uint32_t width;
+    uint32_t height;
+} QEMU_PACKED VhostGpuScanout;
+
+typedef struct VhostGpuGlScanout {
+    uint32_t scanout_id;
+    uint32_t x;
+    uint32_t y;
+    uint32_t width;
+    uint32_t height;
+    uint32_t fd_width;
+    uint32_t fd_height;
+    uint32_t fd_stride;
+    uint32_t fd_flags;
+    int fd_drm_fourcc;
+} QEMU_PACKED VhostGpuGlScanout;
+
+typedef struct VhostGpuUpdate {
+    uint32_t scanout_id;
+    uint32_t x;
+    uint32_t y;
+    uint32_t width;
+    uint32_t height;
+    uint8_t data[];
+} QEMU_PACKED VhostGpuUpdate;
+
+typedef struct VhostGpuMsg {
+    VhostGpuRequest request;
+    uint32_t size; /* the following payload size */
+    union {
+        VhostGpuCursorPos cursor_pos;
+        VhostGpuCursorUpdate cursor_update;
+        VhostGpuScanout scanout;
+        VhostGpuUpdate update;
+        VhostGpuGlScanout gl_scanout;
+    } payload;
+} QEMU_PACKED VhostGpuMsg;
+
+static VhostGpuMsg m __attribute__ ((unused));
+#define VHOST_GPU_HDR_SIZE (sizeof(m.request) + sizeof(m.size))
+
+static void vhost_gpu_handle_cursor(VirtIOGPU *g, VhostGpuMsg *msg)
+{
+    VhostGpuCursorPos *pos =3D &msg->payload.cursor_pos;
+    struct virtio_gpu_scanout *s;
+
+    if (pos->scanout_id >=3D g->conf.max_outputs) {
+        return;
+    }
+    s =3D &g->scanout[pos->scanout_id];
+
+    if (msg->request =3D=3D VHOST_GPU_CURSOR_UPDATE) {
+        VhostGpuCursorUpdate *up =3D &msg->payload.cursor_update;
+        if (!s->current_cursor) {
+            s->current_cursor =3D cursor_alloc(64, 64);
+        }
+
+        s->current_cursor->hot_x =3D up->hot_x;
+        s->current_cursor->hot_y =3D up->hot_y;
+
+        memcpy(s->current_cursor->data, up->data,
+               64 * 64 * sizeof(uint32_t));
+
+        dpy_cursor_define(s->con, s->current_cursor);
+    }
+
+    dpy_mouse_set(s->con, pos->x, pos->y,
+                  msg->request !=3D VHOST_GPU_CURSOR_POS_HIDE);
+}
+
+static void vhost_gpu_handle_display(VirtIOGPU *g, VhostGpuMsg *msg)
+{
+    struct virtio_gpu_scanout *s;
+
+    switch (msg->request) {
+    case VHOST_GPU_SCANOUT: {
+        VhostGpuScanout *m =3D &msg->payload.scanout;
+
+        if (m->scanout_id >=3D g->conf.max_outputs) {
+            return;
+        }
+        s =3D &g->scanout[m->scanout_id];
+
+        s->ds =3D qemu_create_displaysurface(m->width, m->height);
+        if (!s->ds) {
+            return;
+        }
+
+        dpy_gfx_replace_surface(s->con, s->ds);
+        break;
+    }
+    case VHOST_GPU_GL_SCANOUT: {
+        VhostGpuGlScanout *m =3D &msg->payload.gl_scanout;
+        int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
+        QemuDmaBuf *dmabuf;
+
+        if (m->scanout_id >=3D g->conf.max_outputs) {
+            if (fd >=3D 0) {
+                close(fd);
+            }
+            break;
+        }
+
+        dmabuf =3D &g->dmabuf[m->scanout_id];
+        if (g->enable && dmabuf->fd >=3D 0) {
+            close(dmabuf->fd);
+            dmabuf->fd =3D -1;
+        }
+        if (fd =3D=3D -1) {
+            dpy_gl_release_dmabuf(g->scanout[m->scanout_id].con, dmabuf)=
;
+            break;
+        }
+        *dmabuf =3D (QemuDmaBuf) {
+            .fd =3D fd,
+            .width =3D m->fd_width,
+            .height =3D m->fd_height,
+            .stride =3D m->fd_stride,
+            .fourcc =3D m->fd_drm_fourcc,
+            .y0_top =3D m->fd_flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
+        };
+        g->enable =3D 1;
+        dpy_gl_scanout_dmabuf(g->scanout[m->scanout_id].con, dmabuf);
+        break;
+    }
+    case VHOST_GPU_GL_UPDATE: {
+        VhostGpuUpdate *m =3D &msg->payload.update;
+        QemuConsole *con =3D g->scanout[m->scanout_id].con;
+
+        if (m->scanout_id >=3D g->conf.max_outputs ||
+            !g->scanout[m->scanout_id].con) {
+            break;
+        }
+
+        graphic_hw_gl_block(con, true);
+        dpy_gl_update(con, m->x, m->y, m->width, m->height);
+        graphic_hw_gl_block(con, false);
+        break;
+    }
+    case VHOST_GPU_UPDATE: {
+        VhostGpuUpdate *m =3D &msg->payload.update;
+
+        if (m->scanout_id >=3D g->conf.max_outputs) {
+            break;
+        }
+        s =3D &g->scanout[m->scanout_id];
+
+        pixman_image_t *image =3D
+            pixman_image_create_bits(PIXMAN_x8r8g8b8,
+                                     m->width,
+                                     m->height,
+                                     (uint32_t *)m->data,
+                                     m->width * 4);
+
+        pixman_image_composite(PIXMAN_OP_SRC,
+                               image, NULL, s->ds->image,
+                               0, 0, 0, 0, m->x, m->y, m->width, m->heig=
ht);
+
+        pixman_image_unref(image);
+        dpy_gfx_update(s->con, m->x, m->y, m->width, m->height);
+        break;
+    }
+    default:
+        g_warning("unhandled message %d %d", msg->request, msg->size);
+    }
+}
+
+static void vhost_gpu_chr_read(void *opaque)
+{
+    VirtIOGPU *g =3D opaque;
+    VhostGpuMsg *msg =3D NULL;
+    VhostGpuRequest request;
+    uint32_t size;
+    int r;
+
+    r =3D qemu_chr_fe_read_all(&g->vhost_chr,
+                             (uint8_t *)&request, sizeof(uint32_t));
+    if (r !=3D sizeof(uint32_t)) {
+        error_report("failed to read msg header: %d, %d", r, errno);
+        goto end;
+    }
+
+    r =3D qemu_chr_fe_read_all(&g->vhost_chr,
+                             (uint8_t *)&size, sizeof(uint32_t));
+    if (r !=3D sizeof(uint32_t)) {
+        error_report("failed to read msg size");
+        goto end;
+    }
+
+    msg =3D g_malloc(VHOST_GPU_HDR_SIZE + size);
+    g_return_if_fail(msg !=3D NULL);
+
+    r =3D qemu_chr_fe_read_all(&g->vhost_chr,
+                             (uint8_t *)&msg->payload, size);
+    if (r !=3D size) {
+        error_report("failed to read msg payload %d !=3D %d", r, size);
+        goto end;
+    }
+
+    msg->request =3D request;
+    msg->size =3D size;
+
+    if (request =3D=3D VHOST_GPU_CURSOR_UPDATE ||
+        request =3D=3D VHOST_GPU_CURSOR_POS ||
+        request =3D=3D VHOST_GPU_CURSOR_POS_HIDE) {
+        vhost_gpu_handle_cursor(g, msg);
+    } else {
+        vhost_gpu_handle_display(g, msg);
+    }
+
+end:
+    g_free(msg);
+}
+
+int vhost_gpu_init(VirtIOGPU *g, Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(g);
+    Chardev *chr;
+    int sv[2];
+
+    if (vhost_user_backend_dev_init(g->vhost, vdev, 2, errp) < 0) {
+        return -1;
+    }
+
+    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) =3D=3D -1) {
+        error_setg_errno(errp, errno, "socketpair() failed");
+        return -1;
+    }
+
+    chr =3D CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+    if (!chr || qemu_chr_add_client(chr, sv[0]) =3D=3D -1) {
+        error_setg(errp, "Failed to make socket chardev");
+        object_unref(OBJECT(chr));
+        return -1;
+    }
+    if (!qemu_chr_fe_init(&g->vhost_chr, chr, errp)) {
+        object_unref(OBJECT(chr));
+        return -1;
+    }
+
+    qemu_set_fd_handler(sv[0], vhost_gpu_chr_read, NULL, g);
+
+    vhost_user_gpu_set_socket(&g->vhost->dev, sv[1]);
+
+    close(sv[1]);
+
+    return 0;
+}
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 3558f38fe8..90984ea1bb 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -614,9 +614,13 @@ void virtio_gpu_gl_block(void *opaque, bool block)
         g->renderer_blocked--;
     }
     assert(g->renderer_blocked >=3D 0);
-
     if (g->renderer_blocked =3D=3D 0) {
-        virtio_gpu_process_cmdq(g);
+        if (g->vhost && g->enable) {
+            uint32_t ok; /*unblock renderer */
+            qemu_chr_fe_write(&g->vhost_chr, (uint8_t *)&ok, sizeof(ok))=
;
+        } else {
+            virtio_gpu_process_cmdq(g);
+        }
     }
 }
=20
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index cece4aa495..470bf0608c 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -18,6 +18,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "qapi/error.h"
=20
 static Property virtio_gpu_pci_properties[] =3D {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
@@ -67,6 +68,10 @@ static void virtio_gpu_initfn(Object *obj)
=20
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_GPU);
+
+    object_property_add_alias(obj, "vhost-user",
+                              OBJECT(&dev->vdev), "vhost-user",
+                              &error_abort);
 }
=20
 static const TypeInfo virtio_gpu_pci_info =3D {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2dd3c3481a..0dfa08a173 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -22,6 +22,7 @@
 #include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
=20
 #define VIRTIO_GPU_VM_VERSION 1
=20
@@ -1184,11 +1185,16 @@ static void virtio_gpu_device_realize(DeviceState=
 *qdev, Error **errp)
     }
=20
     g->use_virgl_renderer =3D false;
+    if (g->vhost) {
+        /* default to backend virgl=3Don */
+        have_virgl =3D true;
+    } else {
 #if !defined(CONFIG_VIRGL) || defined(HOST_WORDS_BIGENDIAN)
-    have_virgl =3D false;
+        have_virgl =3D false;
 #else
-    have_virgl =3D display_opengl;
+        have_virgl =3D display_opengl;
 #endif
+    }
     if (!have_virgl) {
         g->conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
     }
@@ -1226,6 +1232,10 @@ static void virtio_gpu_device_realize(DeviceState =
*qdev, Error **errp)
         g->cursor_vq =3D virtio_add_queue(vdev, 16, virtio_gpu_handle_cu=
rsor_cb);
     }
=20
+    if (g->vhost && vhost_gpu_init(g, errp) < 0) {
+        return;
+    }
+
     g->ctrl_bh =3D qemu_bh_new(virtio_gpu_ctrl_bh, g);
     g->cursor_bh =3D qemu_bh_new(virtio_gpu_cursor_bh, g);
     QTAILQ_INIT(&g->reslist);
@@ -1253,8 +1263,27 @@ static void virtio_gpu_device_unrealize(DeviceStat=
e *qdev, Error **errp)
     }
 }
=20
+static void virtio_gpu_host_user_is_busy(const Object *obj, const char *=
name,
+                                         Object *val, Error **errp)
+{
+    VirtIOGPU *g =3D VIRTIO_GPU(obj);
+
+    if (g->vhost) {
+        error_setg(errp, "can't use already busy vhost-user");
+    } else {
+        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
+    }
+}
+
 static void virtio_gpu_instance_init(Object *obj)
 {
+    VirtIOGPU *g =3D VIRTIO_GPU(obj);
+
+    object_property_add_link(obj, "vhost-user", TYPE_VHOST_USER_BACKEND,
+                             (Object **)&g->vhost,
+                             virtio_gpu_host_user_is_busy,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             &error_abort);
 }
=20
 static void virtio_gpu_reset(VirtIODevice *vdev)
@@ -1264,7 +1293,9 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
     int i;
=20
     g->enable =3D 0;
-
+    if (g->vhost) {
+        vhost_user_backend_stop(g->vhost);
+    }
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         virtio_gpu_resource_destroy(g, res);
     }
@@ -1312,6 +1343,43 @@ static const VMStateDescription vmstate_virtio_gpu=
 =3D {
     },
 };
=20
+static void virtio_gpu_set_status(VirtIODevice *vdev, uint8_t val)
+{
+    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
+
+    if (g->vhost) {
+        if (val & VIRTIO_CONFIG_S_DRIVER_OK && vdev->vm_running) {
+            vhost_user_backend_start(g->vhost);
+        } else {
+            /* TODO: forcefully gl unblock ? */
+            vhost_user_backend_stop(g->vhost);
+        }
+    }
+}
+
+static bool virtio_gpu_guest_notifier_pending(VirtIODevice *vdev, int id=
x)
+{
+    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
+
+    if (!g->vhost) {
+        return false;
+    }
+
+    return vhost_virtqueue_pending(&g->vhost->dev, idx);
+}
+
+static void virtio_gpu_guest_notifier_mask(VirtIODevice *vdev, int idx,
+                                           bool mask)
+{
+    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
+
+    if (!g->vhost) {
+        return;
+    }
+
+    vhost_virtqueue_mask(&g->vhost->dev, vdev, idx, mask);
+}
+
 static Property virtio_gpu_properties[] =3D {
     DEFINE_PROP_UINT32("max_outputs", VirtIOGPU, conf.max_outputs, 1),
     DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf.max_hostmem,
@@ -1338,6 +1406,9 @@ static void virtio_gpu_class_init(ObjectClass *klas=
s, void *data)
     vdc->set_config =3D virtio_gpu_set_config;
     vdc->get_features =3D virtio_gpu_get_features;
     vdc->set_features =3D virtio_gpu_set_features;
+    vdc->set_status   =3D virtio_gpu_set_status;
+    vdc->guest_notifier_mask =3D virtio_gpu_guest_notifier_mask;
+    vdc->guest_notifier_pending =3D virtio_gpu_guest_notifier_pending;
=20
     vdc->reset =3D virtio_gpu_reset;
=20
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index baa74ba82c..b16edd9e6d 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -201,6 +201,11 @@ static void virtio_vga_inst_initfn(Object *obj)
=20
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_GPU);
+
+    /* could eventually be included in qdev_alias_all_properties? */
+    object_property_add_alias(obj, "vhost-user",
+                              OBJECT(&dev->vdev), "vhost-user",
+                              &error_abort);
 }
=20
 static TypeInfo virtio_vga_info =3D {
diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe734821dd..81f08a85bc 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1048,7 +1048,8 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
             /* note: spice server will close the fd, so hand over a dup =
*/
             spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
                                  dmabuf->width, dmabuf->height,
-                                 dmabuf->stride, dmabuf->fourcc, false);
+                                 dmabuf->stride, dmabuf->fourcc,
+                                 dmabuf->y0_top);
         }
         qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->h=
eight);
         ssd->guest_dmabuf_refresh =3D false;
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index d907b381ae..1c6f3c6bc1 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -36,7 +36,7 @@ obj-$(CONFIG_VGA) +=3D vga.o
=20
 common-obj-$(CONFIG_QXL) +=3D qxl.o qxl-logger.o qxl-render.o
=20
-obj-$(CONFIG_VIRTIO) +=3D virtio-gpu.o virtio-gpu-3d.o
+obj-$(CONFIG_VIRTIO) +=3D virtio-gpu.o virtio-gpu-3d.o vhost-gpu.o
 obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-gpu-pci.o
 obj-$(CONFIG_VIRTIO_VGA) +=3D virtio-vga.o
 virtio-gpu.o-cflags :=3D $(VIRGL_CFLAGS)
--=20
2.17.1.906.g10fd178552
