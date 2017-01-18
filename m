Received: from eggs.gnu.org ([2001:4830:134:3::10]:38193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjW-0003qp-OV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjR-0007tu-63
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsjR-0007tp-0K
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31913606BF
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:05:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:29 +0400
Message-Id: <20170118160332.13390-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 22/25] console: add graphic_hw_update_done()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a function to be called when an async graphic update is done.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h    | 1 +
 hw/display/qxl-render.c | 9 +++++++--
 ui/console.c            | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 9dd53c1a0f..e2d4f0df0d 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -380,6 +380,7 @@ void graphic_console_set_hwops(QemuConsole *con,
                                void *opaque);
=20
 bool graphic_hw_update(QemuConsole *con);
+void graphic_hw_update_done(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 50a019162f..8341f583a2 100644
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
index 9131e45b36..46ad6abd94 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -254,6 +254,10 @@ static void gui_setup_refresh(DisplayState *ds)
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
2.11.0.295.gd7dffce1c
