Received: from eggs.gnu.org ([2001:4830:134:3::10]:46294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIL-0001dY-E1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaII-0003Cp-G0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqaII-0003CQ-BA
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0132540201A5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:07:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:07:13 +0100
Message-Id: <20180227080724.13585-2-kraxel@redhat.com>
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] console: add qemu display registry,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add a registry for user interfaces.  Add qemu_display_init and
qemu_display_early_init helper functions for display initialization.

Hook up gtk ui as first user.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-2-kraxel@redhat.com
---
 include/ui/console.h | 32 ++++++++++++--------------------
 ui/console.c         | 34 ++++++++++++++++++++++++++++++++++
 ui/gtk.c             | 17 +++++++++++++++--
 vl.c                 | 18 ++++++------------
 4 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index f29bacd625..817f9b9bcc 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -432,6 +432,18 @@ void surface_gl_setup_viewport(QemuGLShader *gls,
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
@@ -487,26 +499,6 @@ static inline void curses_display_init(DisplayState *ds, DisplayOptions *opts)
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
index e22931a396..a11b120fc8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2180,6 +2180,40 @@ PixelFormat qemu_default_pixelformat(int bpp)
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
index ab646b70e1..c63408e036 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2297,7 +2297,7 @@ static void gd_create_menus(GtkDisplayState *s)
 
 static gboolean gtkinit;
 
-void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
+static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     VirtualConsole *vc;
 
@@ -2407,7 +2407,7 @@ void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 }
 
-void early_gtk_display_init(DisplayOptions *opts)
+static void early_gtk_display_init(DisplayOptions *opts)
 {
     /* The QEMU code relies on the assumption that it's always run in
      * the C locale. Therefore it is not prepared to deal with
@@ -2450,3 +2450,16 @@ void early_gtk_display_init(DisplayOptions *opts)
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
index 9e7235df6d..70458ba708 100644
--- a/vl.c
+++ b/vl.c
@@ -2173,7 +2173,6 @@ static void parse_display(const char *p)
         exit(1);
 #endif
     } else if (strstart(p, "gtk", &opts)) {
-#ifdef CONFIG_GTK
         dpy.type = DISPLAY_TYPE_GTK;
         while (*opts) {
             const char *nextopt;
@@ -2205,10 +2204,6 @@ static void parse_display(const char *p)
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
@@ -4318,6 +4313,9 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_NONE;
 #endif
     }
+    if (dpy.type == DISPLAY_TYPE_DEFAULT) {
+        dpy.type = DISPLAY_TYPE_NONE;
+    }
 
     if ((no_frame || alt_grab || ctrl_grab) && dpy.type != DISPLAY_TYPE_SDL) {
         error_report("-no-frame, -alt-grab and -ctrl-grab are only valid "
@@ -4329,12 +4327,10 @@ int main(int argc, char **argv, char **envp)
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
@@ -4674,10 +4670,8 @@ int main(int argc, char **argv, char **envp)
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
