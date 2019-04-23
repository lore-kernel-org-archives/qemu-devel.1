Received: from eggs.gnu.org ([209.51.188.92]:60839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvN3-0007bj-8l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvN0-0006Cm-EI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:22:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hIvN0-0006Bf-4t
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EEB4308792E
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:21:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Apr 2019 15:20:04 +0200
Message-Id: <20190423132004.13725-12-marcandre.lureau@redhat.com>
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 11/11] hw/display: add vhost-user-vga &
 gpu-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add new virtio-gpu devices with a "vhost-user" property. The
associated vhost-user backend is used to handle the virtio rings and
provide rendering results thanks to the vhost-user-gpu protocol.

Example usage:
-object vhost-user-backend,id=3Dvug,cmd=3D"./vhost-user-gpu"
-device vhost-user-vga,vhost-user=3Dvug

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-vga.h            |   2 +-
 include/hw/virtio/virtio-gpu-pci.h |  40 ++
 include/hw/virtio/virtio-gpu.h     |  19 +-
 hw/display/vhost-user-gpu-pci.c    |  51 +++
 hw/display/vhost-user-gpu.c        | 572 +++++++++++++++++++++++++++++
 hw/display/vhost-user-vga.c        |  52 +++
 hw/display/virtio-gpu-pci.c        |  17 +-
 vl.c                               |   1 +
 hw/display/Kconfig                 |  10 +
 hw/display/Makefile.objs           |   3 +
 10 files changed, 744 insertions(+), 23 deletions(-)
 create mode 100644 include/hw/virtio/virtio-gpu-pci.h
 create mode 100644 hw/display/vhost-user-gpu-pci.c
 create mode 100644 hw/display/vhost-user-gpu.c
 create mode 100644 hw/display/vhost-user-vga.c

diff --git a/hw/display/virtio-vga.h b/hw/display/virtio-vga.h
index f03e1ba619..c10bf390aa 100644
--- a/hw/display/virtio-vga.h
+++ b/hw/display/virtio-vga.h
@@ -1,7 +1,7 @@
 #ifndef VIRTIO_VGA_H_
 #define VIRTIO_VGA_H_
=20
-#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-gpu-pci.h"
 #include "vga_int.h"
=20
 /*
diff --git a/include/hw/virtio/virtio-gpu-pci.h b/include/hw/virtio/virti=
o-gpu-pci.h
new file mode 100644
index 0000000000..2f69b5a9cc
--- /dev/null
+++ b/include/hw/virtio/virtio-gpu-pci.h
@@ -0,0 +1,40 @@
+/*
+ * Virtio GPU PCI Device
+ *
+ * Copyright Red Hat, Inc. 2013-2014
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VIRTIO_GPU_PCI_H
+#define HW_VIRTIO_GPU_PCI_H
+
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-gpu.h"
+
+typedef struct VirtIOGPUPCIBase VirtIOGPUPCIBase;
+
+/*
+ * virtio-gpu-pci-base: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_GPU_PCI_BASE "virtio-gpu-pci-base"
+#define VIRTIO_GPU_PCI_BASE(obj)                                    \
+    OBJECT_CHECK(VirtIOGPUPCIBase, (obj), TYPE_VIRTIO_GPU_PCI_BASE)
+
+struct VirtIOGPUPCIBase {
+    VirtIOPCIProxy parent_obj;
+    VirtIOGPUBase *vgpu;
+};
+
+/* to share between PCI and VGA */
+#define DEFINE_VIRTIO_GPU_PCI_PROPERTIES(_state)                \
+    DEFINE_PROP_BIT("ioeventfd", _state, flags,                 \
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false),  \
+        DEFINE_PROP_UINT32("vectors", _state, nvectors, 3)
+
+#endif /* HW_VIRTIO_GPU_PCI_H */
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index d0d8d7b246..8ecac1987a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -19,6 +19,7 @@
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/log.h"
+#include "sysemu/vhost-user-backend.h"
=20
 #include "standard-headers/linux/virtio_gpu.h"
=20
@@ -34,6 +35,8 @@
 #define VIRTIO_GPU(obj)                                        \
         OBJECT_CHECK(VirtIOGPU, (obj), TYPE_VIRTIO_GPU)
