Received: from eggs.gnu.org ([2001:4830:134:3::10]:43473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4bC-00054I-QF
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4b9-0001lU-1Q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs4b8-0001l2-QR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:18 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 13:13:13 +0200
Message-Id: <20180821111313.27792-3-kraxel@redhat.com>
In-Reply-To: <20180821111313.27792-1-kraxel@redhat.com>
References: <20180821111313.27792-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] Revert "virtio-gpu: fix crashes upon warm
 reboot with vga mode"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This reverts commit 93f874fe9dbe0b997b5a9459840957efd13d7191.

Now with virtio-vga being resetted properly the
crash workaround is not needed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu.c        |  5 -----
 hw/display/virtio-vga.c        | 11 -----------
 3 files changed, 17 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a718b7233f..2374f022e8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -125,7 +125,6 @@ typedef struct VirtIOGPU {
         uint32_t bytes_3d;
     } stats;
 
-    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
     Error *migration_blocker;
 } VirtIOGPU;
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d6c9b02b86..1cc953006f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -421,11 +421,6 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
                                          scanout->height ?: 480,
                                          "Guest disabled display.");
     }
-
-    if (g->disable_scanout) {
-        g->disable_scanout(g, scanout_id);
-    }
-
     dpy_gfx_replace_surface(scanout->con, ds);
     scanout->resource_id = 0;
     scanout->ds = NULL;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 50c72f26f4..1e601c1a3b 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -75,16 +75,6 @@ static void virtio_vga_gl_block(void *opaque, bool block)
     }
 }
 
-static void virtio_vga_disable_scanout(VirtIOGPU *g, int scanout_id)
-{
-    VirtIOVGA *vvga = container_of(g, VirtIOVGA, vdev);
-
-    if (scanout_id == 0) {
-        /* reset surface if needed */
-        vvga->vga.graphic_mode = -1;
-    }
-}
-
 static const GraphicHwOps virtio_vga_ops = {
     .invalidate = virtio_vga_invalidate_display,
     .gfx_update = virtio_vga_update_display,
@@ -166,7 +156,6 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                                  vvga->vga_mrs, true);
 
     vga->con = g->scanout[0].con;
-    g->disable_scanout = virtio_vga_disable_scanout;
     graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
 
     for (i = 0; i < g->conf.max_outputs; i++) {
-- 
2.9.3
