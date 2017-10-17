Received: from eggs.gnu.org ([2001:4830:134:3::10]:52267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pou-0005KV-D0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pop-0001t5-US
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4Pop-0001qn-Kx
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD0F381DEF
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:13:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Oct 2017 13:13:46 +0200
Message-Id: <20171017111350.8176-3-kraxel@redhat.com>
In-Reply-To: <20171017111350.8176-1-kraxel@redhat.com>
References: <20171017111350.8176-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] opengl: move shader init from console-gl.c
 to shader.c
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

With the upcoming dmabuf support in qemu there will be more users of the
shaders than just console-gl.c.  So rename ConsoleGLState to
QemuGLShader, rename some functions too, move code from console-gl.c to
shaders.c.

No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20171010135453.6704-3-kraxel@redhat.com
---
 Makefile                   |  2 +-
 include/ui/console.h       | 14 ++++++-------
 include/ui/gtk.h           |  2 +-
 include/ui/sdl2.h          |  2 +-
 include/ui/shader.h        | 12 +++++------
 include/ui/spice-display.h |  2 +-
 ui/console-gl.c            | 45 ++++++----------------------------------
 ui/gtk-egl.c               |  2 +-
 ui/gtk-gl-area.c           |  2 +-
 ui/sdl2-gl.c               |  4 ++--
 ui/shader.c                | 51 ++++++++++++++++++++++++++++++++++++++--------
 ui/spice-display.c         |  2 +-
 12 files changed, 68 insertions(+), 72 deletions(-)

diff --git a/Makefile b/Makefile
index 97b4508d7d..e124f1c5a0 100644
--- a/Makefile
+++ b/Makefile
@@ -672,7 +672,7 @@ ui/shader/%-frag.h: $(SRC_PATH)/ui/shader/%.frag $(SRC_PATH)/scripts/shaderinclu
 		perl $(SRC_PATH)/scripts/shaderinclude.pl $< > $@,\
 		"FRAG","$@")
 
-ui/console-gl.o: $(SRC_PATH)/ui/console-gl.c \
+ui/shader.o: $(SRC_PATH)/ui/shader.c \
 	ui/shader/texture-blit-vert.h ui/shader/texture-blit-frag.h
 
 # documentation
diff --git a/include/ui/console.h b/include/ui/console.h
index 158969f978..580dfc57ee 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
+# include "ui/shader.h"
 #endif
 
 /* keyboard/mouse support */
@@ -415,22 +416,19 @@ void qemu_console_resize(QemuConsole *con, int width, int height);
 DisplaySurface *qemu_console_surface(QemuConsole *con);
 
 /* console-gl.c */
-typedef struct ConsoleGLState ConsoleGLState;
 #ifdef CONFIG_OPENGL
-ConsoleGLState *console_gl_init_context(void);
-void console_gl_fini_context(ConsoleGLState *gls);
 bool console_gl_check_format(DisplayChangeListener *dcl,
                              pixman_format_code_t format);
