Received: from eggs.gnu.org ([2001:4830:134:3::10]:39936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Lr-0001e9-Ai
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Lp-0002kI-VW
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1Lp-0002jL-OK
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68EE187A75
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:45:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 09:45:05 +0200
Message-Id: <20180821074509.22688-9-kraxel@redhat.com>
In-Reply-To: <20180821074509.22688-1-kraxel@redhat.com>
References: <20180821074509.22688-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/12] spice-display: fix
 qemu_spice_cursor_refresh_bh locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

spice-display should not call the ui/console.c functions dpy_cursor_defin=
e
and dpy_moues_set with the SimpleSpiceDisplay lock taken.  That will caus=
e
a deadlock, because the DisplayChangeListener callbacks will take the loc=
k
again.  It is also in general a bad idea to invoke generic callbacks with=
 a
lock taken, because it can cause AB-BA deadlocks in the long run.  The on=
ly
thing that requires care is that the cursor may disappear as soon as the
mutex is released, so you need an extra cursor_get/cursor_put pair.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180720063109.4631-3-pbonzini@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 46df673cd7..f1d341091a 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -450,29 +450,35 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *=
ssd,
     qemu_mutex_unlock(&ssd->lock);
 }
=20
-static void qemu_spice_cursor_refresh_unlocked(SimpleSpiceDisplay *ssd)
+void qemu_spice_cursor_refresh_bh(void *opaque)
 {
+    SimpleSpiceDisplay *ssd =3D opaque;
+
+    qemu_mutex_lock(&ssd->lock);
     if (ssd->cursor) {
+        QEMUCursor *c =3D ssd->cursor;
         assert(ssd->dcl.con);
+        cursor_get(c);
+        qemu_mutex_unlock(&ssd->lock);
         dpy_cursor_define(ssd->dcl.con, ssd->cursor);
+        qemu_mutex_lock(&ssd->lock);
+        cursor_put(c);
     }
+
     if (ssd->mouse_x !=3D -1 && ssd->mouse_y !=3D -1) {
+        int x, y;
         assert(ssd->dcl.con);
-        dpy_mouse_set(ssd->dcl.con, ssd->mouse_x, ssd->mouse_y, 1);
+        x =3D ssd->mouse_x;
+        y =3D ssd->mouse_y;
         ssd->mouse_x =3D -1;
         ssd->mouse_y =3D -1;
+        qemu_mutex_unlock(&ssd->lock);
+        dpy_mouse_set(ssd->dcl.con, x, y, 1);
+    } else {
+        qemu_mutex_unlock(&ssd->lock);
     }
 }
=20
-void qemu_spice_cursor_refresh_bh(void *opaque)
-{
-    SimpleSpiceDisplay *ssd =3D opaque;
-
-    qemu_mutex_lock(&ssd->lock);
-    qemu_spice_cursor_refresh_unlocked(ssd);
-    qemu_mutex_unlock(&ssd->lock);
-}
-
 void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 {
     graphic_hw_update(ssd->dcl.con);
--=20
2.9.3
