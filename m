Received: from eggs.gnu.org ([2001:4830:134:3::10]:46763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fgOwe-0005IT-9h
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fgOwd-0007e4-5x
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:16 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:53888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fgOwc-0007dQ-VT
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:15 -0400
Received: by mail-wm0-x22a.google.com with SMTP id s9-v6so8352223wmh.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 23:31:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jul 2018 08:31:09 +0200
Message-Id: <20180720063109.4631-3-pbonzini@redhat.com>
In-Reply-To: <20180720063109.4631-1-pbonzini@redhat.com>
References: <20180720063109.4631-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] spice-display: fix
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

spice-display should not call the ui/console.c functions dpy_cursor_define
and dpy_moues_set with the SimpleSpiceDisplay lock taken.  That will cause
a deadlock, because the DisplayChangeListener callbacks will take the lock
again.  It is also in general a bad idea to invoke generic callbacks with a
lock taken, because it can cause AB-BA deadlocks in the long run.  The only
thing that requires care is that the cursor may disappear as soon as the
mutex is released, so you need an extra cursor_get/cursor_put pair.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/spice-display.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 46df673cd7..f1d341091a 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -450,29 +450,35 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
     qemu_mutex_unlock(&ssd->lock);
 }
 
-static void qemu_spice_cursor_refresh_unlocked(SimpleSpiceDisplay *ssd)
+void qemu_spice_cursor_refresh_bh(void *opaque)
 {
+    SimpleSpiceDisplay *ssd = opaque;
+
+    qemu_mutex_lock(&ssd->lock);
     if (ssd->cursor) {
+        QEMUCursor *c = ssd->cursor;
         assert(ssd->dcl.con);
+        cursor_get(c);
+        qemu_mutex_unlock(&ssd->lock);
         dpy_cursor_define(ssd->dcl.con, ssd->cursor);
+        qemu_mutex_lock(&ssd->lock);
+        cursor_put(c);
     }
+
     if (ssd->mouse_x != -1 && ssd->mouse_y != -1) {
+        int x, y;
         assert(ssd->dcl.con);
-        dpy_mouse_set(ssd->dcl.con, ssd->mouse_x, ssd->mouse_y, 1);
+        x = ssd->mouse_x;
+        y = ssd->mouse_y;
         ssd->mouse_x = -1;
         ssd->mouse_y = -1;
+        qemu_mutex_unlock(&ssd->lock);
+        dpy_mouse_set(ssd->dcl.con, x, y, 1);
+    } else {
+        qemu_mutex_unlock(&ssd->lock);
     }
 }
 
-void qemu_spice_cursor_refresh_bh(void *opaque)
-{
-    SimpleSpiceDisplay *ssd = opaque;
-
-    qemu_mutex_lock(&ssd->lock);
-    qemu_spice_cursor_refresh_unlocked(ssd);
-    qemu_mutex_unlock(&ssd->lock);
-}
-
 void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
 {
     graphic_hw_update(ssd->dcl.con);
-- 
2.17.1
