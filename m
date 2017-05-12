Received: from eggs.gnu.org ([2001:4830:134:3::10]:60931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996q-0002tI-7A
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996o-00056j-TW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996o-000563-Kz
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 846EC7AE8B
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:51:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:33 +0200
Message-Id: <20170512115135.17379-9-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] opengl: add egl-headless display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add egl-headless user interface.  It doesn't provide a real user
interface, it only provides opengl support using drm render nodes.
It will copy back the bits rendered by the guest using virgl back
to a DisplaySurface and kick the usual display update code paths,
so spice and vnc and screendump can pick it up.

Use it this way:
  qemu -display egl-headless -vnc $display
  qemu -display egl-headless -spice gl=off,$args

Note that you should prefer native spice opengl support (-spice
gl=on) if possible because that delivers better performance.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20170505104101.30589-7-kraxel@redhat.com
---
 include/ui/console.h |   3 +
 ui/egl-headless.c    | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                 |  16 ++++++
 ui/Makefile.objs     |   1 +
 4 files changed, 178 insertions(+)
 create mode 100644 ui/egl-headless.c

diff --git a/include/ui/console.h b/include/ui/console.h
index d759338816..7262bef6d3 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -527,4 +527,7 @@ static inline void early_gtk_display_init(int opengl)
 }
 #endif
 
