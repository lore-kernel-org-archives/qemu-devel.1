Received: from eggs.gnu.org ([2001:4830:134:3::10]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sz-0000rZ-1D
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sv-00069n-UI
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg6sv-00069E-Ow
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:25 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB57B81253
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 09:37:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 10:37:17 +0100
Message-Id: <1487669841-13668-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
References: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] console: add dpy_gl_scanout_disable
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

Helper function (and DisplayChangeListenerOps ptr) to disable scanouts.
Replaces using dpy_gl_scanout_texture with 0x0 size and no texture
specified.

Allows cleanups to make the io and gfx emulation code more readable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  2 ++
 ui/console.c         | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index e6ae637..ac2895c 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -215,6 +215,7 @@ typedef struct DisplayChangeListenerOps {
                                    QEMUGLContext ctx);
     QEMUGLContext (*dpy_gl_ctx_get_current)(DisplayChangeListener *dcl);
 
+    void (*dpy_gl_scanout_disable)(DisplayChangeListener *dcl);
     void (*dpy_gl_scanout_texture)(DisplayChangeListener *dcl,
                                    uint32_t backing_id,
                                    bool backing_y_0_top,
@@ -287,6 +288,7 @@ bool dpy_cursor_define_supported(QemuConsole *con);
 bool dpy_gfx_check_format(QemuConsole *con,
                           pixman_format_code_t format);
 
+void dpy_gl_scanout_disable(QemuConsole *con);
 void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
diff --git a/ui/console.c b/ui/console.c
index 22c3c7d..d1ff750 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1735,6 +1735,17 @@ QEMUGLContext dpy_gl_ctx_get_current(QemuConsole *con)
     return con->gl->ops->dpy_gl_ctx_get_current(con->gl);
 }
 
+void dpy_gl_scanout_disable(QemuConsole *con)
+{
+    assert(con->gl);
+    if (con->gl->ops->dpy_gl_scanout_disable) {
+        con->gl->ops->dpy_gl_scanout_disable(con->gl);
+    } else {
+        con->gl->ops->dpy_gl_scanout_texture(con->gl, 0, false, 0, 0,
+                                             0, 0, 0, 0);
+    }
+}
+
 void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id,
                             bool backing_y_0_top,
-- 
1.8.3.1
