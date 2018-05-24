Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRG-0000LV-OC
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fLsRD-000309-4B
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:46:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fLsRD-0002zW-08
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3035440201A8
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:45:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 May 2018 17:45:54 +0200
Message-Id: <20180524154556.17876-6-kraxel@redhat.com>
In-Reply-To: <20180524154556.17876-1-kraxel@redhat.com>
References: <20180524154556.17876-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/7] bochs-display: add dirty tracking support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180522165058.15404-5-kraxel@redhat.com
---
 hw/display/bochs-display.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index a523e81d1d..9607df1c34 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -191,10 +191,13 @@ static int bochs_display_get_mode(BochsDisplayState=
 *s,
 static void bochs_display_update(void *opaque)
 {
     BochsDisplayState *s =3D opaque;
+    DirtyBitmapSnapshot *snap =3D NULL;
+    bool full_update =3D false;
     BochsDisplayMode mode;
     DisplaySurface *ds;
     uint8_t *ptr;
-    int ret;
+    bool dirty;
+    int y, ys, ret;
=20
     ret =3D bochs_display_get_mode(s, &mode);
     if (ret < 0) {
@@ -212,9 +215,34 @@ static void bochs_display_update(void *opaque)
                                              mode.stride,
                                              ptr + mode.offset);
         dpy_gfx_replace_surface(s->con, ds);
+        full_update =3D true;
     }
=20
-    dpy_gfx_update_full(s->con);
+    if (full_update) {
+        dpy_gfx_update_full(s->con);
+    } else {
+        snap =3D memory_region_snapshot_and_clear_dirty(&s->vram,
+                                                      mode.offset, mode.=
size,
+                                                      DIRTY_MEMORY_VGA);
+        ys =3D -1;
+        for (y =3D 0; y < mode.height; y++) {
+            dirty =3D memory_region_snapshot_get_dirty(&s->vram, snap,
+                                                     mode.offset + mode.=
stride * y,
+                                                     mode.stride);
+            if (dirty && ys < 0) {
+                ys =3D y;
+            }
+            if (!dirty && ys >=3D 0) {
+                dpy_gfx_update(s->con, 0, ys,
+                               mode.width, y - ys);
+                ys =3D -1;
+            }
+        }
+        if (ys >=3D 0) {
+            dpy_gfx_update(s->con, 0, ys,
+                           mode.width, y - ys);
+        }
+    }
 }
=20
 static const GraphicHwOps bochs_display_gfx_ops =3D {
@@ -251,6 +279,8 @@ static void bochs_display_realize(PCIDevice *dev, Err=
or **errp)
     pci_set_byte(&s->pci.config[PCI_REVISION_ID], 2);
     pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram=
);
     pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio=
);
+
+    memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
 }
=20
 static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
--=20
2.9.3
