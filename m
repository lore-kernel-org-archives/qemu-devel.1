Received: from eggs.gnu.org ([209.51.188.92]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMq-0007UD-36
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMk-0005yV-Cn
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hIvMi-0005vf-D1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41D7730031B0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:21:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Apr 2019 15:20:02 +0200
Message-Id: <20190423132004.13725-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 09/11] virtio-gpu: split virtio-gpu,
 introduce virtio-gpu-base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Add a base class that is common to virtio-gpu and vhost-user-gpu
devices.

The VirtIOGPUBase base class provides common functionalities necessary
for both virtio-gpu and vhost-user-gpu:
- common configuration (max-outputs, initial resolution, flags)
- virtio device initialization, including queue setup
- device pre-conditions checks (iommu)
- migration blocker
- virtio device callbacks
- hooking up to qemu display subsystem
- a few common helper functions to reset the device, retrieve display
informations
- a class callback to unblock the rendering (for GL updates)

What is left to the virtio-gpu subdevice to take care of, in short,
are all the virtio queues handling, command processing and migration.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  73 +++++--
 hw/display/virtio-gpu-3d.c     |  49 +++--
 hw/display/virtio-gpu-base.c   | 268 ++++++++++++++++++++++++
 hw/display/virtio-gpu-pci.c    |   2 +-
 hw/display/virtio-gpu.c        | 372 +++++++++------------------------
 hw/display/virtio-vga.c        |  11 +-
 hw/display/Makefile.objs       |   2 +-
 7 files changed, 458 insertions(+), 319 deletions(-)
 create mode 100644 hw/display/virtio-gpu-base.c

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 60425c5d58..d0d8d7b246 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -22,6 +22,14 @@
=20
 #include "standard-headers/linux/virtio_gpu.h"
=20
+#define TYPE_VIRTIO_GPU_BASE "virtio-gpu-base"
+#define VIRTIO_GPU_BASE(obj)                                            =
    \
+    OBJECT_CHECK(VirtIOGPUBase, (obj), TYPE_VIRTIO_GPU_BASE)
+#define VIRTIO_GPU_BASE_GET_CLASS(obj)                                  =
    \
+    OBJECT_GET_CLASS(VirtIOGPUBaseClass, obj, TYPE_VIRTIO_GPU_BASE)
+#define VIRTIO_GPU_BASE_CLASS(klass)                                    =
    \
+    OBJECT_CLASS_CHECK(VirtIOGPUBaseClass, klass, TYPE_VIRTIO_GPU_BASE)
+
 #define TYPE_VIRTIO_GPU "virtio-gpu-device"
 #define VIRTIO_GPU(obj)                                        \
         OBJECT_CHECK(VirtIOGPU, (obj), TYPE_VIRTIO_GPU)
@@ -58,7 +66,7 @@ struct virtio_gpu_requested_state {
     int x, y;
 };
