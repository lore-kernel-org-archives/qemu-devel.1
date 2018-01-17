Received: from eggs.gnu.org ([2001:4830:134:3::10]:58055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1ebp4k-0001Jg-6f
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1ebp4j-0002Ft-3V
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:26 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1ebp4i-0002Er-Tx
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:52:25 -0500
Received: by mail-wm0-x243.google.com with SMTP id r78so16367357wme.0
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 06:52:24 -0800 (PST)
From: Elie Tournier <tournier.elie@gmail.com>
Date: Wed, 17 Jan 2018 14:50:29 +0000
Message-Id: <20180117145029.28736-3-tournier.elie@gmail.com>
In-Reply-To: <20180117145029.28736-1-tournier.elie@gmail.com>
References: <20180117145029.28736-1-tournier.elie@gmail.com>
Subject: [Qemu-devel] [RFC 2/2] sdl2: gles option will create a gles context
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

Create an OpenGL ES context if the option `-display sdl,gles=on` is set.

Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
---
 include/sysemu/sysemu.h | 1 +
 include/ui/sdl2.h       | 1 +
 ui/sdl2-gl.c            | 8 ++++++--
 ui/sdl2.c               | 7 +++++++
 vl.c                    | 1 +
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 31612caf10..32f242c4c5 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -108,6 +108,7 @@ extern int graphic_width;
 extern int graphic_height;
 extern int graphic_depth;
 extern int display_opengl;
+extern bool use_opengl_es;
 extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 51084e6320..2aaa203f51 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -26,6 +26,7 @@ struct sdl2_console {
     int idle_counter;
     int ignore_hotkeys;
     SDL_GLContext winctx;
+    bool opengl_es;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 5e1073a084..4e620c5ff7 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -142,8 +142,12 @@ QEMUGLContext sdl2_gl_create_context(DisplayChangeListener *dcl,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
 
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
-    SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
-                        SDL_GL_CONTEXT_PROFILE_CORE);
+    if (scon->opengl_es)
+        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                            SDL_GL_CONTEXT_PROFILE_ES);
+    else
+        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                            SDL_GL_CONTEXT_PROFILE_CORE);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, params->major_ver);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, params->minor_ver);
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index e78cff1a6f..a1250a6902 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -762,9 +762,14 @@ void sdl_display_early_init(int opengl)
     case 0:  /* off */
         break;
     case 1: /* on */
+#ifdef CONFIG_OPENGL
+        display_opengl = 1;
+#endif
+        break;
     case 2: /* gles = on */
 #ifdef CONFIG_OPENGL
         display_opengl = 1;
+        use_opengl_es = true;
 #endif
         break;
     default:
@@ -829,9 +834,11 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
 #ifdef CONFIG_OPENGL
         sdl2_console[i].opengl = display_opengl;
         sdl2_console[i].dcl.ops = display_opengl ? &dcl_gl_ops : &dcl_2d_ops;
+        sdl2_console[i].opengl_es = use_opengl_es;
 #else
         sdl2_console[i].opengl = 0;
         sdl2_console[i].dcl.ops = &dcl_2d_ops;
+        sdl2_console[i].opengl_es = false;
 #endif
         sdl2_console[i].dcl.con = con;
         register_displaychangelistener(&sdl2_console[i].dcl);
diff --git a/vl.c b/vl.c
index 3fe325222e..a7bde1fa1e 100644
--- a/vl.c
+++ b/vl.c
@@ -137,6 +137,7 @@ const char *bios_name = NULL;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int request_opengl = -1;
 int display_opengl;
+bool use_opengl_es;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
 const char *mem_path = NULL;
-- 
2.15.1
