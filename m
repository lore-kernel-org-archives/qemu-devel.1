Received: from eggs.gnu.org ([2001:4830:134:3::10]:46720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpvQt-0007cP-0t
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cpvQp-00025j-2b
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cpvQo-00025Y-Sw
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAF2C6AAE5
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 11:24:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 20 Mar 2017 12:24:53 +0100
Message-Id: <1490009093-28083-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3] console: drop epoxy/gl.h include dependency
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
 ui/sdl2-gl.c         |  2 +-
 3 files changed, 8 insertions(+), 12 deletions(-)

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
index aaf226c..af86dfe 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -7,6 +7,10 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
 
+#ifdef CONFIG_OPENGL
+# include <SDL_opengl.h>
+#endif
+
 struct sdl2_console {
     DisplayChangeListener dcl;
     DisplaySurface *surface;
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 1cd77e2..5bccdc9 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -29,10 +29,10 @@
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "ui/sdl2.h"
 #include "sysemu/sysemu.h"
 
 #include <epoxy/gl.h>
+#include "ui/sdl2.h"
 
 static void sdl2_set_scanout_mode(struct sdl2_console *scon, bool scanout)
 {
-- 
1.8.3.1