=20
-enum virtio_gpu_conf_flags {
+enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_VIRGL_ENABLED =3D 1,
     VIRTIO_GPU_FLAG_STATS_ENABLED,
     VIRTIO_GPU_FLAG_EDID_ENABLED,
@@ -71,8 +79,7 @@ enum virtio_gpu_conf_flags {
 #define virtio_gpu_edid_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_EDID_ENABLED))
=20
-struct virtio_gpu_conf {
-    uint64_t max_hostmem;
+struct virtio_gpu_base_conf {
     uint32_t max_outputs;
     uint32_t flags;
     uint32_t xres;
@@ -88,31 +95,55 @@ struct virtio_gpu_ctrl_command {
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
=20
-typedef struct VirtIOGPU {
+typedef struct VirtIOGPUBase {
     VirtIODevice parent_obj;
=20
-    QEMUBH *ctrl_bh;
-    QEMUBH *cursor_bh;
+    Error *migration_blocker;
+
+    struct virtio_gpu_base_conf conf;
+    struct virtio_gpu_config virtio_config;
+
+    bool use_virgl_renderer;
+    int renderer_blocked;
+    int enable;
+
+    struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
+
+    int enabled_output_bitmask;
+    struct virtio_gpu_requested_state req_state[VIRTIO_GPU_MAX_SCANOUTS]=
;
+} VirtIOGPUBase;
+
+typedef struct VirtIOGPUBaseClass {
+    VirtioDeviceClass parent;
+
+    void (*gl_unblock)(VirtIOGPUBase *g);
+} VirtIOGPUBaseClass;
+
+#define VIRTIO_GPU_BASE_PROPERTIES(_state, _conf)                       =
\
+    DEFINE_PROP_UINT32("max_outputs", _state, _conf.max_outputs, 1),    =
\
+    DEFINE_PROP_BIT("edid", _state, _conf.flags, \
+                    VIRTIO_GPU_FLAG_EDID_ENABLED, false), \
+    DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1024), \
+    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 768)
+
+typedef struct VirtIOGPU {
+    VirtIOGPUBase parent_obj;
+
+    uint64_t conf_max_hostmem;
+
     VirtQueue *ctrl_vq;
     VirtQueue *cursor_vq;
=20
-    int enable;
+    QEMUBH *ctrl_bh;
+    QEMUBH *cursor_bh;
=20
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
=20
-    struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
-    struct virtio_gpu_requested_state req_state[VIRTIO_GPU_MAX_SCANOUTS]=
;
-
-    struct virtio_gpu_conf conf;
     uint64_t hostmem;
-    int enabled_output_bitmask;
-    struct virtio_gpu_config virtio_config;
=20
-    bool use_virgl_renderer;
     bool renderer_inited;
-    int renderer_blocked;
     bool renderer_reset;
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
@@ -124,8 +155,6 @@ typedef struct VirtIOGPU {
         uint32_t req_3d;
         uint32_t bytes_3d;
     } stats;
-
-    Error *migration_blocker;
 } VirtIOGPU;
=20
 extern const GraphicHwOps virtio_gpu_ops;
@@ -148,6 +177,15 @@ extern const GraphicHwOps virtio_gpu_ops;
         }                                                               =
\
     } while (0)
=20
+/* virtio-gpu-base.c */
+bool virtio_gpu_base_device_realize(DeviceState *qdev,
+                                    VirtIOHandleOutput ctrl_cb,
+                                    VirtIOHandleOutput cursor_cb,
+                                    Error **errp);
+void virtio_gpu_base_reset(VirtIOGPUBase *g);
+void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
+                        struct virtio_gpu_resp_display_info *dpy_info);
+
 /* virtio-gpu.c */
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
@@ -175,4 +213,5 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+
 #endif
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 2d302526ab..b918167aec 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -118,11 +118,11 @@ static void virgl_cmd_context_destroy(VirtIOGPU *g,
 static void virtio_gpu_rect_update(VirtIOGPU *g, int idx, int x, int y,
                                 int width, int height)
 {
-    if (!g->scanout[idx].con) {
+    if (!g->parent_obj.scanout[idx].con) {
         return;
     }
=20
-    dpy_gl_update(g->scanout[idx].con, x, y, width, height);
+    dpy_gl_update(g->parent_obj.scanout[idx].con, x, y, width, height);
 }
=20
 static void virgl_cmd_resource_flush(VirtIOGPU *g,
@@ -135,8 +135,8 @@ static void virgl_cmd_resource_flush(VirtIOGPU *g,
     trace_virtio_gpu_cmd_res_flush(rf.resource_id,
                                    rf.r.width, rf.r.height, rf.r.x, rf.r=
.y);
=20
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
-        if (g->scanout[i].resource_id !=3D rf.resource_id) {
+    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id !=3D rf.resource_id) {
             continue;
         }
         virtio_gpu_rect_update(g, i, rf.r.x, rf.r.y, rf.r.width, rf.r.he=
ight);
@@ -154,13 +154,13 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss=
.r.y);
=20
-    if (ss.scanout_id >=3D g->conf.max_outputs) {
+    if (ss.scanout_id >=3D g->parent_obj.conf.max_outputs) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified=
 %d",
                       __func__, ss.scanout_id);
         cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
         return;
     }
-    g->enable =3D 1;
+    g->parent_obj.enable =3D 1;
=20
     memset(&info, 0, sizeof(info));
=20
@@ -173,20 +173,22 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
             return;
         }
-        qemu_console_resize(g->scanout[ss.scanout_id].con,
+        qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
                             ss.r.width, ss.r.height);
         virgl_renderer_force_ctx_0();
-        dpy_gl_scanout_texture(g->scanout[ss.scanout_id].con, info.tex_i=
d,
-                               info.flags & 1 /* FIXME: Y_0_TOP */,
-                               info.width, info.height,
-                               ss.r.x, ss.r.y, ss.r.width, ss.r.height);
+        dpy_gl_scanout_texture(
+            g->parent_obj.scanout[ss.scanout_id].con, info.tex_id,
+            info.flags & 1 /* FIXME: Y_0_TOP */,
+            info.width, info.height,
+            ss.r.x, ss.r.y, ss.r.width, ss.r.height);
     } else {
         if (ss.scanout_id !=3D 0) {
-            dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, NULL)=
;
+            dpy_gfx_replace_surface(
+                g->parent_obj.scanout[ss.scanout_id].con, NULL);
         }
-        dpy_gl_scanout_disable(g->scanout[ss.scanout_id].con);
+        dpy_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con)=
;
     }
-    g->scanout[ss.scanout_id].resource_id =3D ss.resource_id;
+    g->parent_obj.scanout[ss.scanout_id].resource_id =3D ss.resource_id;
 }
=20
 static void virgl_cmd_submit_3d(VirtIOGPU *g,
@@ -209,7 +211,7 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
         goto out;
     }
=20
-    if (virtio_gpu_stats_enabled(g->conf)) {
+    if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         g->stats.req_3d++;
         g->stats.bytes_3d +=3D cs.size;
     }
@@ -507,7 +509,7 @@ static void virgl_write_fence(void *opaque, uint32_t =
fence)
         QTAILQ_REMOVE(&g->fenceq, cmd, next);
         g_free(cmd);
         g->inflight--;
-        if (virtio_gpu_stats_enabled(g->conf)) {
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
         }
     }
@@ -524,7 +526,7 @@ virgl_create_context(void *opaque, int scanout_idx,
     qparams.major_ver =3D params->major_ver;
     qparams.minor_ver =3D params->minor_ver;
=20
-    ctx =3D dpy_gl_ctx_create(g->scanout[scanout_idx].con, &qparams);
+    ctx =3D dpy_gl_ctx_create(g->parent_obj.scanout[scanout_idx].con, &q=
params);
     return (virgl_renderer_gl_context)ctx;
 }
=20
@@ -533,7 +535,7 @@ static void virgl_destroy_context(void *opaque, virgl=
_renderer_gl_context ctx)
     VirtIOGPU *g =3D opaque;
     QEMUGLContext qctx =3D (QEMUGLContext)ctx;
=20
-    dpy_gl_ctx_destroy(g->scanout[0].con, qctx);
+    dpy_gl_ctx_destroy(g->parent_obj.scanout[0].con, qctx);
 }
=20
 static int virgl_make_context_current(void *opaque, int scanout_idx,
@@ -542,7 +544,8 @@ static int virgl_make_context_current(void *opaque, i=
nt scanout_idx,
     VirtIOGPU *g =3D opaque;
     QEMUGLContext qctx =3D (QEMUGLContext)ctx;
=20
-    return dpy_gl_ctx_make_current(g->scanout[scanout_idx].con, qctx);
+    return dpy_gl_ctx_make_current(g->parent_obj.scanout[scanout_idx].co=
n,
+                                   qctx);
 }
=20
 static struct virgl_renderer_callbacks virtio_gpu_3d_cbs =3D {
@@ -594,11 +597,11 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
     int i;
=20
     /* virgl_renderer_reset() ??? */
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
+    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
         if (i !=3D 0) {
-            dpy_gfx_replace_surface(g->scanout[i].con, NULL);
+            dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
         }
-        dpy_gl_scanout_disable(g->scanout[i].con);
+        dpy_gl_scanout_disable(g->parent_obj.scanout[i].con);
     }
 }
