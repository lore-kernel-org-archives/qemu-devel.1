Received: from eggs.gnu.org ([2001:4830:134:3::10]:39368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmup-0003bR-HX
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmuk-00080i-I5
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOmuk-00080R-9d
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2C9F818BAEE
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 16:28:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  1 Jun 2018 18:27:49 +0200
Message-Id: <20180601162749.27406-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180601162749.27406-1-marcandre.lureau@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 12/12] contrib: add vhost-user-gpu
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

Add a vhost-user gpu backend example, based on virtio-gpu/3d device. It
is to be associated with a vhost-user-backend object, ex:

-object vhost-user-backend,id=3Dvug,cmd=3D"vhost-user-gpu"

TODO:
- add/check multi-head support
- add/check resize support
- add missing options, such as virgl=3Doff,rendernode config, initial
  resolution etc..
- stop/crash & resume handling
- accelerated rendering/display to avoid the many round trips

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/virgl.h       |  24 +
 contrib/vhost-user-gpu/vugpu.h       | 152 +++++
 contrib/vhost-user-gpu/main.c        | 953 +++++++++++++++++++++++++++
 contrib/vhost-user-gpu/virgl.c       | 537 +++++++++++++++
 Makefile                             |   3 +
 Makefile.objs                        |   1 +
 configure                            |   4 +
 contrib/vhost-user-gpu/Makefile.objs |   7 +
 8 files changed, 1681 insertions(+)
 create mode 100644 contrib/vhost-user-gpu/virgl.h
 create mode 100644 contrib/vhost-user-gpu/vugpu.h
 create mode 100644 contrib/vhost-user-gpu/main.c
 create mode 100644 contrib/vhost-user-gpu/virgl.c
 create mode 100644 contrib/vhost-user-gpu/Makefile.objs

