Received: from eggs.gnu.org ([2001:4830:134:3::10]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJXB-0007CP-LZ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX5-0004YN-3X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX4-0004Vt-Tm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FCFF4068030
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:13:55 +0100
Message-Id: <20180312091405.19610-5-kraxel@redhat.com>
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] ui/gtk: make GtkGlArea usage a runtime
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Compile in both gtk-egl and gtk-gl-area, then allow to choose at runtime
instead of compile time which opengl variant we want use.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180306090951.22932-2-kraxel@redhat.com
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
index 563cff32b8..856429a02f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -243,6 +243,8 @@ typedef struct VCChardev {
 #define TYPE_CHARDEV_VC "chardev-vc"
 #define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
 
+bool gtk_use_gl_area;
+
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
@@ -453,7 +455,7 @@ static void gd_update_full_redraw(VirtualConsole *vc)
     int ww, wh;
     gdk_drawable_get_size(gtk_widget_get_window(area), &ww, &wh);
 #if defined(CONFIG_GTK_GL)
-    if (vc->gfx.gls) {
+    if (vc->gfx.gls && gtk_use_gl_area) {
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
         return;
     }
@@ -725,7 +727,7 @@ static const DisplayChangeListenerOps dcl_gl_area_ops = {
     .dpy_gl_update           = gd_gl_area_scanout_flush,
 };
 
-#else
+#endif /* CONFIG_GTK_GL */
 
 static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_name             = "gtk-egl",
@@ -745,7 +747,6 @@ static const DisplayChangeListenerOps dcl_egl_ops = {
     .dpy_gl_update           = gd_egl_scanout_flush,
 };
 
-#endif /* CONFIG_GTK_GL */
 #endif /* CONFIG_OPENGL */
 
 /** QEMU Events **/
@@ -844,13 +845,13 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 
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
 
@@ -1993,7 +1994,7 @@ static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
     g_signal_connect(vc->gfx.drawing_area, "draw",
                      G_CALLBACK(gd_draw_event), vc);
 #if defined(CONFIG_GTK_GL)
-    if (display_opengl) {
+    if (gtk_use_gl_area) {
         /* wire up GtkGlArea events */
         g_signal_connect(vc->gfx.drawing_area, "render",
                          G_CALLBACK(gd_render_event), vc);
@@ -2116,26 +2117,29 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
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
@@ -2437,6 +2441,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
     if (opts->has_gl && opts->gl) {
 #if defined(CONFIG_OPENGL)
 #if defined(CONFIG_GTK_GL)
+        gtk_use_gl_area = true;
         gtk_gl_area_init();
 #else
         gtk_egl_init();
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index dcd54a5287..d1203bb80a 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -52,11 +52,10 @@ common-obj-y += egl-context.o
 common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
 ifeq ($(CONFIG_GTK_GL),y)
 gtk.mo-objs += gtk-gl-area.o
-else
+endif
 gtk.mo-objs += gtk-egl.o
 gtk.mo-libs += $(OPENGL_LIBS)
 endif
-endif
 
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
-- 
2.9.3
