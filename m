Received: from eggs.gnu.org ([2001:4830:134:3::10]:44082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcem-0005VY-8e
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcei-00060x-1t
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:49:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehceh-000608-Nd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:49:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BA7A80E45
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 11:10:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 12:10:14 +0100
Message-Id: <20180202111022.19269-5-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-1-kraxel@redhat.com>
References: <20180202111022.19269-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/12] gtk: add and use DisplayOptions +
 DisplayGTK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add QAPI DisplayType enum, DisplayOptions union and DisplayGTK struct.
Switch gtk configuration to use the qapi type.

Some bookkeeping (fullscreen for example) is done twice now, this is
temporary until more/all UIs are switched over to qapi configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  9 ++++----
 ui/gtk.c             | 32 ++++++++++++++++-------------
 vl.c                 | 23 ++++++++++++++++-----
 qapi/ui.json         | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 24 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 7b35778444..58d1a3d27c 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -511,18 +511,17 @@ int index_from_key(const char *key, size_t key_length);
 
 /* gtk.c */
 #ifdef CONFIG_GTK
-void early_gtk_display_init(int opengl);
-void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover);
+void early_gtk_display_init(DisplayOptions *opts);
+void gtk_display_init(DisplayState *ds, DisplayOptions *opts);
 #else
-static inline void gtk_display_init(DisplayState *ds, bool full_screen,
-                                    bool grab_on_hover)
+static inline void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     /* This must never be called if CONFIG_GTK is disabled */
     error_report("GTK support is disabled");
     abort();
 }
 