diff --git a/contrib/vhost-user-gpu/virgl.h b/contrib/vhost-user-gpu/virg=
l.h
new file mode 100644
index 0000000000..c86625b963
--- /dev/null
+++ b/contrib/vhost-user-gpu/virgl.h
@@ -0,0 +1,24 @@
+/*
+ * Virtio vhost-user GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2018
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef VUGPU_VIRGL_H_
+#define VUGPU_VIRGL_H_
+
+#include "vugpu.h"
+
+int vg_virgl_init(VuGpu *g);
+void vg_virgl_process_cmd(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd=
);
+void vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
+                                 gpointer data);
+
+#endif
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugp=
u.h
new file mode 100644
index 0000000000..4515703401
--- /dev/null
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -0,0 +1,152 @@
+/*
+ * Virtio vhost-user GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2018
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef VUGPU_H_
+#define VUGPU_H_
+
+#include "contrib/libvhost-user/libvhost-user-glib.h"
+#include "standard-headers/linux/virtio_gpu.h"
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qemu/iov.h"
+#include "qemu/bswap.h"
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
+typedef struct VhostGpuUpdate {
+    uint32_t scanout_id;
+    uint32_t x;
+    uint32_t y;
+    uint32_t width;
+    uint32_t height;
+    uint8_t data[];
+} QEMU_PACKED VhostGpuUpdate;
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
+struct virtio_gpu_scanout {
+    uint32_t width, height;
+    int x, y;
+    int invalidate;
+    uint32_t resource_id;
+};
+
+typedef struct VuGpu {
+    VugDev dev;
+    int sock_fd;
+    GSource *renderer_source;
+
+    bool virgl;
+    bool virgl_inited;
+    uint32_t inflight;
+
+    struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
+    QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
+    QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
+} VuGpu;
+
+struct virtio_gpu_ctrl_command {
+    VuVirtqElement elem;
+    VuVirtq *vq;
+    struct virtio_gpu_ctrl_hdr cmd_hdr;
+    uint32_t error;
+    bool finished;
+    QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
+};
+
+#define VUGPU_FILL_CMD(out) do {                                \
+        size_t s;                                               \
+        s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
+                       &out, sizeof(out));                      \
+        if (s !=3D sizeof(out)) {                                 \
+            g_critical("%s: command size incorrect %zu vs %zu", \
+                       __func__, s, sizeof(out));               \
+            return;                                             \
+        }                                                       \
+    } while (0)
+
+
+void    vg_ctrl_response(VuGpu *g,
+                         struct virtio_gpu_ctrl_command *cmd,
+                         struct virtio_gpu_ctrl_hdr *resp,
+                         size_t resp_len);
+
+void    vg_ctrl_response_nodata(VuGpu *g,
+                                struct virtio_gpu_ctrl_command *cmd,
+                                enum virtio_gpu_ctrl_type type);
+
+int     vg_create_mapping_iov(VuGpu *g,
+                              struct virtio_gpu_resource_attach_backing =
*ab,
+                              struct virtio_gpu_ctrl_command *cmd,
+                              struct iovec **iov);
+
+void    vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *c=
md);
+
+ssize_t vg_sock_fd_write(int sock, void *buf, ssize_t buflen, int fd);
+
+#endif
diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.=
c
new file mode 100644
index 0000000000..e14d0d2e8a
--- /dev/null
+++ b/contrib/vhost-user-gpu/main.c
@@ -0,0 +1,953 @@
+/*
+ * Virtio vhost-user GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2018
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#include <glib.h>
+#include <pixman.h>
+
+#include "vugpu.h"
+#include "virgl.h"
+
+struct virtio_gpu_simple_resource {
+    uint32_t resource_id;
+    uint32_t width;
+    uint32_t height;
+    uint32_t format;
+    struct iovec *iov;
+    unsigned int iov_cnt;
+    uint32_t scanout_bitmask;
+    pixman_image_t *image;
+    QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
+};
+
+static const char *
+vg_cmd_to_string(int cmd)
+{
+#define CMD(cmd) [cmd] =3D #cmd
+    static const char *vg_cmd_str[] =3D {
+        CMD(VIRTIO_GPU_UNDEFINED),
+
+        /* 2d commands */
+        CMD(VIRTIO_GPU_CMD_GET_DISPLAY_INFO),
+        CMD(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D),
+        CMD(VIRTIO_GPU_CMD_RESOURCE_UNREF),
+        CMD(VIRTIO_GPU_CMD_SET_SCANOUT),
+        CMD(VIRTIO_GPU_CMD_RESOURCE_FLUSH),
+        CMD(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D),
+        CMD(VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING),
+        CMD(VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING),
+        CMD(VIRTIO_GPU_CMD_GET_CAPSET_INFO),
+        CMD(VIRTIO_GPU_CMD_GET_CAPSET),
+
+        /* 3d commands */
+        CMD(VIRTIO_GPU_CMD_CTX_CREATE),
+        CMD(VIRTIO_GPU_CMD_CTX_DESTROY),
+        CMD(VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE),
+        CMD(VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE),
+        CMD(VIRTIO_GPU_CMD_RESOURCE_CREATE_3D),
+        CMD(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D),
+        CMD(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D),
+        CMD(VIRTIO_GPU_CMD_SUBMIT_3D),
+
+        /* cursor commands */
+        CMD(VIRTIO_GPU_CMD_UPDATE_CURSOR),
+        CMD(VIRTIO_GPU_CMD_MOVE_CURSOR),
+    };
+#undef REQ
+
+    if (cmd < G_N_ELEMENTS(vg_cmd_str)) {
+        return vg_cmd_str[cmd];
+    } else {
+        return "unknown";
+    }
+}
+
+ssize_t
+vg_sock_fd_write(int sock, void *buf, ssize_t buflen, int fd)
+{
+    ssize_t size;
+    struct msghdr msg;
+    struct iovec iov;
+    union {
+        struct cmsghdr cmsghdr;
+        char control[CMSG_SPACE(sizeof(int))];
+    } cmsgu;
+    struct cmsghdr *cmsg;
+
+    iov.iov_base =3D buf;
+    iov.iov_len =3D buflen;
+
+    msg.msg_name =3D NULL;
+    msg.msg_namelen =3D 0;
+    msg.msg_iov =3D &iov;
+    msg.msg_iovlen =3D 1;
+
+    if (fd !=3D -1) {
+        msg.msg_control =3D cmsgu.control;
+        msg.msg_controllen =3D sizeof(cmsgu.control);
+
+        cmsg =3D CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_len =3D CMSG_LEN(sizeof(int));
+        cmsg->cmsg_level =3D SOL_SOCKET;
+        cmsg->cmsg_type =3D SCM_RIGHTS;
+
+        *((int *)CMSG_DATA(cmsg)) =3D fd;
+    } else {
+        msg.msg_control =3D NULL;
+        msg.msg_controllen =3D 0;
+    }
+
+    size =3D sendmsg(sock, &msg, 0);
+
+    return size;
+}
+
+static struct virtio_gpu_simple_resource *
+virtio_gpu_find_resource(VuGpu *g, uint32_t resource_id)
+{
+    struct virtio_gpu_simple_resource *res;
+
+    QTAILQ_FOREACH(res, &g->reslist, next) {
+        if (res->resource_id =3D=3D resource_id) {
+            return res;
+        }
+    }
+    return NULL;
+}
+
+void
+vg_ctrl_response(VuGpu *g,
+                 struct virtio_gpu_ctrl_command *cmd,
+                 struct virtio_gpu_ctrl_hdr *resp,
+                 size_t resp_len)
+{
+    size_t s;
+
+    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE) {
+        resp->flags |=3D VIRTIO_GPU_FLAG_FENCE;
+        resp->fence_id =3D cmd->cmd_hdr.fence_id;
+        resp->ctx_id =3D cmd->cmd_hdr.ctx_id;
+    }
+    s =3D iov_from_buf(cmd->elem.in_sg, cmd->elem.in_num, 0, resp, resp_=
len);
+    if (s !=3D resp_len) {
+        g_critical("%s: response size incorrect %zu vs %zu",
+                   __func__, s, resp_len);
+    }
+    vu_queue_push(&g->dev.parent, cmd->vq, &cmd->elem, s);
+    vu_queue_notify(&g->dev.parent, cmd->vq);
+    cmd->finished =3D true;
+}
+
+void
+vg_ctrl_response_nodata(VuGpu *g,
+                        struct virtio_gpu_ctrl_command *cmd,
+                        enum virtio_gpu_ctrl_type type)
+{
+    struct virtio_gpu_ctrl_hdr resp =3D {
+        .type =3D type,
+    };
+
+    vg_ctrl_response(g, cmd, &resp, sizeof(resp));
+}
+
+void
+vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resp_display_info dpy_info =3D { 0 ,};
+    int i;
+
+    dpy_info.hdr.type =3D VIRTIO_GPU_RESP_OK_DISPLAY_INFO;
+    for (i =3D 0; i < 1 /* g->conf.max_outputs */; i++) {
+        /* if (g->enabled_output_bitmask & (1 << i)) { */
+        dpy_info.pmodes[i].enabled =3D 1;
+        dpy_info.pmodes[i].r.width =3D 1024;
+        dpy_info.pmodes[i].r.height =3D 768;
+        /* } */
+    }
+
+    vg_ctrl_response(vg, cmd, &dpy_info.hdr, sizeof(dpy_info));
+}
+
+static pixman_format_code_t
+get_pixman_format(uint32_t virtio_gpu_format)
+{
+    switch (virtio_gpu_format) {
+#ifdef HOST_WORDS_BIGENDIAN
+    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
+        return PIXMAN_b8g8r8x8;
+    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
+        return PIXMAN_b8g8r8a8;
+    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
+        return PIXMAN_x8r8g8b8;
+    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
+        return PIXMAN_a8r8g8b8;
+    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
+        return PIXMAN_r8g8b8x8;
+    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
+        return PIXMAN_r8g8b8a8;
+    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
+        return PIXMAN_x8b8g8r8;
+    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
+        return PIXMAN_a8b8g8r8;
+#else
+    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
+        return PIXMAN_x8r8g8b8;
+    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
+        return PIXMAN_a8r8g8b8;
+    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
+        return PIXMAN_b8g8r8x8;
+    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
+        return PIXMAN_b8g8r8a8;
+    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
+        return PIXMAN_x8b8g8r8;
+    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
+        return PIXMAN_a8b8g8r8;
+    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
+        return PIXMAN_r8g8b8x8;
+    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
+        return PIXMAN_r8g8b8a8;
+#endif
+    default:
+        return 0;
+    }
+}
+
+static void
+vg_resource_create_2d(VuGpu *g,
+                      struct virtio_gpu_ctrl_command *cmd)
+{
+    pixman_format_code_t pformat;
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_resource_create_2d c2d;
+
+    VUGPU_FILL_CMD(c2d);
+
+    if (c2d.resource_id =3D=3D 0) {
+        g_critical("%s: resource id 0 is not allowed", __func__);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res =3D virtio_gpu_find_resource(g, c2d.resource_id);
+    if (res) {
+        g_critical("%s: resource already exists %d", __func__, c2d.resou=
rce_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res =3D g_new0(struct virtio_gpu_simple_resource, 1);
+    res->width =3D c2d.width;
+    res->height =3D c2d.height;
+    res->format =3D c2d.format;
+    res->resource_id =3D c2d.resource_id;
+
+    pformat =3D get_pixman_format(c2d.format);
+    if (!pformat) {
+        g_critical("%s: host couldn't handle guest format %d",
+                   __func__, c2d.format);
+        g_free(res);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+    res->image =3D pixman_image_create_bits(pformat,
+                                          c2d.width,
+                                          c2d.height,
+                                          NULL, 0);
+    if (!res->image) {
+        g_critical("%s: resource creation failed %d %d %d",
+                   __func__, c2d.resource_id, c2d.width, c2d.height);
+        g_free(res);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+        return;
+    }
+
+    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
+}
+
+static void
+vg_resource_destroy(VuGpu *g,
+                    struct virtio_gpu_simple_resource *res)
+{
+    pixman_image_unref(res->image);
+    QTAILQ_REMOVE(&g->reslist, res, next);
+    g_free(res);
+}
+
+static void
+vg_resource_unref(VuGpu *g,
+                  struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_resource_unref unref;
+
+    VUGPU_FILL_CMD(unref);
+
+    res =3D virtio_gpu_find_resource(g, unref.resource_id);
+    if (!res) {
+        g_critical("%s: illegal resource specified %d",
+                   __func__, unref.resource_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+    vg_resource_destroy(g, res);
+}
+
+int
+vg_create_mapping_iov(VuGpu *g,
+                      struct virtio_gpu_resource_attach_backing *ab,
+                      struct virtio_gpu_ctrl_command *cmd,
+                      struct iovec **iov)
+{
+    struct virtio_gpu_mem_entry *ents;
+    size_t esize, s;
+    int i;
+
+    if (ab->nr_entries > 16384) {
+        g_critical("%s: nr_entries is too big (%d > 16384)",
+                   __func__, ab->nr_entries);
+        return -1;
+    }
+
+    esize =3D sizeof(*ents) * ab->nr_entries;
+    ents =3D g_malloc(esize);
+    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
+                   sizeof(*ab), ents, esize);
+    if (s !=3D esize) {
+        g_critical("%s: command data size incorrect %zu vs %zu",
+                   __func__, s, esize);
+        g_free(ents);
+        return -1;
+    }
+
+    *iov =3D g_malloc0(sizeof(struct iovec) * ab->nr_entries);
+    for (i =3D 0; i < ab->nr_entries; i++) {
+        uint64_t len =3D ents[i].length;
+        (*iov)[i].iov_len =3D ents[i].length;
+        (*iov)[i].iov_base =3D vu_gpa_to_va(&g->dev.parent, &len, ents[i=
].addr);
+        if (!(*iov)[i].iov_base || len !=3D ents[i].length) {
+            g_critical("%s: resource %d element %d",
+                       __func__, ab->resource_id, i);
+            g_free(*iov);
+            g_free(ents);
+            *iov =3D NULL;
+            return -1;
+        }
+    }
+    g_free(ents);
+    return 0;
+}
+
+static void
+vg_resource_attach_backing(VuGpu *g,
+                           struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_resource_attach_backing ab;
+    int ret;
+
+    VUGPU_FILL_CMD(ab);
+
+    res =3D virtio_gpu_find_resource(g, ab.resource_id);
+    if (!res) {
+        g_critical("%s: illegal resource specified %d",
+                   __func__, ab.resource_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    ret =3D vg_create_mapping_iov(g, &ab, cmd, &res->iov);
+    if (ret !=3D 0) {
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
+    res->iov_cnt =3D ab.nr_entries;
+}
+
+static void
+vg_resource_detach_backing(VuGpu *g,
+                           struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_resource_detach_backing detach;
+
+    VUGPU_FILL_CMD(detach);
+
+    res =3D virtio_gpu_find_resource(g, detach.resource_id);
+    if (!res || !res->iov) {
+        g_critical("%s: illegal resource specified %d",
+                   __func__, detach.resource_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    g_free(res->iov);
+    res->iov =3D NULL;
+    res->iov_cnt =3D 0;
+}
+
+static void
+vg_transfer_to_host_2d(VuGpu *g,
+                       struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    int h;
+    uint32_t src_offset, dst_offset, stride;
+    int bpp;
+    pixman_format_code_t format;
+    struct virtio_gpu_transfer_to_host_2d t2d;
+
+    VUGPU_FILL_CMD(t2d);
+
+    res =3D virtio_gpu_find_resource(g, t2d.resource_id);
+    if (!res || !res->iov) {
+        g_critical("%s: illegal resource specified %d",
+                   __func__, t2d.resource_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    if (t2d.r.x > res->width ||
+        t2d.r.y > res->height ||
+        t2d.r.width > res->width ||
+        t2d.r.height > res->height ||
+        t2d.r.x + t2d.r.width > res->width ||
+        t2d.r.y + t2d.r.height > res->height) {
+        g_critical("%s: transfer bounds outside resource"
+                   " bounds for resource %d: %d %d %d %d vs %d %d",
+                   __func__, t2d.resource_id, t2d.r.x, t2d.r.y,
+                   t2d.r.width, t2d.r.height, res->width, res->height);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    format =3D pixman_image_get_format(res->image);
+    bpp =3D (PIXMAN_FORMAT_BPP(format) + 7) / 8;
+    stride =3D pixman_image_get_stride(res->image);
+
+    if (t2d.offset || t2d.r.x || t2d.r.y ||
+        t2d.r.width !=3D pixman_image_get_width(res->image)) {
+        void *img_data =3D pixman_image_get_data(res->image);
+        for (h =3D 0; h < t2d.r.height; h++) {
+            src_offset =3D t2d.offset + stride * h;
+            dst_offset =3D (t2d.r.y + h) * stride + (t2d.r.x * bpp);
+
+            iov_to_buf(res->iov, res->iov_cnt, src_offset,
+                       (uint8_t *)img_data
+                       + dst_offset, t2d.r.width * bpp);
+        }
+    } else {
+        iov_to_buf(res->iov, res->iov_cnt, 0,
+                   pixman_image_get_data(res->image),
+                   pixman_image_get_stride(res->image)
+                   * pixman_image_get_height(res->image));
+    }
+}
+
+static void
+vg_set_scanout(VuGpu *g,
+               struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_scanout *scanout;
+    struct virtio_gpu_set_scanout ss;
+
+    VUGPU_FILL_CMD(ss);
+
+    if (ss.scanout_id >=3D VIRTIO_GPU_MAX_SCANOUTS) {
+        g_critical("%s: illegal scanout id specified %d",
+                   __func__, ss.scanout_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
+        return;
+    }
+
+    if (ss.resource_id =3D=3D 0) {
+        scanout =3D &g->scanout[ss.scanout_id];
+        if (scanout->resource_id) {
+            res =3D virtio_gpu_find_resource(g, scanout->resource_id);
+            if (res) {
+                res->scanout_bitmask &=3D ~(1 << ss.scanout_id);
+            }
+        }
+        if (ss.scanout_id =3D=3D 0) {
+            g_critical("%s: illegal scanout id specified %d",
+                          __func__, ss.scanout_id);
+            cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
+            return;
+        }
+        /* dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, NULL);=
 */
+        scanout->width =3D 0;
+        scanout->height =3D 0;
+        return;
+    }
+
+    /* create a surface for this scanout */
+    res =3D virtio_gpu_find_resource(g, ss.resource_id);
+    if (!res) {
+        g_critical("%s: illegal resource specified %d",
+                      __func__, ss.resource_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    if (ss.r.x > res->width ||
+        ss.r.y > res->height ||
+        ss.r.width > res->width ||
+        ss.r.height > res->height ||
+        ss.r.x + ss.r.width > res->width ||
+        ss.r.y + ss.r.height > res->height) {
+        g_critical("%s: illegal scanout %d bounds for"
+                   " resource %d, (%d,%d)+%d,%d vs %d %d",
+                   __func__, ss.scanout_id, ss.resource_id, ss.r.x, ss.r=
.y,
+                   ss.r.width, ss.r.height, res->width, res->height);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    scanout =3D &g->scanout[ss.scanout_id];
+
+    res->scanout_bitmask |=3D (1 << ss.scanout_id);
+    scanout->resource_id =3D ss.resource_id;
+    scanout->x =3D ss.r.x;
+    scanout->y =3D ss.r.y;
+    scanout->width =3D ss.r.width;
+    scanout->height =3D ss.r.height;
+
+    VhostGpuMsg msg =3D {
+        .request =3D VHOST_GPU_SCANOUT,
+        .size =3D sizeof(VhostGpuScanout),
+        .payload.scanout.scanout_id =3D ss.scanout_id,
+        .payload.scanout.width =3D scanout->width,
+        .payload.scanout.height =3D scanout->height
+    };
+    vg_sock_fd_write(g->sock_fd, &msg, VHOST_GPU_HDR_SIZE + msg.size, -1=
);
+}
+
+static void
+vg_resource_flush(VuGpu *g,
+                  struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_simple_resource *res;
+    struct virtio_gpu_resource_flush rf;
+    pixman_region16_t flush_region;
+    int i;
+
+    VUGPU_FILL_CMD(rf);
+
+    res =3D virtio_gpu_find_resource(g, rf.resource_id);
+    if (!res) {
+        g_critical("%s: illegal resource specified %d\n",
+                   __func__, rf.resource_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    if (rf.r.x > res->width ||
+        rf.r.y > res->height ||
+        rf.r.width > res->width ||
+        rf.r.height > res->height ||
+        rf.r.x + rf.r.width > res->width ||
+        rf.r.y + rf.r.height > res->height) {
+        g_critical("%s: flush bounds outside resource"
+                   " bounds for resource %d: %d %d %d %d vs %d %d\n",
+                   __func__, rf.resource_id, rf.r.x, rf.r.y,
+                   rf.r.width, rf.r.height, res->width, res->height);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    pixman_region_init_rect(&flush_region,
+                            rf.r.x, rf.r.y, rf.r.width, rf.r.height);
+    for (i =3D 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
+        struct virtio_gpu_scanout *scanout;
+        pixman_region16_t region, finalregion;
+        pixman_box16_t *extents;
+
+        if (!(res->scanout_bitmask & (1 << i))) {
+            continue;
+        }
+        scanout =3D &g->scanout[i];
+
+        pixman_region_init(&finalregion);
+        pixman_region_init_rect(&region, scanout->x, scanout->y,
+                                scanout->width, scanout->height);
+
+        pixman_region_intersect(&finalregion, &flush_region, &region);
+
+        extents =3D pixman_region_extents(&finalregion);
+        size_t width =3D extents->x2 - extents->x1;
+        size_t height =3D extents->y2 - extents->y1;
+        size_t bpp =3D PIXMAN_FORMAT_BPP(pixman_image_get_format(res->im=
age)) / 8;
+        size_t size =3D width * height * bpp;
+
+        VhostGpuMsg *msg =3D g_malloc(VHOST_GPU_HDR_SIZE +
+                                    sizeof(VhostGpuUpdate) + size);
+        msg->request =3D VHOST_GPU_UPDATE;
+        msg->size =3D sizeof(VhostGpuUpdate) + size;
+        msg->payload.update.scanout_id =3D i;
+        msg->payload.update.x =3D extents->x1;
+        msg->payload.update.y =3D extents->y1;
+        msg->payload.update.width =3D width;
+        msg->payload.update.height =3D height;
+        pixman_image_t *i =3D
+            pixman_image_create_bits(pixman_image_get_format(res->image)=
,
+                                     msg->payload.update.width,
+                                     msg->payload.update.height,
+                                     (uint32_t *)msg->payload.update.dat=
a,
+                                     width * bpp);
+        pixman_image_composite(PIXMAN_OP_SRC,
+                               res->image, NULL, i,
+                               extents->x1, extents->y1,
+                               0, 0, 0, 0,
+                               width, height);
+        pixman_image_unref(i);
+        vg_sock_fd_write(g->sock_fd, msg, VHOST_GPU_HDR_SIZE + msg->size=
, -1);
+        g_free(msg);
+
+        pixman_region_fini(&region);
+        pixman_region_fini(&finalregion);
+    }
+    pixman_region_fini(&flush_region);
+}
+
+static void
+vg_process_cmd(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
+{
+    switch (cmd->cmd_hdr.type) {
+    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
+        vg_get_display_info(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
+        vg_resource_create_2d(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
+        vg_resource_unref(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
+        vg_resource_flush(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
+        vg_transfer_to_host_2d(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_SET_SCANOUT:
+        vg_set_scanout(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
+        vg_resource_attach_backing(vg, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
+        vg_resource_detach_backing(vg, cmd);
+        break;
+    default:
+        g_debug("TODO handle ctrl %x\n", cmd->cmd_hdr.type);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
+        break;
+    }
+    if (!cmd->finished) {
+        vg_ctrl_response_nodata(vg, cmd, cmd->error ? cmd->error :
+                                VIRTIO_GPU_RESP_OK_NODATA);
+    }
+}
+
+static void
+vg_handle_ctrl(VuDev *dev, int qidx)
+{
+    VuGpu *vg =3D container_of(dev, VuGpu, dev.parent);
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
+    struct virtio_gpu_ctrl_command *cmd =3D NULL;
+    size_t len;
+
+    g_debug("%s\n", __func__);
+
+    for (;;) {
+        cmd =3D vu_queue_pop(dev, vq, sizeof(struct virtio_gpu_ctrl_comm=
and));
+        if (!cmd) {
+            break;
+        }
+        cmd->vq =3D vq;
+        cmd->error =3D 0;
+        cmd->finished =3D false;
+
+        len =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
+                         0, &cmd->cmd_hdr, sizeof(cmd->cmd_hdr));
+        if (len !=3D sizeof(cmd->cmd_hdr)) {
+            g_warning("%s: command size incorrect %zu vs %zu\n",
+                      __func__, len, sizeof(cmd->cmd_hdr));
+        }
+
+        g_debug("%d %s\n", cmd->cmd_hdr.type,
+                vg_cmd_to_string(cmd->cmd_hdr.type));
+
+        if (vg->virgl) {
+            vg_virgl_process_cmd(vg, cmd);
+        } else {
+            vg_process_cmd(vg, cmd);
+        }
+
+        if (!cmd->finished) {
+            QTAILQ_INSERT_TAIL(&vg->fenceq, cmd, next);
+            vg->inflight++;
+        } else {
+            g_free(cmd);
+        }
+    }
+}
+
+static void
+update_cursor_data_simple(VuGpu *g, uint32_t resource_id, gpointer data)
+{
+    struct virtio_gpu_simple_resource *res;
+
+    res =3D virtio_gpu_find_resource(g, resource_id);
+    g_return_if_fail(res !=3D NULL);
+    g_return_if_fail(pixman_image_get_width(res->image) =3D=3D 64);
+    g_return_if_fail(pixman_image_get_height(res->image) =3D=3D 64);
+    g_return_if_fail(
+        PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) =3D=3D 32=
);
+
+    memcpy(data, pixman_image_get_data(res->image), 64 * 64 * sizeof(uin=
t32_t));
+}
+
+static void
+vg_handle_cursor(VuDev *dev, int qidx)
+{
+    VuGpu *g =3D container_of(dev, VuGpu, dev.parent);
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
+    VuVirtqElement *elem;
+    size_t len;
+    struct virtio_gpu_update_cursor cursor;
+
+    for (;;) {
+        elem =3D vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
+        if (!elem) {
+            break;
+        }
+        g_debug("cursor out:%d in:%d\n", elem->out_num, elem->in_num);
+
+        len =3D iov_to_buf(elem->out_sg, elem->out_num,
+                         0, &cursor, sizeof(cursor));
+        if (len !=3D sizeof(cursor)) {
+            g_warning("%s: cursor size incorrect %zu vs %zu\n",
+                      __func__, len, sizeof(cursor));
+        }
+        bool move =3D cursor.hdr.type !=3D VIRTIO_GPU_CMD_MOVE_CURSOR;
+        g_debug("%s move:%d\n", __func__, move);
+
+        if (move) {
+            VhostGpuMsg msg =3D {
+                .request =3D cursor.resource_id ?
+                    VHOST_GPU_CURSOR_POS : VHOST_GPU_CURSOR_POS_HIDE,
+                .size =3D sizeof(VhostGpuCursorPos),
+                .payload.cursor_pos =3D {
+                    .scanout_id =3D cursor.pos.scanout_id,
+                    .x =3D cursor.pos.x,
+                    .y =3D cursor.pos.y,
+                }
+            };
+            vg_sock_fd_write(g->sock_fd, &msg,
+                             VHOST_GPU_HDR_SIZE + msg.size, -1);
+        } else {
+            VhostGpuMsg msg =3D {
+                .request =3D VHOST_GPU_CURSOR_UPDATE,
+                .size =3D sizeof(VhostGpuCursorUpdate),
+                .payload.cursor_update =3D {
+                    .pos =3D {
+                        .scanout_id =3D cursor.pos.scanout_id,
+                        .x =3D cursor.pos.x,
+                        .y =3D cursor.pos.y,
+                    },
+                    .hot_x =3D cursor.hot_x,
+                    .hot_y =3D cursor.hot_y,
+                }
+            };
+            if (g->virgl) {
+                vg_virgl_update_cursor_data(g, cursor.resource_id,
+                                            msg.payload.cursor_update.da=
ta);
+            } else {
+                update_cursor_data_simple(g, cursor.resource_id,
+                                          msg.payload.cursor_update.data=
);
+            }
+            vg_sock_fd_write(g->sock_fd, &msg,
+                             VHOST_GPU_HDR_SIZE + msg.size, -1);
+        }
+
+        vu_queue_push(dev, vq, elem, 0);
+        vu_queue_notify(dev, vq);
+        g_free(elem);
+    }
+}
+
+static void
+vg_panic(VuDev *dev, const char *msg)
+{
+    g_critical("%s\n", msg);
+    exit(1);
+}
+
+static void
+vg_queue_set_started(VuDev *dev, int qidx, bool started)
+{
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
+
+    g_debug("queue started %d:%d\n", qidx, started);
+
+    switch (qidx) {
+    case 0:
+        vu_set_queue_handler(dev, vq, started ? vg_handle_ctrl : NULL);
+        break;
+    case 1:
+        vu_set_queue_handler(dev, vq, started ? vg_handle_cursor : NULL)=
;
+        break;
+    default:
+        break;
+    }
+}
+
+static int
+vg_process_msg(VuDev *dev, VhostUserMsg *msg, int *do_reply)
+{
+    VuGpu *g =3D container_of(dev, VuGpu, dev.parent);
+
+    switch (msg->request) {
+    case VHOST_USER_GPU_SET_SOCKET:
+        g_return_val_if_fail(msg->fd_num =3D=3D 1, 1);
+        g_return_val_if_fail(g->sock_fd =3D=3D -1, 1);
+        g->sock_fd =3D msg->fds[0];
+        return 1;
+    default:
+        return 0;
+    }
+
+    return 0;
+}
+
+static void
+vg_set_features(VuDev *dev, uint64_t features)
+{
+    VuGpu *g =3D container_of(dev, VuGpu, dev.parent);
+    bool virgl =3D features & (1 << VIRTIO_GPU_F_VIRGL);
+
+    if (virgl && !g->virgl_inited) {
+        vg_virgl_init(g);
+        g->virgl_inited =3D true;
+    }
+
+    g->virgl =3D virgl;
+}
+
+static const VuDevIface vuiface =3D {
+    .set_features =3D vg_set_features,
+    .queue_set_started =3D vg_queue_set_started,
+    .process_msg =3D vg_process_msg,
+};
+
+static void
+vg_reset(VuGpu *g)
+{
+    struct virtio_gpu_simple_resource *res, *tmp;
+
+    vug_deinit(&g->dev);
+
+    if (g->sock_fd !=3D -1) {
+        close(g->sock_fd);
+        g->sock_fd =3D -1;
+    }
+
+    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
+        vg_resource_destroy(g, res);
+    }
+}
+
+static int unix_sock_new(char *path)
+{
+    int sock;
+    struct sockaddr_un un;
+    size_t len;
+
+    sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
+    if (sock <=3D 0) {
+        perror("socket");
+        return -1;
+    }
+
+    un.sun_family =3D AF_UNIX;
+    snprintf(un.sun_path, sizeof(un.sun_path), "%s", path);
+    len =3D sizeof(un.sun_family) + strlen(un.sun_path);
+
+    unlink(path);
+    if (bind(sock, (struct sockaddr *)&un, len) < 0) {
+        perror("bind");
+        goto fail;
+    }
+
+    if (listen(sock, 1) < 0) {
+        perror("listen");
+        goto fail;
+    }
+
+    return sock;
+
+fail:
+    close(sock);
+
+    return -1;
+}
+
+char *socket_path;
+
+static GOptionEntry entries[] =3D {
+    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &socket_path,
+      "Use UNIX socket path", "" },
+    { NULL, }
+};
+
+int
+main(int argc, char *argv[])
+{
+    GOptionContext *context;
+    GError *error =3D NULL;
+    GMainLoop *loop =3D NULL;
+    int fd;
+    VuGpu g =3D { .sock_fd =3D -1 };
+
+    QTAILQ_INIT(&g.reslist);
+    QTAILQ_INIT(&g.fenceq);
+
+    context =3D g_option_context_new("vhost-user-gpu sample");
+    g_option_context_add_main_entries(context, entries, NULL);
+    if (!g_option_context_parse(context, &argc, &argv, &error)) {
+        g_printerr("Option parsing failed: %s\n", error->message);
+        exit(1);
+    }
+    g_option_context_free(context);
+
+    if (socket_path) {
+        int lsock =3D unix_sock_new(socket_path);
+        fd =3D accept(lsock, NULL, NULL);
+        close(lsock);
+    } else {
+        fd =3D 3;
+    }
+    if (fd =3D=3D -1) {
+        g_printerr("Invalid socket");
+        exit(1);
+    }
+    vug_init(&g.dev, fd, vg_panic, &vuiface);
+
+    loop =3D g_main_loop_new(NULL, FALSE);
+    g_main_loop_run(loop);
+    g_main_loop_unref(loop);
+
+    vg_reset(&g);
+
+    return 0;
+}
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virg=
l.c
new file mode 100644
index 0000000000..38fd5c0198
--- /dev/null
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -0,0 +1,537 @@
+/*
+ * Virtio vhost-user GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2018
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <virglrenderer.h>
+#include "virgl.h"
+
+void
+vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
+                            gpointer data)
+{
+    uint32_t width, height;
+    uint32_t *cursor;
+
+    cursor =3D virgl_renderer_get_cursor_data(resource_id, &width, &heig=
ht);
+    g_return_if_fail(cursor !=3D NULL);
+    g_return_if_fail(width =3D=3D 64);
+    g_return_if_fail(height =3D=3D 64);
+
+    memcpy(data, cursor, 64 * 64 * sizeof(uint32_t));
+    free(cursor);
+}
+
+static void
+virgl_cmd_context_create(VuGpu *g,
+                         struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_ctx_create cc;
+
+    VUGPU_FILL_CMD(cc);
+
+    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
+                                  cc.debug_name);
+}
+
+static void
+virgl_cmd_context_destroy(VuGpu *g,
+                          struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_ctx_destroy cd;
+
+    VUGPU_FILL_CMD(cd);
+
+    virgl_renderer_context_destroy(cd.hdr.ctx_id);
+}
+
+static void
+virgl_cmd_create_resource_2d(VuGpu *g,
+                             struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_create_2d c2d;
+    struct virgl_renderer_resource_create_args args;
+
+    VUGPU_FILL_CMD(c2d);
+
+    args.handle =3D c2d.resource_id;
+    args.target =3D 2;
+    args.format =3D c2d.format;
+    args.bind =3D (1 << 1);
+    args.width =3D c2d.width;
+    args.height =3D c2d.height;
+    args.depth =3D 1;
+    args.array_size =3D 1;
+    args.last_level =3D 0;
+    args.nr_samples =3D 0;
+    args.flags =3D VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
+    virgl_renderer_resource_create(&args, NULL, 0);
+}
+
+static void
+virgl_cmd_create_resource_3d(VuGpu *g,
+                             struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_create_3d c3d;
+    struct virgl_renderer_resource_create_args args;
+
+    VUGPU_FILL_CMD(c3d);
+
+    args.handle =3D c3d.resource_id;
+    args.target =3D c3d.target;
+    args.format =3D c3d.format;
+    args.bind =3D c3d.bind;
+    args.width =3D c3d.width;
+    args.height =3D c3d.height;
+    args.depth =3D c3d.depth;
+    args.array_size =3D c3d.array_size;
+    args.last_level =3D c3d.last_level;
+    args.nr_samples =3D c3d.nr_samples;
+    args.flags =3D c3d.flags;
+    virgl_renderer_resource_create(&args, NULL, 0);
+}
+
+static void
+virgl_cmd_resource_unref(VuGpu *g,
+                         struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_unref unref;
+
+    VUGPU_FILL_CMD(unref);
+
+    virgl_renderer_resource_unref(unref.resource_id);
+}
+
+static void
+virgl_cmd_get_capset_info(VuGpu *g,
+                          struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_get_capset_info info;
+    struct virtio_gpu_resp_capset_info resp;
+
+    g_debug("%s\n", __func__);
+    VUGPU_FILL_CMD(info);
+
+    if (info.capset_index =3D=3D 0) {
+        resp.capset_id =3D VIRTIO_GPU_CAPSET_VIRGL;
+        virgl_renderer_get_cap_set(resp.capset_id,
+                                   &resp.capset_max_version,
+                                   &resp.capset_max_size);
+    } else {
+        resp.capset_max_version =3D 0;
+        resp.capset_max_size =3D 0;
+    }
+    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET_INFO;
+    vg_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
+}
+
+static void
+virgl_cmd_get_capset(VuGpu *g,
+                     struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_get_capset gc;
+    struct virtio_gpu_resp_capset *resp;
+    uint32_t max_ver, max_size;
+
+    VUGPU_FILL_CMD(gc);
+
+    virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
+                               &max_size);
+    resp =3D g_malloc0(sizeof(*resp) + max_size);
+
+    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
+    virgl_renderer_fill_caps(gc.capset_id,
+                             gc.capset_version,
+                             (void *)resp->capset_data);
+    vg_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + max_size);
+    g_free(resp);
+}
+
+static void
+virgl_cmd_submit_3d(VuGpu *g,
+                    struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_cmd_submit cs;
+    void *buf;
+    size_t s;
+
+    VUGPU_FILL_CMD(cs);
+
+    buf =3D g_malloc(cs.size);
+    s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
+                   sizeof(cs), buf, cs.size);
+    if (s !=3D cs.size) {
+        g_critical("%s: size mismatch (%zd/%d)", __func__, s, cs.size);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        goto out;
+    }
+
+    virgl_renderer_submit_cmd(buf, cs.hdr.ctx_id, cs.size / 4);
+
+out:
+    g_free(buf);
+}
+
+static void
+virgl_cmd_transfer_to_host_2d(VuGpu *g,
+                              struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_transfer_to_host_2d t2d;
+    struct virtio_gpu_box box;
+
+    VUGPU_FILL_CMD(t2d);
+
+    box.x =3D t2d.r.x;
+    box.y =3D t2d.r.y;
+    box.z =3D 0;
+    box.w =3D t2d.r.width;
+    box.h =3D t2d.r.height;
+    box.d =3D 1;
+
+    virgl_renderer_transfer_write_iov(t2d.resource_id,
+                                      0,
+                                      0,
+                                      0,
+                                      0,
+                                      (struct virgl_box *)&box,
+                                      t2d.offset, NULL, 0);
+}
+
+static void
+virgl_cmd_transfer_to_host_3d(VuGpu *g,
+                              struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_transfer_host_3d t3d;
+
+    VUGPU_FILL_CMD(t3d);
+
+    virgl_renderer_transfer_write_iov(t3d.resource_id,
+                                      t3d.hdr.ctx_id,
+                                      t3d.level,
+                                      t3d.stride,
+                                      t3d.layer_stride,
+                                      (struct virgl_box *)&t3d.box,
+                                      t3d.offset, NULL, 0);
+}
+
+static void
+virgl_cmd_transfer_from_host_3d(VuGpu *g,
+                                struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_transfer_host_3d tf3d;
+
+    VUGPU_FILL_CMD(tf3d);
+
+    virgl_renderer_transfer_read_iov(tf3d.resource_id,
+                                     tf3d.hdr.ctx_id,
+                                     tf3d.level,
+                                     tf3d.stride,
+                                     tf3d.layer_stride,
+                                     (struct virgl_box *)&tf3d.box,
+                                     tf3d.offset, NULL, 0);
+}
+
+static void
+virgl_resource_attach_backing(VuGpu *g,
+                              struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_attach_backing att_rb;
+    struct iovec *res_iovs;
+    int ret;
+
+    VUGPU_FILL_CMD(att_rb);
+
+    ret =3D vg_create_mapping_iov(g, &att_rb, cmd, &res_iovs);
+    if (ret !=3D 0) {
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
+    virgl_renderer_resource_attach_iov(att_rb.resource_id,
+                                       res_iovs, att_rb.nr_entries);
+}
+
+static void
+virgl_resource_detach_backing(VuGpu *g,
+                              struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_detach_backing detach_rb;
+    struct iovec *res_iovs =3D NULL;
+    int num_iovs =3D 0;
+
+    VUGPU_FILL_CMD(detach_rb);
+
+    virgl_renderer_resource_detach_iov(detach_rb.resource_id,
+                                       &res_iovs,
+                                       &num_iovs);
+    if (res_iovs =3D=3D NULL || num_iovs =3D=3D 0) {
+        return;
+    }
+    g_free(res_iovs);
+}
+
+static void
+virgl_cmd_set_scanout(VuGpu *g,
+                      struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_set_scanout ss;
+    struct virgl_renderer_resource_info info;
+    int ret;
+
+    VUGPU_FILL_CMD(ss);
+
+    if (ss.scanout_id >=3D VIRTIO_GPU_MAX_SCANOUTS) {
+        g_critical("%s: illegal scanout id specified %d",
+                   __func__, ss.scanout_id);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
+        return;
+    }
+
+    memset(&info, 0, sizeof(info));
+
+    if (ss.resource_id && ss.r.width && ss.r.height) {
+        ret =3D virgl_renderer_resource_get_info(ss.resource_id, &info);
+        if (ret =3D=3D -1) {
+            g_critical("%s: illegal resource specified %d\n",
+                       __func__, ss.resource_id);
+            cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+            return;
+        }
+
+        int fd =3D -1;
+        if (virgl_renderer_get_fd_for_texture(info.tex_id, &fd) < 0) {
+            g_critical("%s: failed to get fd for texture\n", __func__);
+            cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+            return;
+        }
+
+        VhostGpuMsg msg =3D {
+            .request =3D VHOST_GPU_GL_SCANOUT,
+            .size =3D sizeof(VhostGpuGlScanout),
+            .payload.gl_scanout.scanout_id =3D ss.scanout_id,
+            .payload.gl_scanout.x =3D  ss.r.x,
+            .payload.gl_scanout.y =3D  ss.r.y,
+            .payload.gl_scanout.width =3D ss.r.width,
+            .payload.gl_scanout.height =3D ss.r.height,
+            .payload.gl_scanout.fd_width =3D info.width,
+            .payload.gl_scanout.fd_height =3D info.height,
+            .payload.gl_scanout.fd_stride =3D info.stride,
+            .payload.gl_scanout.fd_flags =3D info.flags,
+            .payload.gl_scanout.fd_drm_fourcc =3D info.drm_fourcc
+        };
+        vg_sock_fd_write(g->sock_fd, &msg, VHOST_GPU_HDR_SIZE + msg.size=
, fd);
+        close(fd);
+    } else {
+        VhostGpuMsg msg =3D {
+            .request =3D VHOST_GPU_GL_SCANOUT,
+            .size =3D sizeof(VhostGpuGlScanout),
+            .payload.gl_scanout.scanout_id =3D ss.scanout_id,
+        };
+        vg_sock_fd_write(g->sock_fd, &msg, VHOST_GPU_HDR_SIZE + msg.size=
, -1);
+    }
+    g->scanout[ss.scanout_id].resource_id =3D ss.resource_id;
+}
+
+static void
+virgl_cmd_resource_flush(VuGpu *g,
+                         struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_flush rf;
+    int i, ret;
+    uint32_t ok;
+
+    VUGPU_FILL_CMD(rf);
+
+    for (i =3D 0; i < VIRTIO_GPU_MAX_SCANOUTS; i++) {
+        if (g->scanout[i].resource_id !=3D rf.resource_id) {
+            continue;
+        }
+        VhostGpuMsg msg =3D {
+            .request =3D VHOST_GPU_GL_UPDATE,
+            .size =3D sizeof(VhostGpuUpdate),
+            .payload.update.scanout_id =3D i,
+            .payload.update.x =3D rf.r.x,
+            .payload.update.y =3D rf.r.y,
+            .payload.update.width =3D rf.r.width,
+            .payload.update.height =3D rf.r.height
+        };
+        ret =3D vg_sock_fd_write(g->sock_fd, &msg,
+                               VHOST_GPU_HDR_SIZE + msg.size, -1);
+        g_return_if_fail(ret =3D=3D VHOST_GPU_HDR_SIZE + msg.size);
+        ret =3D read(g->sock_fd, &ok, sizeof(ok));
+        g_return_if_fail(ret =3D=3D sizeof(ok));
+    }
+}
+
+static void
+virgl_cmd_ctx_attach_resource(VuGpu *g,
+                              struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_ctx_resource att_res;
+
+    VUGPU_FILL_CMD(att_res);
+
+    virgl_renderer_ctx_attach_resource(att_res.hdr.ctx_id, att_res.resou=
rce_id);
+}
+
+static void
+virgl_cmd_ctx_detach_resource(VuGpu *g,
+                              struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_ctx_resource det_res;
+
+    VUGPU_FILL_CMD(det_res);
+
+    virgl_renderer_ctx_detach_resource(det_res.hdr.ctx_id, det_res.resou=
rce_id);
+}
+
+void vg_virgl_process_cmd(VuGpu *g, struct virtio_gpu_ctrl_command *cmd)
+{
+    virgl_renderer_force_ctx_0();
+    switch (cmd->cmd_hdr.type) {
+    case VIRTIO_GPU_CMD_CTX_CREATE:
+        virgl_cmd_context_create(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_CTX_DESTROY:
+        virgl_cmd_context_destroy(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
+        virgl_cmd_create_resource_2d(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
+        virgl_cmd_create_resource_3d(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_SUBMIT_3D:
+        virgl_cmd_submit_3d(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
+        virgl_cmd_transfer_to_host_2d(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
+        virgl_cmd_transfer_to_host_3d(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
+        virgl_cmd_transfer_from_host_3d(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
+        virgl_resource_attach_backing(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
+        virgl_resource_detach_backing(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_SET_SCANOUT:
+        virgl_cmd_set_scanout(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
+        virgl_cmd_resource_flush(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
+        virgl_cmd_resource_unref(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
+        /* TODO add security */
+        virgl_cmd_ctx_attach_resource(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
+        /* TODO add security */
+        virgl_cmd_ctx_detach_resource(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
+        virgl_cmd_get_capset_info(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_GET_CAPSET:
+        virgl_cmd_get_capset(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
+        vg_get_display_info(g, cmd);
+        break;
+    default:
+        g_debug("TODO handle ctrl %x\n", cmd->cmd_hdr.type);
+        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
+        break;
+    }
+
+    if (cmd->finished) {
+        return;
+    }
+
+    if (cmd->error) {
+        g_warning("%s: ctrl 0x%x, error 0x%x\n", __func__,
+                  cmd->cmd_hdr.type, cmd->error);
+        vg_ctrl_response_nodata(g, cmd, cmd->error);
+        return;
+    }
+
+    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
+        vg_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
+        return;
+    }
+
+    g_debug("Creating fence id:%" PRId64 " type:%d",
+            cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
+}
+
+static void
+virgl_write_fence(void *opaque, uint32_t fence)
+{
+    VuGpu *g =3D opaque;
+    struct virtio_gpu_ctrl_command *cmd, *tmp;
+
+    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
+        /*
+         * the guest can end up emitting fences out of order
+         * so we should check all fenced cmds not just the first one.
+         */
+        if (cmd->cmd_hdr.fence_id > fence) {
+            continue;
+        }
+        g_debug("FENCE %" PRIu64, cmd->cmd_hdr.fence_id);
+        vg_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
+        QTAILQ_REMOVE(&g->fenceq, cmd, next);
+        g_free(cmd);
+        g->inflight--;
+    }
+}
+
+static struct virgl_renderer_callbacks virgl_cbs =3D {
+    .version     =3D 1,
+    .write_fence =3D virgl_write_fence,
+};
+
+static void
+vg_virgl_poll(VuDev *dev, int condition, void *data)
+{
+    virgl_renderer_poll();
+}
+
+int
+vg_virgl_init(VuGpu *g)
+{
+    int ret;
+
+    ret =3D virgl_renderer_init(g,
+                              VIRGL_RENDERER_USE_EGL |
+                              VIRGL_RENDERER_THREAD_SYNC,
+                              &virgl_cbs);
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    ret =3D virgl_renderer_get_poll_fd();
+    if (ret !=3D -1) {
+        g->renderer_source =3D
+            vug_source_new(&g->dev, ret, G_IO_IN, vg_virgl_poll, g);
+    }
+
+    return ret;
+}
diff --git a/Makefile b/Makefile
index d1222da359..fb2359f877 100644
--- a/Makefile
+++ b/Makefile
@@ -421,6 +421,7 @@ dummy :=3D $(call unnest-vars,, \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
+                vhost-user-gpu-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -722,6 +723,8 @@ vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libv=
host-user.a
 	$(call LINK, $^)
 vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a lib=
qemuutil.a
 	$(call LINK, $^)
+vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) =
libqemuutil.a libqemustub.a
+	$(call LINK, $^)
=20
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.=
mak
 	$(call quiet-command,$(PYTHON) $< $@ \
diff --git a/Makefile.objs b/Makefile.objs
index c20f8d35d7..417c115f26 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -194,6 +194,7 @@ vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
 vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
 vhost-user-input-obj-y =3D contrib/vhost-user-input/
+vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
=20
 ######################################################################
 trace-events-subdirs =3D
diff --git a/configure b/configure
index 1d1caea9e7..675a4ba626 100755
--- a/configure
+++ b/configure
@@ -5533,6 +5533,7 @@ if test "$want_tools" =3D "yes" ; then
   if [ "$ivshmem" =3D "yes" ]; then
     tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
     tools=3D"vhost-user-input\$(EXESUF) $tools"
+    tools=3D"vhost-user-gpu\$(EXESUF) $tools"
   fi
 fi
 if test "$softmmu" =3D yes ; then
@@ -7141,6 +7142,9 @@ echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_mak
=20
 done # for target in $targets
=20
+echo "PIXMAN_CFLAGS=3D$pixman_cflags" >> $config_host_mak
+echo "PIXMAN_LIBS=3D$pixman_libs" >> $config_host_mak
+
 if [ "$fdt" =3D "git" ]; then
   echo "config-host.h: subdir-dtc" >> $config_host_mak
 fi
diff --git a/contrib/vhost-user-gpu/Makefile.objs b/contrib/vhost-user-gp=
u/Makefile.objs
new file mode 100644
index 0000000000..da7c4b8ba9
--- /dev/null
+++ b/contrib/vhost-user-gpu/Makefile.objs
@@ -0,0 +1,7 @@
+vhost-user-gpu-obj-y =3D main.o virgl.o
+
+main.o-cflags :=3D $(PIXMAN_CFLAGS)
+main.o-libs :=3D $(PIXMAN_LIBS)
+
+virgl.o-cflags :=3D $(VIRGL_CFLAGS)
+virgl.o-libs :=3D $(VIRGL_LIBS)
--=20
2.17.1.906.g10fd178552
