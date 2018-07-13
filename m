Received: from eggs.gnu.org ([2001:4830:134:3::10]:41428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxq1-0004bi-Gr
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxq0-0005nC-69
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpz-0005iO-8E
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA1D5C12AC
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:10:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:12 +0200
Message-Id: <20180713130916.4153-26-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 25/29] virtio-gpu: block both 2d and 3d
 rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now that 2d commands are translated to 3d rendering, qemu must stop
sending 3d updates (from 2d) to Spice as well.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu-3d.c     | 21 ---------------------
 hw/display/virtio-gpu.c        | 25 ++++++++++++++++++++++---
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 4c68bc4559..763e1291f1 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -166,7 +166,6 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd);
 void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
-void virtio_gpu_gl_block(void *opaque, bool block);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
 #endif
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 3558f38fe8..6fee0e8582 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -404,11 +404,6 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
 {
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
=20
-    cmd->waiting =3D g->renderer_blocked;
-    if (cmd->waiting) {
-        return;
-    }
-
     virgl_renderer_force_ctx_0();
     switch (cmd->cmd_hdr.type) {
     case VIRTIO_GPU_CMD_CTX_CREATE:
@@ -604,22 +599,6 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
     }
 }
=20
-void virtio_gpu_gl_block(void *opaque, bool block)
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
-        virtio_gpu_process_cmdq(g);
-    }
-}
-
 int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7cfb25879a..26a2592c4a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -840,12 +840,15 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
     while (!QTAILQ_EMPTY(&g->cmdq)) {
         cmd =3D QTAILQ_FIRST(&g->cmdq);
=20
-        /* process command */
-        VIRGL(g, virtio_gpu_virgl_process_cmd, virtio_gpu_simple_process=
_cmd,
-              g, cmd);
+        cmd->waiting =3D g->renderer_blocked;
         if (cmd->waiting) {
             break;
         }
+
+        /* process command */
+        VIRGL(g, virtio_gpu_virgl_process_cmd, virtio_gpu_simple_process=
_cmd,
+              g, cmd);
+
         QTAILQ_REMOVE(&g->cmdq, cmd, next);
         if (virtio_gpu_stats_enabled(g->conf)) {
             g->stats.requests++;
@@ -981,6 +984,22 @@ static int virtio_gpu_ui_info(void *opaque, uint32_t=
 idx, QemuUIInfo *info)
     return 0;
 }
=20
+static void virtio_gpu_gl_block(void *opaque, bool block)
+{
+    VirtIOGPU *g =3D opaque;
+
+    if (block) {
+        g->renderer_blocked++;
+    } else {
+        g->renderer_blocked--;
+    }
+    assert(g->renderer_blocked >=3D 0);
+
+    if (g->renderer_blocked =3D=3D 0) {
+        virtio_gpu_process_cmdq(g);
+    }
+}
+
 const GraphicHwOps virtio_gpu_ops =3D {
     .invalidate =3D virtio_gpu_invalidate_display,
     .gfx_update =3D virtio_gpu_update_display,
--=20
2.18.0.129.ge3331758f1
