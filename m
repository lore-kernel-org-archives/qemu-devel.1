Received: from eggs.gnu.org ([2001:4830:134:3::10]:35398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5j7-0005pa-D9
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5j4-00083y-AT
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo5j4-00083f-5z
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 862A2EAE83
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:04:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 12:04:31 +0100
Message-Id: <20180220110433.20353-2-kraxel@redhat.com>
In-Reply-To: <20180220110433.20353-1-kraxel@redhat.com>
References: <20180220110433.20353-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] console/opengl: split up dpy_gl_cursor ops
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

Split the cursor callback into two, one for setting the dmabuf,
one for setting the position.  Also add hotspot information.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 13 ++++++++-----
 ui/console.c         | 18 ++++++++++++++----
 ui/egl-headless.c    | 17 ++++++++++++-----
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 12fef80923..94a670492a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -230,8 +230,10 @@ typedef struct DisplayChangeListenerOps {
     void (*dpy_gl_scanout_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
     void (*dpy_gl_cursor_dmabuf)(DisplayChangeListener *dcl,
-                                 QemuDmaBuf *dmabuf,
-                                 uint32_t pos_x, uint32_t pos_y);
+                                 QemuDmaBuf *dmabuf, bool have_hot,
+                                 uint32_t hot_x, uint32_t hot_y);
+    void (*dpy_gl_cursor_position)(DisplayChangeListener *dcl,
+                                   uint32_t pos_x, uint32_t pos_y);
     void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
     void (*dpy_gl_update)(DisplayChangeListener *dcl,
@@ -304,9 +306,10 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
-void dpy_gl_cursor_dmabuf(QemuConsole *con,
-                          QemuDmaBuf *dmabuf,
-                          uint32_t pos_x, uint32_t pos_y);
+void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
+                          bool have_hot, uint32_t hot_x, uint32_t hot_y);
+void dpy_gl_cursor_position(QemuConsole *con,
+                            uint32_t pos_x, uint32_t pos_y);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/console.c b/ui/console.c
index 36584d039e..e22931a396 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1760,14 +1760,24 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
     con->gl->ops->dpy_gl_scanout_dmabuf(con->gl, dmabuf);
 }
 
-void dpy_gl_cursor_dmabuf(QemuConsole *con,
-                          QemuDmaBuf *dmabuf,
-                          uint32_t pos_x, uint32_t pos_y)
+void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
+                          bool have_hot, uint32_t hot_x, uint32_t hot_y)
 {
     assert(con->gl);
 
     if (con->gl->ops->dpy_gl_cursor_dmabuf) {
-        con->gl->ops->dpy_gl_cursor_dmabuf(con->gl, dmabuf, pos_x, pos_y);
+        con->gl->ops->dpy_gl_cursor_dmabuf(con->gl, dmabuf,
+                                           have_hot, hot_x, hot_y);
+    }
+}
+
+void dpy_gl_cursor_position(QemuConsole *con,
+                            uint32_t pos_x, uint32_t pos_y)
+{
+    assert(con->gl);
+
+    if (con->gl->ops->dpy_gl_cursor_position) {
+        con->gl->ops->dpy_gl_cursor_position(con->gl, pos_x, pos_y);
     }
 }
 
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 5d50226869..825ee5cc12 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -84,14 +84,11 @@ static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
 }
 
 static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
-                              QemuDmaBuf *dmabuf,
-                              uint32_t pos_x, uint32_t pos_y)
+                              QemuDmaBuf *dmabuf, bool have_hot,
+                              uint32_t hot_x, uint32_t hot_y)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
-    edpy->pos_x = pos_x;
-    edpy->pos_y = pos_y;
-
     egl_dmabuf_import_texture(dmabuf);
     if (!dmabuf->texture) {
         return;
@@ -101,6 +98,15 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
                          dmabuf->texture, false);
 }
 
+static void egl_cursor_position(DisplayChangeListener *dcl,
+                                uint32_t pos_x, uint32_t pos_y)
+{
+    egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
+
+    edpy->pos_x = pos_x;
+    edpy->pos_y = pos_y;
+}
+
 static void egl_release_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf)
 {
@@ -150,6 +156,7 @@ static const DisplayChangeListenerOps egl_ops = {
     .dpy_gl_scanout_texture  = egl_scanout_texture,
     .dpy_gl_scanout_dmabuf   = egl_scanout_dmabuf,
     .dpy_gl_cursor_dmabuf    = egl_cursor_dmabuf,
+    .dpy_gl_cursor_position  = egl_cursor_position,
     .dpy_gl_release_dmabuf   = egl_release_dmabuf,
     .dpy_gl_update           = egl_scanout_flush,
 };
-- 
2.9.3
