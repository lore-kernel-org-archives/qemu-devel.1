Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996p-0002tH-KK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996o-00056b-Nz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996o-000560-FS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C864AE184D
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:51:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:28 +0200
Message-Id: <20170512115135.17379-4-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/10] virtio-gpu: move virtio_gpu_gl_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Move to virtio-gpu-3d.c where all the other virgl code lives too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170505104101.30589-2-kraxel@redhat.com
---
 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu-3d.c     | 16 ++++++++++++++++
 hw/display/virtio-gpu.c        | 18 ++----------------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index f3ffdceca4..83f474ffc3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -169,6 +169,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd);
 void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
+void virtio_gpu_gl_block(void *opaque, bool block);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
=20
 #endif
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index f49b7fe8cd..8c106a662d 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -600,6 +600,22 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
     }
 }
=20
+void virtio_gpu_gl_block(void *opaque, bool block)
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
 int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e1056f34df..cfb5dfa336 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -929,28 +929,14 @@ static int virtio_gpu_ui_info(void *opaque, uint32_=
t idx, QemuUIInfo *info)
     return 0;
 }
=20
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
-        virtio_gpu_process_cmdq(g);
-    }
-}
-
 const GraphicHwOps virtio_gpu_ops =3D {
     .invalidate =3D virtio_gpu_invalidate_display,
     .gfx_update =3D virtio_gpu_update_display,
     .text_update =3D virtio_gpu_text_update,
     .ui_info =3D virtio_gpu_ui_info,
+#ifdef CONFIG_VIRGL
     .gl_block =3D virtio_gpu_gl_block,
+#endif
 };
=20
 static const VMStateDescription vmstate_virtio_gpu_scanout =3D {
--=20
2.9.3