+/* egl-headless.c */
+void egl_headless_init(void);
+
 #endif
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
new file mode 100644
index 0000000000..d8d800f8a6
--- /dev/null
+++ b/ui/egl-headless.c
@@ -0,0 +1,158 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+#include "ui/console.h"
+#include "ui/egl-helpers.h"
+#include "ui/egl-context.h"
+
+typedef struct egl_dpy {
+    DisplayChangeListener dcl;
+    DisplaySurface *ds;
+    int width, height;
+    GLuint texture;
+    GLuint framebuffer;
+    GLuint blit_texture;
+    GLuint blit_framebuffer;
+    bool y_0_top;
+} egl_dpy;
+
+static void egl_refresh(DisplayChangeListener *dcl)
+{
+    graphic_hw_update(dcl->con);
+}
+
+static void egl_gfx_update(DisplayChangeListener *dcl,
+                           int x, int y, int w, int h)
+{
+}
+
+static void egl_gfx_switch(DisplayChangeListener *dcl,
+                           struct DisplaySurface *new_surface)
+{
+    egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
+
+    edpy->ds = new_surface;
+}
+
+static void egl_scanout_disable(DisplayChangeListener *dcl)
+{
+    egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
+
+    edpy->texture = 0;
+    /* XXX: delete framebuffers here ??? */
+}
+
+static void egl_scanout_texture(DisplayChangeListener *dcl,
+                                uint32_t backing_id,
+                                bool backing_y_0_top,
+                                uint32_t backing_width,
+                                uint32_t backing_height,
+                                uint32_t x, uint32_t y,
+                                uint32_t w, uint32_t h)
+{
+    egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
+
+    edpy->texture = backing_id;
+    edpy->y_0_top = backing_y_0_top;
+
+    /* source framebuffer */
+    if (!edpy->framebuffer) {
+        glGenFramebuffers(1, &edpy->framebuffer);
+    }
+    glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->framebuffer);
+    glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
+                              GL_TEXTURE_2D, edpy->texture, 0);
+
+    /* dest framebuffer */
+    if (!edpy->blit_framebuffer) {
+        glGenFramebuffers(1, &edpy->blit_framebuffer);
+        glGenTextures(1, &edpy->blit_texture);
+        edpy->width = 0;
+        edpy->height = 0;
+    }
+    if (edpy->width != backing_width || edpy->height != backing_height) {
+        edpy->width   = backing_width;
+        edpy->height  = backing_height;
+        glBindTexture(GL_TEXTURE_2D, edpy->blit_texture);
+        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,
+                     edpy->width, edpy->height,
+                     0, GL_BGRA, GL_UNSIGNED_BYTE, 0);
+        glBindFramebuffer(GL_FRAMEBUFFER_EXT, edpy->blit_framebuffer);
+        glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
+                                  GL_TEXTURE_2D, edpy->blit_texture, 0);
+    }
+}
+
+static void egl_scanout_flush(DisplayChangeListener *dcl,
+                              uint32_t x, uint32_t y,
+                              uint32_t w, uint32_t h)
+{
+    egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
+    GLuint y1, y2;
+
+    if (!edpy->texture || !edpy->ds) {
+        return;
+    }
+    assert(surface_width(edpy->ds)  == edpy->width);
+    assert(surface_height(edpy->ds) == edpy->height);
+    assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
+
+    /* blit framebuffer, flip if needed */
+    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->framebuffer);
+    glBindFramebuffer(GL_DRAW_FRAMEBUFFER, edpy->blit_framebuffer);
+    glViewport(0, 0, edpy->width, edpy->height);
+    y1 = edpy->y_0_top ? edpy->height : 0;
+    y2 = edpy->y_0_top ? 0 : edpy->height;
+    glBlitFramebuffer(0, y1, edpy->width, y2,
+                      0, 0, edpy->width, edpy->height,
+                      GL_COLOR_BUFFER_BIT, GL_NEAREST);
+
+    /* read pixels to surface */
+    glBindFramebuffer(GL_READ_FRAMEBUFFER, edpy->blit_framebuffer);
+    glReadBuffer(GL_COLOR_ATTACHMENT0_EXT);
+    glReadPixels(0, 0, edpy->width, edpy->height,
+                 GL_BGRA, GL_UNSIGNED_BYTE, surface_data(edpy->ds));
+
+    /* notify about updates */
+    dpy_gfx_update(edpy->dcl.con, x, y, w, h);
+}
+
+static const DisplayChangeListenerOps egl_ops = {
+    .dpy_name                = "egl-headless",
+    .dpy_refresh             = egl_refresh,
+    .dpy_gfx_update          = egl_gfx_update,
+    .dpy_gfx_switch          = egl_gfx_switch,
+
+    .dpy_gl_ctx_create       = qemu_egl_create_context,
+    .dpy_gl_ctx_destroy      = qemu_egl_destroy_context,
+    .dpy_gl_ctx_make_current = qemu_egl_make_context_current,
+    .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
+
+    .dpy_gl_scanout_disable  = egl_scanout_disable,
+    .dpy_gl_scanout_texture  = egl_scanout_texture,
+    .dpy_gl_update           = egl_scanout_flush,
+};
+
+void egl_headless_init(void)
+{
+    QemuConsole *con;
+    egl_dpy *edpy;
+    int idx;
+
+    if (egl_rendernode_init(NULL) < 0) {
+        error_report("egl: render node init failed");
+        exit(1);
+    }
+
+    for (idx = 0;; idx++) {
+        con = qemu_console_lookup_by_index(idx);
+        if (!con || !qemu_console_is_graphic(con)) {
+            break;
+        }
+
+        edpy = g_new0(egl_dpy, 1);
+        edpy->dcl.con = con;
+        edpy->dcl.ops = &egl_ops;
+        register_displaychangelistener(&edpy->dcl);
+    }
+}
diff --git a/vl.c b/vl.c
index 58023fca02..aca99e1c77 100644
--- a/vl.c
+++ b/vl.c
@@ -2050,6 +2050,7 @@ typedef enum DisplayType {
     DT_SDL,
     DT_COCOA,
     DT_GTK,
+    DT_EGL,
     DT_NONE,
 } DisplayType;
 
@@ -2127,6 +2128,15 @@ static DisplayType select_display(const char *p)
             error_report("VNC requires a display argument vnc=<display>");
             exit(1);
         }
+    } else if (strstart(p, "egl-headless", &opts)) {
+#ifdef CONFIG_OPENGL
+        request_opengl = 1;
+        display_opengl = 1;
+        display = DT_EGL;
+#else
+        fprintf(stderr, "egl support is disabled\n");
+        exit(1);
+#endif
     } else if (strstart(p, "curses", &opts)) {
 #ifdef CONFIG_CURSES
         display = DT_CURSES;
@@ -4659,6 +4669,12 @@ int main(int argc, char **argv, char **envp)
         qemu_spice_display_init();
     }
 
+#ifdef CONFIG_OPENGL
+    if (display_type == DT_EGL) {
+        egl_headless_init();
+    }
+#endif
+
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 27566b32f1..aac6ae8bef 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -33,6 +33,7 @@ common-obj-y += shader.o
 common-obj-y += console-gl.o
 common-obj-y += egl-helpers.o
 common-obj-y += egl-context.o
+common-obj-y += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
 common-obj-$(CONFIG_GTK) += gtk-gl-area.o
 else
-- 
2.9.3
