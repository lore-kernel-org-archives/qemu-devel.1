Received: from eggs.gnu.org ([2001:4830:134:3::10]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pou-0005KK-A5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pop-0001sY-LQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4Pop-0001q5-DI
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CF6A80484
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:13:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Oct 2017 13:13:45 +0200
Message-Id: <20171017111350.8176-2-kraxel@redhat.com>
In-Reply-To: <20171017111350.8176-1-kraxel@redhat.com>
References: <20171017111350.8176-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] console: add support for dmabufs
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

This patch adds support for dma-bufs to the qemu console interfaces.
It adds a new "struct QemuDmaBuf" to represent a dmabuf with accociated
metatdata (size, format).  It adds three functions (and
DisplayChangeListenerOps operations) to set a dma-buf as display
scanout, as cursor and to release a dmabuf.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20171010135453.6704-2-kraxel@redhat.com
---
 include/qemu/typedefs.h |  1 +
 include/ui/console.h    | 25 +++++++++++++++++++++++++
 ui/console.c            | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 980d2b330e..3dbc69b1e9 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -83,6 +83,7 @@ typedef struct PropertyInfo PropertyInfo;
 typedef struct PS2State PS2State;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
+typedef struct QemuDmaBuf QemuDmaBuf;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuOpt QemuOpt;
 typedef struct QemuOpts QemuOpts;
diff --git a/include/ui/console.h b/include/ui/console.h
index 6966e4bd9d..158969f978 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,6 +5,7 @@
 #include "qom/object.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/notify.h"
+#include "qemu/typedefs.h"
 #include "qapi-types.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -180,6 +181,15 @@ struct QEMUGLParams {
     int minor_ver;
 };
 
+struct QemuDmaBuf {
+    int       fd;
+    uint32_t  width;
+    uint32_t  height;
+    uint32_t  stride;
+    uint32_t  fourcc;
+    uint32_t  texture;
+};
+
 typedef struct DisplayChangeListenerOps {
     const char *dpy_name;
 
@@ -220,6 +230,13 @@ typedef struct DisplayChangeListenerOps {
                                    uint32_t backing_height,
                                    uint32_t x, uint32_t y,
                                    uint32_t w, uint32_t h);
+    void (*dpy_gl_scanout_dmabuf)(DisplayChangeListener *dcl,
+                                  QemuDmaBuf *dmabuf);
+    void (*dpy_gl_cursor_dmabuf)(DisplayChangeListener *dcl,
+                                 QemuDmaBuf *dmabuf,
+                                 uint32_t pos_x, uint32_t pos_y);
+    void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
+                                  QemuDmaBuf *dmabuf);
     void (*dpy_gl_update)(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
@@ -288,6 +305,13 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
                             uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+void dpy_gl_scanout_dmabuf(QemuConsole *con,
+                           QemuDmaBuf *dmabuf);
+void dpy_gl_cursor_dmabuf(QemuConsole *con,
+                          QemuDmaBuf *dmabuf,
+                          uint32_t pos_x, uint32_t pos_y);
+void dpy_gl_release_dmabuf(QemuConsole *con,
+                           QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
                    uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
@@ -298,6 +322,7 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMUGLContext ctx);
 QEMUGLContext dpy_gl_ctx_get_current(QemuConsole *con);
 
 bool console_has_gl(QemuConsole *con);
+bool console_has_gl_dmabuf(QemuConsole *con);
 
 static inline int surface_stride(DisplaySurface *s)
 {
diff --git a/ui/console.c b/ui/console.c
index b82c27960a..eca854cbd5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1404,6 +1404,11 @@ bool console_has_gl(QemuConsole *con)
     return con->gl != NULL;
 }
 
+bool console_has_gl_dmabuf(QemuConsole *con)
+{
+    return con->gl != NULL && con->gl->ops->dpy_gl_scanout_dmabuf != NULL;
+}
+
 void register_displaychangelistener(DisplayChangeListener *dcl)
 {
     static const char nodev[] =
@@ -1745,6 +1750,34 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                                          x, y, width, height);
 }
 
+void dpy_gl_scanout_dmabuf(QemuConsole *con,
+                           QemuDmaBuf *dmabuf)
+{
+    assert(con->gl);
+    con->gl->ops->dpy_gl_scanout_dmabuf(con->gl, dmabuf);
+}
+
+void dpy_gl_cursor_dmabuf(QemuConsole *con,
+                          QemuDmaBuf *dmabuf,
+                          uint32_t pos_x, uint32_t pos_y)
+{
+    assert(con->gl);
+
+    if (con->gl->ops->dpy_gl_cursor_dmabuf) {
+        con->gl->ops->dpy_gl_cursor_dmabuf(con->gl, dmabuf, pos_x, pos_y);
+    }
+}
+
+void dpy_gl_release_dmabuf(QemuConsole *con,
+                          QemuDmaBuf *dmabuf)
+{
+    assert(con->gl);
+
+    if (con->gl->ops->dpy_gl_release_dmabuf) {
+        con->gl->ops->dpy_gl_release_dmabuf(con->gl, dmabuf);
+    }
+}
+
 void dpy_gl_update(QemuConsole *con,
                    uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
-- 
2.9.3