-void surface_gl_create_texture(ConsoleGLState *gls,
+void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
-void surface_gl_update_texture(ConsoleGLState *gls,
+void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h);
-void surface_gl_render_texture(ConsoleGLState *gls,
+void surface_gl_render_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
-void surface_gl_destroy_texture(ConsoleGLState *gls,
+void surface_gl_destroy_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
-void surface_gl_setup_viewport(ConsoleGLState *gls,
+void surface_gl_setup_viewport(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int ww, int wh);
 #endif
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 2f7b720358..849c896eef 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -47,7 +47,7 @@ typedef struct VirtualGfxConsole {
     double scale_x;
     double scale_y;
 #if defined(CONFIG_OPENGL)
-    ConsoleGLState *gls;
+    QemuGLShader *gls;
     EGLContext ectx;
     EGLSurface esurface;
     int glupdates;
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 454367ac84..b29cf803c9 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -26,7 +26,7 @@ struct sdl2_console {
     int idle_counter;
     SDL_GLContext winctx;
 #ifdef CONFIG_OPENGL
-    ConsoleGLState *gls;
+    QemuGLShader *gls;
     egl_fb guest_fb;
     egl_fb win_fb;
     bool y0_top;
diff --git a/include/ui/shader.h b/include/ui/shader.h
index f7d86188bf..369e49865f 100644
--- a/include/ui/shader.h
+++ b/include/ui/shader.h
@@ -3,13 +3,11 @@
 
 #include <epoxy/gl.h>
 
-GLuint qemu_gl_init_texture_blit(GLint texture_blit_prog);
-void qemu_gl_run_texture_blit(GLint texture_blit_prog,
-                              GLint texture_blit_vao);
+typedef struct QemuGLShader QemuGLShader;
 
-GLuint qemu_gl_create_compile_shader(GLenum type, const GLchar *src);
-GLuint qemu_gl_create_link_program(GLuint vert, GLuint frag);
-GLuint qemu_gl_create_compile_link_program(const GLchar *vert_src,
-                                           const GLchar *frag_src);
+void qemu_gl_run_texture_blit(QemuGLShader *gls);
+
+QemuGLShader *qemu_gl_init_shader(void);
+void qemu_gl_fini_shader(QemuGLShader *gls);
 
 #endif /* QEMU_SHADER_H */
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 4ba9444dba..aaf2019889 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -119,7 +119,7 @@ struct SimpleSpiceDisplay {
     /* opengl rendering */
     QEMUBH *gl_unblock_bh;
     QEMUTimer *gl_unblock_timer;
-    ConsoleGLState *gls;
+    QemuGLShader *gls;
     int gl_updates;
     bool have_scanout;
     bool have_surface;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 5165e21646..9b50daedbd 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -29,40 +29,8 @@
 #include "ui/console.h"
 #include "ui/shader.h"
 
-#include "shader/texture-blit-vert.h"
-#include "shader/texture-blit-frag.h"
-
-struct ConsoleGLState {
-    GLint texture_blit_prog;
-    GLint texture_blit_vao;
-};
-
 /* ---------------------------------------------------------------------- */
 
-ConsoleGLState *console_gl_init_context(void)
-{
-    ConsoleGLState *gls = g_new0(ConsoleGLState, 1);
-
-    gls->texture_blit_prog = qemu_gl_create_compile_link_program
-        (texture_blit_vert_src, texture_blit_frag_src);
-    if (!gls->texture_blit_prog) {
-        exit(1);
-    }
-
-    gls->texture_blit_vao =
-        qemu_gl_init_texture_blit(gls->texture_blit_prog);
-
-    return gls;
-}
-
-void console_gl_fini_context(ConsoleGLState *gls)
-{
-    if (!gls) {
-        return;
-    }
-    g_free(gls);
-}
-
 bool console_gl_check_format(DisplayChangeListener *dcl,
                              pixman_format_code_t format)
 {
@@ -76,7 +44,7 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
     }
 }
 
-void surface_gl_create_texture(ConsoleGLState *gls,
+void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface)
 {
     assert(gls);
@@ -116,7 +84,7 @@ void surface_gl_create_texture(ConsoleGLState *gls,
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
 }
 
-void surface_gl_update_texture(ConsoleGLState *gls,
+void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h)
 {
@@ -133,7 +101,7 @@ void surface_gl_update_texture(ConsoleGLState *gls,
                     + surface_bytes_per_pixel(surface) * x);
 }
 
-void surface_gl_render_texture(ConsoleGLState *gls,
+void surface_gl_render_texture(QemuGLShader *gls,
                                DisplaySurface *surface)
 {
     assert(gls);
@@ -141,11 +109,10 @@ void surface_gl_render_texture(ConsoleGLState *gls,
     glClearColor(0.1f, 0.1f, 0.1f, 0.0f);
     glClear(GL_COLOR_BUFFER_BIT);
 
-    qemu_gl_run_texture_blit(gls->texture_blit_prog,
-                             gls->texture_blit_vao);
+    qemu_gl_run_texture_blit(gls);
 }
 
-void surface_gl_destroy_texture(ConsoleGLState *gls,
+void surface_gl_destroy_texture(QemuGLShader *gls,
                                 DisplaySurface *surface)
 {
     if (!surface || !surface->texture) {
@@ -155,7 +122,7 @@ void surface_gl_destroy_texture(ConsoleGLState *gls,
     surface->texture = 0;
 }
 
-void surface_gl_setup_viewport(ConsoleGLState *gls,
+void surface_gl_setup_viewport(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int ww, int wh)
 {
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 0f0d35e041..eb86c26a1d 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -113,7 +113,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
         if (!vc->gfx.esurface) {
             return;
         }
-        vc->gfx.gls = console_gl_init_context();
+        vc->gfx.gls = qemu_gl_init_shader();
         if (vc->gfx.ds) {
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
         }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 01ebf2c7de..55ba2b57d7 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -96,7 +96,7 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
             return;
         }
         gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
-        vc->gfx.gls = console_gl_init_context();
+        vc->gfx.gls = qemu_gl_init_shader();
         if (vc->gfx.ds) {
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
         }
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 9110491ee5..5e1073a084 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -90,7 +90,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
     scon->surface = new_surface;
 
     if (!new_surface) {
-        console_gl_fini_context(scon->gls);
+        qemu_gl_fini_shader(scon->gls);
         scon->gls = NULL;
         sdl2_window_destroy(scon);
         return;
@@ -98,7 +98,7 @@ void sdl2_gl_switch(DisplayChangeListener *dcl,
 
     if (!scon->real_window) {
         sdl2_window_create(scon);
-        scon->gls = console_gl_init_context();
+        scon->gls = qemu_gl_init_shader();
     } else if (old_surface &&
                ((surface_width(old_surface)  != surface_width(new_surface)) ||
                 (surface_height(old_surface) != surface_height(new_surface)))) {
diff --git a/ui/shader.c b/ui/shader.c
index 1ffddbef3b..d36e7af232 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -28,9 +28,17 @@
 #include "qemu-common.h"
 #include "ui/shader.h"
 
+#include "shader/texture-blit-vert.h"
+#include "shader/texture-blit-frag.h"
+
+struct QemuGLShader {
+    GLint texture_blit_prog;
+    GLint texture_blit_vao;
+};
+
 /* ---------------------------------------------------------------------- */
 
-GLuint qemu_gl_init_texture_blit(GLint texture_blit_prog)
+static GLuint qemu_gl_init_texture_blit(GLint texture_blit_prog)
 {
     static const GLfloat in_position[] = {
         -1, -1,
@@ -60,17 +68,16 @@ GLuint qemu_gl_init_texture_blit(GLint texture_blit_prog)
     return vao;
 }
 
-void qemu_gl_run_texture_blit(GLint texture_blit_prog,
-                              GLint texture_blit_vao)
+void qemu_gl_run_texture_blit(QemuGLShader *gls)
 {
-    glUseProgram(texture_blit_prog);
-    glBindVertexArray(texture_blit_vao);
+    glUseProgram(gls->texture_blit_prog);
+    glBindVertexArray(gls->texture_blit_vao);
     glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
 }
 
 /* ---------------------------------------------------------------------- */
 
-GLuint qemu_gl_create_compile_shader(GLenum type, const GLchar *src)
+static GLuint qemu_gl_create_compile_shader(GLenum type, const GLchar *src)
 {
     GLuint shader;
     GLint status, length;
@@ -94,7 +101,7 @@ GLuint qemu_gl_create_compile_shader(GLenum type, const GLchar *src)
     return shader;
 }
 
-GLuint qemu_gl_create_link_program(GLuint vert, GLuint frag)
+static GLuint qemu_gl_create_link_program(GLuint vert, GLuint frag)
 {
     GLuint program;
     GLint status, length;
@@ -117,8 +124,8 @@ GLuint qemu_gl_create_link_program(GLuint vert, GLuint frag)
     return program;
 }
 
-GLuint qemu_gl_create_compile_link_program(const GLchar *vert_src,
-                                           const GLchar *frag_src)
+static GLuint qemu_gl_create_compile_link_program(const GLchar *vert_src,
+                                                  const GLchar *frag_src)
 {
     GLuint vert_shader, frag_shader, program;
 
@@ -134,3 +141,29 @@ GLuint qemu_gl_create_compile_link_program(const GLchar *vert_src,
 
     return program;
 }
+
+/* ---------------------------------------------------------------------- */
+
+QemuGLShader *qemu_gl_init_shader(void)
+{
+    QemuGLShader *gls = g_new0(QemuGLShader, 1);
+
+    gls->texture_blit_prog = qemu_gl_create_compile_link_program
+        (texture_blit_vert_src, texture_blit_frag_src);
+    if (!gls->texture_blit_prog) {
+        exit(1);
+    }
+
+    gls->texture_blit_vao =
+        qemu_gl_init_texture_blit(gls->texture_blit_prog);
+
+    return gls;
+}
+
+void qemu_gl_fini_shader(QemuGLShader *gls)
+{
+    if (!gls) {
+        return;
+    }
+    g_free(gls);
+}
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 0963c7825f..ad1ceafb3f 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1019,7 +1019,7 @@ static void qemu_spice_display_init_one(QemuConsole *con)
         ssd->gl_unblock_bh = qemu_bh_new(qemu_spice_gl_unblock_bh, ssd);
         ssd->gl_unblock_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
                                              qemu_spice_gl_block_timer, ssd);
-        ssd->gls = console_gl_init_context();
+        ssd->gls = qemu_gl_init_shader();
         ssd->have_surface = false;
         ssd->have_scanout = false;
     }
-- 
2.9.3
