Received: from eggs.gnu.org ([209.51.188.92]:43446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmlm-0007tV-71
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmll-0003BR-2b
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmlk-00031t-N8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B25EC307D960
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:43:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:43:29 +0100
Message-Id: <20190221114330.17968-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190221114330.17968-1-marcandre.lureau@redhat.com>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] virtio-gpu: block both 2d and 3d rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Now that 2d commands are translated to 3d rendering, qemu must stop
sending 3d updates (from 2d) to Spice as well.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1674324

Cc: cfergeau@redhat.com
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu-3d.c     | 21 ---------------------
 hw/display/virtio-gpu.c        | 27 ++++++++++++++++++++++-----
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index a1cecd1df8..f8cd8ee96f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,7 +169,6 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd);
 void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
-void virtio_gpu_gl_block(void *opaque, bool block);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
 #endif
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index bc6e99c943..cb83479ed2 100644
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
index 8f4351420b..7ada4b83ac 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -889,12 +889,15 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
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
@@ -1030,14 +1033,28 @@ static int virtio_gpu_ui_info(void *opaque, uint3=
2_t idx, QemuUIInfo *info)
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
     .text_update =3D virtio_gpu_text_update,
     .ui_info =3D virtio_gpu_ui_info,
-#ifdef CONFIG_VIRGL
     .gl_block =3D virtio_gpu_gl_block,
-#endif
 };
=20
 static const VMStateDescription vmstate_virtio_gpu_scanout =3D {
--=20
2.21.0.rc1
