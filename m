Received: from eggs.gnu.org ([2001:4830:134:3::10]:46991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f6zJx-0004Cu-He
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f6zJu-00019K-AB
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:04:57 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f6zJu-00019D-3V
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:04:54 -0400
Received: by mail-wr0-x242.google.com with SMTP id u46so8435221wrc.11
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:04:53 -0700 (PDT)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Fri, 13 Apr 2018 14:58:42 +0100
Message-Id: <20180413135842.21325-4-tournier.elie@gmail.com>
In-Reply-To: <20180413135842.21325-1-tournier.elie@gmail.com>
References: <20180413135842.21325-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [PATCH v3 3/3] sdl: Allow OpenGL ES context creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kraxel@redhat.com, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
---
 qemu-options.hx |  2 +-
 ui/sdl2-gl.c    | 19 +++++++++++++++++--
 vl.c            |  4 ++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ca4e412f2f..333dd1f1c8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1240,7 +1240,7 @@ ETEXI
 
 DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display sdl[,frame=on|off][,alt_grab=on|off][,ctrl_grab=on|off]\n"
-    "            [,window_close=on|off][,gl=on|off]\n"
+    "            [,window_close=on|off][,gl=on|core|es|off]\n"
     "-display gtk[,grab_on_hover=on|off][,gl=on|off]|\n"
     "-display vnc=<display>[,<optargs>]\n"
     "-display curses\n"
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index c3683e6b65..a1200bfd20 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -140,12 +140,27 @@ QEMUGLContext sdl2_gl_create_context(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
-    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
-                        SDL_GL_CONTEXT_PROFILE_CORE);
+    if (scon->opts->gl == DISPLAYGL_MODE_ON ||
+        scon->opts->gl == DISPLAYGL_MODE_CORE) {
+       SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                           SDL_GL_CONTEXT_PROFILE_CORE);
+    } else if (scon->opts->gl == DISPLAYGL_MODE_ES) {
+       SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                           SDL_GL_CONTEXT_PROFILE_ES);
+    }
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, params->major_ver);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, params->minor_ver);
 
     ctx = SDL_GL_CreateContext(scon->real_window);
+
+    /* If SDL fail to create a GL context and we use the "on" flag,
+     * then try to fallback to GLES.
+     */
+    if (!ctx && scon->opts->gl == DISPLAYGL_MODE_ON) {
+       SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                           SDL_GL_CONTEXT_PROFILE_ES);
+       ctx = SDL_GL_CreateContext(scon->real_window);
+    }
     return (QEMUGLContext)ctx;
 }
 
diff --git a/vl.c b/vl.c
index 99284fd518..3bd3b902a0 100644
--- a/vl.c
+++ b/vl.c
@@ -2143,6 +2143,10 @@ static void parse_display(const char *p)
                 dpy.has_gl = true;
                 if (strstart(opts, "on", &nextopt)) {
                     dpy.gl = DISPLAYGL_MODE_ON;
+                } else if (strstart(opts, "core", &nextopt)) {
+                    dpy.gl = DISPLAYGL_MODE_CORE;
+                } else if (strstart(opts, "es", &nextopt)) {
+                    dpy.gl = DISPLAYGL_MODE_ES;
                 } else if (strstart(opts, "off", &nextopt)) {
                     dpy.gl = DISPLAYGL_MODE_OFF;
                 } else {
-- 
2.17.0
