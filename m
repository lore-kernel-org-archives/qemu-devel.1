Received: from eggs.gnu.org ([2001:4830:134:3::10]:53086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f5s4o-0001tq-NC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1f5s4n-0004eh-IE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:08:42 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1f5s4n-0004do-BA
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:08:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id 66so19343434wmd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 05:08:41 -0700 (PDT)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Tue, 10 Apr 2018 13:02:22 +0100
Message-Id: <20180410120222.31845-3-tournier.elie@gmail.com>
In-Reply-To: <20180410120222.31845-1-tournier.elie@gmail.com>
References: <20180410120222.31845-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] sdl: Allow OpenGL ES context creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kraxel@redhat.com, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
---
 include/ui/sdl2.h |  1 +
 qemu-options.hx   |  2 +-
 ui/sdl2-gl.c      | 17 +++++++++++++++--
 ui/sdl2.c         |  1 +
 vl.c              |  4 ++++
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 51084e6320..8495795e48 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -22,6 +22,7 @@ struct sdl2_console {
     int x, y, w, h;
     int hidden;
     int opengl;
+    DisplayGLMode gl_mode;
     int updates;
     int idle_counter;
     int ignore_hotkeys;
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
index c3683e6b65..4755314afe 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -140,12 +140,25 @@ QEMUGLContext sdl2_gl_create_context(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
-    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
-                        SDL_GL_CONTEXT_PROFILE_CORE);
+    if (scon->gl_mode ==  DISPLAYGL_MODE_ON || scon->gl_mode == DISPLAYGL_MODE_CORE)
+       SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                           SDL_GL_CONTEXT_PROFILE_CORE);
+    else if (scon->gl_mode == DISPLAYGL_MODE_ES)
+       SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                           SDL_GL_CONTEXT_PROFILE_ES);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, params->major_ver);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, params->minor_ver);
 
     ctx = SDL_GL_CreateContext(scon->real_window);
+
+    /* If SDL fail to create a GL context and we use the "on" flag,
+     * then try to fallback to GLES.
+     */
+    if (!ctx && scon->gl_mode == DISPLAYGL_MODE_ON) {
+       SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                           SDL_GL_CONTEXT_PROFILE_ES);
+       ctx = SDL_GL_CreateContext(scon->real_window);
+    }
     return (QEMUGLContext)ctx;
 }
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 83b917fa37..29bf8e36ad 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -815,6 +815,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].idx = i;
 #ifdef CONFIG_OPENGL
         sdl2_console[i].opengl = display_opengl;
+        sdl2_console[i].gl_mode = o->gl;
         sdl2_console[i].dcl.ops = display_opengl ? &dcl_gl_ops : &dcl_2d_ops;
 #else
         sdl2_console[i].opengl = 0;
diff --git a/vl.c b/vl.c
index 7809a15caf..5694c23742 100644
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
