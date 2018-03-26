Received: from eggs.gnu.org ([2001:4830:134:3::10]:55434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tly-0006VJ-Rr
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlu-0003XI-Gl
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tlu-0003WK-BS
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:11 +0200
Message-Id: <20180326150916.9602-34-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 33/38] console: graphic_hw_update return
 true if async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qxl_render_update() returns true if the update is deferred.

Let the caller know if the update is immediate or async.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.h        |  2 +-
 include/ui/console.h    |  3 ++-
 hw/display/qxl-render.c |  5 +++--
 hw/display/qxl.c        |  8 ++++----
 ui/console.c            | 14 ++++++++++++--
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 089696ef62..cc4f83f990 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -169,7 +169,7 @@ int qxl_log_command(PCIQXLDevice *qxl, const char *ri=
ng, QXLCommandExt *ext);
=20
 /* qxl-render.c */
 void qxl_render_resize(PCIQXLDevice *qxl);
-void qxl_render_update(PCIQXLDevice *qxl);
+bool qxl_render_update(PCIQXLDevice *qxl);
 int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext);
 void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie);
 void qxl_render_update_area_bh(void *opaque);
diff --git a/include/ui/console.h b/include/ui/console.h
index 6d2c052068..d2b6c46a62 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -374,6 +374,7 @@ static inline void console_write_ch(console_ch_t *des=
t, uint32_t ch)
 typedef struct GraphicHwOps {
     void (*invalidate)(void *opaque);
     void (*gfx_update)(void *opaque);
+    bool (*gfx_update_async)(void *opaque);
     void (*text_update)(void *opaque, console_ch_t *text);
     void (*update_interval)(void *opaque, uint64_t interval);
     int (*ui_info)(void *opaque, uint32_t head, QemuUIInfo *info);
@@ -388,7 +389,7 @@ void graphic_console_set_hwops(QemuConsole *con,
                                void *opaque);
 void graphic_console_close(QemuConsole *con);
=20
-void graphic_hw_update(QemuConsole *con);
+bool graphic_hw_update(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8789..62574173a2 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -163,7 +163,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDev=
ice *qxl)
  * callbacks are called by spice_server thread, deferring to bh called f=
rom the
  * io thread.
  */
-void qxl_render_update(PCIQXLDevice *qxl)
+bool qxl_render_update(PCIQXLDevice *qxl)
 {
     QXLCookie *cookie;
=20
@@ -172,7 +172,7 @@ void qxl_render_update(PCIQXLDevice *qxl)
     if (!runstate_is_running() || !qxl->guest_primary.commands) {
         qxl_render_update_area_unlocked(qxl);
         qemu_mutex_unlock(&qxl->ssd.lock);
-        return;
+        return false;
     }
=20
     qxl->guest_primary.commands =3D 0;
@@ -183,6 +183,7 @@ void qxl_render_update(PCIQXLDevice *qxl)
     qxl_set_rect_to_surface(qxl, &cookie->u.render.area);
     qxl_spice_update_area(qxl, 0, &cookie->u.render.area, NULL,
                           0, 1 /* clear_dirty_region */, QXL_ASYNC, cook=
ie);
+    return true;
 }
=20
 void qxl_render_update_area_bh(void *opaque)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index a71714ccb4..7dda2ae576 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -136,7 +136,7 @@ static void qxl_reset_memslots(PCIQXLDevice *d);
 static void qxl_reset_surfaces(PCIQXLDevice *d);
 static void qxl_ring_set_dirty(PCIQXLDevice *qxl);
=20
-static void qxl_hw_update(void *opaque);
+static bool qxl_hw_update_async(void *opaque);
=20
 void qxl_set_guest_bug(PCIQXLDevice *qxl, const char *msg, ...)
 {
@@ -1167,7 +1167,7 @@ static const QXLInterface qxl_interface =3D {
 };
=20
 static const GraphicHwOps qxl_ops =3D {
-    .gfx_update  =3D qxl_hw_update,
+    .gfx_update_async =3D qxl_hw_update_async,
 };
=20
 static void qxl_enter_vga_mode(PCIQXLDevice *d)
@@ -1889,11 +1889,11 @@ static void qxl_send_events(PCIQXLDevice *d, uint=
32_t events)
=20
 /* graphics console */
=20
-static void qxl_hw_update(void *opaque)
+static bool qxl_hw_update_async(void *opaque)
 {
     PCIQXLDevice *qxl =3D opaque;
=20
-    qxl_render_update(qxl);
+    return qxl_render_update(qxl);
 }
=20
 static void qxl_dirty_one_surface(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
diff --git a/ui/console.c b/ui/console.c
index 530a491987..0774cd3366 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -256,14 +256,24 @@ static void gui_setup_refresh(DisplayState *ds)
     ds->have_text =3D have_text;
 }
=20
-void graphic_hw_update(QemuConsole *con)
+bool graphic_hw_update(QemuConsole *con)
 {
     if (!con) {
         con =3D active_console;
     }
-    if (con && con->hw_ops->gfx_update) {
+
+    if (!con) {
+        return false;
+    }
+
+    if (con->hw_ops->gfx_update_async) {
+        return con->hw_ops->gfx_update_async(con->hw);
+    } else if (con->hw_ops->gfx_update) {
         con->hw_ops->gfx_update(con->hw);
+        return false;
     }
+
+    return false;
 }
=20
 void graphic_hw_gl_block(QemuConsole *con, bool block)
--=20
2.17.0.rc1.1.g4c4f2b46a3
