Received: from eggs.gnu.org ([2001:4830:134:3::10]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio9-0001nH-KD
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio8-0008I1-JG
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Sep 2018 08:57:42 +0200
Message-Id: <20180903065745.23055-3-kraxel@redhat.com>
In-Reply-To: <20180903065745.23055-1-kraxel@redhat.com>
References: <20180903065745.23055-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] Revert "virtio-gpu: fix crashes upon warm
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
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>

This reverts commit 93f874fe9dbe0b997b5a9459840957efd13d7191.

Now with virtio-vga being resetted properly the
crash workaround is not needed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180821111313.27792-3-kraxel@redhat.com
---
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu.c        |  5 -----
 hw/display/virtio-vga.c        | 11 -----------
 3 files changed, 17 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index a718b7233f..2374f022e8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -125,7 +125,6 @@ typedef struct VirtIOGPU {
         uint32_t bytes_3d;
     } stats;
=20
-    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
     Error *migration_blocker;
 } VirtIOGPU;
=20
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d6c9b02b86..1cc953006f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -421,11 +421,6 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g,=
 int scanout_id)
                                          scanout->height ?: 480,
                                          "Guest disabled display.");
     }
-
-    if (g->disable_scanout) {
-        g->disable_scanout(g, scanout_id);
-    }
-
     dpy_gfx_replace_surface(scanout->con, ds);
     scanout->resource_id =3D 0;
     scanout->ds =3D NULL;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 50c72f26f4..1e601c1a3b 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -75,16 +75,6 @@ static void virtio_vga_gl_block(void *opaque, bool blo=
ck)
     }
 }
=20
-static void virtio_vga_disable_scanout(VirtIOGPU *g, int scanout_id)
-{
-    VirtIOVGA *vvga =3D container_of(g, VirtIOVGA, vdev);
-
-    if (scanout_id =3D=3D 0) {
-        /* reset surface if needed */
-        vvga->vga.graphic_mode =3D -1;
-    }
-}
-
 static const GraphicHwOps virtio_vga_ops =3D {
     .invalidate =3D virtio_vga_invalidate_display,
     .gfx_update =3D virtio_vga_update_display,
@@ -166,7 +156,6 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
                                  vvga->vga_mrs, true);
=20
     vga->con =3D g->scanout[0].con;
-    g->disable_scanout =3D virtio_vga_disable_scanout;
     graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
=20
     for (i =3D 0; i < g->conf.max_outputs; i++) {
--=20
2.9.3