=20
+#define TYPE_VHOST_USER_GPU "vhost-user-gpu"
+
 #define VIRTIO_ID_GPU 16
=20
 struct virtio_gpu_simple_resource {
@@ -157,13 +160,17 @@ typedef struct VirtIOGPU {
     } stats;
 } VirtIOGPU;
=20
-extern const GraphicHwOps virtio_gpu_ops;
+typedef struct VhostUserGPU {
+    VirtIOGPUBase parent_obj;
=20
-/* to share between PCI and VGA */
-#define DEFINE_VIRTIO_GPU_PCI_PROPERTIES(_state)               \
-    DEFINE_PROP_BIT("ioeventfd", _state, flags,                \
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false), \
-    DEFINE_PROP_UINT32("vectors", _state, nvectors, 3)
+    VhostUserBackend *vhost;
+    int vhost_gpu_fd; /* closed by the chardev */
+    CharBackend vhost_chr;
+    QemuDmaBuf dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
+    bool backend_blocked;
+} VhostUserGPU;
+
+extern const GraphicHwOps virtio_gpu_ops;
=20
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   =
\
         size_t s;                                                       =
\
diff --git a/hw/display/vhost-user-gpu-pci.c b/hw/display/vhost-user-gpu-=
pci.c
new file mode 100644
index 0000000000..7d9b1f5a8c
--- /dev/null
+++ b/hw/display/vhost-user-gpu-pci.c
@@ -0,0 +1,51 @@
+/*
+ * vhost-user GPU PCI device
+ *
+ * Copyright Red Hat, Inc. 2018
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/virtio/virtio-gpu-pci.h"
+
+#define TYPE_VHOST_USER_GPU_PCI "vhost-user-gpu-pci"
+#define VHOST_USER_GPU_PCI(obj)                                     \
+    OBJECT_CHECK(VhostUserGPUPCI, (obj), TYPE_VHOST_USER_GPU_PCI)
+
+typedef struct VhostUserGPUPCI {
+    VirtIOGPUPCIBase parent_obj;
+
+    VhostUserGPU vdev;
+} VhostUserGPUPCI;
+
+static void vhost_user_gpu_pci_initfn(Object *obj)
+{
+    VhostUserGPUPCI *dev =3D VHOST_USER_GPU_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_GPU);
+
+    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
+
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(&dev->vdev), "chardev",
+                              &error_abort);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_gpu_pci_info =3D {
+    .generic_name =3D TYPE_VHOST_USER_GPU_PCI,
+    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
+    .instance_size =3D sizeof(VhostUserGPUPCI),
+    .instance_init =3D vhost_user_gpu_pci_initfn,
+};
+
+static void vhost_user_gpu_pci_register_types(void)
+{
+    virtio_pci_types_register(&vhost_user_gpu_pci_info);
+}
+
+type_init(vhost_user_gpu_pci_register_types)
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
new file mode 100644
index 0000000000..8f21967061
--- /dev/null
+++ b/hw/display/vhost-user-gpu.c
@@ -0,0 +1,572 @@
+/*
+ * vhost-user GPU Device
+ *
+ * Copyright Red Hat, Inc. 2018
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
+#include "migration/blocker.h"
+
+#define VHOST_USER_GPU(obj)                                    \
+    OBJECT_CHECK(VhostUserGPU, (obj), TYPE_VHOST_USER_GPU)
+
+typedef enum VhostUserGpuRequest {
+    VHOST_USER_GPU_NONE =3D 0,
+    VHOST_USER_GPU_GET_PROTOCOL_FEATURES,
+    VHOST_USER_GPU_SET_PROTOCOL_FEATURES,
+    VHOST_USER_GPU_GET_DISPLAY_INFO,
+    VHOST_USER_GPU_CURSOR_POS,
+    VHOST_USER_GPU_CURSOR_POS_HIDE,
+    VHOST_USER_GPU_CURSOR_UPDATE,
+    VHOST_USER_GPU_SCANOUT,
+    VHOST_USER_GPU_UPDATE,
+    VHOST_USER_GPU_DMABUF_SCANOUT,
+    VHOST_USER_GPU_DMABUF_UPDATE,
+} VhostUserGpuRequest;
+
+typedef struct VhostUserGpuDisplayInfoReply {
+    struct virtio_gpu_resp_display_info info;
+} VhostUserGpuDisplayInfoReply;
+
+typedef struct VhostUserGpuCursorPos {
+    uint32_t scanout_id;
+    uint32_t x;
+    uint32_t y;
+} QEMU_PACKED VhostUserGpuCursorPos;
+
+typedef struct VhostUserGpuCursorUpdate {
+    VhostUserGpuCursorPos pos;
+    uint32_t hot_x;
+    uint32_t hot_y;
+    uint32_t data[64 * 64];
+} QEMU_PACKED VhostUserGpuCursorUpdate;
+
+typedef struct VhostUserGpuScanout {
+    uint32_t scanout_id;
+    uint32_t width;
+    uint32_t height;
+} QEMU_PACKED VhostUserGpuScanout;
+
+typedef struct VhostUserGpuUpdate {
+    uint32_t scanout_id;
+    uint32_t x;
+    uint32_t y;
+    uint32_t width;
+    uint32_t height;
+    uint8_t data[];
+} QEMU_PACKED VhostUserGpuUpdate;
+
+typedef struct VhostUserGpuDMABUFScanout {
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
+} QEMU_PACKED VhostUserGpuDMABUFScanout;
+
+typedef struct VhostUserGpuMsg {
+    uint32_t request; /* VhostUserGpuRequest */
+    uint32_t size; /* the following payload size */
+    union {
+        VhostUserGpuCursorPos cursor_pos;
+        VhostUserGpuCursorUpdate cursor_update;
+        VhostUserGpuScanout scanout;
+        VhostUserGpuUpdate update;
+        VhostUserGpuDMABUFScanout dmabuf_scanout;
+        uint64_t u64;
+    } payload;
+} QEMU_PACKED VhostUserGpuMsg;
+
+static VhostUserGpuMsg m __attribute__ ((unused));
+#define VHOST_USER_GPU_HDR_SIZE (sizeof(m.request) + sizeof(m.size))
+
+static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)=
;
+
+static void
+vhost_user_gpu_handle_cursor(VhostUserGPU *g, VhostUserGpuMsg *msg)
+{
+    VhostUserGpuCursorPos *pos =3D &msg->payload.cursor_pos;
+    struct virtio_gpu_scanout *s;
+
+    if (pos->scanout_id >=3D g->parent_obj.conf.max_outputs) {
+        return;
+    }
+    s =3D &g->parent_obj.scanout[pos->scanout_id];
+
+    if (msg->request =3D=3D VHOST_USER_GPU_CURSOR_UPDATE) {
+        VhostUserGpuCursorUpdate *up =3D &msg->payload.cursor_update;
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
+                  msg->request !=3D VHOST_USER_GPU_CURSOR_POS_HIDE);
+}
+
+static void
+vhost_user_gpu_unblock(VhostUserGPU *g)
+{
+    uint32_t ok;
+
+    qemu_chr_fe_write(&g->vhost_chr, (uint8_t *)&ok, sizeof(ok));
+
+}
+static void
+vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
+{
+    QemuConsole *con =3D NULL;
+    struct virtio_gpu_scanout *s;
+
+    switch (msg->request) {
+    case VHOST_USER_GPU_GET_PROTOCOL_FEATURES: {
+        uint64_t u64 =3D 0;
+        qemu_chr_fe_write(&g->vhost_chr, (uint8_t *)&u64, sizeof(u64));
+        break;
+    }
+    case VHOST_USER_GPU_SET_PROTOCOL_FEATURES: {
+        break;
+    }
+    case VHOST_USER_GPU_GET_DISPLAY_INFO: {
+        struct virtio_gpu_resp_display_info display_info =3D { {} };
+        display_info.hdr.type =3D VIRTIO_GPU_RESP_OK_DISPLAY_INFO;
+        virtio_gpu_base_fill_display_info(VIRTIO_GPU_BASE(g), &display_i=
nfo);
+        qemu_chr_fe_write(&g->vhost_chr,
+                          (uint8_t *)&display_info, sizeof(display_info)=
);
+        break;
+    }
+    case VHOST_USER_GPU_SCANOUT: {
+        VhostUserGpuScanout *m =3D &msg->payload.scanout;
+
+        if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
+            return;
+        }
+
+        g->parent_obj.enable =3D 1;
+        s =3D &g->parent_obj.scanout[m->scanout_id];
+        con =3D s->con;
+
+        if (m->scanout_id =3D=3D 0 && m->width =3D=3D 0) {
+            s->ds =3D qemu_create_message_surface(640, 480,
+                                                "Guest disabled display.=
");
+            dpy_gfx_replace_surface(con, s->ds);
+        } else {
+            s->ds =3D qemu_create_displaysurface(m->width, m->height);
+            /* replace surface on next update */
+        }
+
+        break;
+    }
+    case VHOST_USER_GPU_DMABUF_SCANOUT: {
+        VhostUserGpuDMABUFScanout *m =3D &msg->payload.dmabuf_scanout;
+        int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
+        QemuDmaBuf *dmabuf;
+
+        if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
+            error_report("invalid scanout: %d", m->scanout_id);
+            if (fd >=3D 0) {
+                close(fd);
+            }
+            break;
+        }
+
+        g->parent_obj.enable =3D 1;
+        con =3D g->parent_obj.scanout[m->scanout_id].con;
+        dmabuf =3D &g->dmabuf[m->scanout_id];
+        if (dmabuf->fd >=3D 0) {
+            close(dmabuf->fd);
+            dmabuf->fd =3D -1;
+        }
+        if (!console_has_gl_dmabuf(con)) {
+            /* it would be nice to report that error earlier */
+            error_report("console doesn't support dmabuf!");
+            break;
+        }
+        dpy_gl_release_dmabuf(con, dmabuf);
+        if (fd =3D=3D -1) {
+            dpy_gl_scanout_disable(con);
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
+        dpy_gl_scanout_dmabuf(con, dmabuf);
+        break;
+    }
+    case VHOST_USER_GPU_DMABUF_UPDATE: {
+        VhostUserGpuUpdate *m =3D &msg->payload.update;
+
+        if (m->scanout_id >=3D g->parent_obj.conf.max_outputs ||
+            !g->parent_obj.scanout[m->scanout_id].con) {
+            error_report("invalid scanout update: %d", m->scanout_id);
+            vhost_user_gpu_unblock(g);
+            break;
+        }
+
+        con =3D g->parent_obj.scanout[m->scanout_id].con;
+        if (!console_has_gl(con)) {
+            error_report("console doesn't support GL!");
+            vhost_user_gpu_unblock(g);
+            break;
+        }
+        dpy_gl_update(con, m->x, m->y, m->width, m->height);
+        g->backend_blocked =3D true;
+        break;
+    }
+    case VHOST_USER_GPU_UPDATE: {
+        VhostUserGpuUpdate *m =3D &msg->payload.update;
+
+        if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
+            break;
+        }
+        s =3D &g->parent_obj.scanout[m->scanout_id];
+        con =3D s->con;
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
+        if (qemu_console_surface(con) !=3D s->ds) {
+            dpy_gfx_replace_surface(con, s->ds);
+        } else {
+            dpy_gfx_update(con, m->x, m->y, m->width, m->height);
+        }
+        break;
+    }
+    default:
+        g_warning("unhandled message %d %d", msg->request, msg->size);
+    }
+
+    if (con && qemu_console_is_gl_blocked(con)) {
+        vhost_user_gpu_update_blocked(g, true);
+    }
+}
+
+static void
+vhost_user_gpu_chr_read(void *opaque)
+{
+    VhostUserGPU *g =3D opaque;
+    VhostUserGpuMsg *msg =3D NULL;
+    VhostUserGpuRequest request;
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
+    msg =3D g_malloc(VHOST_USER_GPU_HDR_SIZE + size);
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
+    if (request =3D=3D VHOST_USER_GPU_CURSOR_UPDATE ||
+        request =3D=3D VHOST_USER_GPU_CURSOR_POS ||
+        request =3D=3D VHOST_USER_GPU_CURSOR_POS_HIDE) {
+        vhost_user_gpu_handle_cursor(g, msg);
+    } else {
+        vhost_user_gpu_handle_display(g, msg);
+    }
+
+end:
+    g_free(msg);
+}
+
+static void
+vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)
+{
+    qemu_set_fd_handler(g->vhost_gpu_fd,
+                        blocked ? NULL : vhost_user_gpu_chr_read, NULL, =
g);
+}
+
+static void
+vhost_user_gpu_gl_unblock(VirtIOGPUBase *b)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(b);
+
+    if (g->backend_blocked) {
+        vhost_user_gpu_unblock(VHOST_USER_GPU(g));
+        g->backend_blocked =3D false;
+    }
+
+    vhost_user_gpu_update_blocked(VHOST_USER_GPU(g), false);
+}
+
+static bool
+vhost_user_gpu_do_set_socket(VhostUserGPU *g, Error **errp)
+{
+    Chardev *chr;
+    int sv[2];
+
+    if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) =3D=3D -1) {
+        error_setg_errno(errp, errno, "socketpair() failed");
+        return false;
+    }
+
+    chr =3D CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+    if (!chr || qemu_chr_add_client(chr, sv[0]) =3D=3D -1) {
+        error_setg(errp, "Failed to make socket chardev");
+        goto err;
+    }
+    if (!qemu_chr_fe_init(&g->vhost_chr, chr, errp)) {
+        goto err;
+    }
+    if (vhost_user_gpu_set_socket(&g->vhost->dev, sv[1]) < 0) {
+        error_setg(errp, "Failed to set vhost-user-gpu socket");
+        qemu_chr_fe_deinit(&g->vhost_chr, false);
+        goto err;
+    }
+
+    g->vhost_gpu_fd =3D sv[0];
+    vhost_user_gpu_update_blocked(g, false);
+    close(sv[1]);
+    return true;
+
+err:
+    close(sv[0]);
+    close(sv[1]);
+    if (chr) {
+        object_unref(OBJECT(chr));
+    }
+    return false;
+}
+
+static void
+vhost_user_gpu_get_config(VirtIODevice *vdev, uint8_t *config_data)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
+    VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(vdev);
+    struct virtio_gpu_config *vgconfig =3D
+        (struct virtio_gpu_config *)config_data;
+    int ret;
+
+    memset(config_data, 0, sizeof(struct virtio_gpu_config));
+
+    ret =3D vhost_dev_get_config(&g->vhost->dev,
+                               config_data, sizeof(struct virtio_gpu_con=
fig));
+    if (ret) {
+        error_report("vhost-user-gpu: get device config space failed");
+        return;
+    }
+
+    /* those fields are managed by qemu */
+    vgconfig->num_scanouts =3D b->virtio_config.num_scanouts;
+    vgconfig->events_read =3D b->virtio_config.events_read;
+    vgconfig->events_clear =3D b->virtio_config.events_clear;
+}
+
+static void
+vhost_user_gpu_set_config(VirtIODevice *vdev,
+                          const uint8_t *config_data)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
+    VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(vdev);
+    const struct virtio_gpu_config *vgconfig =3D
+        (const struct virtio_gpu_config *)config_data;
+    int ret;
+
+    if (vgconfig->events_clear) {
+        b->virtio_config.events_read &=3D ~vgconfig->events_clear;
+    }
+
+    ret =3D vhost_dev_set_config(&g->vhost->dev, config_data,
+                               0, sizeof(struct virtio_gpu_config),
+                               VHOST_SET_CONFIG_TYPE_MASTER);
+    if (ret) {
+        error_report("vhost-user-input: set device config space failed")=
;
+        return;
+    }
+}
+
+static void
+vhost_user_gpu_set_status(VirtIODevice *vdev, uint8_t val)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
+    Error *err =3D NULL;
+
+    if (val & VIRTIO_CONFIG_S_DRIVER_OK && vdev->vm_running) {
+        if (!vhost_user_gpu_do_set_socket(g, &err)) {
+            error_report_err(err);
+            return;
+        }
+        vhost_user_backend_start(g->vhost);
+    } else {
+        /* unblock any wait and stop processing */
+        if (g->vhost_gpu_fd !=3D -1) {
+            vhost_user_gpu_update_blocked(g, true);
+            qemu_chr_fe_deinit(&g->vhost_chr, true);
+            g->vhost_gpu_fd =3D -1;
+        }
+        vhost_user_backend_stop(g->vhost);
+    }
+}
+
+static bool
+vhost_user_gpu_guest_notifier_pending(VirtIODevice *vdev, int idx)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
+
+    return vhost_virtqueue_pending(&g->vhost->dev, idx);
+}
+
+static void
+vhost_user_gpu_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mas=
k)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
+
+    vhost_virtqueue_mask(&g->vhost->dev, vdev, idx, mask);
+}
+
+static void
+vhost_user_gpu_instance_init(Object *obj)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(obj);
+
+    g->vhost =3D VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND))=
;
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(g->vhost), "chardev", &error_abort)=
;
+}
+
+static void
+vhost_user_gpu_instance_finalize(Object *obj)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(obj);
+
+    object_unref(OBJECT(g->vhost));
+}
+
+static void
+vhost_user_gpu_reset(VirtIODevice *vdev)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
+
+    virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
+
+    vhost_user_backend_stop(g->vhost);
+}
+
+static int
+vhost_user_gpu_config_change(struct vhost_dev *dev)
+{
+    error_report("vhost-user-gpu: unhandled backend config change");
+    return -1;
+}
+
+static const VhostDevConfigOps config_ops =3D {
+    .vhost_dev_config_notifier =3D vhost_user_gpu_config_change,
+};
+
+static void
+vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
+{
+    VhostUserGPU *g =3D VHOST_USER_GPU(qdev);
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(g);
+
+    vhost_dev_set_config_notifier(&g->vhost->dev, &config_ops);
+    if (vhost_user_backend_dev_init(g->vhost, vdev, 2, errp) < 0) {
+        return;
+    }
+
+    if (virtio_has_feature(g->vhost->dev.features, VIRTIO_GPU_F_VIRGL)) =
{
+        g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED=
;
+    }
+
+    if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
+        return;
+    }
+
+    g->vhost_gpu_fd =3D -1;
+}
+
+static Property vhost_user_gpu_properties[] =3D {
+    VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void
+vhost_user_gpu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+    VirtIOGPUBaseClass *vgc =3D VIRTIO_GPU_BASE_CLASS(klass);
+
+    vgc->gl_unblock =3D vhost_user_gpu_gl_unblock;
+
+    vdc->realize =3D vhost_user_gpu_device_realize;
+    vdc->reset =3D vhost_user_gpu_reset;
+    vdc->set_status   =3D vhost_user_gpu_set_status;
+    vdc->guest_notifier_mask =3D vhost_user_gpu_guest_notifier_mask;
+    vdc->guest_notifier_pending =3D vhost_user_gpu_guest_notifier_pendin=
g;
+    vdc->get_config =3D vhost_user_gpu_get_config;
+    vdc->set_config =3D vhost_user_gpu_set_config;
+
+    dc->props =3D vhost_user_gpu_properties;
+}
+
+static const TypeInfo vhost_user_gpu_info =3D {
+    .name =3D TYPE_VHOST_USER_GPU,
+    .parent =3D TYPE_VIRTIO_GPU_BASE,
+    .instance_size =3D sizeof(VhostUserGPU),
+    .instance_init =3D vhost_user_gpu_instance_init,
+    .instance_finalize =3D vhost_user_gpu_instance_finalize,
+    .class_init =3D vhost_user_gpu_class_init,
+};
+
+static void vhost_user_gpu_register_types(void)
+{
+    type_register_static(&vhost_user_gpu_info);
+}
+
+type_init(vhost_user_gpu_register_types)
diff --git a/hw/display/vhost-user-vga.c b/hw/display/vhost-user-vga.c
new file mode 100644
index 0000000000..a7195276d9
--- /dev/null
+++ b/hw/display/vhost-user-vga.c
@@ -0,0 +1,52 @@
+/*
+ * vhost-user VGA device
+ *
+ * Copyright Red Hat, Inc. 2018
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "virtio-vga.h"
+
+#define TYPE_VHOST_USER_VGA "vhost-user-vga"
+
+#define VHOST_USER_VGA(obj)                                \
+    OBJECT_CHECK(VhostUserVGA, (obj), TYPE_VHOST_USER_VGA)
+
+typedef struct VhostUserVGA {
+    VirtIOVGABase parent_obj;
+
+    VhostUserGPU vdev;
+} VhostUserVGA;
+
+static void vhost_user_vga_inst_initfn(Object *obj)
+{
+    VhostUserVGA *dev =3D VHOST_USER_VGA(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_GPU);
+
+    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
+
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(&dev->vdev), "chardev",
+                              &error_abort);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_vga_info =3D {
+    .generic_name  =3D TYPE_VHOST_USER_VGA,
+    .parent        =3D TYPE_VIRTIO_VGA_BASE,
+    .instance_size =3D sizeof(struct VhostUserVGA),
+    .instance_init =3D vhost_user_vga_inst_initfn,
+};
+
+static void vhost_user_vga_register_types(void)
+{
+    virtio_pci_types_register(&vhost_user_vga_info);
+}
+
+type_init(vhost_user_vga_register_types)
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 3b88bf4d1f..ef8d6ecb49 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -16,22 +16,7 @@
 #include "hw/pci/pci.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-pci.h"
-#include "hw/virtio/virtio-gpu.h"
-
-typedef struct VirtIOGPUPCIBase VirtIOGPUPCIBase;
-
-/*
- * virtio-gpu-pci-base: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_GPU_PCI_BASE "virtio-gpu-pci-base"
-#define VIRTIO_GPU_PCI_BASE(obj) \
-        OBJECT_CHECK(VirtIOGPUPCIBase, (obj), TYPE_VIRTIO_GPU_PCI_BASE)
-
-struct VirtIOGPUPCIBase {
-    VirtIOPCIProxy parent_obj;
-    VirtIOGPUBase *vgpu;
-};
+#include "hw/virtio/virtio-gpu-pci.h"
=20
 static Property virtio_gpu_pci_base_properties[] =3D {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
diff --git a/vl.c b/vl.c
index c696ad2a13..b06458070f 100644
--- a/vl.c
+++ b/vl.c
@@ -238,6 +238,7 @@ static struct {
     { .driver =3D "qxl-vga",              .flag =3D &default_vga       }=
,
     { .driver =3D "virtio-vga",           .flag =3D &default_vga       }=
,
     { .driver =3D "ati-vga",              .flag =3D &default_vga       }=
,
+    { .driver =3D "vhost-user-vga",       .flag =3D &default_vga       }=
,
 };
=20
 static QemuOptsList qemu_rtc_opts =3D {
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 72be57a403..492ea35104 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -104,6 +104,16 @@ config VIRTIO_VGA
     depends on VIRTIO_PCI
     select VGA
=20
+config VHOST_USER_GPU
+    bool
+    default y
+    depends on VIRTIO_GPU && VHOST_USER
+
+config VHOST_USER_VGA
+    bool
+    default y
+    depends on VIRTIO_VGA && VHOST_USER_GPU
+
 config DPCD
     bool
=20
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index f1c46b8e3e..9c342eef41 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -43,8 +43,11 @@ obj-$(CONFIG_VGA) +=3D vga.o
 common-obj-$(CONFIG_QXL) +=3D qxl.o qxl-logger.o qxl-render.o
=20
 obj-$(CONFIG_VIRTIO_GPU) +=3D virtio-gpu-base.o virtio-gpu.o virtio-gpu-=
3d.o
+obj-$(CONFIG_VHOST_USER_GPU) +=3D vhost-user-gpu.o
 obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) +=3D virtio-g=
pu-pci.o
+obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) +=3D vhos=
t-user-gpu-pci.o
 obj-$(CONFIG_VIRTIO_VGA) +=3D virtio-vga.o
+obj-$(CONFIG_VHOST_USER_VGA) +=3D vhost-user-vga.o
 virtio-gpu.o-cflags :=3D $(VIRGL_CFLAGS)
 virtio-gpu.o-libs +=3D $(VIRGL_LIBS)
 virtio-gpu-3d.o-cflags :=3D $(VIRGL_CFLAGS)
--=20
2.21.0.313.ge35b8cb8e2
