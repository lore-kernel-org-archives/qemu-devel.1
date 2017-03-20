Received: from eggs.gnu.org ([2001:4830:134:3::10]:58425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpuQc-00058F-4Z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpuQZ-0008D5-0D
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpuQY-0008Cu-Qk
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:20:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD496C05AA6B
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 10:20:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 11:20:27 +0100
Message-Id: <1490005227-1997-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] console: drop epoxy/gl.h include dependency
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

Use "unsigned int" instead of GLenum and GLuint, so we don't depend on
these types from opengl headers.  Drop all CONFIG_OPENGL #ifdefs from
console.h

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 14 +++-----------
 include/ui/sdl2.h    |  4 ++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index d759338..2f4aae2 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -9,10 +9,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 
-#ifdef CONFIG_OPENGL
-# include <epoxy/gl.h>
-#endif
-
 /* keyboard/mouse support */
 
 #define MOUSE_EVENT_LBUTTON 0x01
@@ -136,11 +132,9 @@ struct DisplaySurface {
     pixman_format_code_t format;
     pixman_image_t *image;
     uint8_t flags;
-#ifdef CONFIG_OPENGL
-    GLenum glformat;
-    GLenum gltype;
-    GLuint texture;
-#endif
+    unsigned int glformat;
+    unsigned int gltype;
+    unsigned int texture;
 };
 
 typedef struct QemuUIInfo {
@@ -410,7 +404,6 @@ DisplaySurface *qemu_console_surface(QemuConsole *con);
 
 /* console-gl.c */
 typedef struct ConsoleGLState ConsoleGLState;
-#ifdef CONFIG_OPENGL
 ConsoleGLState *console_gl_init_context(void);
 void console_gl_fini_context(ConsoleGLState *gls);
 bool console_gl_check_format(DisplayChangeListener *dcl,
@@ -427,7 +420,6 @@ void surface_gl_destroy_texture(ConsoleGLState *gls,
 void surface_gl_setup_viewport(ConsoleGLState *gls,
                                DisplaySurface *surface,
                                int ww, int wh);
-#endif
 
 /* sdl.c */
 #ifdef CONFIG_SDL
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index aaf226c..1e8d07b 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -7,6 +7,10 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
 
+#ifdef CONFIG_OPENGL
+# include <epoxy/gl.h>
+#endif
+
 struct sdl2_console {
     DisplayChangeListener dcl;
     DisplaySurface *surface;
-- 
1.8.3.1