=20
@@ -614,7 +617,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  virtio_gpu_fence_poll, g);
=20
-    if (virtio_gpu_stats_enabled(g->conf)) {
+    if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         g->print_stats =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                       virtio_gpu_print_stats, g);
         timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) =
+ 1000);
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
new file mode 100644
index 0000000000..55e07995fe
--- /dev/null
+++ b/hw/display/virtio-gpu-base.c
@@ -0,0 +1,268 @@
+/*
+ * Virtio GPU Device
+ *
+ * Copyright Red Hat, Inc. 2013-2014
+ *
+ * Authors:
+ *     Dave Airlie <airlied@redhat.com>
+ *     Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio-gpu.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+
+void
+virtio_gpu_base_reset(VirtIOGPUBase *g)
+{
+    int i;
+
+    g->enable =3D 0;
+    g->use_virgl_renderer =3D false;
+
+    for (i =3D 0; i < g->conf.max_outputs; i++) {
+        g->scanout[i].resource_id =3D 0;
+        g->scanout[i].width =3D 0;
+        g->scanout[i].height =3D 0;
+        g->scanout[i].x =3D 0;
+        g->scanout[i].y =3D 0;
+        g->scanout[i].ds =3D NULL;
+    }
+}
+
+void
+virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
+                                  struct virtio_gpu_resp_display_info *d=
py_info)
+{
+    int i;
+
+    for (i =3D 0; i < g->conf.max_outputs; i++) {
+        if (g->enabled_output_bitmask & (1 << i)) {
+            dpy_info->pmodes[i].enabled =3D 1;
+            dpy_info->pmodes[i].r.width =3D cpu_to_le32(g->req_state[i].=
width);
+            dpy_info->pmodes[i].r.height =3D cpu_to_le32(g->req_state[i]=
.height);
+        }
+    }
+}
+
+static void virtio_gpu_invalidate_display(void *opaque)
+{
+}
+
+static void virtio_gpu_update_display(void *opaque)
+{
+}
+
+static void virtio_gpu_text_update(void *opaque, console_ch_t *chardata)
+{
+}
+
+static void virtio_gpu_notify_event(VirtIOGPUBase *g, uint32_t event_typ=
e)
+{
+    g->virtio_config.events_read |=3D event_type;
+    virtio_notify_config(&g->parent_obj);
+}
+
+static int virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *in=
fo)
+{
+    VirtIOGPUBase *g =3D opaque;
+
+    if (idx >=3D g->conf.max_outputs) {
+        return -1;
+    }
+
+    g->req_state[idx].x =3D info->xoff;
+    g->req_state[idx].y =3D info->yoff;
+    g->req_state[idx].width =3D info->width;
+    g->req_state[idx].height =3D info->height;
+
+    if (info->width && info->height) {
+        g->enabled_output_bitmask |=3D (1 << idx);
+    } else {
+        g->enabled_output_bitmask &=3D ~(1 << idx);
+    }
+
+    /* send event to guest */
+    virtio_gpu_notify_event(g, VIRTIO_GPU_EVENT_DISPLAY);
+    return 0;
+}
+
+static void
+virtio_gpu_gl_block(void *opaque, bool block)
+{
+    VirtIOGPUBase *g =3D opaque;
+    VirtIOGPUBaseClass *vgc =3D VIRTIO_GPU_BASE_GET_CLASS(g);
+
+    if (block) {
+        g->renderer_blocked++;
+    } else {
+        g->renderer_blocked--;
+    }
+    assert(g->renderer_blocked >=3D 0);
+
+    if (g->renderer_blocked =3D=3D 0) {
+        vgc->gl_unblock(g);
+    }
+}
+
+const GraphicHwOps virtio_gpu_ops =3D {
+    .invalidate =3D virtio_gpu_invalidate_display,
+    .gfx_update =3D virtio_gpu_update_display,
+    .text_update =3D virtio_gpu_text_update,
+    .ui_info =3D virtio_gpu_ui_info,
+    .gl_block =3D virtio_gpu_gl_block,
+};
+
+bool
+virtio_gpu_base_device_realize(DeviceState *qdev,
+                               VirtIOHandleOutput ctrl_cb,
+                               VirtIOHandleOutput cursor_cb,
+                               Error **errp)
+{
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(qdev);
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(qdev);
+    Error *local_err =3D NULL;
+    int i;
+
+    if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
+        error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCAN=
OUTS);
+        return false;
+    }
+
+    g->use_virgl_renderer =3D false;
+    if (virtio_gpu_virgl_enabled(g->conf)) {
+        error_setg(&g->migration_blocker, "virgl is not yet migratable")=
;
+        migrate_add_blocker(g->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_free(g->migration_blocker);
+            return false;
+        }
+    }
+
+    g->virtio_config.num_scanouts =3D cpu_to_le32(g->conf.max_outputs);
+    virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
+                sizeof(struct virtio_gpu_config));
+
+    if (virtio_gpu_virgl_enabled(g->conf)) {
+        /* use larger control queue in 3d mode */
+        virtio_add_queue(vdev, 256, ctrl_cb);
+        virtio_add_queue(vdev, 16, cursor_cb);
+    } else {
+        virtio_add_queue(vdev, 64, ctrl_cb);
+        virtio_add_queue(vdev, 16, cursor_cb);
+    }
+
+    g->enabled_output_bitmask =3D 1;
+
+    g->req_state[0].width =3D g->conf.xres;
+    g->req_state[0].height =3D g->conf.yres;
+
+    for (i =3D 0; i < g->conf.max_outputs; i++) {
+        g->scanout[i].con =3D
+            graphic_console_init(DEVICE(g), i, &virtio_gpu_ops, g);
+        if (i > 0) {
+            dpy_gfx_replace_surface(g->scanout[i].con, NULL);
+        }
+    }
+
+    return true;
+}
+
+static uint64_t
+virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
+                             Error **errp)
+{
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
+
+    if (virtio_gpu_virgl_enabled(g->conf)) {
+        features |=3D (1 << VIRTIO_GPU_F_VIRGL);
+    }
+    if (virtio_gpu_edid_enabled(g->conf)) {
+        features |=3D (1 << VIRTIO_GPU_F_EDID);
+    }
+
+    return features;
+}
+
+static void
+virtio_gpu_base_set_features(VirtIODevice *vdev, uint64_t features)
+{
+    static const uint32_t virgl =3D (1 << VIRTIO_GPU_F_VIRGL);
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
+
+    g->use_virgl_renderer =3D ((features & virgl) =3D=3D virgl);
+    trace_virtio_gpu_features(g->use_virgl_renderer);
+}
+
+static void
+virtio_gpu_base_device_unrealize(DeviceState *qdev, Error **errp)
+{
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(qdev);
+
+    if (g->migration_blocker) {
+        migrate_del_blocker(g->migration_blocker);
+        error_free(g->migration_blocker);
+    }
+}
+
+static void
+virtio_gpu_base_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+
+    vdc->unrealize =3D virtio_gpu_base_device_unrealize;
+    vdc->get_features =3D virtio_gpu_base_get_features;
+    vdc->set_features =3D virtio_gpu_base_set_features;
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->hotpluggable =3D false;
+}
+
+static const TypeInfo virtio_gpu_base_info =3D {
+    .name =3D TYPE_VIRTIO_GPU_BASE,
+    .parent =3D TYPE_VIRTIO_DEVICE,
+    .instance_size =3D sizeof(VirtIOGPUBase),
+    .class_size =3D sizeof(VirtIOGPUBaseClass),
+    .class_init =3D virtio_gpu_base_class_init,
+    .abstract =3D true
+};
+
+static void
+virtio_register_types(void)
+{
+    type_register_static(&virtio_gpu_base_info);
+}
+
+type_init(virtio_register_types)
+
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctrl_hdr)                !=3D=
 24);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_update_cursor)           !=3D=
 56);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_unref)          !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_create_2d)      !=3D=
 40);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_set_scanout)             !=3D=
 48);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_flush)          !=3D=
 48);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_transfer_to_host_2d)     !=3D=
 56);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_mem_entry)               !=3D=
 16);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_attach_backing) !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_detach_backing) !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resp_display_info)       !=3D=
 408);
