Received: from eggs.gnu.org ([209.51.188.92]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLf-0003Gl-Tp
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLe-00058X-Dx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLd-00057I-D1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:10:05 +0200
Message-Id: <20190409161009.6322-17-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 16/20] console: add graphic_hw_update_done()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a function to be called when a graphic update is done.

Declare the QXL renderer as async: render_update_cookie_num counts the
number of outstanding updates, and graphic_hw_update_done() is called
when it reaches none.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h    | 2 ++
 hw/display/qxl-render.c | 9 +++++++--
 hw/display/qxl.c        | 1 +
 ui/console.c            | 9 +++++++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index fef900db76..9415adadfe 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -364,6 +364,7 @@ static inline void console_write_ch(console_ch_t *des=
t, uint32_t ch)
 typedef struct GraphicHwOps {
     void (*invalidate)(void *opaque);
     void (*gfx_update)(void *opaque);
+    bool gfx_update_async; /* if true, calls graphic_hw_update_done() */
     void (*text_update)(void *opaque, console_ch_t *text);
     void (*update_interval)(void *opaque, uint64_t interval);
     int (*ui_info)(void *opaque, uint32_t head, QemuUIInfo *info);
@@ -379,6 +380,7 @@ void graphic_console_set_hwops(QemuConsole *con,
 void graphic_console_close(QemuConsole *con);
=20
 void graphic_hw_update(QemuConsole *con);
+void graphic_hw_update_done(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 14ad2b352d..102fa0b7e9 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -108,7 +108,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDev=
ice *qxl)
                                                 qxl->guest_primary.surfa=
ce.mem,
                                                 MEMSLOT_GROUP_GUEST);
         if (!qxl->guest_primary.data) {
-            return;
+            goto end;
         }
         qxl_set_rect_to_surface(qxl, &qxl->dirty[0]);
         qxl->num_dirty_rects =3D 1;
@@ -136,7 +136,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDev=
ice *qxl)
     }
=20
     if (!qxl->guest_primary.data) {
-        return;
+        goto end;
     }
     for (i =3D 0; i < qxl->num_dirty_rects; i++) {
         if (qemu_spice_rect_is_empty(qxl->dirty+i)) {
@@ -157,6 +157,11 @@ static void qxl_render_update_area_unlocked(PCIQXLDe=
vice *qxl)
                        qxl->dirty[i].bottom - qxl->dirty[i].top);
     }
     qxl->num_dirty_rects =3D 0;
+
+end:
+    if (qxl->render_update_cookie_num =3D=3D 0) {
+        graphic_hw_update_done(qxl->ssd.dcl.con);
+    }
 }
=20
 /*
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c8ce5781e0..884e24766c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1182,6 +1182,7 @@ static const QXLInterface qxl_interface =3D {
=20
 static const GraphicHwOps qxl_ops =3D {
     .gfx_update  =3D qxl_hw_update,
+    .gfx_update_async =3D true,
 };
=20
 static void qxl_enter_vga_mode(PCIQXLDevice *d)
diff --git a/ui/console.c b/ui/console.c
index 6d2282d3e9..3a7f71021f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -258,13 +258,22 @@ static void gui_setup_refresh(DisplayState *ds)
     ds->have_text =3D have_text;
 }
=20
+void graphic_hw_update_done(QemuConsole *con)
+{
+}
+
 void graphic_hw_update(QemuConsole *con)
 {
+    bool async =3D false;
     if (!con) {
         con =3D active_console;
     }
     if (con && con->hw_ops->gfx_update) {
         con->hw_ops->gfx_update(con->hw);
+        async =3D con->hw_ops->gfx_update_async;
+    }
+    if (!async) {
+        graphic_hw_update_done(con);
     }
 }
=20
--=20
2.21.0.196.g041f5ea1cf
