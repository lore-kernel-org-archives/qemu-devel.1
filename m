Received: from eggs.gnu.org ([2001:4830:134:3::10]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSX-0006ni-5F
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSS-0000Ei-UG
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6bSS-0000E0-LT
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCC5D81DFF
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 12:03:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 14:03:15 +0200
Message-Id: <20171023120317.8296-3-kraxel@redhat.com>
In-Reply-To: <20171023120317.8296-1-kraxel@redhat.com>
References: <20171023120317.8296-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] gtk: make GtkGlArea usage a runtime option
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

Compile gtk with both opengl code variants (GtkGlArea widget and
egl context).  This allows to select the code path at runtime.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 53 +++++++++++++++++++++++++++++------------------------
 ui/Makefile.objs |  3 +--
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 849c896eef..f6dafc5961 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -90,6 +90,8 @@ typedef struct VirtualConsole {
     };
 } VirtualConsole;
 
+extern bool gtk_use_gl_area;
+
 /* ui/gtk.c */
 void gd_update_windowsize(VirtualConsole *vc);
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 342e96fbe9..33cd848db3 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -191,6 +191,8 @@ typedef struct VCChardev {
 #define TYPE_CHARDEV_VC "chardev-vc"
 #define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
 
+bool gtk_use_gl_area;
+
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
@@ -401,7 +403,7 @@ static void gd_update_full_redraw(VirtualConsole *vc)
     int ww, wh;
     gdk_drawable_get_size(gtk_widget_get_window(area), &ww, &wh);
 #if defined(CONFIG_GTK_GL)
-    if (vc->gfx.gls) {
+    if (vc->gfx.gls && gtk_use_gl_area) {
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
         return;
     }
@@ -673,7 +675,7 @@ static const DisplayChangeListenerOps dcl_gl_area_ops = {
     .dpy_gl_update           = gd_gl_area_scanout_flush,
 };
 
-#else
+#endif /* CONFIG_GTK_GL */
 
 static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_name             = "gtk-egl",
@@ -693,7 +695,6 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_update           = gd_egl_scanout_flush,
 };
 
-#endif /* CONFIG_GTK_GL */
 #endif /* CONFIG_OPENGL */
 
 /** QEMU Events **/
@@ -787,13 +788,13 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 
 #if defined(CONFIG_OPENGL)
     if (vc->gfx.gls) {
-#if defined(CONFIG_GTK_GL)
-        /* invoke render callback please */
-        return FALSE;
-#else
-        gd_egl_draw(vc);
-        return TRUE;
-#endif
+        if (gtk_use_gl_area) {
+            /* invoke render callback please */
+            return FALSE;
+        } else {
+            gd_egl_draw(vc);
+            return TRUE;
+        }
     }
 #endif
 
@@ -1899,7 +1900,7 @@ static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
     g_signal_connect(vc->gfx.drawing_area, "draw",
                      G_CALLBACK(gd_draw_event), vc);
 #if defined(CONFIG_GTK_GL)
-    if (display_opengl) {
+    if (gtk_use_gl_area) {
         /* wire up GtkGlArea events */
         g_signal_connect(vc->gfx.drawing_area, "render",
                          G_CALLBACK(gd_render_event), vc);
@@ -2022,26 +2023,29 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 #if defined(CONFIG_OPENGL)
     if (display_opengl) {
 #if defined(CONFIG_GTK_GL)
-        vc->gfx.drawing_area = gtk_gl_area_new();
-        vc->gfx.dcl.ops = &dcl_gl_area_ops;
-#else
-        vc->gfx.drawing_area = gtk_drawing_area_new();
-        /*
-         * gtk_widget_set_double_buffered() was deprecated in 3.14.
-         * It is required for opengl rendering on X11 though.  A
-         * proper replacement (native opengl support) is only
-         * available in 3.16+.  Silence the warning if possible.
-         */
+        if (gtk_use_gl_area) {
+            vc->gfx.drawing_area = gtk_gl_area_new();
+            vc->gfx.dcl.ops = &dcl_gl_area_ops;
+        } else
+#endif /* CONFIG_GTK_GL */
+        {
+            vc->gfx.drawing_area = gtk_drawing_area_new();
+            /*
+             * gtk_widget_set_double_buffered() was deprecated in 3.14.
+             * It is required for opengl rendering on X11 though.  A
+             * proper replacement (native opengl support) is only
+             * available in 3.16+.  Silence the warning if possible.
+             */
 #ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 #endif
-        gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
+            gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
 #ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic pop
 #endif
-        vc->gfx.dcl.ops = &dcl_egl_ops;
-#endif /* CONFIG_GTK_GL */
+            vc->gfx.dcl.ops = &dcl_egl_ops;
+        }
     } else
 #endif
     {
@@ -2371,6 +2375,7 @@ void early_gtk_display_init(int opengl)
     case 1: /* on */
 #if defined(CONFIG_OPENGL)
 #if defined(CONFIG_GTK_GL)
+        gtk_use_gl_area = true;
         gtk_gl_area_init();
 #else
         gtk_egl_init();
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index ec8533d6d9..45703e7c85 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -37,10 +37,9 @@ common-obj-y += egl-context.o
 common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
 common-obj-$(CONFIG_GTK) += gtk-gl-area.o
-else
+endif
 common-obj-$(CONFIG_GTK) += gtk-egl.o
 endif
-endif
 
 gtk.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
 gtk-egl.o-cflags := $(GTK_CFLAGS) $(VTE_CFLAGS)
-- 
2.9.3
