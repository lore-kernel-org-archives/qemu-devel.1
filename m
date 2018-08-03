Received: from eggs.gnu.org ([2001:4830:134:3::10]:34525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1flc4a-0003ks-G2
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1flc4W-0003f6-G1
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:33:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1flc4W-0003eD-8y
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:32:56 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 17:32:35 +0200
Message-Id: <20180803153235.4134-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot with
 vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

With vga=3D775 on the Linux command line a first boot of the VM running
Linux works fine. After a warm reboot it crashes during Linux boot.

Before that, valgrind points out bad memory write to console
surface. The VGA code is not aware that virtio-gpu got a message
surface scanout when the display is disabled. Let's reset VGA graphic
mode when it is the case, so that a new display surface is created
when doing further VGA operations.

https://bugs.launchpad.net/qemu/+bug/1784900/

Reported-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu.c        |  5 +++++
 hw/display/virtio-vga.c        | 11 +++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 9780f755ef..d0321672f4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -125,6 +125,7 @@ typedef struct VirtIOGPU {
         uint32_t bytes_3d;
     } stats;
=20
+    void (*disable_scanout)(struct VirtIOGPU *g, int scanout_id);
     Error *migration_blocker;
 } VirtIOGPU;
=20
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ec366f4c35..3ddd29c0de 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -421,6 +421,11 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g,=
 int scanout_id)
                                          scanout->height ?: 480,
                                          "Guest disabled display.");
     }
+
+    if (g->disable_scanout) {
+        g->disable_scanout(g, scanout_id);
+    }
+
     dpy_gfx_replace_surface(scanout->con, ds);
     scanout->resource_id =3D 0;
     scanout->ds =3D NULL;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 2b36f2899a..672b7f9ce2 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -75,6 +75,16 @@ static void virtio_vga_gl_block(void *opaque, bool blo=
ck)
     }
 }
=20
+static void virtio_vga_disable_scanout(VirtIOGPU *g, int scanout_id)
+{
+    VirtIOVGA *vvga =3D container_of(g, VirtIOVGA, vdev);
+
+    if (scanout_id =3D=3D 0) {
+        /* reset surface if needed */
+        vvga->vga.graphic_mode =3D -1;
+    }
+}
+
 static const GraphicHwOps virtio_vga_ops =3D {
     .invalidate =3D virtio_vga_invalidate_display,
     .gfx_update =3D virtio_vga_update_display,
@@ -156,6 +166,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
                                  vvga->vga_mrs, true);
=20
     vga->con =3D g->scanout[0].con;
+    g->disable_scanout =3D virtio_vga_disable_scanout;
     graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
=20
     for (i =3D 0; i < g->conf.max_outputs; i++) {
--=20
2.18.0.547.g1d89318c48
