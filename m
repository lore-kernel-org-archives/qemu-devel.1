Received: from eggs.gnu.org ([2001:4830:134:3::10]:41973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSV-0006nc-Da
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bST-0000FE-JV
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6bST-0000EY-Bu
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70EEEC058EC1
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 12:03:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 14:03:14 +0200
Message-Id: <20171023120317.8296-2-kraxel@redhat.com>
In-Reply-To: <20171023120317.8296-1-kraxel@redhat.com>
References: <20171023120317.8296-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] opengl: split up dpy_gl_cursor ops
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

Add a separate callback to set the position of the cursor dmabuf.
Note that the position is the upper left corner not the hotspot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 10 ++++++----
 ui/console.c         | 15 ++++++++++++---
 ui/egl-headless.c    | 16 +++++++++++-----
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 580dfc57ee..fa68ba5737 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -234,8 +234,9 @@ typedef struct DisplayChangeListenerOps {
     void (*dpy_gl_scanout_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
     void (*dpy_gl_cursor_dmabuf)(DisplayChangeListener *dcl,
-                                 QemuDmaBuf *dmabuf,
-                                 uint32_t pos_x, uint32_t pos_y);
+                                 QemuDmaBuf *dmabuf);
+    void (*dpy_gl_cursor_position)(DisplayChangeListener *dcl,
+                                   uint32_t pos_x, uint32_t pos_y);
     void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
                                   QemuDmaBuf *dmabuf);
     void (*dpy_gl_update)(DisplayChangeListener *dcl,
@@ -309,8 +310,9 @@ void dpy_gl_scanout_texture(QemuConsole *con,
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_cursor_dmabuf(QemuConsole *con,
-                          QemuDmaBuf *dmabuf,
-                          uint32_t pos_x, uint32_t pos_y);
+                          QemuDmaBuf *dmabuf);
+void dpy_gl_cursor_position(QemuConsole *con,
+                            uint32_t pos_x, uint32_t pos_y);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/console.c b/ui/console.c
index eca854cbd5..31c14f83d4 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1758,13 +1758,22 @@ void dpy_gl_scanout_dmabuf(QemuConsole *con,
 }
 
 void dpy_gl_cursor_dmabuf(QemuConsole *con,
-                          QemuDmaBuf *dmabuf,
-                          uint32_t pos_x, uint32_t pos_y)
+                          QemuDmaBuf *dmabuf)
 {
     assert(con->gl);
 
     if (con->gl->ops->dpy_gl_cursor_dmabuf) {
-        con->gl->ops->dpy_gl_cursor_dmabuf(con->gl, dmabuf, pos_x, pos_y);
+        con->gl->ops->dpy_gl_cursor_dmabuf(con->gl, dmabuf);
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
index 5d50226869..c75f5ac655 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -84,14 +84,10 @@ static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
 }
 
 static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
-                              QemuDmaBuf *dmabuf,
-                              uint32_t pos_x, uint32_t pos_y)
+                              QemuDmaBuf *dmabuf)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
-    edpy->pos_x = pos_x;
-    edpy->pos_y = pos_y;
-
     egl_dmabuf_import_texture(dmabuf);
     if (!dmabuf->texture) {
         return;
@@ -101,6 +97,15 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
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
@@ -150,6 +155,7 @@ static const DisplayChangeListenerOps egl_ops = {
     .dpy_gl_scanout_texture  = egl_scanout_texture,
     .dpy_gl_scanout_dmabuf   = egl_scanout_dmabuf,
     .dpy_gl_cursor_dmabuf    = egl_cursor_dmabuf,
+    .dpy_gl_cursor_position  = egl_cursor_position,
     .dpy_gl_release_dmabuf   = egl_release_dmabuf,
     .dpy_gl_update           = egl_scanout_flush,
 };
-- 
2.9.3
