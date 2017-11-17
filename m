Received: from eggs.gnu.org ([2001:4830:134:3::10]:49936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvH-0000qs-DR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvA-0007LH-VG
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvA-0007K2-Lv
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E29D419D4C9
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:36 +0100
Message-Id: <20171117103046.15943-15-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 14/24] console: add qemu display registry,
 add gtk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add a registry for user interfaces.  Add qemu_display_init and
qemu_display_early_init helper functions for display initialization.

Hook up gtk ui as first user.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 32 ++++++++++++--------------------
 ui/console.c         | 34 ++++++++++++++++++++++++++++++++++
 ui/gtk.c             | 17 +++++++++++++++--
 vl.c                 | 18 ++++++------------
 4 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index f96fd907d0..b293c26477 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -433,6 +433,18 @@ void surface_gl_setup_viewport(QemuGLShader *gls,
                                int ww, int wh);
 #endif
 
+typedef struct QemuDisplay QemuDisplay;
+
+struct QemuDisplay {
+    DisplayType type;
+    void (*early_init)(DisplayOptions *opts);
+    void (*init)(DisplayState *ds, DisplayOptions *opts);
+};
+
+void qemu_display_register(QemuDisplay *ui);
+void qemu_display_early_init(DisplayOptions *opts);
+void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
+
 /* sdl.c */
 #ifdef CONFIG_SDL
 void sdl_display_early_init(DisplayOptions *opts);
@@ -509,26 +521,6 @@ static inline void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 /* input.c */
 int index_from_key(const char *key, size_t key_length);
 
-/* gtk.c */
-#ifdef CONFIG_GTK
-void early_gtk_display_init(DisplayOptions *opts);
-void gtk_display_init(DisplayState *ds, DisplayOptions *opts);
-#else
-static inline void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
-{
-    /* This must never be called if CONFIG_GTK is disabled */
-    error_report("GTK support is disabled");
-    abort();
-}
-
-static inline void early_gtk_display_init(DisplayOptions *opts)
-{
-    /* This must never be called if CONFIG_GTK is disabled */
-    error_report("GTK support is disabled");
-    abort();
-}
-#endif
-
 /* egl-headless.c */
 void egl_headless_init(DisplayOptions *opts);
 
diff --git a/ui/console.c b/ui/console.c
index c4c95abed7..aa8afbfe26 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2168,6 +2168,40 @@ PixelFormat qemu_default_pixelformat(int bpp)
     return pf;
 }
 
+static QemuDisplay *dpys[DISPLAY_TYPE__MAX];
+
+void qemu_display_register(QemuDisplay *ui)
+{
+    assert(ui->type < DISPLAY_TYPE__MAX);
+    dpys[ui->type] = ui;
+}
+
+void qemu_display_early_init(DisplayOptions *opts)
+{
+    assert(opts->type < DISPLAY_TYPE__MAX);
+    if (opts->type == DISPLAY_TYPE_NONE) {
+        return;
+    }
+    if (dpys[opts->type] == NULL) {
+        error_report("Display '%s' is not available.",
+                     DisplayType_lookup.array[opts->type]);
+        exit(1);
+    }
+    if (dpys[opts->type]->early_init) {
+        dpys[opts->type]->early_init(opts);
+    }
+}
+
+void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
+{
+    assert(opts->type < DISPLAY_TYPE__MAX);
+    if (opts->type == DISPLAY_TYPE_NONE) {
+        return;
+    }
+    assert(dpys[opts->type] != NULL);
+    dpys[opts->type]->init(ds, opts);
+}
+
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     int val;
diff --git a/ui/gtk.c b/ui/gtk.c
index c2426dd44e..18020543ce 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2242,7 +2242,7 @@ static void gd_set_keycode_type(GtkDisplayState *s)
 
 static gboolean gtkinit;
 
-void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
+static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     VirtualConsole *vc;
 
@@ -2349,7 +2349,7 @@ void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     gd_set_keycode_type(s);
 }
 
-void early_gtk_display_init(DisplayOptions *opts)
+static void early_gtk_display_init(DisplayOptions *opts)
 {
     /* The QEMU code relies on the assumption that it's always run in
      * the C locale. Therefore it is not prepared to deal with
@@ -2390,3 +2390,16 @@ void early_gtk_display_init(DisplayOptions *opts)
     type_register(&char_gd_vc_type_info);
 #endif
 }
+
+static QemuDisplay qemu_display_gtk = {
+    .type       = DISPLAY_TYPE_GTK,
+    .early_init = early_gtk_display_init,
+    .init       = gtk_display_init,
+};
+
+static void register_gtk(void)
+{
+    qemu_display_register(&qemu_display_gtk);
+}
+
+type_init(register_gtk);
diff --git a/vl.c b/vl.c
index c04cef83da..57e775f8cd 100644
--- a/vl.c
+++ b/vl.c
@@ -2209,7 +2209,6 @@ static void parse_display(const char *p)
         exit(1);
 #endif
     } else if (strstart(p, "gtk", &opts)) {
-#ifdef CONFIG_GTK
         dpy.type = DISPLAY_TYPE_GTK;
         while (*opts) {
             const char *nextopt;
@@ -2241,10 +2240,6 @@ static void parse_display(const char *p)
             }
             opts = nextopt;
         }
-#else
-        error_report("GTK support is disabled");
-        exit(1);
-#endif
     } else if (strstart(p, "none", &opts)) {
         dpy.type = DISPLAY_TYPE_NONE;
     } else {
@@ -4439,6 +4434,9 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_NONE;
 #endif
     }
+    if (dpy.type == DISPLAY_TYPE_DEFAULT) {
+        dpy.type = DISPLAY_TYPE_NONE;
+    }
 
     if (dpy.has_window_close &&
         (dpy.type != DISPLAY_TYPE_GTK && dpy.type != DISPLAY_TYPE_SDL)) {
@@ -4446,12 +4444,10 @@ int main(int argc, char **argv, char **envp)
                      "ignoring option");
     }
 
-    if (dpy.type == DISPLAY_TYPE_GTK) {
-        early_gtk_display_init(&dpy);
-    }
-
     if (dpy.type == DISPLAY_TYPE_SDL) {
         sdl_display_early_init(&dpy);
+    } else {
+        qemu_display_early_init(&dpy);
     }
 
     qemu_console_early_init();
@@ -4793,10 +4789,8 @@ int main(int argc, char **argv, char **envp)
     case DISPLAY_TYPE_COCOA:
         cocoa_display_init(ds, &dpy);
         break;
-    case DISPLAY_TYPE_GTK:
-        gtk_display_init(ds, &dpy);
-        break;
     default:
+        qemu_display_init(ds, &dpy);
         break;
     }
 
-- 
2.9.3
