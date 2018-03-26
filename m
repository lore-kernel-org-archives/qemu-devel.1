Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlx-0006UE-OL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlv-0003Zd-Sf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tlv-0003Z6-OL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:12 +0200
Message-Id: <20180326150916.9602-35-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 34/38] console: add graphic_hw_update_done()
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

Add a function to be called when an async graphic update is done.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h    | 1 +
 hw/display/qxl-render.c | 9 +++++++--
 ui/console.c            | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index d2b6c46a62..fc21621656 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -390,6 +390,7 @@ void graphic_console_set_hwops(QemuConsole *con,
 void graphic_console_close(QemuConsole *con);
=20
 bool graphic_hw_update(QemuConsole *con);
+void graphic_hw_update_done(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 62574173a2..08722d2833 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -106,7 +106,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDev=
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
@@ -134,7 +134,7 @@ static void qxl_render_update_area_unlocked(PCIQXLDev=
ice *qxl)
     }
=20
     if (!qxl->guest_primary.data) {
-        return;
+        goto end;
     }
     for (i =3D 0; i < qxl->num_dirty_rects; i++) {
         if (qemu_spice_rect_is_empty(qxl->dirty+i)) {
@@ -155,6 +155,11 @@ static void qxl_render_update_area_unlocked(PCIQXLDe=
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
diff --git a/ui/console.c b/ui/console.c
index 0774cd3366..29234605a7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -256,6 +256,10 @@ static void gui_setup_refresh(DisplayState *ds)
     ds->have_text =3D have_text;
 }
=20
+void graphic_hw_update_done(QemuConsole *con)
+{
+}
+
 bool graphic_hw_update(QemuConsole *con)
 {
     if (!con) {
--=20
2.17.0.rc1.1.g4c4f2b46a3