-static inline void early_gtk_display_init(int opengl)
+static inline void early_gtk_display_init(DisplayOptions *opts)
 {
     /* This must never be called if CONFIG_GTK is disabled */
     error_report("GTK support is disabled");
diff --git a/ui/gtk.c b/ui/gtk.c
index f0ad63e431..c12d5e020c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -229,6 +229,8 @@ struct GtkDisplayState {
 
     bool modifier_pressed[ARRAY_SIZE(modifier_keycode)];
     bool ignore_keys;
+
+    DisplayOptions *opts;
 };
 
 typedef struct VCChardev {
@@ -777,9 +779,14 @@ static gboolean gd_window_close(GtkWidget *widget, GdkEvent *event,
                                 void *opaque)
 {
     GtkDisplayState *s = opaque;
+    bool allow_close = true;
     int i;
 
-    if (!no_quit) {
+    if (s->opts->has_window_close && !s->opts->window_close) {
+        allow_close = false;
+    }
+
+    if (allow_close) {
         for (i = 0; i < s->nb_vcs; i++) {
             if (s->vc[i].type != GD_VC_GFX) {
                 continue;
@@ -2289,7 +2296,7 @@ static void gd_create_menus(GtkDisplayState *s)
 
 static gboolean gtkinit;
 
-void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
+void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     VirtualConsole *vc;
 
@@ -2301,6 +2308,8 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
         fprintf(stderr, "gtk initialization failed\n");
         exit(1);
     }
+    assert(opts->type == DISPLAY_TYPE_GTK);
+    s->opts = opts;
 
 #if !GTK_CHECK_VERSION(3, 0, 0)
     g_printerr("Running QEMU with GTK 2.x is deprecated, and will be removed\n"
@@ -2387,15 +2396,17 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
                              vc && vc->type == GD_VC_VTE);
 #endif
 
-    if (full_screen) {
+    if (opts->has_full_screen &&
+        opts->full_screen) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->full_screen_item));
     }
-    if (grab_on_hover) {
+    if (opts->u.gtk.has_grab_on_hover &&
+        opts->u.gtk.grab_on_hover) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->grab_on_hover_item));
     }
 }
 
-void early_gtk_display_init(int opengl)
+void early_gtk_display_init(DisplayOptions *opts)
 {
     /* The QEMU code relies on the assumption that it's always run in
      * the C locale. Therefore it is not prepared to deal with
@@ -2421,11 +2432,8 @@ void early_gtk_display_init(int opengl)
         return;
     }
 
-    switch (opengl) {
-    case -1: /* default */
-    case 0:  /* off */
-        break;
-    case 1: /* on */
+    assert(opts->type == DISPLAY_TYPE_GTK);
+    if (opts->has_gl && opts->gl) {
 #if defined(CONFIG_OPENGL)
 #if defined(CONFIG_GTK_GL)
         gtk_gl_area_init();
@@ -2433,10 +2441,6 @@ void early_gtk_display_init(int opengl)
         gtk_egl_init();
 #endif
 #endif
-        break;
-    default:
-        g_assert_not_reached();
-        break;
     }
 
     keycode_map = gd_get_keymap(&keycode_maplen);
diff --git a/vl.c b/vl.c
index a2478412c7..4a555de0cf 100644
--- a/vl.c
+++ b/vl.c
@@ -150,9 +150,9 @@ static int rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static int full_screen = 0;
+static DisplayOptions dpy;
 int no_frame;
 int no_quit = 0;
-static bool grab_on_hover;
 Chardev *serial_hds[MAX_SERIAL_PORTS];
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
@@ -2191,24 +2191,29 @@ static LegacyDisplayType select_display(const char *p)
     } else if (strstart(p, "gtk", &opts)) {
 #ifdef CONFIG_GTK
         display = DT_GTK;
+        dpy.type = DISPLAY_TYPE_GTK;
         while (*opts) {
             const char *nextopt;
 
             if (strstart(opts, ",grab_on_hover=", &nextopt)) {
                 opts = nextopt;
+                dpy.u.gtk.has_grab_on_hover = true;
                 if (strstart(opts, "on", &nextopt)) {
-                    grab_on_hover = true;
+                    dpy.u.gtk.grab_on_hover = true;
                 } else if (strstart(opts, "off", &nextopt)) {
-                    grab_on_hover = false;
+                    dpy.u.gtk.grab_on_hover = false;
                 } else {
                     goto invalid_gtk_args;
                 }
             } else if (strstart(opts, ",gl=", &nextopt)) {
                 opts = nextopt;
+                dpy.has_gl = true;
                 if (strstart(opts, "on", &nextopt)) {
                     request_opengl = 1;
+                    dpy.gl = true;
                 } else if (strstart(opts, "off", &nextopt)) {
                     request_opengl = 0;
+                    dpy.gl = false;
                 } else {
                     goto invalid_gtk_args;
                 }
@@ -2225,6 +2230,7 @@ static LegacyDisplayType select_display(const char *p)
 #endif
     } else if (strstart(p, "none", &opts)) {
         display = DT_NONE;
+        dpy.type = DISPLAY_TYPE_NONE;
     } else {
         error_report("unknown display type");
         exit(1);
@@ -3259,6 +3265,7 @@ int main(int argc, char **argv, char **envp)
                 qemu_opts_parse_noisily(olist, "graphics=off", false);
                 nographic = true;
                 display_type = DT_NONE;
+                dpy.type = DISPLAY_TYPE_NONE;
                 break;
             case QEMU_OPTION_curses:
 #ifdef CONFIG_CURSES
@@ -3646,6 +3653,8 @@ int main(int argc, char **argv, char **envp)
                 break;
             case QEMU_OPTION_full_screen:
                 full_screen = 1;
+                dpy.has_full_screen = true;
+                dpy.full_screen = true;
                 break;
             case QEMU_OPTION_no_frame:
                 g_printerr("The -no-frame switch is deprecated, and will be\n"
@@ -3664,6 +3673,8 @@ int main(int argc, char **argv, char **envp)
                 break;
             case QEMU_OPTION_no_quit:
                 no_quit = 1;
+                dpy.has_window_close = true;
+                dpy.window_close = false;
                 break;
             case QEMU_OPTION_sdl:
 #ifdef CONFIG_SDL
@@ -4331,6 +4342,7 @@ int main(int argc, char **argv, char **envp)
     if (display_type == DT_DEFAULT && !display_remote) {
 #if defined(CONFIG_GTK)
         display_type = DT_GTK;
+        dpy.type = DISPLAY_TYPE_GTK;
 #elif defined(CONFIG_SDL)
         display_type = DT_SDL;
 #elif defined(CONFIG_COCOA)
@@ -4339,6 +4351,7 @@ int main(int argc, char **argv, char **envp)
         vnc_parse("localhost:0,to=99,id=default", &error_abort);
 #else
         display_type = DT_NONE;
+        dpy.type = DISPLAY_TYPE_NONE;
 #endif
     }
 
@@ -4352,7 +4365,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (display_type == DT_GTK) {
-        early_gtk_display_init(request_opengl);
+        early_gtk_display_init(&dpy);
     }
 
     if (display_type == DT_SDL) {
@@ -4697,7 +4710,7 @@ int main(int argc, char **argv, char **envp)
         cocoa_display_init(ds, full_screen);
         break;
     case DT_GTK:
-        gtk_display_init(ds, full_screen, grab_on_hover);
+        gtk_display_init(ds, &dpy);
         break;
     default:
         break;
diff --git a/qapi/ui.json b/qapi/ui.json
index 07b468f625..bdb166a608 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -982,3 +982,61 @@
   'data': { '*device': 'str',
             '*head'  : 'int',
             'events' : [ 'InputEvent' ] } }
+
+
+##
+# @DisplayNoOpts:
+#
+# Empty struct for displays without config options.
+#
+# Since: 2.12
+#
+##
+{ 'struct'  : 'DisplayNoOpts',
+  'data'    : { } }
+
+##
+# @DisplayGTK:
+#
+# GTK display options.
+#
+# @grab-on-hover: Grab keyboard input on mouse hover.
+#
+# Since: 2.12
+#
+##
+{ 'struct'  : 'DisplayGTK',
+  'data'    : { '*grab-on-hover' : 'bool' } }
+
+##
+# @DisplayType:
+#
+# Display (user interface) type.
+#
+# Since: 2.12
+#
+##
+{ 'enum'    : 'DisplayType',
+  'data'    : [ 'none', 'gtk' ] }
+
+##
+# @DisplayOptions:
+#
+# Display (user interface) options.
+#
+# @type:          Which DisplayType qemu should use.
+# @full-screen:   Start user interface in fullscreen mode (default: off).
+# @window-close:  Allow to quit qemu with window close button (default: on).
+# @gl:            Enable OpenGL support (default: off).
+#
+# Since: 2.12
+#
+##
+{ 'union'   : 'DisplayOptions',
+  'base'    : { 'type'           : 'DisplayType',
+                '*full-screen'   : 'bool',
+                '*window-close'  : 'bool',
+                '*gl'            : 'bool' },
+  'discriminator' : 'type',
+  'data'    : { 'none'           : 'DisplayNoOpts',
+                'gtk'            : 'DisplayGTK' } }
-- 
2.9.3