+
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_transfer_host_3d)        !=3D=
 72);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_create_3d)      !=3D=
 72);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctx_create)              !=3D=
 96);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctx_destroy)             !=3D=
 24);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctx_resource)            !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_cmd_submit)              !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_get_capset_info)         !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resp_capset_info)        !=3D=
 40);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_get_capset)              !=3D=
 32);
+QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resp_capset)             !=3D=
 24);
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index bdcd33c925..305ea5fff3 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -41,7 +41,7 @@ static Property virtio_gpu_pci_properties[] =3D {
 static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
 {
     VirtIOGPUPCI *vgpu =3D VIRTIO_GPU_PCI(vpci_dev);
-    VirtIOGPU *g =3D &vgpu->vdev;
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vgpu->vdev);
     DeviceState *vdev =3D DEVICE(&vgpu->vdev);
     int i;
     Error *local_error =3D NULL;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c35025b6fb..b0a71537b9 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -23,9 +23,9 @@
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/display/edid.h"
-#include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
=20
 #define VIRTIO_GPU_VM_VERSION 1
=20
@@ -39,7 +39,7 @@ static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
 #include <virglrenderer.h>
 #define VIRGL(_g, _virgl, _simple, ...)                     \
     do {                                                    \
-        if (_g->use_virgl_renderer) {                       \
+        if (_g->parent_obj.use_virgl_renderer) {            \
             _virgl(__VA_ARGS__);                            \
         } else {                                            \
             _simple(__VA_ARGS__);                           \
@@ -107,10 +107,10 @@ static void update_cursor(VirtIOGPU *g, struct virt=
io_gpu_update_cursor *cursor)
     struct virtio_gpu_scanout *s;
     bool move =3D cursor->hdr.type =3D=3D VIRTIO_GPU_CMD_MOVE_CURSOR;
=20
-    if (cursor->pos.scanout_id >=3D g->conf.max_outputs) {
+    if (cursor->pos.scanout_id >=3D g->parent_obj.conf.max_outputs) {
         return;
     }
-    s =3D &g->scanout[cursor->pos.scanout_id];
+    s =3D &g->parent_obj.scanout[cursor->pos.scanout_id];
=20
     trace_virtio_gpu_update_cursor(cursor->pos.scanout_id,
                                    cursor->pos.x,
@@ -141,53 +141,6 @@ static void update_cursor(VirtIOGPU *g, struct virti=
o_gpu_update_cursor *cursor)
                   cursor->resource_id ? 1 : 0);
 }
=20
-static void virtio_gpu_get_config(VirtIODevice *vdev, uint8_t *config)
-{
-    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
-    memcpy(config, &g->virtio_config, sizeof(g->virtio_config));
-}
-
-static void virtio_gpu_set_config(VirtIODevice *vdev, const uint8_t *con=
fig)
-{
-    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
-    struct virtio_gpu_config vgconfig;
-
-    memcpy(&vgconfig, config, sizeof(g->virtio_config));
-
-    if (vgconfig.events_clear) {
-        g->virtio_config.events_read &=3D ~vgconfig.events_clear;
-    }
-}
-
-static uint64_t virtio_gpu_get_features(VirtIODevice *vdev, uint64_t fea=
tures,
-                                        Error **errp)
-{
-    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
-
-    if (virtio_gpu_virgl_enabled(g->conf)) {
-        features |=3D (1 << VIRTIO_GPU_F_VIRGL);
-    }
-    if (virtio_gpu_edid_enabled(g->conf)) {
-        features |=3D (1 << VIRTIO_GPU_F_EDID);
-    }
-    return features;
-}
-
-static void virtio_gpu_set_features(VirtIODevice *vdev, uint64_t feature=
s)
-{
-    static const uint32_t virgl =3D (1 << VIRTIO_GPU_F_VIRGL);
-    VirtIOGPU *g =3D VIRTIO_GPU(vdev);
-
-    g->use_virgl_renderer =3D ((features & virgl) =3D=3D virgl);
-    trace_virtio_gpu_features(g->use_virgl_renderer);
-}
-
-static void virtio_gpu_notify_event(VirtIOGPU *g, uint32_t event_type)
-{
-    g->virtio_config.events_read |=3D event_type;
-    virtio_notify_config(&g->parent_obj);
-}
-
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
 {
@@ -236,21 +189,6 @@ void virtio_gpu_ctrl_response_nodata(VirtIOGPU *g,
     virtio_gpu_ctrl_response(g, cmd, &resp, sizeof(resp));
 }
=20
-static void
-virtio_gpu_fill_display_info(VirtIOGPU *g,
-                             struct virtio_gpu_resp_display_info *dpy_in=
fo)
-{
-    int i;
-
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
-        if (g->enabled_output_bitmask & (1 << i)) {
-            dpy_info->pmodes[i].enabled =3D 1;
-            dpy_info->pmodes[i].r.width =3D cpu_to_le32(g->req_state[i].=
width);
-            dpy_info->pmodes[i].r.height =3D cpu_to_le32(g->req_state[i]=
.height);
-        }
-    }
-}
-
 void virtio_gpu_get_display_info(VirtIOGPU *g,
                                  struct virtio_gpu_ctrl_command *cmd)
 {
@@ -259,7 +197,7 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
     trace_virtio_gpu_cmd_get_display_info();
     memset(&display_info, 0, sizeof(display_info));
     display_info.hdr.type =3D VIRTIO_GPU_RESP_OK_DISPLAY_INFO;
-    virtio_gpu_fill_display_info(g, &display_info);
+    virtio_gpu_base_fill_display_info(VIRTIO_GPU_BASE(g), &display_info)=
;
     virtio_gpu_ctrl_response(g, cmd, &display_info.hdr,
                              sizeof(display_info));
 }
@@ -268,9 +206,10 @@ static void
 virtio_gpu_generate_edid(VirtIOGPU *g, int scanout,
                          struct virtio_gpu_resp_edid *edid)
 {
+    VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(g);
     qemu_edid_info info =3D {
-        .prefx =3D g->req_state[scanout].width,
-        .prefy =3D g->req_state[scanout].height,
+        .prefx =3D b->req_state[scanout].width,
+        .prefy =3D b->req_state[scanout].height,
     };
=20
     edid->size =3D cpu_to_le32(sizeof(edid->edid));
@@ -282,11 +221,12 @@ void virtio_gpu_get_edid(VirtIOGPU *g,
 {
     struct virtio_gpu_resp_edid edid;
     struct virtio_gpu_cmd_get_edid get_edid;
+    VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(g);
=20
     VIRTIO_GPU_FILL_CMD(get_edid);
     virtio_gpu_bswap_32(&get_edid, sizeof(get_edid));
=20
-    if (get_edid.scanout >=3D g->conf.max_outputs) {
+    if (get_edid.scanout >=3D b->conf.max_outputs) {
         cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
@@ -379,7 +319,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
     }
=20
     res->hostmem =3D calc_image_hostmem(pformat, c2d.width, c2d.height);
-    if (res->hostmem + g->hostmem < g->conf.max_hostmem) {
+    if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
         res->image =3D pixman_image_create_bits(pformat,
                                               c2d.width,
                                               c2d.height,
@@ -401,7 +341,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *=
g,
=20
 static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
-    struct virtio_gpu_scanout *scanout =3D &g->scanout[scanout_id];
+    struct virtio_gpu_scanout *scanout =3D &g->parent_obj.scanout[scanou=
t_id];
     struct virtio_gpu_simple_resource *res;
     DisplaySurface *ds =3D NULL;
=20
@@ -433,7 +373,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
     int i;
=20
     if (res->scanout_bitmask) {
-        for (i =3D 0; i < g->conf.max_outputs; i++) {
+        for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
             if (res->scanout_bitmask & (1 << i)) {
                 virtio_gpu_disable_scanout(g, i);
             }
@@ -563,7 +503,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
=20
     pixman_region_init_rect(&flush_region,
                             rf.r.x, rf.r.y, rf.r.width, rf.r.height);
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
+    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
         struct virtio_gpu_scanout *scanout;
         pixman_region16_t region, finalregion;
         pixman_box16_t *extents;
@@ -571,7 +511,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
         if (!(res->scanout_bitmask & (1 << i))) {
             continue;
         }
-        scanout =3D &g->scanout[i];
+        scanout =3D &g->parent_obj.scanout[i];
=20
         pixman_region_init(&finalregion);
         pixman_region_init_rect(&region, scanout->x, scanout->y,
@@ -581,7 +521,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
         pixman_region_translate(&finalregion, -scanout->x, -scanout->y);
         extents =3D pixman_region_extents(&finalregion);
         /* work out the area we need to update for each console */
-        dpy_gfx_update(g->scanout[i].con,
+        dpy_gfx_update(g->parent_obj.scanout[i].con,
                        extents->x1, extents->y1,
                        extents->x2 - extents->x1,
                        extents->y2 - extents->y1);
@@ -612,14 +552,14 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss=
.r.y);
=20
-    if (ss.scanout_id >=3D g->conf.max_outputs) {
+    if (ss.scanout_id >=3D g->parent_obj.conf.max_outputs) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified=
 %d",
                       __func__, ss.scanout_id);
         cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
         return;
     }
=20
-    g->enable =3D 1;
+    g->parent_obj.enable =3D 1;
     if (ss.resource_id =3D=3D 0) {
         virtio_gpu_disable_scanout(g, ss.scanout_id);
         return;
@@ -648,7 +588,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
         return;
     }
=20
-    scanout =3D &g->scanout[ss.scanout_id];
+    scanout =3D &g->parent_obj.scanout[ss.scanout_id];
=20
     format =3D pixman_image_get_format(res->image);
     bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
@@ -671,7 +611,8 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
             return;
         }
         pixman_image_unref(rect);
-        dpy_gfx_replace_surface(g->scanout[ss.scanout_id].con, scanout->=
ds);
+        dpy_gfx_replace_surface(g->parent_obj.scanout[ss.scanout_id].con=
,
+                                scanout->ds);
     }
=20
     ores =3D virtio_gpu_find_resource(g, scanout->resource_id);
@@ -889,7 +830,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
=20
-        if (g->renderer_blocked) {
+        if (g->parent_obj.renderer_blocked) {
             break;
         }
=20
@@ -898,14 +839,14 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
               g, cmd);
=20
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
-        if (virtio_gpu_stats_enabled(g->conf)) {
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             g->stats.requests++;
         }
=20
         if (!cmd->finished) {
             QTAILQ_INSERT_TAIL(&g->fenceq, cmd, next);
             g->inflight++;
-            if (virtio_gpu_stats_enabled(g->conf)) {
+            if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
                 if (g->stats.max_inflight < g->inflight) {
                     g->stats.max_inflight =3D g->inflight;
                 }
@@ -917,6 +858,19 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
     }
 }
=20
+static void virtio_gpu_gl_unblock(VirtIOGPUBase *b)
+{
+    VirtIOGPU *g =3D VIRTIO_GPU(b);
+
+#ifdef CONFIG_VIRGL
+    if (g->renderer_reset) {
+        g->renderer_reset =3D false;
+        virtio_gpu_virgl_reset(g);
+    }
+#endif
+    virtio_gpu_process_cmdq(g);
+}
+
 static void virtio_gpu_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOGPU *g =3D VIRTIO_GPU(vdev);
@@ -927,7 +881,7 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
, VirtQueue *vq)
     }
=20
 #ifdef CONFIG_VIRGL
-    if (!g->renderer_inited && g->use_virgl_renderer) {
+    if (!g->renderer_inited && g->parent_obj.use_virgl_renderer) {
         virtio_gpu_virgl_init(g);
         g->renderer_inited =3D true;
     }
@@ -945,7 +899,7 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
, VirtQueue *vq)
     virtio_gpu_process_cmdq(g);
=20
 #ifdef CONFIG_VIRGL
-    if (g->use_virgl_renderer) {
+    if (g->parent_obj.use_virgl_renderer) {
         virtio_gpu_virgl_fence_poll(g);
     }
 #endif
@@ -954,7 +908,7 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev=
, VirtQueue *vq)
 static void virtio_gpu_ctrl_bh(void *opaque)
 {
     VirtIOGPU *g =3D opaque;
-    virtio_gpu_handle_ctrl(&g->parent_obj, g->ctrl_vq);
+    virtio_gpu_handle_ctrl(&g->parent_obj.parent_obj, g->ctrl_vq);
 }
=20
 static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
@@ -992,75 +946,9 @@ static void virtio_gpu_handle_cursor(VirtIODevice *v=
dev, VirtQueue *vq)
 static void virtio_gpu_cursor_bh(void *opaque)
 {
     VirtIOGPU *g =3D opaque;
-    virtio_gpu_handle_cursor(&g->parent_obj, g->cursor_vq);
-}
-
-static void virtio_gpu_invalidate_display(void *opaque)
-{
+    virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
=20
-static void virtio_gpu_update_display(void *opaque)
-{
-}
-
-static void virtio_gpu_text_update(void *opaque, console_ch_t *chardata)
-{
-}
-
-static int virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *in=
fo)
-{
-    VirtIOGPU *g =3D opaque;
-
-    if (idx >=3D g->conf.max_outputs) {
-        return -1;
-    }
-
-    g->req_state[idx].x =3D info->xoff;
-    g->req_state[idx].y =3D info->yoff;
-    g->req_state[idx].width =3D info->width;
-    g->req_state[idx].height =3D info->height;
-
-    if (info->width && info->height) {
-        g->enabled_output_bitmask |=3D (1 << idx);
-    } else {
-        g->enabled_output_bitmask &=3D ~(1 << idx);
-    }
-
-    /* send event to guest */
-    virtio_gpu_notify_event(g, VIRTIO_GPU_EVENT_DISPLAY);
-    return 0;
-}
-
-static void virtio_gpu_gl_block(void *opaque, bool block)
-{
-    VirtIOGPU *g =3D opaque;
-
-    if (block) {
-        g->renderer_blocked++;
-    } else {
-        g->renderer_blocked--;
-    }
-    assert(g->renderer_blocked >=3D 0);
-
-    if (g->renderer_blocked =3D=3D 0) {
-#ifdef CONFIG_VIRGL
-        if (g->renderer_reset) {
-            g->renderer_reset =3D false;
-            virtio_gpu_virgl_reset(g);
-        }
-#endif
-        virtio_gpu_process_cmdq(g);
-    }
-}
-
-const GraphicHwOps virtio_gpu_ops =3D {
-    .invalidate =3D virtio_gpu_invalidate_display,
-    .gfx_update =3D virtio_gpu_update_display,
-    .text_update =3D virtio_gpu_text_update,
-    .ui_info =3D virtio_gpu_ui_info,
-    .gl_block =3D virtio_gpu_gl_block,
-};
-
 static const VMStateDescription vmstate_virtio_gpu_scanout =3D {
     .name =3D "virtio-gpu-one-scanout",
     .version_id =3D 1,
@@ -1083,10 +971,11 @@ static const VMStateDescription vmstate_virtio_gpu=
_scanouts =3D {
     .name =3D "virtio-gpu-scanouts",
     .version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_INT32(enable, struct VirtIOGPU),
-        VMSTATE_UINT32_EQUAL(conf.max_outputs, struct VirtIOGPU, NULL),
-        VMSTATE_STRUCT_VARRAY_UINT32(scanout, struct VirtIOGPU,
-                                     conf.max_outputs, 1,
+        VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
+        VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
+                             struct VirtIOGPU, NULL),
+        VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGP=
U,
+                                     parent_obj.conf.max_outputs, 1,
                                      vmstate_virtio_gpu_scanout,
                                      struct virtio_gpu_scanout),
         VMSTATE_END_OF_LIST()
@@ -1201,8 +1090,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaqu=
e, size_t size,
=20
     /* load & apply scanout state */
     vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
-        scanout =3D &g->scanout[i];
+    for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
+        scanout =3D &g->parent_obj.scanout[i];
         if (!scanout->resource_id) {
             continue;
         }
@@ -1231,84 +1120,35 @@ static void virtio_gpu_device_realize(DeviceState=
 *qdev, Error **errp)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(qdev);
     VirtIOGPU *g =3D VIRTIO_GPU(qdev);
     bool have_virgl;
-    Error *local_err =3D NULL;
-    int i;
=20
-    if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
-        error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCAN=
OUTS);
-        return;
-    }
-
-    g->use_virgl_renderer =3D false;
 #if !defined(CONFIG_VIRGL) || defined(HOST_WORDS_BIGENDIAN)
     have_virgl =3D false;
 #else
     have_virgl =3D display_opengl;
 #endif
     if (!have_virgl) {
-        g->conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
-    }
-
-    if (virtio_gpu_virgl_enabled(g->conf)) {
-        error_setg(&g->migration_blocker, "virgl is not yet migratable")=
;
-        migrate_add_blocker(g->migration_blocker, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            error_free(g->migration_blocker);
-            return;
-        }
+        g->parent_obj.conf.flags &=3D ~(1 << VIRTIO_GPU_FLAG_VIRGL_ENABL=
ED);
     }
=20
-    g->virtio_config.num_scanouts =3D cpu_to_le32(g->conf.max_outputs);
-    virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
-                sizeof(struct virtio_gpu_config));
-
-    g->req_state[0].width =3D g->conf.xres;
-    g->req_state[0].height =3D g->conf.yres;
-
-    if (virtio_gpu_virgl_enabled(g->conf)) {
-        /* use larger control queue in 3d mode */
-        g->ctrl_vq   =3D virtio_add_queue(vdev, 256, virtio_gpu_handle_c=
trl_cb);
-        g->cursor_vq =3D virtio_add_queue(vdev, 16, virtio_gpu_handle_cu=
rsor_cb);
-
 #if defined(CONFIG_VIRGL)
-        g->virtio_config.num_capsets =3D virtio_gpu_virgl_get_num_capset=
s(g);
-#else
-        g->virtio_config.num_capsets =3D 0;
+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =3D
+        virtio_gpu_virgl_get_num_capsets(g);
 #endif
-    } else {
-        g->ctrl_vq   =3D virtio_add_queue(vdev, 64, virtio_gpu_handle_ct=
rl_cb);
-        g->cursor_vq =3D virtio_add_queue(vdev, 16, virtio_gpu_handle_cu=
rsor_cb);
+
+    if (!virtio_gpu_base_device_realize(qdev,
+                                        virtio_gpu_handle_ctrl_cb,
+                                        virtio_gpu_handle_cursor_cb,
+                                        errp)) {
+        return;
     }
=20
+    g->ctrl_vq =3D virtio_get_queue(vdev, 0);
+    g->cursor_vq =3D virtio_get_queue(vdev, 1);
     g->ctrl_bh =3D qemu_bh_new(virtio_gpu_ctrl_bh, g);
     g->cursor_bh =3D qemu_bh_new(virtio_gpu_cursor_bh, g);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
     QTAILQ_INIT(&g->fenceq);
-
-    g->enabled_output_bitmask =3D 1;
-
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
-        g->scanout[i].con =3D
-            graphic_console_init(DEVICE(g), i, &virtio_gpu_ops, g);
-        if (i > 0) {
-            dpy_gfx_replace_surface(g->scanout[i].con, NULL);
-        }
-    }
-}
-
-static void virtio_gpu_device_unrealize(DeviceState *qdev, Error **errp)
-{
-    VirtIOGPU *g =3D VIRTIO_GPU(qdev);
-    if (g->migration_blocker) {
-        migrate_del_blocker(g->migration_blocker);
-        error_free(g->migration_blocker);
-    }
-}
-
-static void virtio_gpu_instance_init(Object *obj)
-{
 }
=20
 static void virtio_gpu_reset(VirtIODevice *vdev)
@@ -1316,21 +1156,16 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
     VirtIOGPU *g =3D VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
     struct virtio_gpu_ctrl_command *cmd;
-    int i;
=20
-    g->enable =3D 0;
+#ifdef CONFIG_VIRGL
+    if (g->parent_obj.use_virgl_renderer) {
+        virtio_gpu_virgl_reset(g);
+    }
+#endif
=20
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
         virtio_gpu_resource_destroy(g, res);
     }
-    for (i =3D 0; i < g->conf.max_outputs; i++) {
-        g->scanout[i].resource_id =3D 0;
-        g->scanout[i].width =3D 0;
-        g->scanout[i].height =3D 0;
-        g->scanout[i].x =3D 0;
-        g->scanout[i].y =3D 0;
-        g->scanout[i].ds =3D NULL;
-    }
=20
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
@@ -1346,15 +1181,37 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
     }
=20
 #ifdef CONFIG_VIRGL
-    if (g->use_virgl_renderer) {
-        if (g->renderer_blocked) {
+    if (g->parent_obj.use_virgl_renderer) {
+        if (g->parent_obj.renderer_blocked) {
             g->renderer_reset =3D true;
         } else {
             virtio_gpu_virgl_reset(g);
         }
-        g->use_virgl_renderer =3D 0;
+        g->parent_obj.use_virgl_renderer =3D false;
     }
 #endif
+
+    virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
+}
+
+static void
+virtio_gpu_get_config(VirtIODevice *vdev, uint8_t *config)
+{
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
+
+    memcpy(config, &g->virtio_config, sizeof(g->virtio_config));
+}
+
+static void
+virtio_gpu_set_config(VirtIODevice *vdev, const uint8_t *config)
+{
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(vdev);
+    const struct virtio_gpu_config *vgconfig =3D
+        (const struct virtio_gpu_config *)config;
+
+    if (vgconfig->events_clear) {
+        g->virtio_config.events_read &=3D ~vgconfig->events_clear;
+    }
 }
=20
 /*
@@ -1385,18 +1242,15 @@ static const VMStateDescription vmstate_virtio_gp=
u =3D {
 };
=20
 static Property virtio_gpu_properties[] =3D {
-    DEFINE_PROP_UINT32("max_outputs", VirtIOGPU, conf.max_outputs, 1),
-    DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf.max_hostmem, 256 * M=
iB),
+    VIRTIO_GPU_BASE_PROPERTIES(VirtIOGPU, parent_obj.conf),
+    DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf_max_hostmem,
+                     256 * MiB),
 #ifdef CONFIG_VIRGL
-    DEFINE_PROP_BIT("virgl", VirtIOGPU, conf.flags,
+    DEFINE_PROP_BIT("virgl", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VIRGL_ENABLED, true),
-    DEFINE_PROP_BIT("stats", VirtIOGPU, conf.flags,
+    DEFINE_PROP_BIT("stats", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
 #endif
-    DEFINE_PROP_BIT("edid", VirtIOGPU, conf.flags,
-                    VIRTIO_GPU_FLAG_EDID_ENABLED, false),
-    DEFINE_PROP_UINT32("xres", VirtIOGPU, conf.xres, 1024),
-    DEFINE_PROP_UINT32("yres", VirtIOGPU, conf.yres, 768),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1404,27 +1258,22 @@ static void virtio_gpu_class_init(ObjectClass *kl=
ass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
+    VirtIOGPUBaseClass *vgc =3D VIRTIO_GPU_BASE_CLASS(klass);
=20
+    vgc->gl_unblock =3D virtio_gpu_gl_unblock;
     vdc->realize =3D virtio_gpu_device_realize;
-    vdc->unrealize =3D virtio_gpu_device_unrealize;
+    vdc->reset =3D virtio_gpu_reset;
     vdc->get_config =3D virtio_gpu_get_config;
     vdc->set_config =3D virtio_gpu_set_config;
-    vdc->get_features =3D virtio_gpu_get_features;
-    vdc->set_features =3D virtio_gpu_set_features;
-
-    vdc->reset =3D virtio_gpu_reset;
=20
-    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->props =3D virtio_gpu_properties;
     dc->vmsd =3D &vmstate_virtio_gpu;
-    dc->hotpluggable =3D false;
+    dc->props =3D virtio_gpu_properties;
 }
=20
 static const TypeInfo virtio_gpu_info =3D {
     .name =3D TYPE_VIRTIO_GPU,
-    .parent =3D TYPE_VIRTIO_DEVICE,
+    .parent =3D TYPE_VIRTIO_GPU_BASE,
     .instance_size =3D sizeof(VirtIOGPU),
-    .instance_init =3D virtio_gpu_instance_init,
     .class_init =3D virtio_gpu_class_init,
 };
=20
@@ -1434,26 +1283,3 @@ static void virtio_register_types(void)
 }
=20
 type_init(virtio_register_types)
-
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctrl_hdr)                !=3D=
 24);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_update_cursor)           !=3D=
 56);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_unref)          !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_create_2d)      !=3D=
 40);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_set_scanout)             !=3D=
 48);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_flush)          !=3D=
 48);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_transfer_to_host_2d)     !=3D=
 56);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_mem_entry)               !=3D=
 16);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_attach_backing) !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_detach_backing) !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resp_display_info)       !=3D=
 408);
-
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_transfer_host_3d)        !=3D=
 72);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resource_create_3d)      !=3D=
 72);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctx_create)              !=3D=
 96);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctx_destroy)             !=3D=
 24);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_ctx_resource)            !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_cmd_submit)              !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_get_capset_info)         !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resp_capset_info)        !=3D=
 40);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_get_capset)              !=3D=
 32);
-QEMU_BUILD_BUG_ON(sizeof(struct virtio_gpu_resp_capset)             !=3D=
 24);
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index a2b803b75f..33af54d44f 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -32,8 +32,9 @@ typedef struct VirtIOVGAClass {
 static void virtio_vga_invalidate_display(void *opaque)
 {
     VirtIOVGA *vvga =3D opaque;
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
=20
-    if (vvga->vdev.enable) {
+    if (g->enable) {
         virtio_gpu_ops.invalidate(&vvga->vdev);
     } else {
         vvga->vga.hw_ops->invalidate(&vvga->vga);
@@ -43,8 +44,9 @@ static void virtio_vga_invalidate_display(void *opaque)
 static void virtio_vga_update_display(void *opaque)
 {
     VirtIOVGA *vvga =3D opaque;
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
=20
-    if (vvga->vdev.enable) {
+    if (g->enable) {
         virtio_gpu_ops.gfx_update(&vvga->vdev);
     } else {
         vvga->vga.hw_ops->gfx_update(&vvga->vga);
@@ -54,8 +56,9 @@ static void virtio_vga_update_display(void *opaque)
 static void virtio_vga_text_update(void *opaque, console_ch_t *chardata)
 {
     VirtIOVGA *vvga =3D opaque;
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
=20
-    if (vvga->vdev.enable) {
+    if (g->enable) {
         if (virtio_gpu_ops.text_update) {
             virtio_gpu_ops.text_update(&vvga->vdev, chardata);
         }
@@ -108,7 +111,7 @@ static const VMStateDescription vmstate_virtio_vga =3D=
 {
 static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOVGA *vvga =3D VIRTIO_VGA(vpci_dev);
-    VirtIOGPU *g =3D &vvga->vdev;
+    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
     VGACommonState *vga =3D &vvga->vga;
     Error *err =3D NULL;
     uint32_t offset;
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index dbd453ab1b..f1c46b8e3e 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -42,7 +42,7 @@ obj-$(CONFIG_VGA) +=3D vga.o
=20
 common-obj-$(CONFIG_QXL) +=3D qxl.o qxl-logger.o qxl-render.o
=20
-obj-$(CONFIG_VIRTIO_GPU) +=3D virtio-gpu.o virtio-gpu-3d.o
+obj-$(CONFIG_VIRTIO_GPU) +=3D virtio-gpu-base.o virtio-gpu.o virtio-gpu-=
3d.o
 obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) +=3D virtio-g=
pu-pci.o
 obj-$(CONFIG_VIRTIO_VGA) +=3D virtio-vga.o
 virtio-gpu.o-cflags :=3D $(VIRGL_CFLAGS)
--=20
2.21.0.313.ge35b8cb8e2
