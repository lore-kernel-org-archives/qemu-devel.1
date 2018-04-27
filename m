Received: from eggs.gnu.org ([2001:4830:134:3::10]:41158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05T-0007Q9-Qb
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05S-0001g7-Rh
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC05S-0001fg-Lf
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:42 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 11:54:32 +0200
Message-Id: <20180427095434.14013-5-kraxel@redhat.com>
In-Reply-To: <20180427095434.14013-1-kraxel@redhat.com>
References: <20180427095434.14013-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] sdl: Allow OpenGL ES context creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

From: Elie Tournier <tournier.elie@gmail.com>

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
Message-id: 20180413135842.21325-4-tournier.elie@gmail.com

[ kraxel: fix indent ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-gl.c    | 19 +++++++++++++++++--
 vl.c            |  4 ++++
 qemu-options.hx |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index c3683e6b65..83b71853d1 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -140,12 +140,27 @@ QEMUGLContext sdl2_gl_create_context(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
-    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
-                        SDL_GL_CONTEXT_PROFILE_CORE);
+    if (scon->opts->gl == DISPLAYGL_MODE_ON ||
+        scon->opts->gl == DISPLAYGL_MODE_CORE) {
+        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                            SDL_GL_CONTEXT_PROFILE_CORE);
+    } else if (scon->opts->gl == DISPLAYGL_MODE_ES) {
+        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                            SDL_GL_CONTEXT_PROFILE_ES);
+    }
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, params->major_ver);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, params->minor_ver);
 
     ctx = SDL_GL_CreateContext(scon->real_window);
+
+    /* If SDL fail to create a GL context and we use the "on" flag,
+     * then try to fallback to GLES.
+     */
+    if (!ctx && scon->opts->gl == DISPLAYGL_MODE_ON) {
+        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                            SDL_GL_CONTEXT_PROFILE_ES);
+        ctx = SDL_GL_CreateContext(scon->real_window);
+    }
     return (QEMUGLContext)ctx;
 }
 
diff --git a/vl.c b/vl.c
index f7804f7a18..916d2a80a7 100644
--- a/vl.c
+++ b/vl.c
@@ -2144,6 +2144,10 @@ static void parse_display(const char *p)
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
-- 
2.9.3
