Received: from eggs.gnu.org ([2001:4830:134:3::10]:48826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkST-00013L-4U
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkS7-0003VA-L5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkS7-0003UW-00
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:38:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BC4981DFF
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 12:38:06 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 13:37:43 +0100
Message-Id: <20170912123744.14730-12-berrange@redhat.com>
In-Reply-To: <20170912123744.14730-1-berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 11/12] ui: convert GTK and SDL1 frontends to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The x_keycode_to_pc_keycode and evdev_keycode_to_pc_keycode
tables are replaced with automatically generated tables.
In addition the X11 heuristics are improved to detect running
on XQuartz and XWin X11 servers, to activate the correct OS-X
and Win32 keycode maps.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h                     |  21 ++
 ui/Makefile.objs                       |  12 +-
 ui/gtk.c                               | 205 +++++++++------
 ui/input-keymap-atset1-to-qcode.c      | 245 +++++++++++++++++
 ui/input-keymap-win32-to-qcode.c       | 157 +++++++++++
 ui/input-keymap-x11-to-qcode.c         | 163 ++++++++++++
 ui/input-keymap-xorgevdev-to-qcode.c   | 463 +++++++++++++++++++++++++++++++++
 ui/input-keymap-xorgkbd-to-qcode.c     | 122 +++++++++
 ui/input-keymap-xorgxquartz-to-qcode.c | 128 +++++++++
 ui/input-keymap-xorgxwin-to-qcode.c    | 122 +++++++++
 ui/input-keymap.c                      |   7 +
 ui/sdl.c                               | 105 +++-----
 ui/trace-events                        |   9 +-
 ui/x_keymap.c                          | 250 +++++++-----------
 ui/x_keymap.h                          |   8 +-
 15 files changed, 1700 insertions(+), 317 deletions(-)
 create mode 100644 ui/input-keymap-atset1-to-qcode.c
 create mode 100644 ui/input-keymap-win32-to-qcode.c
 create mode 100644 ui/input-keymap-x11-to-qcode.c
 create mode 100644 ui/input-keymap-xorgevdev-to-qcode.c
 create mode 100644 ui/input-keymap-xorgkbd-to-qcode.c
 create mode 100644 ui/input-keymap-xorgxquartz-to-qcode.c
 create mode 100644 ui/input-keymap-xorgxwin-to-qcode.c

diff --git a/include/ui/input.h b/include/ui/input.h
index dcf7e0e731..1c1731ef18 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -68,6 +68,9 @@ void qemu_input_check_mode_change(void);
 void qemu_add_mouse_mode_change_notifier(Notifier *notify);
 void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
 
+extern const guint qemu_input_map_atset1_to_qcode_len;
+extern const guint16 qemu_input_map_atset1_to_qcode[];
+
 extern const guint qemu_input_map_linux_to_qcode_len;
 extern const guint16 qemu_input_map_linux_to_qcode[];
 
@@ -101,4 +104,22 @@ extern const guint16 qemu_input_map_qnum_to_qcode[];
 extern const guint qemu_input_map_usb_to_qcode_len;
 extern const guint16 qemu_input_map_usb_to_qcode[];
 
+extern const guint qemu_input_map_win32_to_qcode_len;
+extern const guint16 qemu_input_map_win32_to_qcode[];
+
+extern const guint qemu_input_map_x11_to_qcode_len;
+extern const guint16 qemu_input_map_x11_to_qcode[];
+
+extern const guint qemu_input_map_xorgevdev_to_qcode_len;
+extern const guint16 qemu_input_map_xorgevdev_to_qcode[];
+
+extern const guint qemu_input_map_xorgkbd_to_qcode_len;
+extern const guint16 qemu_input_map_xorgkbd_to_qcode[];
+
+extern const guint qemu_input_map_xorgxquartz_to_qcode_len;
+extern const guint16 qemu_input_map_xorgxquartz_to_qcode[];
+
+extern const guint qemu_input_map_xorgxwin_to_qcode_len;
+extern const guint16 qemu_input_map_xorgxwin_to_qcode[];
+
 #endif /* INPUT_H */
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 7823e85d7c..b6512e3dc2 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -11,11 +11,12 @@ common-obj-y += keymaps.o console.o cursor.o qemu-pixman.o
 common-obj-y += input.o input-keymap.o input-legacy.o
 common-obj-$(CONFIG_LINUX) += input-linux.o
 common-obj-$(CONFIG_SPICE) += spice-core.o spice-input.o spice-display.o
-common-obj-$(CONFIG_SDL) += sdl.mo x_keymap.o
+common-obj-$(CONFIG_SDL) += sdl.mo
 common-obj-$(CONFIG_COCOA) += cocoa.o
 common-obj-$(CONFIG_CURSES) += curses.o
 common-obj-$(CONFIG_VNC) += $(vnc-obj-y)
-common-obj-$(CONFIG_GTK) += gtk.o x_keymap.o
+common-obj-$(CONFIG_GTK) += gtk.o
+common-obj-$(if $(CONFIG_WIN32),n,$(if $(CONFIG_SDL),y,$(CONFIG_GTK))) += x_keymap.o
 
 ifeq ($(CONFIG_SDLABI),1.2)
 sdl.mo-objs := sdl.o sdl_zoom.o
@@ -54,6 +55,7 @@ KEYCODEMAP_GEN = $(SRC_PATH)/ui/keycodemapdb/tools/keymap-gen
 KEYCODEMAP_CSV = $(SRC_PATH)/ui/keycodemapdb/data/keymaps.csv
 
 KEYCODEMAP_FILES = \
+		 ui/input-keymap-atset1-to-qcode.c \
 		 ui/input-keymap-linux-to-qcode.c \
 		 ui/input-keymap-osx-to-qcode.c \
 		 ui/input-keymap-qcode-to-adb.c \
@@ -65,6 +67,12 @@ KEYCODEMAP_FILES = \
 		 ui/input-keymap-qcode-to-sun.c \
 		 ui/input-keymap-qnum-to-qcode.c \
 		 ui/input-keymap-usb-to-qcode.c \
+		 ui/input-keymap-win32-to-qcode.c \
+		 ui/input-keymap-x11-to-qcode.c \
+		 ui/input-keymap-xorgevdev-to-qcode.c \
+		 ui/input-keymap-xorgkbd-to-qcode.c \
+		 ui/input-keymap-xorgxquartz-to-qcode.c \
+		 ui/input-keymap-xorgxwin-to-qcode.c \
 		 $(NULL)
 
 # Generated input-keymap-XXX.c files are kept in GIT, so
diff --git a/ui/gtk.c b/ui/gtk.c
index 5bd87c265a..398f3aad81 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -52,7 +52,6 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qmp-commands.h"
-#include "x_keymap.h"
 #include "keymaps.h"
 #include "chardev/char.h"
 #include "qom/object.h"
@@ -65,6 +64,48 @@
 #define VC_SCALE_MIN    0.25
 #define VC_SCALE_STEP   0.25
 
+#ifdef GDK_WINDOWING_X11
+#include "ui/x_keymap.h"
+
+/* Gtk2 compat */
+#ifndef GDK_IS_X11_DISPLAY
+#define GDK_IS_X11_DISPLAY(dpy) (dpy != NULL)
+#endif
+#endif
+
+
+#ifdef GDK_WINDOWING_WAYLAND
+/* Gtk2 compat */
+#ifndef GDK_IS_WAYLAND_DISPLAY
+#define GDK_IS_WAYLAND_DISPLAY(dpy) (dpy != NULL)
+#endif
+#endif
+
+
+#ifdef GDK_WINDOWING_WIN32
+/* Gtk2 compat */
+#ifndef GDK_IS_WIN32_DISPLAY
+#define GDK_IS_WIN32_DISPLAY(dpy) (dpy != NULL)
+#endif
+#endif
+
+
+#ifdef GDK_WINDOWING_BROADWAY
+/* Gtk2 compat */
+#ifndef GDK_IS_BROADWAY_DISPLAY
+#define GDK_IS_BROADWAY_DISPLAY(dpy) (dpy != NULL)
+#endif
+#endif
+
+
+#ifdef GDK_WINDOWING_QUARTZ
+/* Gtk2 compat */
+#ifndef GDK_IS_QUARTZ_DISPLAY
+#define GDK_IS_QUARTZ_DISPLAY(dpy) (dpy != NULL)
+#endif
+#endif
+
+
 #if !defined(CONFIG_VTE)
 # define VTE_CHECK_VERSION(a, b, c) 0
 #endif
@@ -123,10 +164,19 @@
 #define HOTKEY_MODIFIERS        (GDK_CONTROL_MASK | GDK_MOD1_MASK)
 
 static const int modifier_keycode[] = {
-    /* shift, control, alt keys, meta keys, both left & right */
-    0x2a, 0x36, 0x1d, 0x9d, 0x38, 0xb8, 0xdb, 0xdd,
+    Q_KEY_CODE_SHIFT,
+    Q_KEY_CODE_SHIFT_R,
+    Q_KEY_CODE_CTRL,
+    Q_KEY_CODE_CTRL_R,
+    Q_KEY_CODE_ALT,
+    Q_KEY_CODE_ALT_R,
+    Q_KEY_CODE_META_L,
+    Q_KEY_CODE_META_R,
 };
 
+static const guint16 *keycode_map;
+static size_t keycode_maplen;
+
 struct GtkDisplayState {
     GtkWidget *window;
 
@@ -178,7 +228,6 @@ struct GtkDisplayState {
     bool external_pause_update;
 
     bool modifier_pressed[ARRAY_SIZE(modifier_keycode)];
-    bool has_evdev;
     bool ignore_keys;
 };
 
@@ -412,18 +461,18 @@ static void gd_update_full_redraw(VirtualConsole *vc)
 static void gtk_release_modifiers(GtkDisplayState *s)
 {
     VirtualConsole *vc = gd_vc_find_current(s);
-    int i, keycode;
+    int i, qcode;
 
     if (vc->type != GD_VC_GFX ||
         !qemu_console_is_graphic(vc->gfx.dcl.con)) {
         return;
     }
     for (i = 0; i < ARRAY_SIZE(modifier_keycode); i++) {
-        keycode = modifier_keycode[i];
+        qcode = modifier_keycode[i];
         if (!s->modifier_pressed[i]) {
             continue;
         }
-        qemu_input_event_send_key_number(vc->gfx.dcl.con, keycode, false);
+        qemu_input_event_send_key_qcode(vc->gfx.dcl.con, qcode, false);
         s->modifier_pressed[i] = false;
     }
 }
@@ -1057,47 +1106,75 @@ static gboolean gd_scroll_event(GtkWidget *widget, GdkEventScroll *scroll,
     return TRUE;
 }
 
-static int gd_map_keycode(GtkDisplayState *s, GdkDisplay *dpy, int gdk_keycode)
+
+static const guint16 *gd_get_keymap(size_t *maplen)
 {
-    int qemu_keycode;
+    GdkDisplay *dpy = gdk_display_get_default();
+
+#ifdef GDK_WINDOWING_X11
+    if (GDK_IS_X11_DISPLAY(dpy)) {
+        trace_gd_keymap_windowing("x11");
+        return qemu_xkeymap_mapping_table(
+            gdk_x11_display_get_xdisplay(dpy), maplen);
+    }
+#endif
+
+#ifdef GDK_WINDOWING_WAYLAND
+    if (GDK_IS_WAYLAND_DISPLAY(dpy)) {
+        trace_gd_keymap_windowing("wayland");
+        *maplen = qemu_input_map_xorgevdev_to_qcode_len;
+        return qemu_input_map_xorgevdev_to_qcode;
+    }
+#endif
 
 #ifdef GDK_WINDOWING_WIN32
     if (GDK_IS_WIN32_DISPLAY(dpy)) {
-        qemu_keycode = MapVirtualKey(gdk_keycode, MAPVK_VK_TO_VSC);
-        switch (qemu_keycode) {
-        case 103:   /* alt gr */
-            qemu_keycode = 56 | SCANCODE_GREY;
-            break;
-        }
-        return qemu_keycode;
+        trace_gd_keymap_windowing("win32");
+        *maplen = qemu_input_map_win32_to_qcode_len;
+        return qemu_input_map_win32_to_qcode;
     }
 #endif
 
-    if (gdk_keycode < 9) {
-        qemu_keycode = 0;
-    } else if (gdk_keycode < 97) {
-        qemu_keycode = gdk_keycode - 8;
-#ifdef GDK_WINDOWING_X11
-    } else if (GDK_IS_X11_DISPLAY(dpy) && gdk_keycode < 158) {
-        if (s->has_evdev) {
-            qemu_keycode = translate_evdev_keycode(gdk_keycode - 97);
-        } else {
-            qemu_keycode = translate_xfree86_keycode(gdk_keycode - 97);
-        }
+#ifdef GDK_WINDOWING_QUARTZ
+    if (GDK_IS_QUARTZ_DISPLAY(dpy)) {
+        trace_gd_keymap_windowing("quartz");
+        *maplen = qemu_input_map_osx_to_qcode_len;
+        return qemu_input_map_osx_to_qcode;
+    }
 #endif
-#ifdef GDK_WINDOWING_WAYLAND
-    } else if (GDK_IS_WAYLAND_DISPLAY(dpy) && gdk_keycode < 158) {
-        qemu_keycode = translate_evdev_keycode(gdk_keycode - 97);
+
+#ifdef GDK_WINDOWING_BROADWAY
+    if (GDK_IS_BROADWAY_DISPLAY(dpy)) {
+        trace_gd_keymap_windowing("broadway");
+        g_warning("experimental: using broadway, x11 virtual keysym\n"
+                  "mapping - with very limited support. See also\n"
+                  "https://bugzilla.gnome.org/show_bug.cgi?id=700105");
+        *maplen = qemu_input_map_x11_to_qcode_len;
+        return qemu_input_map_x11_to_qcode;
+    }
 #endif
-    } else if (gdk_keycode == 208) { /* Hiragana_Katakana */
-        qemu_keycode = 0x70;
-    } else if (gdk_keycode == 211) { /* backslash */
-        qemu_keycode = 0x73;
-    } else {
-        qemu_keycode = 0;
+
+    g_warning("Unsupported GDK Windowing platform.\n"
+              "Disabling extended keycode tables.\n"
+              "Please report to qemu-devel@nongnu.org\n"
+              "including the following information:\n"
+              "\n"
+              "  - Operating system\n"
+              "  - GDK Windowing system build\n");
+    return NULL;
+}
+
+
+static int gd_map_keycode(int scancode)
+{
+    if (!keycode_map) {
+        return 0;
+    }
+    if (scancode > keycode_maplen) {
+        return 0;
     }
 
-    return qemu_keycode;
+    return keycode_map[scancode];
 }
 
 static gboolean gd_text_key_down(GtkWidget *widget,
@@ -1111,9 +1188,7 @@ static gboolean gd_text_key_down(GtkWidget *widget,
     } else if (key->length) {
         kbd_put_string_console(con, key->string, key->length);
     } else {
-        int num = gd_map_keycode(vc->s, gtk_widget_get_display(widget),
-                                 key->hardware_keycode);
-        int qcode = qemu_input_key_number_to_qcode(num);
+        int qcode = gd_map_keycode(key->hardware_keycode);
         kbd_put_qcode_console(con, qcode);
     }
     return TRUE;
@@ -1123,8 +1198,7 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
 {
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
-    int gdk_keycode = key->hardware_keycode;
-    int qemu_keycode;
+    int qcode;
     int i;
 
     if (s->ignore_keys) {
@@ -1138,20 +1212,19 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         return TRUE;
     }
 
-    qemu_keycode = gd_map_keycode(s, gtk_widget_get_display(widget),
-                                  gdk_keycode);
+    qcode = gd_map_keycode(key->hardware_keycode);
 
-    trace_gd_key_event(vc->label, gdk_keycode, qemu_keycode,
+    trace_gd_key_event(vc->label, key->hardware_keycode, qcode,
                        (key->type == GDK_KEY_PRESS) ? "down" : "up");
 
     for (i = 0; i < ARRAY_SIZE(modifier_keycode); i++) {
-        if (qemu_keycode == modifier_keycode[i]) {
+        if (qcode == modifier_keycode[i]) {
             s->modifier_pressed[i] = (key->type == GDK_KEY_PRESS);
         }
     }
 
-    qemu_input_event_send_key_number(vc->gfx.dcl.con, qemu_keycode,
-                                     key->type == GDK_KEY_PRESS);
+    qemu_input_event_send_key_qcode(vc->gfx.dcl.con, qcode,
+                                    key->type == GDK_KEY_PRESS);
 
     return TRUE;
 }
@@ -2195,38 +2268,6 @@ static void gd_create_menus(GtkDisplayState *s)
     gtk_window_add_accel_group(GTK_WINDOW(s->window), s->accel_group);
 }
 
-static void gd_set_keycode_type(GtkDisplayState *s)
-{
-#ifdef GDK_WINDOWING_X11
-    GdkDisplay *display = gtk_widget_get_display(s->window);
-    if (GDK_IS_X11_DISPLAY(display)) {
-        Display *x11_display = gdk_x11_display_get_xdisplay(display);
-        XkbDescPtr desc = XkbGetMap(x11_display, XkbGBN_AllComponentsMask,
-                                    XkbUseCoreKbd);
-        char *keycodes = NULL;
-
-        if (desc &&
-            (XkbGetNames(x11_display, XkbKeycodesNameMask, desc) == Success)) {
-            keycodes = XGetAtomName(x11_display, desc->names->keycodes);
-        }
-        if (keycodes == NULL) {
-            fprintf(stderr, "could not lookup keycode name\n");
-        } else if (strstart(keycodes, "evdev", NULL)) {
-            s->has_evdev = true;
-        } else if (!strstart(keycodes, "xfree86", NULL)) {
-            fprintf(stderr, "unknown keycodes `%s', please report to "
-                    "qemu-devel@nongnu.org\n", keycodes);
-        }
-
-        if (desc) {
-            XkbFreeKeyboard(desc, XkbGBN_AllComponentsMask, True);
-        }
-        if (keycodes) {
-            XFree(keycodes);
-        }
-    }
-#endif
-}
 
 static gboolean gtkinit;
 
@@ -2329,8 +2370,6 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
     if (grab_on_hover) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->grab_on_hover_item));
     }
-
-    gd_set_keycode_type(s);
 }
 
 void early_gtk_display_init(int opengl)
@@ -2377,6 +2416,8 @@ void early_gtk_display_init(int opengl)
         break;
     }
 
+    keycode_map = gd_get_keymap(&keycode_maplen);
+
 #if defined(CONFIG_VTE)
     type_register(&char_gd_vc_type_info);
 #endif
diff --git a/ui/input-keymap-atset1-to-qcode.c b/ui/input-keymap-atset1-to-qcode.c
new file mode 100644
index 0000000000..7882724e36
--- /dev/null
+++ b/ui/input-keymap-atset1-to-qcode.c
@@ -0,0 +1,245 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_atset1_to_qcode code-map keymaps.csv atset1 qcode
+*/
+const guint16 qemu_input_map_atset1_to_qcode[57470] = {
+  [0x1] = Q_KEY_CODE_ESC, /* atset1:1 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x2] = Q_KEY_CODE_1, /* atset1:2 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x3] = Q_KEY_CODE_2, /* atset1:3 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x4] = Q_KEY_CODE_3, /* atset1:4 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x5] = Q_KEY_CODE_4, /* atset1:5 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x6] = Q_KEY_CODE_5, /* atset1:6 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x7] = Q_KEY_CODE_6, /* atset1:7 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x8] = Q_KEY_CODE_7, /* atset1:8 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x9] = Q_KEY_CODE_8, /* atset1:9 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0xa] = Q_KEY_CODE_9, /* atset1:10 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0xb] = Q_KEY_CODE_0, /* atset1:11 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0xc] = Q_KEY_CODE_MINUS, /* atset1:12 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0xd] = Q_KEY_CODE_EQUAL, /* atset1:13 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0xe] = Q_KEY_CODE_BACKSPACE, /* atset1:14 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0xf] = Q_KEY_CODE_TAB, /* atset1:15 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x10] = Q_KEY_CODE_Q, /* atset1:16 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x11] = Q_KEY_CODE_W, /* atset1:17 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x12] = Q_KEY_CODE_E, /* atset1:18 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x13] = Q_KEY_CODE_R, /* atset1:19 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x14] = Q_KEY_CODE_T, /* atset1:20 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x15] = Q_KEY_CODE_Y, /* atset1:21 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x16] = Q_KEY_CODE_U, /* atset1:22 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x17] = Q_KEY_CODE_I, /* atset1:23 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x18] = Q_KEY_CODE_O, /* atset1:24 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x19] = Q_KEY_CODE_P, /* atset1:25 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x1a] = Q_KEY_CODE_BRACKET_LEFT, /* atset1:26 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x1b] = Q_KEY_CODE_BRACKET_RIGHT, /* atset1:27 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x1c] = Q_KEY_CODE_RET, /* atset1:28 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x1d] = Q_KEY_CODE_CTRL, /* atset1:29 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x1e] = Q_KEY_CODE_A, /* atset1:30 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x1f] = Q_KEY_CODE_S, /* atset1:31 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x20] = Q_KEY_CODE_D, /* atset1:32 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x21] = Q_KEY_CODE_F, /* atset1:33 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x22] = Q_KEY_CODE_G, /* atset1:34 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x23] = Q_KEY_CODE_H, /* atset1:35 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x24] = Q_KEY_CODE_J, /* atset1:36 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x25] = Q_KEY_CODE_K, /* atset1:37 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x26] = Q_KEY_CODE_L, /* atset1:38 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x27] = Q_KEY_CODE_SEMICOLON, /* atset1:39 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x28] = Q_KEY_CODE_APOSTROPHE, /* atset1:40 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x29] = Q_KEY_CODE_GRAVE_ACCENT, /* atset1:41 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x2a] = Q_KEY_CODE_SHIFT, /* atset1:42 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x2b] = Q_KEY_CODE_BACKSLASH, /* atset1:43 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x2c] = Q_KEY_CODE_Z, /* atset1:44 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x2d] = Q_KEY_CODE_X, /* atset1:45 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x2e] = Q_KEY_CODE_C, /* atset1:46 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x2f] = Q_KEY_CODE_V, /* atset1:47 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x30] = Q_KEY_CODE_B, /* atset1:48 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x31] = Q_KEY_CODE_N, /* atset1:49 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x32] = Q_KEY_CODE_M, /* atset1:50 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x33] = Q_KEY_CODE_COMMA, /* atset1:51 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x34] = Q_KEY_CODE_DOT, /* atset1:52 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x35] = Q_KEY_CODE_SLASH, /* atset1:53 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x36] = Q_KEY_CODE_SHIFT_R, /* atset1:54 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x37] = Q_KEY_CODE_KP_MULTIPLY, /* atset1:55 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x38] = Q_KEY_CODE_ALT, /* atset1:56 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x39] = Q_KEY_CODE_SPC, /* atset1:57 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x3a] = Q_KEY_CODE_CAPS_LOCK, /* atset1:58 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x3b] = Q_KEY_CODE_F1, /* atset1:59 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x3c] = Q_KEY_CODE_F2, /* atset1:60 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x3d] = Q_KEY_CODE_F3, /* atset1:61 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x3e] = Q_KEY_CODE_F4, /* atset1:62 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x3f] = Q_KEY_CODE_F5, /* atset1:63 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x40] = Q_KEY_CODE_F6, /* atset1:64 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x41] = Q_KEY_CODE_F7, /* atset1:65 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x42] = Q_KEY_CODE_F8, /* atset1:66 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x43] = Q_KEY_CODE_F9, /* atset1:67 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x44] = Q_KEY_CODE_F10, /* atset1:68 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x45] = Q_KEY_CODE_NUM_LOCK, /* atset1:69 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x46] = Q_KEY_CODE_SCROLL_LOCK, /* atset1:70 -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x47] = Q_KEY_CODE_KP_7, /* atset1:71 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x48] = Q_KEY_CODE_KP_8, /* atset1:72 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x49] = Q_KEY_CODE_KP_9, /* atset1:73 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x4a] = Q_KEY_CODE_KP_SUBTRACT, /* atset1:74 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x4b] = Q_KEY_CODE_KP_4, /* atset1:75 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x4c] = Q_KEY_CODE_KP_5, /* atset1:76 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x4d] = Q_KEY_CODE_KP_6, /* atset1:77 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x4e] = Q_KEY_CODE_KP_ADD, /* atset1:78 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x4f] = Q_KEY_CODE_KP_1, /* atset1:79 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x50] = Q_KEY_CODE_KP_2, /* atset1:80 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x51] = Q_KEY_CODE_KP_3, /* atset1:81 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x52] = Q_KEY_CODE_KP_0, /* atset1:82 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x53] = Q_KEY_CODE_KP_DECIMAL, /* atset1:83 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x54] = Q_KEY_CODE_SYSRQ, /* atset1:84 -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x55] = Q_KEY_CODE_UNMAPPED, /* atset1:85 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x56] = Q_KEY_CODE_LESS, /* atset1:86 -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x57] = Q_KEY_CODE_F11, /* atset1:87 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x58] = Q_KEY_CODE_F12, /* atset1:88 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x59] = Q_KEY_CODE_KP_EQUALS, /* atset1:89 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x5a] = Q_KEY_CODE_UNMAPPED, /* atset1:90 -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5b] = Q_KEY_CODE_LF, /* atset1:91 -> linux:101 (KEY_LINEFEED) -> qcode:Q_KEY_CODE_LF (lf) */
+  [0x5c] = Q_KEY_CODE_UNMAPPED, /* atset1:92 -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5d] = Q_KEY_CODE_UNMAPPED, /* atset1:93 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5e] = Q_KEY_CODE_UNMAPPED, /* atset1:94 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5f] = Q_KEY_CODE_UNMAPPED, /* atset1:95 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x63] = Q_KEY_CODE_UNMAPPED, /* atset1:99 -> linux:169 (KEY_PHONE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x64] = Q_KEY_CODE_OPEN, /* atset1:100 -> linux:134 (KEY_OPEN) -> qcode:Q_KEY_CODE_OPEN (open) */
+  [0x65] = Q_KEY_CODE_PASTE, /* atset1:101 -> linux:135 (KEY_PASTE) -> qcode:Q_KEY_CODE_PASTE (paste) */
+  [0x66] = Q_KEY_CODE_UNMAPPED, /* atset1:102 -> linux:141 (KEY_SETUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x67] = Q_KEY_CODE_UNMAPPED, /* atset1:103 -> linux:144 (KEY_FILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x68] = Q_KEY_CODE_UNMAPPED, /* atset1:104 -> linux:145 (KEY_SENDFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x69] = Q_KEY_CODE_UNMAPPED, /* atset1:105 -> linux:146 (KEY_DELETEFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6a] = Q_KEY_CODE_UNMAPPED, /* atset1:106 -> linux:151 (KEY_MSDOS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6b] = Q_KEY_CODE_UNMAPPED, /* atset1:107 -> linux:153 (KEY_DIRECTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6c] = Q_KEY_CODE_UNMAPPED, /* atset1:108 -> linux:161 (KEY_EJECTCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6d] = Q_KEY_CODE_UNMAPPED, /* atset1:109 -> linux:193 (KEY_F23) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6f] = Q_KEY_CODE_UNMAPPED, /* atset1:111 -> linux:194 (KEY_F24) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x70] = Q_KEY_CODE_UNMAPPED, /* atset1:112 -> linux:170 (KEY_ISO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x71] = Q_KEY_CODE_UNMAPPED, /* atset1:113 -> linux:174 (KEY_EXIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x72] = Q_KEY_CODE_UNMAPPED, /* atset1:114 -> linux:175 (KEY_MOVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x73] = Q_KEY_CODE_RO, /* atset1:115 -> linux:89 (KEY_RO) -> qcode:Q_KEY_CODE_RO (ro) */
+  [0x74] = Q_KEY_CODE_UNMAPPED, /* atset1:116 -> linux:191 (KEY_F21) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x75] = Q_KEY_CODE_UNMAPPED, /* atset1:117 -> linux:177 (KEY_SCROLLUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x76] = Q_KEY_CODE_UNMAPPED, /* atset1:118 -> linux:85 (KEY_ZENKAKUHANKAKU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x77] = Q_KEY_CODE_HIRAGANA, /* atset1:119 -> linux:91 (KEY_HIRAGANA) -> qcode:Q_KEY_CODE_HIRAGANA (hiragana) */
+  [0x78] = Q_KEY_CODE_UNMAPPED, /* atset1:120 -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x79] = Q_KEY_CODE_HENKAN, /* atset1:121 -> linux:92 (KEY_HENKAN) -> qcode:Q_KEY_CODE_HENKAN (henkan) */
+  [0x7b] = Q_KEY_CODE_UNMAPPED, /* atset1:123 -> linux:94 (KEY_MUHENKAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7d] = Q_KEY_CODE_YEN, /* atset1:125 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x7e] = Q_KEY_CODE_KP_COMMA, /* atset1:126 -> linux:121 (KEY_KPCOMMA) -> qcode:Q_KEY_CODE_KP_COMMA (kp_comma) */
+  [0xe001] = Q_KEY_CODE_UNMAPPED, /* atset1:57345 -> linux:171 (KEY_CONFIG) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe002] = Q_KEY_CODE_UNMAPPED, /* atset1:57346 -> linux:150 (KEY_WWW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe003] = Q_KEY_CODE_UNMAPPED, /* atset1:57347 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe004] = Q_KEY_CODE_UNMAPPED, /* atset1:57348 -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe005] = Q_KEY_CODE_AGAIN, /* atset1:57349 -> linux:129 (KEY_AGAIN) -> qcode:Q_KEY_CODE_AGAIN (again) */
+  [0xe006] = Q_KEY_CODE_PROPS, /* atset1:57350 -> linux:130 (KEY_PROPS) -> qcode:Q_KEY_CODE_PROPS (props) */
+  [0xe007] = Q_KEY_CODE_UNDO, /* atset1:57351 -> linux:131 (KEY_UNDO) -> qcode:Q_KEY_CODE_UNDO (undo) */
+  [0xe008] = Q_KEY_CODE_UNMAPPED, /* atset1:57352 -> linux:176 (KEY_EDIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe009] = Q_KEY_CODE_UNMAPPED, /* atset1:57353 -> linux:181 (KEY_NEW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe00a] = Q_KEY_CODE_UNMAPPED, /* atset1:57354 -> linux:182 (KEY_REDO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe00b] = Q_KEY_CODE_UNMAPPED, /* atset1:57355 -> linux:120 (KEY_SCALE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe00c] = Q_KEY_CODE_FRONT, /* atset1:57356 -> linux:132 (KEY_FRONT) -> qcode:Q_KEY_CODE_FRONT (front) */
+  [0xe00d] = Q_KEY_CODE_UNMAPPED, /* atset1:57357 -> linux:123 (KEY_HANJA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe00e] = Q_KEY_CODE_UNMAPPED, /* atset1:57358 -> linux:233 (KEY_FORWARDMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe00f] = Q_KEY_CODE_UNMAPPED, /* atset1:57359 -> linux:178 (KEY_SCROLLDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe010] = Q_KEY_CODE_AUDIOPREV, /* atset1:57360 -> linux:165 (KEY_PREVIOUSSONG) -> qcode:Q_KEY_CODE_AUDIOPREV (audioprev) */
+  [0xe012] = Q_KEY_CODE_UNMAPPED, /* atset1:57362 -> linux:152 (KEY_SCREENLOCK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe013] = Q_KEY_CODE_UNMAPPED, /* atset1:57363 -> linux:147 (KEY_XFER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe014] = Q_KEY_CODE_UNMAPPED, /* atset1:57364 -> linux:222 (KEY_ALTERASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe015] = Q_KEY_CODE_UNMAPPED, /* atset1:57365 -> linux:195 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe016] = Q_KEY_CODE_UNMAPPED, /* atset1:57366 -> linux:196 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe017] = Q_KEY_CODE_UNMAPPED, /* atset1:57367 -> linux:149 (KEY_PROG2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe018] = Q_KEY_CODE_UNMAPPED, /* atset1:57368 -> linux:168 (KEY_REWIND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe019] = Q_KEY_CODE_AUDIONEXT, /* atset1:57369 -> linux:163 (KEY_NEXTSONG) -> qcode:Q_KEY_CODE_AUDIONEXT (audionext) */
+  [0xe01a] = Q_KEY_CODE_UNMAPPED, /* atset1:57370 -> linux:197 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe01b] = Q_KEY_CODE_UNMAPPED, /* atset1:57371 -> linux:198 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe01c] = Q_KEY_CODE_KP_ENTER, /* atset1:57372 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0xe01d] = Q_KEY_CODE_CTRL_R, /* atset1:57373 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0xe01e] = Q_KEY_CODE_MENU, /* atset1:57374 -> linux:139 (KEY_MENU) -> qcode:Q_KEY_CODE_MENU (menu) */
+  [0xe01f] = Q_KEY_CODE_UNMAPPED, /* atset1:57375 -> linux:148 (KEY_PROG1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe020] = Q_KEY_CODE_AUDIOMUTE, /* atset1:57376 -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0xe021] = Q_KEY_CODE_CALCULATOR, /* atset1:57377 -> linux:140 (KEY_CALC) -> qcode:Q_KEY_CODE_CALCULATOR (calculator) */
+  [0xe022] = Q_KEY_CODE_AUDIOPLAY, /* atset1:57378 -> linux:164 (KEY_PLAYPAUSE) -> qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) */
+  [0xe023] = Q_KEY_CODE_UNMAPPED, /* atset1:57379 -> linux:160 (KEY_CLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe024] = Q_KEY_CODE_AUDIOSTOP, /* atset1:57380 -> linux:166 (KEY_STOPCD) -> qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) */
+  [0xe025] = Q_KEY_CODE_UNMAPPED, /* atset1:57381 -> linux:205 (KEY_SUSPEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe026] = Q_KEY_CODE_UNMAPPED, /* atset1:57382 -> linux:154 (KEY_CYCLEWINDOWS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe027] = Q_KEY_CODE_UNMAPPED, /* atset1:57383 -> linux:199 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe028] = Q_KEY_CODE_UNMAPPED, /* atset1:57384 -> linux:200 (KEY_PLAYCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe029] = Q_KEY_CODE_UNMAPPED, /* atset1:57385 -> linux:201 (KEY_PAUSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe02b] = Q_KEY_CODE_UNMAPPED, /* atset1:57387 -> linux:202 (KEY_PROG3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe02c] = Q_KEY_CODE_UNMAPPED, /* atset1:57388 -> linux:203 (KEY_PROG4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe02d] = Q_KEY_CODE_UNMAPPED, /* atset1:57389 -> linux:204 (KEY_DASHBOARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe02e] = Q_KEY_CODE_VOLUMEDOWN, /* atset1:57390 -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0xe02f] = Q_KEY_CODE_UNMAPPED, /* atset1:57391 -> linux:206 (KEY_CLOSE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe030] = Q_KEY_CODE_VOLUMEUP, /* atset1:57392 -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0xe031] = Q_KEY_CODE_UNMAPPED, /* atset1:57393 -> linux:167 (KEY_RECORD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe032] = Q_KEY_CODE_AC_HOME, /* atset1:57394 -> linux:172 (KEY_HOMEPAGE) -> qcode:Q_KEY_CODE_AC_HOME (ac_home) */
+  [0xe033] = Q_KEY_CODE_UNMAPPED, /* atset1:57395 -> linux:207 (KEY_PLAY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe034] = Q_KEY_CODE_UNMAPPED, /* atset1:57396 -> linux:208 (KEY_FASTFORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe035] = Q_KEY_CODE_KP_DIVIDE, /* atset1:57397 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0xe036] = Q_KEY_CODE_UNMAPPED, /* atset1:57398 -> linux:209 (KEY_BASSBOOST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe038] = Q_KEY_CODE_ALT_R, /* atset1:57400 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0xe039] = Q_KEY_CODE_UNMAPPED, /* atset1:57401 -> linux:210 (KEY_PRINT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe03a] = Q_KEY_CODE_UNMAPPED, /* atset1:57402 -> linux:211 (KEY_HP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe03b] = Q_KEY_CODE_UNMAPPED, /* atset1:57403 -> linux:212 (KEY_CAMERA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe03c] = Q_KEY_CODE_CUT, /* atset1:57404 -> linux:137 (KEY_CUT) -> qcode:Q_KEY_CODE_CUT (cut) */
+  [0xe03d] = Q_KEY_CODE_UNMAPPED, /* atset1:57405 -> linux:213 (KEY_SOUND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe03e] = Q_KEY_CODE_UNMAPPED, /* atset1:57406 -> linux:214 (KEY_QUESTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe03f] = Q_KEY_CODE_UNMAPPED, /* atset1:57407 -> linux:215 (KEY_EMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe040] = Q_KEY_CODE_UNMAPPED, /* atset1:57408 -> linux:216 (KEY_CHAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe041] = Q_KEY_CODE_FIND, /* atset1:57409 -> linux:136 (KEY_FIND) -> qcode:Q_KEY_CODE_FIND (find) */
+  [0xe042] = Q_KEY_CODE_UNMAPPED, /* atset1:57410 -> linux:218 (KEY_CONNECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe043] = Q_KEY_CODE_UNMAPPED, /* atset1:57411 -> linux:219 (KEY_FINANCE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe044] = Q_KEY_CODE_UNMAPPED, /* atset1:57412 -> linux:220 (KEY_SPORT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe045] = Q_KEY_CODE_UNMAPPED, /* atset1:57413 -> linux:221 (KEY_SHOP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe046] = Q_KEY_CODE_PAUSE, /* atset1:57414 -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0xe047] = Q_KEY_CODE_HOME, /* atset1:57415 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0xe048] = Q_KEY_CODE_UP, /* atset1:57416 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0xe049] = Q_KEY_CODE_PGUP, /* atset1:57417 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0xe04a] = Q_KEY_CODE_UNMAPPED, /* atset1:57418 -> linux:223 (KEY_CANCEL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe04b] = Q_KEY_CODE_LEFT, /* atset1:57419 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0xe04c] = Q_KEY_CODE_UNMAPPED, /* atset1:57420 -> linux:224 (KEY_BRIGHTNESSDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe04d] = Q_KEY_CODE_RIGHT, /* atset1:57421 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0xe04e] = Q_KEY_CODE_UNMAPPED, /* atset1:57422 -> linux:118 (KEY_KPPLUSMINUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe04f] = Q_KEY_CODE_END, /* atset1:57423 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0xe050] = Q_KEY_CODE_DOWN, /* atset1:57424 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0xe051] = Q_KEY_CODE_PGDN, /* atset1:57425 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0xe052] = Q_KEY_CODE_INSERT, /* atset1:57426 -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0xe053] = Q_KEY_CODE_DELETE, /* atset1:57427 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0xe054] = Q_KEY_CODE_UNMAPPED, /* atset1:57428 -> linux:225 (KEY_BRIGHTNESSUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe055] = Q_KEY_CODE_UNMAPPED, /* atset1:57429 -> linux:234 (KEY_SAVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe056] = Q_KEY_CODE_UNMAPPED, /* atset1:57430 -> linux:227 (KEY_SWITCHVIDEOMODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe057] = Q_KEY_CODE_UNMAPPED, /* atset1:57431 -> linux:228 (KEY_KBDILLUMTOGGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe058] = Q_KEY_CODE_UNMAPPED, /* atset1:57432 -> linux:229 (KEY_KBDILLUMDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe059] = Q_KEY_CODE_UNMAPPED, /* atset1:57433 -> linux:230 (KEY_KBDILLUMUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe05a] = Q_KEY_CODE_UNMAPPED, /* atset1:57434 -> linux:231 (KEY_SEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe05b] = Q_KEY_CODE_META_L, /* atset1:57435 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0xe05c] = Q_KEY_CODE_META_R, /* atset1:57436 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0xe05d] = Q_KEY_CODE_COMPOSE, /* atset1:57437 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0xe05e] = Q_KEY_CODE_POWER, /* atset1:57438 -> linux:116 (KEY_POWER) -> qcode:Q_KEY_CODE_POWER (power) */
+  [0xe05f] = Q_KEY_CODE_SLEEP, /* atset1:57439 -> linux:142 (KEY_SLEEP) -> qcode:Q_KEY_CODE_SLEEP (sleep) */
+  [0xe063] = Q_KEY_CODE_WAKE, /* atset1:57443 -> linux:143 (KEY_WAKEUP) -> qcode:Q_KEY_CODE_WAKE (wake) */
+  [0xe064] = Q_KEY_CODE_UNMAPPED, /* atset1:57444 -> linux:232 (KEY_REPLY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe065] = Q_KEY_CODE_UNMAPPED, /* atset1:57445 -> linux:217 (KEY_SEARCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe066] = Q_KEY_CODE_AC_BOOKMARKS, /* atset1:57446 -> linux:156 (KEY_BOOKMARKS) -> qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) */
+  [0xe067] = Q_KEY_CODE_AC_REFRESH, /* atset1:57447 -> linux:173 (KEY_REFRESH) -> qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) */
+  [0xe068] = Q_KEY_CODE_STOP, /* atset1:57448 -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0xe069] = Q_KEY_CODE_AC_FORWARD, /* atset1:57449 -> linux:159 (KEY_FORWARD) -> qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) */
+  [0xe06a] = Q_KEY_CODE_AC_BACK, /* atset1:57450 -> linux:158 (KEY_BACK) -> qcode:Q_KEY_CODE_AC_BACK (ac_back) */
+  [0xe06b] = Q_KEY_CODE_COMPUTER, /* atset1:57451 -> linux:157 (KEY_COMPUTER) -> qcode:Q_KEY_CODE_COMPUTER (computer) */
+  [0xe06c] = Q_KEY_CODE_MAIL, /* atset1:57452 -> linux:155 (KEY_MAIL) -> qcode:Q_KEY_CODE_MAIL (mail) */
+  [0xe06d] = Q_KEY_CODE_MEDIASELECT, /* atset1:57453 -> linux:226 (KEY_MEDIA) -> qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) */
+  [0xe06f] = Q_KEY_CODE_UNMAPPED, /* atset1:57455 -> linux:112 (KEY_MACRO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe070] = Q_KEY_CODE_UNMAPPED, /* atset1:57456 -> linux:235 (KEY_DOCUMENTS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe071] = Q_KEY_CODE_UNMAPPED, /* atset1:57457 -> linux:236 (KEY_BATTERY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe072] = Q_KEY_CODE_UNMAPPED, /* atset1:57458 -> linux:237 (KEY_BLUETOOTH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe073] = Q_KEY_CODE_UNMAPPED, /* atset1:57459 -> linux:238 (KEY_WLAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe074] = Q_KEY_CODE_UNMAPPED, /* atset1:57460 -> linux:239 (KEY_UWB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe075] = Q_KEY_CODE_HELP, /* atset1:57461 -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0xe076] = Q_KEY_CODE_UNMAPPED, /* atset1:57462 -> linux:179 (KEY_KPLEFTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe077] = Q_KEY_CODE_UNMAPPED, /* atset1:57463 -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe078] = Q_KEY_CODE_COPY, /* atset1:57464 -> linux:133 (KEY_COPY) -> qcode:Q_KEY_CODE_COPY (copy) */
+  [0xe079] = Q_KEY_CODE_UNMAPPED, /* atset1:57465 -> linux:192 (KEY_F22) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe07b] = Q_KEY_CODE_UNMAPPED, /* atset1:57467 -> linux:180 (KEY_KPRIGHTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe07d] = Q_KEY_CODE_UNMAPPED, /* atset1:57469 -> linux:162 (KEY_EJECTCLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_atset1_to_qcode_len = sizeof(qemu_input_map_atset1_to_qcode)/sizeof(qemu_input_map_atset1_to_qcode[0]);
diff --git a/ui/input-keymap-win32-to-qcode.c b/ui/input-keymap-win32-to-qcode.c
new file mode 100644
index 0000000000..c05dfb9106
--- /dev/null
+++ b/ui/input-keymap-win32-to-qcode.c
@@ -0,0 +1,157 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_win32_to_qcode code-map keymaps.csv win32 qcode
+*/
+const guint16 qemu_input_map_win32_to_qcode[252] = {
+  [0x1] = Q_KEY_CODE_UNMAPPED, /* win32:1 (VK_LBUTTON) -> linux:256 (BTN_0) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x2] = Q_KEY_CODE_UNMAPPED, /* win32:2 (VK_RBUTTON) -> linux:257 (BTN_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x4] = Q_KEY_CODE_UNMAPPED, /* win32:4 (VK_MBUTTON) -> linux:258 (BTN_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5] = Q_KEY_CODE_UNMAPPED, /* win32:5 (VK_XBUTTON1) -> linux:259 (BTN_3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x6] = Q_KEY_CODE_UNMAPPED, /* win32:6 (VK_XBUTTON2) -> linux:260 (BTN_4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x8] = Q_KEY_CODE_BACKSPACE, /* win32:8 (VK_BACK) -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x9] = Q_KEY_CODE_TAB, /* win32:9 (VK_TAB) -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0xd] = Q_KEY_CODE_RET, /* win32:13 (VK_RETURN) -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x10] = Q_KEY_CODE_SHIFT, /* win32:16 (VK_LSHIFT) -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x11] = Q_KEY_CODE_CTRL, /* win32:17 (VK_CONTROL) -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x12] = Q_KEY_CODE_ALT, /* win32:18 (VK_MENU) -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x13] = Q_KEY_CODE_PAUSE, /* win32:19 (VK_PAUSE) -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0x14] = Q_KEY_CODE_CAPS_LOCK, /* win32:20 (VK_CAPITAL) -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x15] = Q_KEY_CODE_UNMAPPED, /* win32:21 (VK_HANGEUL) -> linux:122 (KEY_HANGEUL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19] = Q_KEY_CODE_UNMAPPED, /* win32:25 (VK_HANJA) -> linux:123 (KEY_HANJA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b] = Q_KEY_CODE_ESC, /* win32:27 (VK_ESCAPE) -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x20] = Q_KEY_CODE_SPC, /* win32:32 (VK_SPACE) -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x21] = Q_KEY_CODE_PGUP, /* win32:33 (VK_PRIOR) -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x22] = Q_KEY_CODE_PGDN, /* win32:34 (VK_NEXT) -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x23] = Q_KEY_CODE_END, /* win32:35 (VK_END) -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x24] = Q_KEY_CODE_HOME, /* win32:36 (VK_HOME) -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x25] = Q_KEY_CODE_LEFT, /* win32:37 (VK_LEFT) -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x26] = Q_KEY_CODE_UP, /* win32:38 (VK_UP) -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x27] = Q_KEY_CODE_RIGHT, /* win32:39 (VK_RIGHT) -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x28] = Q_KEY_CODE_DOWN, /* win32:40 (VK_DOWN) -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x29] = Q_KEY_CODE_UNMAPPED, /* win32:41 (VK_SELECT) -> linux:353 (KEY_SELECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x2a] = Q_KEY_CODE_UNMAPPED, /* win32:42 (VK_PRINT) -> linux:210 (KEY_PRINT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x2c] = Q_KEY_CODE_SYSRQ, /* win32:44 (VK_SNAPSHOT) -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x2d] = Q_KEY_CODE_INSERT, /* win32:45 (VK_INSERT) -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0x2e] = Q_KEY_CODE_DELETE, /* win32:46 (VK_DELETE) -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x2f] = Q_KEY_CODE_HELP, /* win32:47 (VK_HELP) -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0x30] = Q_KEY_CODE_0, /* win32:48 (VK_0) -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x31] = Q_KEY_CODE_1, /* win32:49 (VK_1) -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x32] = Q_KEY_CODE_2, /* win32:50 (VK_2) -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x33] = Q_KEY_CODE_3, /* win32:51 (VK_3) -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x34] = Q_KEY_CODE_4, /* win32:52 (VK_4) -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x35] = Q_KEY_CODE_5, /* win32:53 (VK_5) -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x36] = Q_KEY_CODE_6, /* win32:54 (VK_6) -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x37] = Q_KEY_CODE_7, /* win32:55 (VK_7) -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x38] = Q_KEY_CODE_8, /* win32:56 (VK_8) -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x39] = Q_KEY_CODE_9, /* win32:57 (VK_9) -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x41] = Q_KEY_CODE_A, /* win32:65 (VK_A) -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x42] = Q_KEY_CODE_B, /* win32:66 (VK_B) -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x43] = Q_KEY_CODE_C, /* win32:67 (VK_C) -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x44] = Q_KEY_CODE_D, /* win32:68 (VK_D) -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x45] = Q_KEY_CODE_E, /* win32:69 (VK_E) -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x46] = Q_KEY_CODE_F, /* win32:70 (VK_F) -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x47] = Q_KEY_CODE_G, /* win32:71 (VK_G) -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x48] = Q_KEY_CODE_H, /* win32:72 (VK_H) -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x49] = Q_KEY_CODE_I, /* win32:73 (VK_I) -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x4a] = Q_KEY_CODE_J, /* win32:74 (VK_J) -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x4b] = Q_KEY_CODE_K, /* win32:75 (VK_K) -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x4c] = Q_KEY_CODE_L, /* win32:76 (VK_L) -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x4d] = Q_KEY_CODE_M, /* win32:77 (VK_M) -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x4e] = Q_KEY_CODE_N, /* win32:78 (VK_N) -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x4f] = Q_KEY_CODE_O, /* win32:79 (VK_O) -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x50] = Q_KEY_CODE_P, /* win32:80 (VK_P) -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x51] = Q_KEY_CODE_Q, /* win32:81 (VK_Q) -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x52] = Q_KEY_CODE_R, /* win32:82 (VK_R) -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x53] = Q_KEY_CODE_S, /* win32:83 (VK_S) -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x54] = Q_KEY_CODE_T, /* win32:84 (VK_T) -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x55] = Q_KEY_CODE_U, /* win32:85 (VK_U) -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x56] = Q_KEY_CODE_V, /* win32:86 (VK_V) -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x57] = Q_KEY_CODE_W, /* win32:87 (VK_W) -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x58] = Q_KEY_CODE_X, /* win32:88 (VK_X) -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x59] = Q_KEY_CODE_Y, /* win32:89 (VK_Y) -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x5a] = Q_KEY_CODE_Z, /* win32:90 (VK_Z) -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x5b] = Q_KEY_CODE_META_L, /* win32:91 (VK_LWIN) -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x5c] = Q_KEY_CODE_META_R, /* win32:92 (VK_RWIN) -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x5d] = Q_KEY_CODE_COMPOSE, /* win32:93 (VK_APPS) -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x5f] = Q_KEY_CODE_SLEEP, /* win32:95 (VK_SLEEP) -> linux:142 (KEY_SLEEP) -> qcode:Q_KEY_CODE_SLEEP (sleep) */
+  [0x60] = Q_KEY_CODE_KP_0, /* win32:96 (VK_NUMPAD0) -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x61] = Q_KEY_CODE_KP_1, /* win32:97 (VK_NUMPAD1) -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x62] = Q_KEY_CODE_KP_2, /* win32:98 (VK_NUMPAD2) -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x63] = Q_KEY_CODE_KP_3, /* win32:99 (VK_NUMPAD3) -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x64] = Q_KEY_CODE_KP_4, /* win32:100 (VK_NUMPAD4) -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x65] = Q_KEY_CODE_KP_5, /* win32:101 (VK_NUMPAD5) -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x66] = Q_KEY_CODE_KP_6, /* win32:102 (VK_NUMPAD6) -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x67] = Q_KEY_CODE_KP_7, /* win32:103 (VK_NUMPAD7) -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x68] = Q_KEY_CODE_KP_8, /* win32:104 (VK_NUMPAD8) -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x69] = Q_KEY_CODE_KP_9, /* win32:105 (VK_NUMPAD9) -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x6a] = Q_KEY_CODE_KP_MULTIPLY, /* win32:106 (VK_MULTIPLY) -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x6b] = Q_KEY_CODE_KP_ADD, /* win32:107 (VK_ADD) -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x6c] = Q_KEY_CODE_KP_COMMA, /* win32:108 (VK_SEPARATOR??) -> linux:121 (KEY_KPCOMMA) -> qcode:Q_KEY_CODE_KP_COMMA (kp_comma) */
+  [0x6d] = Q_KEY_CODE_KP_SUBTRACT, /* win32:109 (VK_SUBTRACT) -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x6e] = Q_KEY_CODE_KP_DECIMAL, /* win32:110 (VK_DECIMAL) -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x6f] = Q_KEY_CODE_KP_DIVIDE, /* win32:111 (VK_DIVIDE) -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x70] = Q_KEY_CODE_F1, /* win32:112 (VK_F1) -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x71] = Q_KEY_CODE_F2, /* win32:113 (VK_F2) -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x72] = Q_KEY_CODE_F3, /* win32:114 (VK_F3) -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x73] = Q_KEY_CODE_F4, /* win32:115 (VK_F4) -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x74] = Q_KEY_CODE_F5, /* win32:116 (VK_F5) -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x75] = Q_KEY_CODE_F6, /* win32:117 (VK_F6) -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x76] = Q_KEY_CODE_F7, /* win32:118 (VK_F7) -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x77] = Q_KEY_CODE_F8, /* win32:119 (VK_F8) -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x78] = Q_KEY_CODE_F9, /* win32:120 (VK_F9) -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x79] = Q_KEY_CODE_F10, /* win32:121 (VK_F10) -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x7a] = Q_KEY_CODE_F11, /* win32:122 (VK_F11) -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x7b] = Q_KEY_CODE_F12, /* win32:123 (VK_F12) -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x7c] = Q_KEY_CODE_UNMAPPED, /* win32:124 (VK_F13) -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7d] = Q_KEY_CODE_UNMAPPED, /* win32:125 (VK_F14) -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7e] = Q_KEY_CODE_UNMAPPED, /* win32:126 (VK_F15) -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7f] = Q_KEY_CODE_UNMAPPED, /* win32:127 (VK_F16) -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x80] = Q_KEY_CODE_UNMAPPED, /* win32:128 (VK_F17) -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x81] = Q_KEY_CODE_UNMAPPED, /* win32:129 (VK_F18) -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x82] = Q_KEY_CODE_UNMAPPED, /* win32:130 (VK_F19) -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x83] = Q_KEY_CODE_UNMAPPED, /* win32:131 (VK_F20) -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x84] = Q_KEY_CODE_UNMAPPED, /* win32:132 (VK_F21) -> linux:191 (KEY_F21) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x85] = Q_KEY_CODE_UNMAPPED, /* win32:133 (VK_F22) -> linux:192 (KEY_F22) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x86] = Q_KEY_CODE_UNMAPPED, /* win32:134 (VK_F23) -> linux:193 (KEY_F23) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x87] = Q_KEY_CODE_UNMAPPED, /* win32:135 (VK_F24) -> linux:194 (KEY_F24) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x90] = Q_KEY_CODE_NUM_LOCK, /* win32:144 (VK_NUMLOCK) -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x91] = Q_KEY_CODE_SCROLL_LOCK, /* win32:145 (VK_SCROLL) -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0xa0] = Q_KEY_CODE_SHIFT, /* win32:160 (VK_LSHIFT) -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0xa1] = Q_KEY_CODE_SHIFT_R, /* win32:161 (VK_RSHIFT) -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0xa2] = Q_KEY_CODE_CTRL, /* win32:162 (VK_CONTROL) -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0xa3] = Q_KEY_CODE_CTRL_R, /* win32:163 (VK_RCONTROL) -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0xa4] = Q_KEY_CODE_ALT, /* win32:164 (VK_MENU) -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0xa5] = Q_KEY_CODE_ALT_R, /* win32:165 (VK_RMENU) -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0xa6] = Q_KEY_CODE_AC_BACK, /* win32:166 (VK_BROWSER_BACK) -> linux:158 (KEY_BACK) -> qcode:Q_KEY_CODE_AC_BACK (ac_back) */
+  [0xa7] = Q_KEY_CODE_AC_FORWARD, /* win32:167 (VK_BROWSER_FORWARD) -> linux:159 (KEY_FORWARD) -> qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) */
+  [0xa8] = Q_KEY_CODE_AC_REFRESH, /* win32:168 (VK_BROWSER_REFRESH) -> linux:173 (KEY_REFRESH) -> qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) */
+  [0xa9] = Q_KEY_CODE_STOP, /* win32:169 (VK_BROWSER_STOP) -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0xaa] = Q_KEY_CODE_UNMAPPED, /* win32:170 (VK_BROWSER_SEARCH) -> linux:217 (KEY_SEARCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xab] = Q_KEY_CODE_UNMAPPED, /* win32:171 (VK_BROWSER_FAVOURITES) -> linux:364 (KEY_FAVORITES) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xac] = Q_KEY_CODE_AC_HOME, /* win32:172 (VK_BROWSER_HOME) -> linux:172 (KEY_HOMEPAGE) -> qcode:Q_KEY_CODE_AC_HOME (ac_home) */
+  [0xad] = Q_KEY_CODE_AUDIOMUTE, /* win32:173 (VK_VOLUME_MUTE) -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0xae] = Q_KEY_CODE_VOLUMEDOWN, /* win32:174 (VK_VOLUME_DOWN) -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0xaf] = Q_KEY_CODE_VOLUMEUP, /* win32:175 (VK_VOLUME_UP) -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0xb0] = Q_KEY_CODE_AUDIONEXT, /* win32:176 (VK_MEDIA_NEXT_TRACK) -> linux:163 (KEY_NEXTSONG) -> qcode:Q_KEY_CODE_AUDIONEXT (audionext) */
+  [0xb1] = Q_KEY_CODE_AUDIOPREV, /* win32:177 (VK_MEDIA_PREV_TRACK) -> linux:165 (KEY_PREVIOUSSONG) -> qcode:Q_KEY_CODE_AUDIOPREV (audioprev) */
+  [0xb2] = Q_KEY_CODE_AUDIOSTOP, /* win32:178 (VK_MEDIA_STOP) -> linux:166 (KEY_STOPCD) -> qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) */
+  [0xb3] = Q_KEY_CODE_AUDIOPLAY, /* win32:179 (VK_MEDIA_PLAY_PAUSE) -> linux:164 (KEY_PLAYPAUSE) -> qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) */
+  [0xb4] = Q_KEY_CODE_UNMAPPED, /* win32:180 (VK_LAUNCH_MAIL) -> linux:215 (KEY_EMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xba] = Q_KEY_CODE_SEMICOLON, /* win32:186 (VK_OEM_1) -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0xbb] = Q_KEY_CODE_EQUAL, /* win32:187 (VK_OEM_PLUS) -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0xbc] = Q_KEY_CODE_COMMA, /* win32:188 (VK_OEM_COMMA) -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0xbd] = Q_KEY_CODE_MINUS, /* win32:189 (VK_OEM_MINUS) -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0xbe] = Q_KEY_CODE_DOT, /* win32:190 (VK_OEM_PERIOD) -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0xbf] = Q_KEY_CODE_SLASH, /* win32:191 (VK_OEM_2) -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0xc0] = Q_KEY_CODE_GRAVE_ACCENT, /* win32:192 (VK_OEM_3) -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0xdb] = Q_KEY_CODE_BRACKET_LEFT, /* win32:219 (VK_OEM_4) -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0xdc] = Q_KEY_CODE_BACKSLASH, /* win32:220 (VK_OEM_5) -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0xdd] = Q_KEY_CODE_BRACKET_RIGHT, /* win32:221 (VK_OEM_6) -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0xde] = Q_KEY_CODE_APOSTROPHE, /* win32:222 (VK_OEM_7) -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0xe1] = Q_KEY_CODE_LESS, /* win32:225 (VK_OEM_102) -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0xfa] = Q_KEY_CODE_UNMAPPED, /* win32:250 (VK_PLAY) -> linux:207 (KEY_PLAY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfb] = Q_KEY_CODE_UNMAPPED, /* win32:251 (VK_ZOOM) -> linux:372 (KEY_ZOOM) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_win32_to_qcode_len = sizeof(qemu_input_map_win32_to_qcode)/sizeof(qemu_input_map_win32_to_qcode[0]);
diff --git a/ui/input-keymap-x11-to-qcode.c b/ui/input-keymap-x11-to-qcode.c
new file mode 100644
index 0000000000..5802a1d052
--- /dev/null
+++ b/ui/input-keymap-x11-to-qcode.c
@@ -0,0 +1,163 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_x11_to_qcode code-map keymaps.csv x11 qcode
+*/
+const guint16 qemu_input_map_x11_to_qcode[65536] = {
+  [0x20] = Q_KEY_CODE_SPC, /* x11:32 (XK_space) -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x21] = Q_KEY_CODE_1, /* x11:33 (XK_exclam) -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x22] = Q_KEY_CODE_APOSTROPHE, /* x11:34 (XK_quotedbl) -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x23] = Q_KEY_CODE_3, /* x11:35 (XK_numbersign) -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x24] = Q_KEY_CODE_4, /* x11:36 (XK_dollar) -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x25] = Q_KEY_CODE_5, /* x11:37 (XK_percent) -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x26] = Q_KEY_CODE_7, /* x11:38 (XK_ampersand) -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x27] = Q_KEY_CODE_APOSTROPHE, /* x11:39 (XK_quotedbl) -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x28] = Q_KEY_CODE_9, /* x11:40 (XK_parenleft) -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x29] = Q_KEY_CODE_0, /* x11:41 (XK_parenright) -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x2a] = Q_KEY_CODE_8, /* x11:42 (XK_asterisk) -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x2b] = Q_KEY_CODE_EQUAL, /* x11:43 (XK_plus) -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x2c] = Q_KEY_CODE_COMMA, /* x11:44 (XK_less) -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x2d] = Q_KEY_CODE_MINUS, /* x11:45 (XK_underscore) -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x2e] = Q_KEY_CODE_DOT, /* x11:46 (XK_greater) -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x2f] = Q_KEY_CODE_SLASH, /* x11:47 (XK_question) -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x30] = Q_KEY_CODE_0, /* x11:48 (XK_parenright) -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x31] = Q_KEY_CODE_1, /* x11:49 (XK_exclam) -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x32] = Q_KEY_CODE_2, /* x11:50 (XK_at) -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x33] = Q_KEY_CODE_3, /* x11:51 (XK_numbersign) -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x34] = Q_KEY_CODE_4, /* x11:52 (XK_dollar) -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x35] = Q_KEY_CODE_5, /* x11:53 (XK_percent) -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x36] = Q_KEY_CODE_6, /* x11:54 (XK_asciicircum) -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x37] = Q_KEY_CODE_7, /* x11:55 (XK_ampersand) -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x38] = Q_KEY_CODE_8, /* x11:56 (XK_asterisk) -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x39] = Q_KEY_CODE_9, /* x11:57 (XK_parenleft) -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x3a] = Q_KEY_CODE_SEMICOLON, /* x11:58 (XK_colon) -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x3b] = Q_KEY_CODE_SEMICOLON, /* x11:59 (XK_colon) -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x3c] = Q_KEY_CODE_COMMA, /* x11:60 (XK_less) -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x3d] = Q_KEY_CODE_EQUAL, /* x11:61 (XK_plus) -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x3e] = Q_KEY_CODE_DOT, /* x11:62 (XK_greater) -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x3f] = Q_KEY_CODE_SLASH, /* x11:63 (XK_question) -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x40] = Q_KEY_CODE_2, /* x11:64 (XK_at) -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x41] = Q_KEY_CODE_A, /* x11:65 (XK_a) -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x42] = Q_KEY_CODE_B, /* x11:66 (XK_b) -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x43] = Q_KEY_CODE_C, /* x11:67 (XK_c) -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x44] = Q_KEY_CODE_D, /* x11:68 (XK_d) -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x45] = Q_KEY_CODE_E, /* x11:69 (XK_e) -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x46] = Q_KEY_CODE_F, /* x11:70 (XK_f) -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x47] = Q_KEY_CODE_G, /* x11:71 (XK_g) -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x48] = Q_KEY_CODE_H, /* x11:72 (XK_h) -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x49] = Q_KEY_CODE_I, /* x11:73 (XK_i) -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x4a] = Q_KEY_CODE_J, /* x11:74 (XK_j) -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x4b] = Q_KEY_CODE_K, /* x11:75 (XK_k) -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x4c] = Q_KEY_CODE_L, /* x11:76 (XK_l) -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x4d] = Q_KEY_CODE_M, /* x11:77 (XK_m) -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x4e] = Q_KEY_CODE_N, /* x11:78 (XK_n) -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x4f] = Q_KEY_CODE_O, /* x11:79 (XK_o) -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x50] = Q_KEY_CODE_P, /* x11:80 (XK_p) -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x51] = Q_KEY_CODE_Q, /* x11:81 (XK_q) -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x52] = Q_KEY_CODE_R, /* x11:82 (XK_r) -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x53] = Q_KEY_CODE_S, /* x11:83 (XK_s) -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x54] = Q_KEY_CODE_T, /* x11:84 (XK_t) -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x55] = Q_KEY_CODE_U, /* x11:85 (XK_u) -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x56] = Q_KEY_CODE_V, /* x11:86 (XK_v) -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x57] = Q_KEY_CODE_W, /* x11:87 (XK_w) -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x58] = Q_KEY_CODE_X, /* x11:88 (XK_x) -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x59] = Q_KEY_CODE_Y, /* x11:89 (XK_y) -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x5a] = Q_KEY_CODE_Z, /* x11:90 (XK_z) -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x5b] = Q_KEY_CODE_BRACKET_LEFT, /* x11:91 (XK_braceleft) -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x5c] = Q_KEY_CODE_BACKSLASH, /* x11:92 (XK_bar) -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x5d] = Q_KEY_CODE_BRACKET_RIGHT, /* x11:93 (XK_braceright) -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x5e] = Q_KEY_CODE_6, /* x11:94 (XK_asciicircum) -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x5f] = Q_KEY_CODE_MINUS, /* x11:95 (XK_underscore) -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x60] = Q_KEY_CODE_GRAVE_ACCENT, /* x11:96 (XK_asciitilde) -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x61] = Q_KEY_CODE_A, /* x11:97 (XK_a) -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x62] = Q_KEY_CODE_B, /* x11:98 (XK_b) -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x63] = Q_KEY_CODE_C, /* x11:99 (XK_c) -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x64] = Q_KEY_CODE_D, /* x11:100 (XK_d) -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x65] = Q_KEY_CODE_E, /* x11:101 (XK_e) -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x66] = Q_KEY_CODE_F, /* x11:102 (XK_f) -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x67] = Q_KEY_CODE_G, /* x11:103 (XK_g) -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x68] = Q_KEY_CODE_H, /* x11:104 (XK_h) -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x69] = Q_KEY_CODE_I, /* x11:105 (XK_i) -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x6a] = Q_KEY_CODE_J, /* x11:106 (XK_j) -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x6b] = Q_KEY_CODE_K, /* x11:107 (XK_k) -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x6c] = Q_KEY_CODE_L, /* x11:108 (XK_l) -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x6d] = Q_KEY_CODE_M, /* x11:109 (XK_m) -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x6e] = Q_KEY_CODE_N, /* x11:110 (XK_n) -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x6f] = Q_KEY_CODE_O, /* x11:111 (XK_o) -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x70] = Q_KEY_CODE_P, /* x11:112 (XK_p) -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x71] = Q_KEY_CODE_Q, /* x11:113 (XK_q) -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x72] = Q_KEY_CODE_R, /* x11:114 (XK_r) -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x73] = Q_KEY_CODE_S, /* x11:115 (XK_s) -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x74] = Q_KEY_CODE_T, /* x11:116 (XK_t) -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x75] = Q_KEY_CODE_U, /* x11:117 (XK_u) -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x76] = Q_KEY_CODE_V, /* x11:118 (XK_v) -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x77] = Q_KEY_CODE_W, /* x11:119 (XK_w) -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x78] = Q_KEY_CODE_X, /* x11:120 (XK_x) -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x79] = Q_KEY_CODE_Y, /* x11:121 (XK_y) -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x7a] = Q_KEY_CODE_Z, /* x11:122 (XK_z) -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x7b] = Q_KEY_CODE_BRACKET_LEFT, /* x11:123 (XK_braceleft) -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x7c] = Q_KEY_CODE_BACKSLASH, /* x11:124 (XK_bar) -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x7d] = Q_KEY_CODE_BRACKET_RIGHT, /* x11:125 (XK_braceright) -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x7e] = Q_KEY_CODE_GRAVE_ACCENT, /* x11:126 (XK_asciitilde) -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0xd7] = Q_KEY_CODE_KP_MULTIPLY, /* x11:215 (XK_multiply) -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0xff08] = Q_KEY_CODE_BACKSPACE, /* x11:65288 (XK_BackSpace) -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0xff09] = Q_KEY_CODE_TAB, /* x11:65289 (XK_Tab) -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0xff0d] = Q_KEY_CODE_RET, /* x11:65293 (XK_Return) -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0xff13] = Q_KEY_CODE_PAUSE, /* x11:65299 (XK_Pause) -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0xff14] = Q_KEY_CODE_SCROLL_LOCK, /* x11:65300 (XK_Scroll_Lock) -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0xff15] = Q_KEY_CODE_SYSRQ, /* x11:65301 (XK_Sys_Req) -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0xff1b] = Q_KEY_CODE_ESC, /* x11:65307 (XK_Escape) -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0xff50] = Q_KEY_CODE_HOME, /* x11:65360 (XK_Home) -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0xff51] = Q_KEY_CODE_LEFT, /* x11:65361 (XK_Left) -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0xff52] = Q_KEY_CODE_UP, /* x11:65362 (XK_Up) -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0xff53] = Q_KEY_CODE_RIGHT, /* x11:65363 (XK_Right) -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0xff54] = Q_KEY_CODE_DOWN, /* x11:65364 (XK_Down) -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0xff55] = Q_KEY_CODE_PGUP, /* x11:65365 (XK_Page_Up) -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0xff56] = Q_KEY_CODE_PGDN, /* x11:65366 (XK_Page_Down) -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0xff57] = Q_KEY_CODE_END, /* x11:65367 (XK_End) -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0xff60] = Q_KEY_CODE_UNMAPPED, /* x11:65376 (XK_Select) -> linux:353 (KEY_SELECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xff63] = Q_KEY_CODE_INSERT, /* x11:65379 (XK_Insert) -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0xff6a] = Q_KEY_CODE_HELP, /* x11:65386 (XK_Help) -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0xff7f] = Q_KEY_CODE_NUM_LOCK, /* x11:65407 (XK_Num_Lock) -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0xff8d] = Q_KEY_CODE_KP_ENTER, /* x11:65421 (XK_KP_Enter) -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0xffab] = Q_KEY_CODE_KP_ADD, /* x11:65451 (XK_KP_Add) -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0xffac] = Q_KEY_CODE_UNMAPPED, /* x11:65452 (XK_KP_Separator) -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xffad] = Q_KEY_CODE_KP_SUBTRACT, /* x11:65453 (XK_KP_Subtract) -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0xffae] = Q_KEY_CODE_KP_DECIMAL, /* x11:65454 (XK_KP_Decimal) -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0xffaf] = Q_KEY_CODE_KP_DIVIDE, /* x11:65455 (XK_KP_Divide) -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0xffb0] = Q_KEY_CODE_KP_0, /* x11:65456 (XK_KP_0) -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0xffb1] = Q_KEY_CODE_KP_1, /* x11:65457 (XK_KP_1) -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0xffb2] = Q_KEY_CODE_KP_2, /* x11:65458 (XK_KP_2) -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0xffb3] = Q_KEY_CODE_KP_3, /* x11:65459 (XK_KP_3) -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0xffb4] = Q_KEY_CODE_KP_4, /* x11:65460 (XK_KP_4) -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0xffb5] = Q_KEY_CODE_KP_5, /* x11:65461 (XK_KP_5) -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0xffb6] = Q_KEY_CODE_KP_6, /* x11:65462 (XK_KP_6) -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0xffb7] = Q_KEY_CODE_KP_7, /* x11:65463 (XK_KP_7) -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0xffb8] = Q_KEY_CODE_KP_8, /* x11:65464 (XK_KP_8) -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0xffb9] = Q_KEY_CODE_KP_9, /* x11:65465 (XK_KP_9) -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0xffbd] = Q_KEY_CODE_KP_EQUALS, /* x11:65469 (XK_KP_Equal) -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0xffbe] = Q_KEY_CODE_F1, /* x11:65470 (XK_F1) -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0xffbf] = Q_KEY_CODE_F2, /* x11:65471 (XK_F2) -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0xffc0] = Q_KEY_CODE_F3, /* x11:65472 (XK_F3) -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0xffc1] = Q_KEY_CODE_F4, /* x11:65473 (XK_F4) -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0xffc2] = Q_KEY_CODE_F5, /* x11:65474 (XK_F5) -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0xffc3] = Q_KEY_CODE_F6, /* x11:65475 (XK_F6) -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0xffc4] = Q_KEY_CODE_F7, /* x11:65476 (XK_F7) -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0xffc5] = Q_KEY_CODE_F8, /* x11:65477 (XK_F8) -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0xffc6] = Q_KEY_CODE_F9, /* x11:65478 (XK_F9) -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0xffc7] = Q_KEY_CODE_F10, /* x11:65479 (XK_F10) -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0xffc8] = Q_KEY_CODE_F11, /* x11:65480 (XK_F11) -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0xffc9] = Q_KEY_CODE_F12, /* x11:65481 (XK_F12) -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0xffe1] = Q_KEY_CODE_SHIFT, /* x11:65505 (XK_Shift_L) -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0xffe2] = Q_KEY_CODE_SHIFT_R, /* x11:65506 (XK_Shift_R) -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0xffe3] = Q_KEY_CODE_CTRL, /* x11:65507 (XK_Control_L) -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0xffe4] = Q_KEY_CODE_CTRL_R, /* x11:65508 (XK_Control_R) -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0xffe5] = Q_KEY_CODE_CAPS_LOCK, /* x11:65509 (XK_Caps_Lock) -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0xffe7] = Q_KEY_CODE_META_L, /* x11:65511 (XK_Meta_L) -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0xffe8] = Q_KEY_CODE_META_R, /* x11:65512 (XK_Meta_R) -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0xffe9] = Q_KEY_CODE_ALT, /* x11:65513 (XK_Alt_L) -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0xffea] = Q_KEY_CODE_ALT_R, /* x11:65514 (XK_Alt_R) -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0xffff] = Q_KEY_CODE_DELETE, /* x11:65535 (XK_Delete) -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+};
+const guint qemu_input_map_x11_to_qcode_len = sizeof(qemu_input_map_x11_to_qcode)/sizeof(qemu_input_map_x11_to_qcode[0]);
diff --git a/ui/input-keymap-xorgevdev-to-qcode.c b/ui/input-keymap-xorgevdev-to-qcode.c
new file mode 100644
index 0000000000..8e6de616d9
--- /dev/null
+++ b/ui/input-keymap-xorgevdev-to-qcode.c
@@ -0,0 +1,463 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_xorgevdev_to_qcode code-map keymaps.csv xorgevdev qcode
+*/
+const guint16 qemu_input_map_xorgevdev_to_qcode[533] = {
+  [0x8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:8 -> linux:0 (KEY_RESERVED) -> qcode:Q_KEY_CODE_UNMAPPED (unmapped) */
+  [0x9] = Q_KEY_CODE_ESC, /* xorgevdev:9 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0xa] = Q_KEY_CODE_1, /* xorgevdev:10 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0xb] = Q_KEY_CODE_2, /* xorgevdev:11 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0xc] = Q_KEY_CODE_3, /* xorgevdev:12 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0xd] = Q_KEY_CODE_4, /* xorgevdev:13 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0xe] = Q_KEY_CODE_5, /* xorgevdev:14 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0xf] = Q_KEY_CODE_6, /* xorgevdev:15 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x10] = Q_KEY_CODE_7, /* xorgevdev:16 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x11] = Q_KEY_CODE_8, /* xorgevdev:17 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x12] = Q_KEY_CODE_9, /* xorgevdev:18 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x13] = Q_KEY_CODE_0, /* xorgevdev:19 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x14] = Q_KEY_CODE_MINUS, /* xorgevdev:20 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x15] = Q_KEY_CODE_EQUAL, /* xorgevdev:21 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x16] = Q_KEY_CODE_BACKSPACE, /* xorgevdev:22 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x17] = Q_KEY_CODE_TAB, /* xorgevdev:23 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x18] = Q_KEY_CODE_Q, /* xorgevdev:24 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x19] = Q_KEY_CODE_W, /* xorgevdev:25 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x1a] = Q_KEY_CODE_E, /* xorgevdev:26 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x1b] = Q_KEY_CODE_R, /* xorgevdev:27 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x1c] = Q_KEY_CODE_T, /* xorgevdev:28 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x1d] = Q_KEY_CODE_Y, /* xorgevdev:29 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x1e] = Q_KEY_CODE_U, /* xorgevdev:30 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x1f] = Q_KEY_CODE_I, /* xorgevdev:31 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x20] = Q_KEY_CODE_O, /* xorgevdev:32 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x21] = Q_KEY_CODE_P, /* xorgevdev:33 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x22] = Q_KEY_CODE_BRACKET_LEFT, /* xorgevdev:34 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x23] = Q_KEY_CODE_BRACKET_RIGHT, /* xorgevdev:35 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x24] = Q_KEY_CODE_RET, /* xorgevdev:36 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x25] = Q_KEY_CODE_CTRL, /* xorgevdev:37 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x26] = Q_KEY_CODE_A, /* xorgevdev:38 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x27] = Q_KEY_CODE_S, /* xorgevdev:39 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x28] = Q_KEY_CODE_D, /* xorgevdev:40 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x29] = Q_KEY_CODE_F, /* xorgevdev:41 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x2a] = Q_KEY_CODE_G, /* xorgevdev:42 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x2b] = Q_KEY_CODE_H, /* xorgevdev:43 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x2c] = Q_KEY_CODE_J, /* xorgevdev:44 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x2d] = Q_KEY_CODE_K, /* xorgevdev:45 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x2e] = Q_KEY_CODE_L, /* xorgevdev:46 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x2f] = Q_KEY_CODE_SEMICOLON, /* xorgevdev:47 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x30] = Q_KEY_CODE_APOSTROPHE, /* xorgevdev:48 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x31] = Q_KEY_CODE_GRAVE_ACCENT, /* xorgevdev:49 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x32] = Q_KEY_CODE_SHIFT, /* xorgevdev:50 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x33] = Q_KEY_CODE_BACKSLASH, /* xorgevdev:51 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x34] = Q_KEY_CODE_Z, /* xorgevdev:52 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x35] = Q_KEY_CODE_X, /* xorgevdev:53 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x36] = Q_KEY_CODE_C, /* xorgevdev:54 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x37] = Q_KEY_CODE_V, /* xorgevdev:55 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x38] = Q_KEY_CODE_B, /* xorgevdev:56 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x39] = Q_KEY_CODE_N, /* xorgevdev:57 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x3a] = Q_KEY_CODE_M, /* xorgevdev:58 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x3b] = Q_KEY_CODE_COMMA, /* xorgevdev:59 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x3c] = Q_KEY_CODE_DOT, /* xorgevdev:60 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x3d] = Q_KEY_CODE_SLASH, /* xorgevdev:61 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x3e] = Q_KEY_CODE_SHIFT_R, /* xorgevdev:62 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x3f] = Q_KEY_CODE_KP_MULTIPLY, /* xorgevdev:63 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x40] = Q_KEY_CODE_ALT, /* xorgevdev:64 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x41] = Q_KEY_CODE_SPC, /* xorgevdev:65 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x42] = Q_KEY_CODE_CAPS_LOCK, /* xorgevdev:66 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x43] = Q_KEY_CODE_F1, /* xorgevdev:67 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x44] = Q_KEY_CODE_F2, /* xorgevdev:68 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x45] = Q_KEY_CODE_F3, /* xorgevdev:69 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x46] = Q_KEY_CODE_F4, /* xorgevdev:70 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x47] = Q_KEY_CODE_F5, /* xorgevdev:71 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x48] = Q_KEY_CODE_F6, /* xorgevdev:72 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x49] = Q_KEY_CODE_F7, /* xorgevdev:73 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x4a] = Q_KEY_CODE_F8, /* xorgevdev:74 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x4b] = Q_KEY_CODE_F9, /* xorgevdev:75 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x4c] = Q_KEY_CODE_F10, /* xorgevdev:76 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x4d] = Q_KEY_CODE_NUM_LOCK, /* xorgevdev:77 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x4e] = Q_KEY_CODE_SCROLL_LOCK, /* xorgevdev:78 -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x4f] = Q_KEY_CODE_KP_7, /* xorgevdev:79 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x50] = Q_KEY_CODE_KP_8, /* xorgevdev:80 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x51] = Q_KEY_CODE_KP_9, /* xorgevdev:81 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x52] = Q_KEY_CODE_KP_SUBTRACT, /* xorgevdev:82 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x53] = Q_KEY_CODE_KP_4, /* xorgevdev:83 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x54] = Q_KEY_CODE_KP_5, /* xorgevdev:84 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x55] = Q_KEY_CODE_KP_6, /* xorgevdev:85 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x56] = Q_KEY_CODE_KP_ADD, /* xorgevdev:86 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x57] = Q_KEY_CODE_KP_1, /* xorgevdev:87 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x58] = Q_KEY_CODE_KP_2, /* xorgevdev:88 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x59] = Q_KEY_CODE_KP_3, /* xorgevdev:89 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x5a] = Q_KEY_CODE_KP_0, /* xorgevdev:90 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x5b] = Q_KEY_CODE_KP_DECIMAL, /* xorgevdev:91 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x5c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:92 -> linux:84 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:93 -> linux:85 (KEY_ZENKAKUHANKAKU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x5e] = Q_KEY_CODE_LESS, /* xorgevdev:94 -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x5f] = Q_KEY_CODE_F11, /* xorgevdev:95 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x60] = Q_KEY_CODE_F12, /* xorgevdev:96 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x61] = Q_KEY_CODE_RO, /* xorgevdev:97 -> linux:89 (KEY_RO) -> qcode:Q_KEY_CODE_RO (ro) */
+  [0x62] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:98 -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x63] = Q_KEY_CODE_HIRAGANA, /* xorgevdev:99 -> linux:91 (KEY_HIRAGANA) -> qcode:Q_KEY_CODE_HIRAGANA (hiragana) */
+  [0x64] = Q_KEY_CODE_HENKAN, /* xorgevdev:100 -> linux:92 (KEY_HENKAN) -> qcode:Q_KEY_CODE_HENKAN (henkan) */
+  [0x65] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:101 -> linux:93 (KEY_KATAKANAHIRAGANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x66] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:102 -> linux:94 (KEY_MUHENKAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x67] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:103 -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x68] = Q_KEY_CODE_KP_ENTER, /* xorgevdev:104 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x69] = Q_KEY_CODE_CTRL_R, /* xorgevdev:105 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x6a] = Q_KEY_CODE_KP_DIVIDE, /* xorgevdev:106 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x6b] = Q_KEY_CODE_SYSRQ, /* xorgevdev:107 -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x6c] = Q_KEY_CODE_ALT_R, /* xorgevdev:108 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0x6d] = Q_KEY_CODE_LF, /* xorgevdev:109 -> linux:101 (KEY_LINEFEED) -> qcode:Q_KEY_CODE_LF (lf) */
+  [0x6e] = Q_KEY_CODE_HOME, /* xorgevdev:110 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x6f] = Q_KEY_CODE_UP, /* xorgevdev:111 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x70] = Q_KEY_CODE_PGUP, /* xorgevdev:112 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x71] = Q_KEY_CODE_LEFT, /* xorgevdev:113 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x72] = Q_KEY_CODE_RIGHT, /* xorgevdev:114 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x73] = Q_KEY_CODE_END, /* xorgevdev:115 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x74] = Q_KEY_CODE_DOWN, /* xorgevdev:116 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x75] = Q_KEY_CODE_PGDN, /* xorgevdev:117 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x76] = Q_KEY_CODE_INSERT, /* xorgevdev:118 -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0x77] = Q_KEY_CODE_DELETE, /* xorgevdev:119 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x78] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:120 -> linux:112 (KEY_MACRO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x79] = Q_KEY_CODE_AUDIOMUTE, /* xorgevdev:121 -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0x7a] = Q_KEY_CODE_VOLUMEDOWN, /* xorgevdev:122 -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0x7b] = Q_KEY_CODE_VOLUMEUP, /* xorgevdev:123 -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0x7c] = Q_KEY_CODE_POWER, /* xorgevdev:124 -> linux:116 (KEY_POWER) -> qcode:Q_KEY_CODE_POWER (power) */
+  [0x7d] = Q_KEY_CODE_KP_EQUALS, /* xorgevdev:125 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x7e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:126 -> linux:118 (KEY_KPPLUSMINUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7f] = Q_KEY_CODE_PAUSE, /* xorgevdev:127 -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0x80] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:128 -> linux:120 (KEY_SCALE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x81] = Q_KEY_CODE_KP_COMMA, /* xorgevdev:129 -> linux:121 (KEY_KPCOMMA) -> qcode:Q_KEY_CODE_KP_COMMA (kp_comma) */
+  [0x82] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:130 -> linux:122 (KEY_HANGEUL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x83] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:131 -> linux:123 (KEY_HANJA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x84] = Q_KEY_CODE_YEN, /* xorgevdev:132 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x85] = Q_KEY_CODE_META_L, /* xorgevdev:133 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x86] = Q_KEY_CODE_META_R, /* xorgevdev:134 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x87] = Q_KEY_CODE_COMPOSE, /* xorgevdev:135 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x88] = Q_KEY_CODE_STOP, /* xorgevdev:136 -> linux:128 (KEY_STOP) -> qcode:Q_KEY_CODE_STOP (stop) */
+  [0x89] = Q_KEY_CODE_AGAIN, /* xorgevdev:137 -> linux:129 (KEY_AGAIN) -> qcode:Q_KEY_CODE_AGAIN (again) */
+  [0x8a] = Q_KEY_CODE_PROPS, /* xorgevdev:138 -> linux:130 (KEY_PROPS) -> qcode:Q_KEY_CODE_PROPS (props) */
+  [0x8b] = Q_KEY_CODE_UNDO, /* xorgevdev:139 -> linux:131 (KEY_UNDO) -> qcode:Q_KEY_CODE_UNDO (undo) */
+  [0x8c] = Q_KEY_CODE_FRONT, /* xorgevdev:140 -> linux:132 (KEY_FRONT) -> qcode:Q_KEY_CODE_FRONT (front) */
+  [0x8d] = Q_KEY_CODE_COPY, /* xorgevdev:141 -> linux:133 (KEY_COPY) -> qcode:Q_KEY_CODE_COPY (copy) */
+  [0x8e] = Q_KEY_CODE_OPEN, /* xorgevdev:142 -> linux:134 (KEY_OPEN) -> qcode:Q_KEY_CODE_OPEN (open) */
+  [0x8f] = Q_KEY_CODE_PASTE, /* xorgevdev:143 -> linux:135 (KEY_PASTE) -> qcode:Q_KEY_CODE_PASTE (paste) */
+  [0x90] = Q_KEY_CODE_FIND, /* xorgevdev:144 -> linux:136 (KEY_FIND) -> qcode:Q_KEY_CODE_FIND (find) */
+  [0x91] = Q_KEY_CODE_CUT, /* xorgevdev:145 -> linux:137 (KEY_CUT) -> qcode:Q_KEY_CODE_CUT (cut) */
+  [0x92] = Q_KEY_CODE_HELP, /* xorgevdev:146 -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0x93] = Q_KEY_CODE_MENU, /* xorgevdev:147 -> linux:139 (KEY_MENU) -> qcode:Q_KEY_CODE_MENU (menu) */
+  [0x94] = Q_KEY_CODE_CALCULATOR, /* xorgevdev:148 -> linux:140 (KEY_CALC) -> qcode:Q_KEY_CODE_CALCULATOR (calculator) */
+  [0x95] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:149 -> linux:141 (KEY_SETUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x96] = Q_KEY_CODE_SLEEP, /* xorgevdev:150 -> linux:142 (KEY_SLEEP) -> qcode:Q_KEY_CODE_SLEEP (sleep) */
+  [0x97] = Q_KEY_CODE_WAKE, /* xorgevdev:151 -> linux:143 (KEY_WAKEUP) -> qcode:Q_KEY_CODE_WAKE (wake) */
+  [0x98] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:152 -> linux:144 (KEY_FILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x99] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:153 -> linux:145 (KEY_SENDFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:154 -> linux:146 (KEY_DELETEFILE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:155 -> linux:147 (KEY_XFER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:156 -> linux:148 (KEY_PROG1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:157 -> linux:149 (KEY_PROG2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:158 -> linux:150 (KEY_WWW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x9f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:159 -> linux:151 (KEY_MSDOS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:160 -> linux:152 (KEY_SCREENLOCK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:161 -> linux:153 (KEY_DIRECTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:162 -> linux:154 (KEY_CYCLEWINDOWS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa3] = Q_KEY_CODE_MAIL, /* xorgevdev:163 -> linux:155 (KEY_MAIL) -> qcode:Q_KEY_CODE_MAIL (mail) */
+  [0xa4] = Q_KEY_CODE_AC_BOOKMARKS, /* xorgevdev:164 -> linux:156 (KEY_BOOKMARKS) -> qcode:Q_KEY_CODE_AC_BOOKMARKS (ac_bookmarks) */
+  [0xa5] = Q_KEY_CODE_COMPUTER, /* xorgevdev:165 -> linux:157 (KEY_COMPUTER) -> qcode:Q_KEY_CODE_COMPUTER (computer) */
+  [0xa6] = Q_KEY_CODE_AC_BACK, /* xorgevdev:166 -> linux:158 (KEY_BACK) -> qcode:Q_KEY_CODE_AC_BACK (ac_back) */
+  [0xa7] = Q_KEY_CODE_AC_FORWARD, /* xorgevdev:167 -> linux:159 (KEY_FORWARD) -> qcode:Q_KEY_CODE_AC_FORWARD (ac_forward) */
+  [0xa8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:168 -> linux:160 (KEY_CLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xa9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:169 -> linux:161 (KEY_EJECTCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xaa] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:170 -> linux:162 (KEY_EJECTCLOSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xab] = Q_KEY_CODE_AUDIONEXT, /* xorgevdev:171 -> linux:163 (KEY_NEXTSONG) -> qcode:Q_KEY_CODE_AUDIONEXT (audionext) */
+  [0xac] = Q_KEY_CODE_AUDIOPLAY, /* xorgevdev:172 -> linux:164 (KEY_PLAYPAUSE) -> qcode:Q_KEY_CODE_AUDIOPLAY (audioplay) */
+  [0xad] = Q_KEY_CODE_AUDIOPREV, /* xorgevdev:173 -> linux:165 (KEY_PREVIOUSSONG) -> qcode:Q_KEY_CODE_AUDIOPREV (audioprev) */
+  [0xae] = Q_KEY_CODE_AUDIOSTOP, /* xorgevdev:174 -> linux:166 (KEY_STOPCD) -> qcode:Q_KEY_CODE_AUDIOSTOP (audiostop) */
+  [0xaf] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:175 -> linux:167 (KEY_RECORD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:176 -> linux:168 (KEY_REWIND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:177 -> linux:169 (KEY_PHONE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:178 -> linux:170 (KEY_ISO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:179 -> linux:171 (KEY_CONFIG) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb4] = Q_KEY_CODE_AC_HOME, /* xorgevdev:180 -> linux:172 (KEY_HOMEPAGE) -> qcode:Q_KEY_CODE_AC_HOME (ac_home) */
+  [0xb5] = Q_KEY_CODE_AC_REFRESH, /* xorgevdev:181 -> linux:173 (KEY_REFRESH) -> qcode:Q_KEY_CODE_AC_REFRESH (ac_refresh) */
+  [0xb6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:182 -> linux:174 (KEY_EXIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:183 -> linux:175 (KEY_MOVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:184 -> linux:176 (KEY_EDIT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xb9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:185 -> linux:177 (KEY_SCROLLUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xba] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:186 -> linux:178 (KEY_SCROLLDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:187 -> linux:179 (KEY_KPLEFTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:188 -> linux:180 (KEY_KPRIGHTPAREN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:189 -> linux:181 (KEY_NEW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbe] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:190 -> linux:182 (KEY_REDO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xbf] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:191 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:192 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:193 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:194 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:195 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:196 -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:197 -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:198 -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:199 -> linux:191 (KEY_F21) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:200 -> linux:192 (KEY_F22) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xc9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:201 -> linux:193 (KEY_F23) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xca] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:202 -> linux:194 (KEY_F24) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:203 -> linux:195 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:204 -> linux:196 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:205 -> linux:197 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xce] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:206 -> linux:198 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xcf] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:207 -> linux:199 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:208 -> linux:200 (KEY_PLAYCD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:209 -> linux:201 (KEY_PAUSECD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:210 -> linux:202 (KEY_PROG3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:211 -> linux:203 (KEY_PROG4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:212 -> linux:204 (KEY_DASHBOARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:213 -> linux:205 (KEY_SUSPEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:214 -> linux:206 (KEY_CLOSE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:215 -> linux:207 (KEY_PLAY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:216 -> linux:208 (KEY_FASTFORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xd9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:217 -> linux:209 (KEY_BASSBOOST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xda] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:218 -> linux:210 (KEY_PRINT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:219 -> linux:211 (KEY_HP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:220 -> linux:212 (KEY_CAMERA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:221 -> linux:213 (KEY_SOUND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xde] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:222 -> linux:214 (KEY_QUESTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xdf] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:223 -> linux:215 (KEY_EMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:224 -> linux:216 (KEY_CHAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:225 -> linux:217 (KEY_SEARCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:226 -> linux:218 (KEY_CONNECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:227 -> linux:219 (KEY_FINANCE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:228 -> linux:220 (KEY_SPORT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:229 -> linux:221 (KEY_SHOP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:230 -> linux:222 (KEY_ALTERASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:231 -> linux:223 (KEY_CANCEL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:232 -> linux:224 (KEY_BRIGHTNESSDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xe9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:233 -> linux:225 (KEY_BRIGHTNESSUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xea] = Q_KEY_CODE_MEDIASELECT, /* xorgevdev:234 -> linux:226 (KEY_MEDIA) -> qcode:Q_KEY_CODE_MEDIASELECT (mediaselect) */
+  [0xeb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:235 -> linux:227 (KEY_SWITCHVIDEOMODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xec] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:236 -> linux:228 (KEY_KBDILLUMTOGGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xed] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:237 -> linux:229 (KEY_KBDILLUMDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xee] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:238 -> linux:230 (KEY_KBDILLUMUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xef] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:239 -> linux:231 (KEY_SEND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:240 -> linux:232 (KEY_REPLY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:241 -> linux:233 (KEY_FORWARDMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:242 -> linux:234 (KEY_SAVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:243 -> linux:235 (KEY_DOCUMENTS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:244 -> linux:236 (KEY_BATTERY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:245 -> linux:237 (KEY_BLUETOOTH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:246 -> linux:238 (KEY_WLAN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:247 -> linux:239 (KEY_UWB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:248 -> linux:240 (KEY_UNKNOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xf9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:249 -> linux:241 (KEY_VIDEO_NEXT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfa] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:250 -> linux:242 (KEY_VIDEO_PREV) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:251 -> linux:243 (KEY_BRIGHTNESS_CYCLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:252 -> linux:244 (KEY_BRIGHTNESS_ZERO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:253 -> linux:245 (KEY_DISPLAY_OFF) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xfe] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:254 -> linux:246 (KEY_WIMAX) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0xff] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:255 -> linux:247 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x100] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:256 -> linux:248 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x101] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:257 -> linux:249 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x102] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:258 -> linux:250 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x103] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:259 -> linux:251 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x104] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:260 -> linux:252 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x105] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:261 -> linux:253 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x106] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:262 -> linux:254 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x107] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:263 -> linux:255 (unnamed) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x108] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:264 -> linux:256 (BTN_0) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x109] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:265 -> linux:257 (BTN_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x10a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:266 -> linux:258 (BTN_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x10b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:267 -> linux:259 (BTN_3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x10c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:268 -> linux:260 (BTN_4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x10d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:269 -> linux:261 (BTN_5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x10e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:270 -> linux:262 (BTN_6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x10f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:271 -> linux:263 (BTN_7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x110] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:272 -> linux:264 (BTN_8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x111] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:273 -> linux:265 (BTN_9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x118] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:280 -> linux:272 (BTN_LEFT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x119] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:281 -> linux:273 (BTN_RIGHT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x11a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:282 -> linux:274 (BTN_MIDDLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x11b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:283 -> linux:275 (BTN_SIDE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x11c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:284 -> linux:276 (BTN_EXTRA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x11d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:285 -> linux:277 (BTN_FORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x11e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:286 -> linux:278 (BTN_BACK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x11f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:287 -> linux:279 (BTN_TASK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x128] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:296 -> linux:288 (BTN_TRIGGER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x129] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:297 -> linux:289 (BTN_THUMB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:298 -> linux:290 (BTN_THUMB2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:299 -> linux:291 (BTN_TOP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:300 -> linux:292 (BTN_TOP2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:301 -> linux:293 (BTN_PINKIE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:302 -> linux:294 (BTN_BASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x12f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:303 -> linux:295 (BTN_BASE2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x130] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:304 -> linux:296 (BTN_BASE3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x131] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:305 -> linux:297 (BTN_BASE4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x132] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:306 -> linux:298 (BTN_BASE5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x133] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:307 -> linux:299 (BTN_BASE6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x137] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:311 -> linux:303 (BTN_DEAD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x138] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:312 -> linux:304 (BTN_A) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x139] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:313 -> linux:305 (BTN_B) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:314 -> linux:306 (BTN_C) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:315 -> linux:307 (BTN_X) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:316 -> linux:308 (BTN_Y) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:317 -> linux:309 (BTN_Z) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:318 -> linux:310 (BTN_TL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:319 -> linux:311 (BTN_TR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x140] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:320 -> linux:312 (BTN_TL2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x141] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:321 -> linux:313 (BTN_TR2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x142] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:322 -> linux:314 (BTN_SELECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x143] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:323 -> linux:315 (BTN_START) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x144] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:324 -> linux:316 (BTN_MODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x145] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:325 -> linux:317 (BTN_THUMBL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x146] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:326 -> linux:318 (BTN_THUMBR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x148] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:328 -> linux:320 (BTN_TOOL_PEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x149] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:329 -> linux:321 (BTN_TOOL_RUBBER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:330 -> linux:322 (BTN_TOOL_BRUSH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:331 -> linux:323 (BTN_TOOL_PENCIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:332 -> linux:324 (BTN_TOOL_AIRBRUSH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:333 -> linux:325 (BTN_TOOL_FINGER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:334 -> linux:326 (BTN_TOOL_MOUSE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x14f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:335 -> linux:327 (BTN_TOOL_LENS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x152] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:338 -> linux:330 (BTN_TOUCH) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x153] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:339 -> linux:331 (BTN_STYLUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x154] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:340 -> linux:332 (BTN_STYLUS2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x155] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:341 -> linux:333 (BTN_TOOL_DOUBLETAP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x156] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:342 -> linux:334 (BTN_TOOL_TRIPLETAP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x157] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:343 -> linux:335 (BTN_TOOL_QUADTAP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x158] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:344 -> linux:336 (BTN_GEAR_DOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x159] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:345 -> linux:337 (BTN_GEAR_UP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x168] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:360 -> linux:352 (KEY_OK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x169] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:361 -> linux:353 (KEY_SELECT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:362 -> linux:354 (KEY_GOTO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:363 -> linux:355 (KEY_CLEAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:364 -> linux:356 (KEY_POWER2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:365 -> linux:357 (KEY_OPTION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:366 -> linux:358 (KEY_INFO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x16f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:367 -> linux:359 (KEY_TIME) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x170] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:368 -> linux:360 (KEY_VENDOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x171] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:369 -> linux:361 (KEY_ARCHIVE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x172] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:370 -> linux:362 (KEY_PROGRAM) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x173] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:371 -> linux:363 (KEY_CHANNEL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x174] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:372 -> linux:364 (KEY_FAVORITES) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x175] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:373 -> linux:365 (KEY_EPG) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x176] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:374 -> linux:366 (KEY_PVR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x177] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:375 -> linux:367 (KEY_MHP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x178] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:376 -> linux:368 (KEY_LANGUAGE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x179] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:377 -> linux:369 (KEY_TITLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:378 -> linux:370 (KEY_SUBTITLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:379 -> linux:371 (KEY_ANGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:380 -> linux:372 (KEY_ZOOM) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:381 -> linux:373 (KEY_MODE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:382 -> linux:374 (KEY_KEYBOARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x17f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:383 -> linux:375 (KEY_SCREEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x180] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:384 -> linux:376 (KEY_PC) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x181] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:385 -> linux:377 (KEY_TV) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x182] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:386 -> linux:378 (KEY_TV2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x183] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:387 -> linux:379 (KEY_VCR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x184] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:388 -> linux:380 (KEY_VCR2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x185] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:389 -> linux:381 (KEY_SAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x186] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:390 -> linux:382 (KEY_SAT2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x187] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:391 -> linux:383 (KEY_CD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x188] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:392 -> linux:384 (KEY_TAPE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x189] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:393 -> linux:385 (KEY_RADIO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:394 -> linux:386 (KEY_TUNER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:395 -> linux:387 (KEY_PLAYER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:396 -> linux:388 (KEY_TEXT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:397 -> linux:389 (KEY_DVD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:398 -> linux:390 (KEY_AUX) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x18f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:399 -> linux:391 (KEY_MP3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x190] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:400 -> linux:392 (KEY_AUDIO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x191] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:401 -> linux:393 (KEY_VIDEO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x192] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:402 -> linux:394 (KEY_DIRECTORY) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x193] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:403 -> linux:395 (KEY_LIST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x194] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:404 -> linux:396 (KEY_MEMO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x195] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:405 -> linux:397 (KEY_CALENDAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x196] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:406 -> linux:398 (KEY_RED) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x197] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:407 -> linux:399 (KEY_GREEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x198] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:408 -> linux:400 (KEY_YELLOW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x199] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:409 -> linux:401 (KEY_BLUE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:410 -> linux:402 (KEY_CHANNELUP) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:411 -> linux:403 (KEY_CHANNELDOWN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:412 -> linux:404 (KEY_FIRST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:413 -> linux:405 (KEY_LAST) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:414 -> linux:406 (KEY_AB) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x19f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:415 -> linux:407 (KEY_NEXT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:416 -> linux:408 (KEY_RESTART) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:417 -> linux:409 (KEY_SLOW) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:418 -> linux:410 (KEY_SHUFFLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:419 -> linux:411 (KEY_BREAK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:420 -> linux:412 (KEY_PREVIOUS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:421 -> linux:413 (KEY_DIGITS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:422 -> linux:414 (KEY_TEEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:423 -> linux:415 (KEY_TWEN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:424 -> linux:416 (KEY_VIDEOPHONE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1a9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:425 -> linux:417 (KEY_GAMES) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1aa] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:426 -> linux:418 (KEY_ZOOMIN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ab] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:427 -> linux:419 (KEY_ZOOMOUT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ac] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:428 -> linux:420 (KEY_ZOOMRESET) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ad] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:429 -> linux:421 (KEY_WORDPROCESSOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ae] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:430 -> linux:422 (KEY_EDITOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1af] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:431 -> linux:423 (KEY_SPREADSHEET) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:432 -> linux:424 (KEY_GRAPHICSEDITOR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:433 -> linux:425 (KEY_PRESENTATION) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:434 -> linux:426 (KEY_DATABASE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:435 -> linux:427 (KEY_NEWS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:436 -> linux:428 (KEY_VOICEMAIL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:437 -> linux:429 (KEY_ADDRESSBOOK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:438 -> linux:430 (KEY_MESSENGER) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:439 -> linux:431 (KEY_DISPLAYTOGGLE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:440 -> linux:432 (KEY_SPELLCHECK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1b9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:441 -> linux:433 (KEY_LOGOFF) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ba] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:442 -> linux:434 (KEY_DOLLAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1bb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:443 -> linux:435 (KEY_EURO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1bc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:444 -> linux:436 (KEY_FRAMEBACK) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1bd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:445 -> linux:437 (KEY_FRAMEFORWARD) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1be] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:446 -> linux:438 (KEY_CONTEXT_MENU) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1bf] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:447 -> linux:439 (KEY_MEDIA_REPEAT) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1c8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:456 -> linux:448 (KEY_DEL_EOL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1c9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:457 -> linux:449 (KEY_DEL_EOS) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ca] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:458 -> linux:450 (KEY_INS_LINE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1cb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:459 -> linux:451 (KEY_DEL_LINE) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:472 -> linux:464 (KEY_FN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1d9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:473 -> linux:465 (KEY_FN_ESC) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1da] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:474 -> linux:466 (KEY_FN_F1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1db] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:475 -> linux:467 (KEY_FN_F2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1dc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:476 -> linux:468 (KEY_FN_F3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1dd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:477 -> linux:469 (KEY_FN_F4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1de] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:478 -> linux:470 (KEY_FN_F5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1df] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:479 -> linux:471 (KEY_FN_F6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e0] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:480 -> linux:472 (KEY_FN_F7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e1] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:481 -> linux:473 (KEY_FN_F8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e2] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:482 -> linux:474 (KEY_FN_F9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e3] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:483 -> linux:475 (KEY_FN_F10) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e4] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:484 -> linux:476 (KEY_FN_F11) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e5] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:485 -> linux:477 (KEY_FN_F12) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e6] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:486 -> linux:478 (KEY_FN_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e7] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:487 -> linux:479 (KEY_FN_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e8] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:488 -> linux:480 (KEY_FN_D) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1e9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:489 -> linux:481 (KEY_FN_E) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ea] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:490 -> linux:482 (KEY_FN_F) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1eb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:491 -> linux:483 (KEY_FN_S) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ec] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:492 -> linux:484 (KEY_FN_B) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1f9] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:505 -> linux:497 (KEY_BRL_DOT1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1fa] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:506 -> linux:498 (KEY_BRL_DOT2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1fb] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:507 -> linux:499 (KEY_BRL_DOT3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1fc] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:508 -> linux:500 (KEY_BRL_DOT4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1fd] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:509 -> linux:501 (KEY_BRL_DOT5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1fe] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:510 -> linux:502 (KEY_BRL_DOT6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x1ff] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:511 -> linux:503 (KEY_BRL_DOT7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x200] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:512 -> linux:504 (KEY_BRL_DOT8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x201] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:513 -> linux:505 (KEY_BRL_DOT9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x202] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:514 -> linux:506 (KEY_BRL_DOT10) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x208] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:520 -> linux:512 (KEY_NUMERIC_0) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x209] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:521 -> linux:513 (KEY_NUMERIC_1) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20a] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:522 -> linux:514 (KEY_NUMERIC_2) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20b] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:523 -> linux:515 (KEY_NUMERIC_3) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20c] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:524 -> linux:516 (KEY_NUMERIC_4) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20d] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:525 -> linux:517 (KEY_NUMERIC_5) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20e] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:526 -> linux:518 (KEY_NUMERIC_6) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x20f] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:527 -> linux:519 (KEY_NUMERIC_7) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x210] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:528 -> linux:520 (KEY_NUMERIC_8) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x211] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:529 -> linux:521 (KEY_NUMERIC_9) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x212] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:530 -> linux:522 (KEY_NUMERIC_STAR) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x213] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:531 -> linux:523 (KEY_NUMERIC_POUND) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x214] = Q_KEY_CODE_UNMAPPED, /* xorgevdev:532 -> linux:524 (KEY_RFKILL) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_xorgevdev_to_qcode_len = sizeof(qemu_input_map_xorgevdev_to_qcode)/sizeof(qemu_input_map_xorgevdev_to_qcode[0]);
diff --git a/ui/input-keymap-xorgkbd-to-qcode.c b/ui/input-keymap-xorgkbd-to-qcode.c
new file mode 100644
index 0000000000..c46097a0e8
--- /dev/null
+++ b/ui/input-keymap-xorgkbd-to-qcode.c
@@ -0,0 +1,122 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_xorgkbd_to_qcode code-map keymaps.csv xorgkbd qcode
+*/
+const guint16 qemu_input_map_xorgkbd_to_qcode[209] = {
+  [0x9] = Q_KEY_CODE_ESC, /* xorgkbd:9 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0xa] = Q_KEY_CODE_1, /* xorgkbd:10 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0xb] = Q_KEY_CODE_2, /* xorgkbd:11 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0xc] = Q_KEY_CODE_3, /* xorgkbd:12 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0xd] = Q_KEY_CODE_4, /* xorgkbd:13 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0xe] = Q_KEY_CODE_5, /* xorgkbd:14 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0xf] = Q_KEY_CODE_6, /* xorgkbd:15 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x10] = Q_KEY_CODE_7, /* xorgkbd:16 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x11] = Q_KEY_CODE_8, /* xorgkbd:17 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x12] = Q_KEY_CODE_9, /* xorgkbd:18 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x13] = Q_KEY_CODE_0, /* xorgkbd:19 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x14] = Q_KEY_CODE_MINUS, /* xorgkbd:20 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x15] = Q_KEY_CODE_EQUAL, /* xorgkbd:21 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x16] = Q_KEY_CODE_BACKSPACE, /* xorgkbd:22 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x17] = Q_KEY_CODE_TAB, /* xorgkbd:23 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x18] = Q_KEY_CODE_Q, /* xorgkbd:24 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x19] = Q_KEY_CODE_W, /* xorgkbd:25 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x1a] = Q_KEY_CODE_E, /* xorgkbd:26 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x1b] = Q_KEY_CODE_R, /* xorgkbd:27 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x1c] = Q_KEY_CODE_T, /* xorgkbd:28 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x1d] = Q_KEY_CODE_Y, /* xorgkbd:29 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x1e] = Q_KEY_CODE_U, /* xorgkbd:30 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x1f] = Q_KEY_CODE_I, /* xorgkbd:31 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x20] = Q_KEY_CODE_O, /* xorgkbd:32 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x21] = Q_KEY_CODE_P, /* xorgkbd:33 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x22] = Q_KEY_CODE_BRACKET_LEFT, /* xorgkbd:34 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x23] = Q_KEY_CODE_BRACKET_RIGHT, /* xorgkbd:35 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x24] = Q_KEY_CODE_RET, /* xorgkbd:36 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x25] = Q_KEY_CODE_CTRL, /* xorgkbd:37 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x26] = Q_KEY_CODE_A, /* xorgkbd:38 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x27] = Q_KEY_CODE_S, /* xorgkbd:39 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x28] = Q_KEY_CODE_D, /* xorgkbd:40 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x29] = Q_KEY_CODE_F, /* xorgkbd:41 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x2a] = Q_KEY_CODE_G, /* xorgkbd:42 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x2b] = Q_KEY_CODE_H, /* xorgkbd:43 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x2c] = Q_KEY_CODE_J, /* xorgkbd:44 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x2d] = Q_KEY_CODE_K, /* xorgkbd:45 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x2e] = Q_KEY_CODE_L, /* xorgkbd:46 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x2f] = Q_KEY_CODE_SEMICOLON, /* xorgkbd:47 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x30] = Q_KEY_CODE_APOSTROPHE, /* xorgkbd:48 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x31] = Q_KEY_CODE_GRAVE_ACCENT, /* xorgkbd:49 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x32] = Q_KEY_CODE_SHIFT, /* xorgkbd:50 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x33] = Q_KEY_CODE_BACKSLASH, /* xorgkbd:51 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x34] = Q_KEY_CODE_Z, /* xorgkbd:52 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x35] = Q_KEY_CODE_X, /* xorgkbd:53 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x36] = Q_KEY_CODE_C, /* xorgkbd:54 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x37] = Q_KEY_CODE_V, /* xorgkbd:55 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x38] = Q_KEY_CODE_B, /* xorgkbd:56 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x39] = Q_KEY_CODE_N, /* xorgkbd:57 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x3a] = Q_KEY_CODE_M, /* xorgkbd:58 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x3b] = Q_KEY_CODE_COMMA, /* xorgkbd:59 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x3c] = Q_KEY_CODE_DOT, /* xorgkbd:60 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x3d] = Q_KEY_CODE_SLASH, /* xorgkbd:61 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x3e] = Q_KEY_CODE_SHIFT_R, /* xorgkbd:62 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x3f] = Q_KEY_CODE_KP_MULTIPLY, /* xorgkbd:63 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x40] = Q_KEY_CODE_ALT, /* xorgkbd:64 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x41] = Q_KEY_CODE_SPC, /* xorgkbd:65 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x42] = Q_KEY_CODE_CAPS_LOCK, /* xorgkbd:66 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x43] = Q_KEY_CODE_F1, /* xorgkbd:67 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x44] = Q_KEY_CODE_F2, /* xorgkbd:68 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x45] = Q_KEY_CODE_F3, /* xorgkbd:69 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x46] = Q_KEY_CODE_F4, /* xorgkbd:70 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x47] = Q_KEY_CODE_F5, /* xorgkbd:71 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x48] = Q_KEY_CODE_F6, /* xorgkbd:72 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x49] = Q_KEY_CODE_F7, /* xorgkbd:73 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x4a] = Q_KEY_CODE_F8, /* xorgkbd:74 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x4b] = Q_KEY_CODE_F9, /* xorgkbd:75 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x4c] = Q_KEY_CODE_F10, /* xorgkbd:76 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x4d] = Q_KEY_CODE_NUM_LOCK, /* xorgkbd:77 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x4e] = Q_KEY_CODE_SCROLL_LOCK, /* xorgkbd:78 -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x4f] = Q_KEY_CODE_KP_7, /* xorgkbd:79 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x50] = Q_KEY_CODE_KP_8, /* xorgkbd:80 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x51] = Q_KEY_CODE_KP_9, /* xorgkbd:81 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x52] = Q_KEY_CODE_KP_SUBTRACT, /* xorgkbd:82 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x53] = Q_KEY_CODE_KP_4, /* xorgkbd:83 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x54] = Q_KEY_CODE_KP_5, /* xorgkbd:84 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x55] = Q_KEY_CODE_KP_6, /* xorgkbd:85 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x56] = Q_KEY_CODE_KP_ADD, /* xorgkbd:86 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x57] = Q_KEY_CODE_KP_1, /* xorgkbd:87 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x58] = Q_KEY_CODE_KP_2, /* xorgkbd:88 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x59] = Q_KEY_CODE_KP_3, /* xorgkbd:89 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x5a] = Q_KEY_CODE_KP_0, /* xorgkbd:90 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x5b] = Q_KEY_CODE_KP_DECIMAL, /* xorgkbd:91 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x5e] = Q_KEY_CODE_LESS, /* xorgkbd:94 -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x5f] = Q_KEY_CODE_F11, /* xorgkbd:95 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x60] = Q_KEY_CODE_F12, /* xorgkbd:96 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x61] = Q_KEY_CODE_HOME, /* xorgkbd:97 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x62] = Q_KEY_CODE_UP, /* xorgkbd:98 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x63] = Q_KEY_CODE_PGUP, /* xorgkbd:99 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x64] = Q_KEY_CODE_LEFT, /* xorgkbd:100 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x66] = Q_KEY_CODE_RIGHT, /* xorgkbd:102 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x67] = Q_KEY_CODE_END, /* xorgkbd:103 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x68] = Q_KEY_CODE_DOWN, /* xorgkbd:104 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x69] = Q_KEY_CODE_PGDN, /* xorgkbd:105 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x6a] = Q_KEY_CODE_INSERT, /* xorgkbd:106 -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0x6b] = Q_KEY_CODE_DELETE, /* xorgkbd:107 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x6c] = Q_KEY_CODE_KP_ENTER, /* xorgkbd:108 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x6d] = Q_KEY_CODE_CTRL_R, /* xorgkbd:109 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x6e] = Q_KEY_CODE_PAUSE, /* xorgkbd:110 -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0x6f] = Q_KEY_CODE_SYSRQ, /* xorgkbd:111 -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x70] = Q_KEY_CODE_KP_DIVIDE, /* xorgkbd:112 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x71] = Q_KEY_CODE_ALT_R, /* xorgkbd:113 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0x73] = Q_KEY_CODE_META_L, /* xorgkbd:115 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x74] = Q_KEY_CODE_META_R, /* xorgkbd:116 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x75] = Q_KEY_CODE_COMPOSE, /* xorgkbd:117 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x76] = Q_KEY_CODE_UNMAPPED, /* xorgkbd:118 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x77] = Q_KEY_CODE_UNMAPPED, /* xorgkbd:119 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x78] = Q_KEY_CODE_UNMAPPED, /* xorgkbd:120 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x79] = Q_KEY_CODE_UNMAPPED, /* xorgkbd:121 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7a] = Q_KEY_CODE_UNMAPPED, /* xorgkbd:122 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7e] = Q_KEY_CODE_KP_EQUALS, /* xorgkbd:126 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x85] = Q_KEY_CODE_YEN, /* xorgkbd:133 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0xd0] = Q_KEY_CODE_UNMAPPED, /* xorgkbd:208 -> linux:93 (KEY_KATAKANAHIRAGANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_xorgkbd_to_qcode_len = sizeof(qemu_input_map_xorgkbd_to_qcode)/sizeof(qemu_input_map_xorgkbd_to_qcode[0]);
diff --git a/ui/input-keymap-xorgxquartz-to-qcode.c b/ui/input-keymap-xorgxquartz-to-qcode.c
new file mode 100644
index 0000000000..5758ecd223
--- /dev/null
+++ b/ui/input-keymap-xorgxquartz-to-qcode.c
@@ -0,0 +1,128 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_xorgxquartz_to_qcode code-map keymaps.csv xorgxquartz qcode
+*/
+const guint16 qemu_input_map_xorgxquartz_to_qcode[264] = {
+  [0x8] = Q_KEY_CODE_A, /* xorgxquartz:8 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x9] = Q_KEY_CODE_S, /* xorgxquartz:9 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0xa] = Q_KEY_CODE_D, /* xorgxquartz:10 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0xb] = Q_KEY_CODE_F, /* xorgxquartz:11 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0xc] = Q_KEY_CODE_H, /* xorgxquartz:12 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0xd] = Q_KEY_CODE_G, /* xorgxquartz:13 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0xe] = Q_KEY_CODE_Z, /* xorgxquartz:14 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0xf] = Q_KEY_CODE_X, /* xorgxquartz:15 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x10] = Q_KEY_CODE_C, /* xorgxquartz:16 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x11] = Q_KEY_CODE_V, /* xorgxquartz:17 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x12] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:18 -> linux:170 (KEY_ISO) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x13] = Q_KEY_CODE_B, /* xorgxquartz:19 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x14] = Q_KEY_CODE_Q, /* xorgxquartz:20 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x15] = Q_KEY_CODE_W, /* xorgxquartz:21 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x16] = Q_KEY_CODE_E, /* xorgxquartz:22 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x17] = Q_KEY_CODE_R, /* xorgxquartz:23 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x18] = Q_KEY_CODE_Y, /* xorgxquartz:24 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x19] = Q_KEY_CODE_T, /* xorgxquartz:25 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x1a] = Q_KEY_CODE_1, /* xorgxquartz:26 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0x1b] = Q_KEY_CODE_2, /* xorgxquartz:27 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0x1c] = Q_KEY_CODE_3, /* xorgxquartz:28 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0x1d] = Q_KEY_CODE_4, /* xorgxquartz:29 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0x1e] = Q_KEY_CODE_6, /* xorgxquartz:30 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x1f] = Q_KEY_CODE_5, /* xorgxquartz:31 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0x20] = Q_KEY_CODE_EQUAL, /* xorgxquartz:32 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x21] = Q_KEY_CODE_9, /* xorgxquartz:33 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x22] = Q_KEY_CODE_7, /* xorgxquartz:34 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x23] = Q_KEY_CODE_MINUS, /* xorgxquartz:35 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x24] = Q_KEY_CODE_8, /* xorgxquartz:36 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x25] = Q_KEY_CODE_0, /* xorgxquartz:37 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x26] = Q_KEY_CODE_BRACKET_RIGHT, /* xorgxquartz:38 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x27] = Q_KEY_CODE_O, /* xorgxquartz:39 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x28] = Q_KEY_CODE_U, /* xorgxquartz:40 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x29] = Q_KEY_CODE_BRACKET_LEFT, /* xorgxquartz:41 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x2a] = Q_KEY_CODE_I, /* xorgxquartz:42 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x2b] = Q_KEY_CODE_P, /* xorgxquartz:43 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x2c] = Q_KEY_CODE_RET, /* xorgxquartz:44 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x2d] = Q_KEY_CODE_L, /* xorgxquartz:45 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x2e] = Q_KEY_CODE_J, /* xorgxquartz:46 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x2f] = Q_KEY_CODE_APOSTROPHE, /* xorgxquartz:47 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x30] = Q_KEY_CODE_K, /* xorgxquartz:48 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x31] = Q_KEY_CODE_SEMICOLON, /* xorgxquartz:49 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x32] = Q_KEY_CODE_BACKSLASH, /* xorgxquartz:50 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x33] = Q_KEY_CODE_COMMA, /* xorgxquartz:51 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x34] = Q_KEY_CODE_SLASH, /* xorgxquartz:52 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x35] = Q_KEY_CODE_N, /* xorgxquartz:53 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x36] = Q_KEY_CODE_M, /* xorgxquartz:54 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x37] = Q_KEY_CODE_DOT, /* xorgxquartz:55 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x38] = Q_KEY_CODE_TAB, /* xorgxquartz:56 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x39] = Q_KEY_CODE_SPC, /* xorgxquartz:57 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x3a] = Q_KEY_CODE_GRAVE_ACCENT, /* xorgxquartz:58 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x3b] = Q_KEY_CODE_BACKSPACE, /* xorgxquartz:59 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x3d] = Q_KEY_CODE_ESC, /* xorgxquartz:61 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0x3e] = Q_KEY_CODE_META_R, /* xorgxquartz:62 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x3f] = Q_KEY_CODE_META_L, /* xorgxquartz:63 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x40] = Q_KEY_CODE_SHIFT, /* xorgxquartz:64 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x41] = Q_KEY_CODE_CAPS_LOCK, /* xorgxquartz:65 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x42] = Q_KEY_CODE_ALT, /* xorgxquartz:66 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x43] = Q_KEY_CODE_CTRL, /* xorgxquartz:67 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x44] = Q_KEY_CODE_SHIFT_R, /* xorgxquartz:68 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x45] = Q_KEY_CODE_ALT_R, /* xorgxquartz:69 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0x46] = Q_KEY_CODE_CTRL_R, /* xorgxquartz:70 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x47] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:71 -> linux:464 (KEY_FN) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x48] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:72 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x49] = Q_KEY_CODE_KP_DECIMAL, /* xorgxquartz:73 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x4b] = Q_KEY_CODE_KP_MULTIPLY, /* xorgxquartz:75 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x4d] = Q_KEY_CODE_KP_ADD, /* xorgxquartz:77 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x4f] = Q_KEY_CODE_NUM_LOCK, /* xorgxquartz:79 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x50] = Q_KEY_CODE_VOLUMEUP, /* xorgxquartz:80 -> linux:115 (KEY_VOLUMEUP) -> qcode:Q_KEY_CODE_VOLUMEUP (volumeup) */
+  [0x51] = Q_KEY_CODE_VOLUMEDOWN, /* xorgxquartz:81 -> linux:114 (KEY_VOLUMEDOWN) -> qcode:Q_KEY_CODE_VOLUMEDOWN (volumedown) */
+  [0x52] = Q_KEY_CODE_AUDIOMUTE, /* xorgxquartz:82 -> linux:113 (KEY_MUTE) -> qcode:Q_KEY_CODE_AUDIOMUTE (audiomute) */
+  [0x53] = Q_KEY_CODE_KP_DIVIDE, /* xorgxquartz:83 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x54] = Q_KEY_CODE_KP_ENTER, /* xorgxquartz:84 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x56] = Q_KEY_CODE_KP_SUBTRACT, /* xorgxquartz:86 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x57] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:87 -> linux:188 (KEY_F18) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x58] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:88 -> linux:189 (KEY_F19) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x59] = Q_KEY_CODE_KP_EQUALS, /* xorgxquartz:89 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x5a] = Q_KEY_CODE_KP_0, /* xorgxquartz:90 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x5b] = Q_KEY_CODE_KP_1, /* xorgxquartz:91 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x5c] = Q_KEY_CODE_KP_2, /* xorgxquartz:92 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x5d] = Q_KEY_CODE_KP_3, /* xorgxquartz:93 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x5e] = Q_KEY_CODE_KP_4, /* xorgxquartz:94 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x5f] = Q_KEY_CODE_KP_5, /* xorgxquartz:95 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x60] = Q_KEY_CODE_KP_6, /* xorgxquartz:96 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x61] = Q_KEY_CODE_KP_7, /* xorgxquartz:97 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x62] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:98 -> linux:190 (KEY_F20) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x63] = Q_KEY_CODE_KP_8, /* xorgxquartz:99 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x64] = Q_KEY_CODE_KP_9, /* xorgxquartz:100 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x65] = Q_KEY_CODE_YEN, /* xorgxquartz:101 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0x67] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:103 -> linux:95 (KEY_KPJPCOMMA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x68] = Q_KEY_CODE_F5, /* xorgxquartz:104 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x69] = Q_KEY_CODE_F6, /* xorgxquartz:105 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x6a] = Q_KEY_CODE_F7, /* xorgxquartz:106 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x6b] = Q_KEY_CODE_F3, /* xorgxquartz:107 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x6c] = Q_KEY_CODE_F8, /* xorgxquartz:108 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x6d] = Q_KEY_CODE_F9, /* xorgxquartz:109 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x6f] = Q_KEY_CODE_F11, /* xorgxquartz:111 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x70] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:112 -> linux:90 (KEY_KATAKANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x71] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:113 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x72] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:114 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x73] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:115 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x75] = Q_KEY_CODE_F10, /* xorgxquartz:117 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x76] = Q_KEY_CODE_COMPOSE, /* xorgxquartz:118 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x77] = Q_KEY_CODE_F12, /* xorgxquartz:119 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x79] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:121 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7a] = Q_KEY_CODE_HELP, /* xorgxquartz:122 -> linux:138 (KEY_HELP) -> qcode:Q_KEY_CODE_HELP (help) */
+  [0x7b] = Q_KEY_CODE_HOME, /* xorgxquartz:123 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x7c] = Q_KEY_CODE_PGUP, /* xorgxquartz:124 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x7d] = Q_KEY_CODE_DELETE, /* xorgxquartz:125 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x7e] = Q_KEY_CODE_F4, /* xorgxquartz:126 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x7f] = Q_KEY_CODE_END, /* xorgxquartz:127 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x80] = Q_KEY_CODE_F2, /* xorgxquartz:128 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x81] = Q_KEY_CODE_PGDN, /* xorgxquartz:129 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x82] = Q_KEY_CODE_F1, /* xorgxquartz:130 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x83] = Q_KEY_CODE_LEFT, /* xorgxquartz:131 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x84] = Q_KEY_CODE_RIGHT, /* xorgxquartz:132 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x85] = Q_KEY_CODE_DOWN, /* xorgxquartz:133 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x86] = Q_KEY_CODE_UP, /* xorgxquartz:134 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x107] = Q_KEY_CODE_UNMAPPED, /* xorgxquartz:263 -> linux:0 (KEY_RESERVED) -> qcode:Q_KEY_CODE_UNMAPPED (unmapped) */
+};
+const guint qemu_input_map_xorgxquartz_to_qcode_len = sizeof(qemu_input_map_xorgxquartz_to_qcode)/sizeof(qemu_input_map_xorgxquartz_to_qcode[0]);
diff --git a/ui/input-keymap-xorgxwin-to-qcode.c b/ui/input-keymap-xorgxwin-to-qcode.c
new file mode 100644
index 0000000000..c71714daa8
--- /dev/null
+++ b/ui/input-keymap-xorgxwin-to-qcode.c
@@ -0,0 +1,122 @@
+/*
+ * This file is auto-generated from keymaps.csv on 2017-08-31 11:08
+ * Database checksum sha256(f8aeff0c3430077a350e3d7ba2b335b381bd929ac4b193413730a402ff3f0097)
+ * To re-generate, run:
+ *   keymap-gen --lang=glib2 --varname=qemu_input_map_xorgxwin_to_qcode code-map keymaps.csv xorgxwin qcode
+*/
+const guint16 qemu_input_map_xorgxwin_to_qcode[209] = {
+  [0x9] = Q_KEY_CODE_ESC, /* xorgxwin:9 -> linux:1 (KEY_ESC) -> qcode:Q_KEY_CODE_ESC (esc) */
+  [0xa] = Q_KEY_CODE_1, /* xorgxwin:10 -> linux:2 (KEY_1) -> qcode:Q_KEY_CODE_1 (1) */
+  [0xb] = Q_KEY_CODE_2, /* xorgxwin:11 -> linux:3 (KEY_2) -> qcode:Q_KEY_CODE_2 (2) */
+  [0xc] = Q_KEY_CODE_3, /* xorgxwin:12 -> linux:4 (KEY_3) -> qcode:Q_KEY_CODE_3 (3) */
+  [0xd] = Q_KEY_CODE_4, /* xorgxwin:13 -> linux:5 (KEY_4) -> qcode:Q_KEY_CODE_4 (4) */
+  [0xe] = Q_KEY_CODE_5, /* xorgxwin:14 -> linux:6 (KEY_5) -> qcode:Q_KEY_CODE_5 (5) */
+  [0xf] = Q_KEY_CODE_6, /* xorgxwin:15 -> linux:7 (KEY_6) -> qcode:Q_KEY_CODE_6 (6) */
+  [0x10] = Q_KEY_CODE_7, /* xorgxwin:16 -> linux:8 (KEY_7) -> qcode:Q_KEY_CODE_7 (7) */
+  [0x11] = Q_KEY_CODE_8, /* xorgxwin:17 -> linux:9 (KEY_8) -> qcode:Q_KEY_CODE_8 (8) */
+  [0x12] = Q_KEY_CODE_9, /* xorgxwin:18 -> linux:10 (KEY_9) -> qcode:Q_KEY_CODE_9 (9) */
+  [0x13] = Q_KEY_CODE_0, /* xorgxwin:19 -> linux:11 (KEY_0) -> qcode:Q_KEY_CODE_0 (0) */
+  [0x14] = Q_KEY_CODE_MINUS, /* xorgxwin:20 -> linux:12 (KEY_MINUS) -> qcode:Q_KEY_CODE_MINUS (minus) */
+  [0x15] = Q_KEY_CODE_EQUAL, /* xorgxwin:21 -> linux:13 (KEY_EQUAL) -> qcode:Q_KEY_CODE_EQUAL (equal) */
+  [0x16] = Q_KEY_CODE_BACKSPACE, /* xorgxwin:22 -> linux:14 (KEY_BACKSPACE) -> qcode:Q_KEY_CODE_BACKSPACE (backspace) */
+  [0x17] = Q_KEY_CODE_TAB, /* xorgxwin:23 -> linux:15 (KEY_TAB) -> qcode:Q_KEY_CODE_TAB (tab) */
+  [0x18] = Q_KEY_CODE_Q, /* xorgxwin:24 -> linux:16 (KEY_Q) -> qcode:Q_KEY_CODE_Q (q) */
+  [0x19] = Q_KEY_CODE_W, /* xorgxwin:25 -> linux:17 (KEY_W) -> qcode:Q_KEY_CODE_W (w) */
+  [0x1a] = Q_KEY_CODE_E, /* xorgxwin:26 -> linux:18 (KEY_E) -> qcode:Q_KEY_CODE_E (e) */
+  [0x1b] = Q_KEY_CODE_R, /* xorgxwin:27 -> linux:19 (KEY_R) -> qcode:Q_KEY_CODE_R (r) */
+  [0x1c] = Q_KEY_CODE_T, /* xorgxwin:28 -> linux:20 (KEY_T) -> qcode:Q_KEY_CODE_T (t) */
+  [0x1d] = Q_KEY_CODE_Y, /* xorgxwin:29 -> linux:21 (KEY_Y) -> qcode:Q_KEY_CODE_Y (y) */
+  [0x1e] = Q_KEY_CODE_U, /* xorgxwin:30 -> linux:22 (KEY_U) -> qcode:Q_KEY_CODE_U (u) */
+  [0x1f] = Q_KEY_CODE_I, /* xorgxwin:31 -> linux:23 (KEY_I) -> qcode:Q_KEY_CODE_I (i) */
+  [0x20] = Q_KEY_CODE_O, /* xorgxwin:32 -> linux:24 (KEY_O) -> qcode:Q_KEY_CODE_O (o) */
+  [0x21] = Q_KEY_CODE_P, /* xorgxwin:33 -> linux:25 (KEY_P) -> qcode:Q_KEY_CODE_P (p) */
+  [0x22] = Q_KEY_CODE_BRACKET_LEFT, /* xorgxwin:34 -> linux:26 (KEY_LEFTBRACE) -> qcode:Q_KEY_CODE_BRACKET_LEFT (bracket_left) */
+  [0x23] = Q_KEY_CODE_BRACKET_RIGHT, /* xorgxwin:35 -> linux:27 (KEY_RIGHTBRACE) -> qcode:Q_KEY_CODE_BRACKET_RIGHT (bracket_right) */
+  [0x24] = Q_KEY_CODE_RET, /* xorgxwin:36 -> linux:28 (KEY_ENTER) -> qcode:Q_KEY_CODE_RET (ret) */
+  [0x25] = Q_KEY_CODE_CTRL, /* xorgxwin:37 -> linux:29 (KEY_LEFTCTRL) -> qcode:Q_KEY_CODE_CTRL (ctrl) */
+  [0x26] = Q_KEY_CODE_A, /* xorgxwin:38 -> linux:30 (KEY_A) -> qcode:Q_KEY_CODE_A (a) */
+  [0x27] = Q_KEY_CODE_S, /* xorgxwin:39 -> linux:31 (KEY_S) -> qcode:Q_KEY_CODE_S (s) */
+  [0x28] = Q_KEY_CODE_D, /* xorgxwin:40 -> linux:32 (KEY_D) -> qcode:Q_KEY_CODE_D (d) */
+  [0x29] = Q_KEY_CODE_F, /* xorgxwin:41 -> linux:33 (KEY_F) -> qcode:Q_KEY_CODE_F (f) */
+  [0x2a] = Q_KEY_CODE_G, /* xorgxwin:42 -> linux:34 (KEY_G) -> qcode:Q_KEY_CODE_G (g) */
+  [0x2b] = Q_KEY_CODE_H, /* xorgxwin:43 -> linux:35 (KEY_H) -> qcode:Q_KEY_CODE_H (h) */
+  [0x2c] = Q_KEY_CODE_J, /* xorgxwin:44 -> linux:36 (KEY_J) -> qcode:Q_KEY_CODE_J (j) */
+  [0x2d] = Q_KEY_CODE_K, /* xorgxwin:45 -> linux:37 (KEY_K) -> qcode:Q_KEY_CODE_K (k) */
+  [0x2e] = Q_KEY_CODE_L, /* xorgxwin:46 -> linux:38 (KEY_L) -> qcode:Q_KEY_CODE_L (l) */
+  [0x2f] = Q_KEY_CODE_SEMICOLON, /* xorgxwin:47 -> linux:39 (KEY_SEMICOLON) -> qcode:Q_KEY_CODE_SEMICOLON (semicolon) */
+  [0x30] = Q_KEY_CODE_APOSTROPHE, /* xorgxwin:48 -> linux:40 (KEY_APOSTROPHE) -> qcode:Q_KEY_CODE_APOSTROPHE (apostrophe) */
+  [0x31] = Q_KEY_CODE_GRAVE_ACCENT, /* xorgxwin:49 -> linux:41 (KEY_GRAVE) -> qcode:Q_KEY_CODE_GRAVE_ACCENT (grave_accent) */
+  [0x32] = Q_KEY_CODE_SHIFT, /* xorgxwin:50 -> linux:42 (KEY_LEFTSHIFT) -> qcode:Q_KEY_CODE_SHIFT (shift) */
+  [0x33] = Q_KEY_CODE_BACKSLASH, /* xorgxwin:51 -> linux:43 (KEY_BACKSLASH) -> qcode:Q_KEY_CODE_BACKSLASH (backslash) */
+  [0x34] = Q_KEY_CODE_Z, /* xorgxwin:52 -> linux:44 (KEY_Z) -> qcode:Q_KEY_CODE_Z (z) */
+  [0x35] = Q_KEY_CODE_X, /* xorgxwin:53 -> linux:45 (KEY_X) -> qcode:Q_KEY_CODE_X (x) */
+  [0x36] = Q_KEY_CODE_C, /* xorgxwin:54 -> linux:46 (KEY_C) -> qcode:Q_KEY_CODE_C (c) */
+  [0x37] = Q_KEY_CODE_V, /* xorgxwin:55 -> linux:47 (KEY_V) -> qcode:Q_KEY_CODE_V (v) */
+  [0x38] = Q_KEY_CODE_B, /* xorgxwin:56 -> linux:48 (KEY_B) -> qcode:Q_KEY_CODE_B (b) */
+  [0x39] = Q_KEY_CODE_N, /* xorgxwin:57 -> linux:49 (KEY_N) -> qcode:Q_KEY_CODE_N (n) */
+  [0x3a] = Q_KEY_CODE_M, /* xorgxwin:58 -> linux:50 (KEY_M) -> qcode:Q_KEY_CODE_M (m) */
+  [0x3b] = Q_KEY_CODE_COMMA, /* xorgxwin:59 -> linux:51 (KEY_COMMA) -> qcode:Q_KEY_CODE_COMMA (comma) */
+  [0x3c] = Q_KEY_CODE_DOT, /* xorgxwin:60 -> linux:52 (KEY_DOT) -> qcode:Q_KEY_CODE_DOT (dot) */
+  [0x3d] = Q_KEY_CODE_SLASH, /* xorgxwin:61 -> linux:53 (KEY_SLASH) -> qcode:Q_KEY_CODE_SLASH (slash) */
+  [0x3e] = Q_KEY_CODE_SHIFT_R, /* xorgxwin:62 -> linux:54 (KEY_RIGHTSHIFT) -> qcode:Q_KEY_CODE_SHIFT_R (shift_r) */
+  [0x3f] = Q_KEY_CODE_KP_MULTIPLY, /* xorgxwin:63 -> linux:55 (KEY_KPASTERISK) -> qcode:Q_KEY_CODE_KP_MULTIPLY (kp_multiply) */
+  [0x40] = Q_KEY_CODE_ALT, /* xorgxwin:64 -> linux:56 (KEY_LEFTALT) -> qcode:Q_KEY_CODE_ALT (alt) */
+  [0x41] = Q_KEY_CODE_SPC, /* xorgxwin:65 -> linux:57 (KEY_SPACE) -> qcode:Q_KEY_CODE_SPC (spc) */
+  [0x42] = Q_KEY_CODE_CAPS_LOCK, /* xorgxwin:66 -> linux:58 (KEY_CAPSLOCK) -> qcode:Q_KEY_CODE_CAPS_LOCK (caps_lock) */
+  [0x43] = Q_KEY_CODE_F1, /* xorgxwin:67 -> linux:59 (KEY_F1) -> qcode:Q_KEY_CODE_F1 (f1) */
+  [0x44] = Q_KEY_CODE_F2, /* xorgxwin:68 -> linux:60 (KEY_F2) -> qcode:Q_KEY_CODE_F2 (f2) */
+  [0x45] = Q_KEY_CODE_F3, /* xorgxwin:69 -> linux:61 (KEY_F3) -> qcode:Q_KEY_CODE_F3 (f3) */
+  [0x46] = Q_KEY_CODE_F4, /* xorgxwin:70 -> linux:62 (KEY_F4) -> qcode:Q_KEY_CODE_F4 (f4) */
+  [0x47] = Q_KEY_CODE_F5, /* xorgxwin:71 -> linux:63 (KEY_F5) -> qcode:Q_KEY_CODE_F5 (f5) */
+  [0x48] = Q_KEY_CODE_F6, /* xorgxwin:72 -> linux:64 (KEY_F6) -> qcode:Q_KEY_CODE_F6 (f6) */
+  [0x49] = Q_KEY_CODE_F7, /* xorgxwin:73 -> linux:65 (KEY_F7) -> qcode:Q_KEY_CODE_F7 (f7) */
+  [0x4a] = Q_KEY_CODE_F8, /* xorgxwin:74 -> linux:66 (KEY_F8) -> qcode:Q_KEY_CODE_F8 (f8) */
+  [0x4b] = Q_KEY_CODE_F9, /* xorgxwin:75 -> linux:67 (KEY_F9) -> qcode:Q_KEY_CODE_F9 (f9) */
+  [0x4c] = Q_KEY_CODE_F10, /* xorgxwin:76 -> linux:68 (KEY_F10) -> qcode:Q_KEY_CODE_F10 (f10) */
+  [0x4d] = Q_KEY_CODE_NUM_LOCK, /* xorgxwin:77 -> linux:69 (KEY_NUMLOCK) -> qcode:Q_KEY_CODE_NUM_LOCK (num_lock) */
+  [0x4e] = Q_KEY_CODE_SCROLL_LOCK, /* xorgxwin:78 -> linux:70 (KEY_SCROLLLOCK) -> qcode:Q_KEY_CODE_SCROLL_LOCK (scroll_lock) */
+  [0x4f] = Q_KEY_CODE_KP_7, /* xorgxwin:79 -> linux:71 (KEY_KP7) -> qcode:Q_KEY_CODE_KP_7 (kp_7) */
+  [0x50] = Q_KEY_CODE_KP_8, /* xorgxwin:80 -> linux:72 (KEY_KP8) -> qcode:Q_KEY_CODE_KP_8 (kp_8) */
+  [0x51] = Q_KEY_CODE_KP_9, /* xorgxwin:81 -> linux:73 (KEY_KP9) -> qcode:Q_KEY_CODE_KP_9 (kp_9) */
+  [0x52] = Q_KEY_CODE_KP_SUBTRACT, /* xorgxwin:82 -> linux:74 (KEY_KPMINUS) -> qcode:Q_KEY_CODE_KP_SUBTRACT (kp_subtract) */
+  [0x53] = Q_KEY_CODE_KP_4, /* xorgxwin:83 -> linux:75 (KEY_KP4) -> qcode:Q_KEY_CODE_KP_4 (kp_4) */
+  [0x54] = Q_KEY_CODE_KP_5, /* xorgxwin:84 -> linux:76 (KEY_KP5) -> qcode:Q_KEY_CODE_KP_5 (kp_5) */
+  [0x55] = Q_KEY_CODE_KP_6, /* xorgxwin:85 -> linux:77 (KEY_KP6) -> qcode:Q_KEY_CODE_KP_6 (kp_6) */
+  [0x56] = Q_KEY_CODE_KP_ADD, /* xorgxwin:86 -> linux:78 (KEY_KPPLUS) -> qcode:Q_KEY_CODE_KP_ADD (kp_add) */
+  [0x57] = Q_KEY_CODE_KP_1, /* xorgxwin:87 -> linux:79 (KEY_KP1) -> qcode:Q_KEY_CODE_KP_1 (kp_1) */
+  [0x58] = Q_KEY_CODE_KP_2, /* xorgxwin:88 -> linux:80 (KEY_KP2) -> qcode:Q_KEY_CODE_KP_2 (kp_2) */
+  [0x59] = Q_KEY_CODE_KP_3, /* xorgxwin:89 -> linux:81 (KEY_KP3) -> qcode:Q_KEY_CODE_KP_3 (kp_3) */
+  [0x5a] = Q_KEY_CODE_KP_0, /* xorgxwin:90 -> linux:82 (KEY_KP0) -> qcode:Q_KEY_CODE_KP_0 (kp_0) */
+  [0x5b] = Q_KEY_CODE_KP_DECIMAL, /* xorgxwin:91 -> linux:83 (KEY_KPDOT) -> qcode:Q_KEY_CODE_KP_DECIMAL (kp_decimal) */
+  [0x5e] = Q_KEY_CODE_LESS, /* xorgxwin:94 -> linux:86 (KEY_102ND) -> qcode:Q_KEY_CODE_LESS (less) */
+  [0x5f] = Q_KEY_CODE_F11, /* xorgxwin:95 -> linux:87 (KEY_F11) -> qcode:Q_KEY_CODE_F11 (f11) */
+  [0x60] = Q_KEY_CODE_F12, /* xorgxwin:96 -> linux:88 (KEY_F12) -> qcode:Q_KEY_CODE_F12 (f12) */
+  [0x61] = Q_KEY_CODE_HOME, /* xorgxwin:97 -> linux:102 (KEY_HOME) -> qcode:Q_KEY_CODE_HOME (home) */
+  [0x62] = Q_KEY_CODE_UP, /* xorgxwin:98 -> linux:103 (KEY_UP) -> qcode:Q_KEY_CODE_UP (up) */
+  [0x63] = Q_KEY_CODE_PGUP, /* xorgxwin:99 -> linux:104 (KEY_PAGEUP) -> qcode:Q_KEY_CODE_PGUP (pgup) */
+  [0x64] = Q_KEY_CODE_LEFT, /* xorgxwin:100 -> linux:105 (KEY_LEFT) -> qcode:Q_KEY_CODE_LEFT (left) */
+  [0x66] = Q_KEY_CODE_RIGHT, /* xorgxwin:102 -> linux:106 (KEY_RIGHT) -> qcode:Q_KEY_CODE_RIGHT (right) */
+  [0x67] = Q_KEY_CODE_END, /* xorgxwin:103 -> linux:107 (KEY_END) -> qcode:Q_KEY_CODE_END (end) */
+  [0x68] = Q_KEY_CODE_DOWN, /* xorgxwin:104 -> linux:108 (KEY_DOWN) -> qcode:Q_KEY_CODE_DOWN (down) */
+  [0x69] = Q_KEY_CODE_PGDN, /* xorgxwin:105 -> linux:109 (KEY_PAGEDOWN) -> qcode:Q_KEY_CODE_PGDN (pgdn) */
+  [0x6a] = Q_KEY_CODE_INSERT, /* xorgxwin:106 -> linux:110 (KEY_INSERT) -> qcode:Q_KEY_CODE_INSERT (insert) */
+  [0x6b] = Q_KEY_CODE_DELETE, /* xorgxwin:107 -> linux:111 (KEY_DELETE) -> qcode:Q_KEY_CODE_DELETE (delete) */
+  [0x6c] = Q_KEY_CODE_KP_ENTER, /* xorgxwin:108 -> linux:96 (KEY_KPENTER) -> qcode:Q_KEY_CODE_KP_ENTER (kp_enter) */
+  [0x6d] = Q_KEY_CODE_CTRL_R, /* xorgxwin:109 -> linux:97 (KEY_RIGHTCTRL) -> qcode:Q_KEY_CODE_CTRL_R (ctrl_r) */
+  [0x6e] = Q_KEY_CODE_PAUSE, /* xorgxwin:110 -> linux:119 (KEY_PAUSE) -> qcode:Q_KEY_CODE_PAUSE (pause) */
+  [0x6f] = Q_KEY_CODE_SYSRQ, /* xorgxwin:111 -> linux:99 (KEY_SYSRQ) -> qcode:Q_KEY_CODE_SYSRQ (sysrq) */
+  [0x70] = Q_KEY_CODE_KP_DIVIDE, /* xorgxwin:112 -> linux:98 (KEY_KPSLASH) -> qcode:Q_KEY_CODE_KP_DIVIDE (kp_divide) */
+  [0x71] = Q_KEY_CODE_ALT_R, /* xorgxwin:113 -> linux:100 (KEY_RIGHTALT) -> qcode:Q_KEY_CODE_ALT_R (alt_r) */
+  [0x73] = Q_KEY_CODE_META_L, /* xorgxwin:115 -> linux:125 (KEY_LEFTMETA) -> qcode:Q_KEY_CODE_META_L (meta_l) */
+  [0x74] = Q_KEY_CODE_META_R, /* xorgxwin:116 -> linux:126 (KEY_RIGHTMETA) -> qcode:Q_KEY_CODE_META_R (meta_r) */
+  [0x75] = Q_KEY_CODE_COMPOSE, /* xorgxwin:117 -> linux:127 (KEY_COMPOSE) -> qcode:Q_KEY_CODE_COMPOSE (compose) */
+  [0x76] = Q_KEY_CODE_UNMAPPED, /* xorgxwin:118 -> linux:183 (KEY_F13) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x77] = Q_KEY_CODE_UNMAPPED, /* xorgxwin:119 -> linux:184 (KEY_F14) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x78] = Q_KEY_CODE_UNMAPPED, /* xorgxwin:120 -> linux:185 (KEY_F15) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x79] = Q_KEY_CODE_UNMAPPED, /* xorgxwin:121 -> linux:186 (KEY_F16) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7a] = Q_KEY_CODE_UNMAPPED, /* xorgxwin:122 -> linux:187 (KEY_F17) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+  [0x7e] = Q_KEY_CODE_KP_EQUALS, /* xorgxwin:126 -> linux:117 (KEY_KPEQUAL) -> qcode:Q_KEY_CODE_KP_EQUALS (kp_equals) */
+  [0x85] = Q_KEY_CODE_YEN, /* xorgxwin:133 -> linux:124 (KEY_YEN) -> qcode:Q_KEY_CODE_YEN (yen) */
+  [0xd0] = Q_KEY_CODE_UNMAPPED, /* xorgxwin:208 -> linux:93 (KEY_KATAKANAHIRAGANA) -> qcode:Q_KEY_CODE_UNMAPPED (unnamed) */
+};
+const guint qemu_input_map_xorgxwin_to_qcode_len = sizeof(qemu_input_map_xorgxwin_to_qcode)/sizeof(qemu_input_map_xorgxwin_to_qcode[0]);
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index ad98b153cf..908d58ea63 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -5,6 +5,7 @@
 
 #include "standard-headers/linux/input.h"
 
+#include "ui/input-keymap-atset1-to-qcode.c"
 #include "ui/input-keymap-linux-to-qcode.c"
 #include "ui/input-keymap-osx-to-qcode.c"
 #include "ui/input-keymap-qcode-to-adb.c"
@@ -16,6 +17,12 @@
 #include "ui/input-keymap-qcode-to-sun.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
 #include "ui/input-keymap-usb-to-qcode.c"
+#include "ui/input-keymap-win32-to-qcode.c"
+#include "ui/input-keymap-x11-to-qcode.c"
+#include "ui/input-keymap-xorgevdev-to-qcode.c"
+#include "ui/input-keymap-xorgkbd-to-qcode.c"
+#include "ui/input-keymap-xorgxquartz-to-qcode.c"
+#include "ui/input-keymap-xorgxwin-to-qcode.c"
 
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
diff --git a/ui/sdl.c b/ui/sdl.c
index 7b71a9ac58..afb4992da2 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -34,7 +34,9 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
+#ifndef WIN32
 #include "x_keymap.h"
+#endif
 #include "sdl_zoom.h"
 
 static DisplayChangeListener *dcl;
@@ -63,6 +65,8 @@ static SDL_PixelFormat host_format;
 static int scaling_active = 0;
 static Notifier mouse_mode_notifier;
 static int idle_counter;
+static const guint16 *keycode_map;
+static size_t keycode_maplen;
 
 #define SDL_REFRESH_INTERVAL_BUSY 10
 #define SDL_MAX_IDLE_COUNT (2 * GUI_REFRESH_INTERVAL_DEFAULT \
@@ -208,94 +212,45 @@ static uint8_t sdl_keyevent_to_keycode_generic(const SDL_KeyboardEvent *ev)
     return keysym2scancode(kbd_layout, keysym) & SCANCODE_KEYMASK;
 }
 
-/* specific keyboard conversions from scan codes */
-
-#if defined(_WIN32)
 
-static uint8_t sdl_keyevent_to_keycode(const SDL_KeyboardEvent *ev)
+static const guint16 *sdl_get_keymap(size_t *maplen)
 {
-    return ev->keysym.scancode;
-}
-
+#if defined(WIN32)
+    *maplen = qemu_input_map_atset1_to_qcode_len;
+    return qemu_input_map_atset1_to_qcode;
 #else
-
 #if defined(SDL_VIDEO_DRIVER_X11)
-#include <X11/XKBlib.h>
-
-static int check_for_evdev(void)
-{
     SDL_SysWMinfo info;
-    XkbDescPtr desc = NULL;
-    int has_evdev = 0;
-    char *keycodes = NULL;
 
     SDL_VERSION(&info.version);
-    if (!SDL_GetWMInfo(&info)) {
-        return 0;
+    if (SDL_GetWMInfo(&info) > 0) {
+        return qemu_xkeymap_mapping_table(
+            info.info.x11.display, maplen);
     }
-    desc = XkbGetMap(info.info.x11.display,
-                     XkbGBN_AllComponentsMask,
-                     XkbUseCoreKbd);
-    if (desc &&
-        (XkbGetNames(info.info.x11.display,
-                     XkbKeycodesNameMask, desc) == Success)) {
-        keycodes = XGetAtomName(info.info.x11.display, desc->names->keycodes);
-        if (keycodes == NULL) {
-            fprintf(stderr, "could not lookup keycode name\n");
-        } else if (strstart(keycodes, "evdev", NULL)) {
-            has_evdev = 1;
-        } else if (!strstart(keycodes, "xfree86", NULL)) {
-            fprintf(stderr, "unknown keycodes `%s', please report to "
-                    "qemu-devel@nongnu.org\n", keycodes);
-        }
-    }
-
-    if (desc) {
-        XkbFreeKeyboard(desc, XkbGBN_AllComponentsMask, True);
-    }
-    if (keycodes) {
-        XFree(keycodes);
-    }
-    return has_evdev;
-}
-#else
-static int check_for_evdev(void)
-{
-	return 0;
-}
 #endif
+    g_warning("Unsupported SDL video driver / platform.\n"
+              "Assuming Linux KBD scancodes, but probably wrong.\n"
+              "Please report to qemu-devel@nongnu.org\n"
+              "including the following information:\n"
+              "\n"
+              "  - Operating system\n"
+              "  - SDL video driver\n");
+    *maplen = qemu_input_map_xorgkbd_to_qcode_len;
+    return qemu_input_map_xorgkbd_to_qcode;
+#endif
+}
 
 static uint8_t sdl_keyevent_to_keycode(const SDL_KeyboardEvent *ev)
 {
-    int keycode;
-    static int has_evdev = -1;
-
-    if (has_evdev == -1)
-        has_evdev = check_for_evdev();
-
-    keycode = ev->keysym.scancode;
-
-    if (keycode < 9) {
-        keycode = 0;
-    } else if (keycode < 97) {
-        keycode -= 8; /* just an offset */
-    } else if (keycode < 158) {
-        /* use conversion table */
-        if (has_evdev)
-            keycode = translate_evdev_keycode(keycode - 97);
-        else
-            keycode = translate_xfree86_keycode(keycode - 97);
-    } else if (keycode == 208) { /* Hiragana_Katakana */
-        keycode = 0x70;
-    } else if (keycode == 211) { /* backslash */
-        keycode = 0x73;
-    } else {
-        keycode = 0;
+    if (!keycode_map) {
+        return 0;
+    }
+    if (ev->keysym.scancode > keycode_maplen) {
+        return 0;
     }
-    return keycode;
-}
 
-#endif
+    return keycode_map[ev->keysym.scancode];
+}
 
 static void reset_keys(void)
 {
@@ -995,6 +950,8 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     vi = SDL_GetVideoInfo();
     host_format = *(vi->vfmt);
 
+    keycode_map = sdl_get_keymap(&keycode_maplen);
+
     /* Load a 32x32x4 image. White pixels are transparent. */
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "qemu-icon.bmp");
     if (filename) {
diff --git a/ui/trace-events b/ui/trace-events
index 34c2213700..9a943f645d 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -18,9 +18,10 @@ ppm_save(const char *filename, void *display_surface) "%s surface=%p"
 # ui/gtk.c
 gd_switch(const char *tab, int width, int height) "tab=%s, width=%d, height=%d"
 gd_update(const char *tab, int x, int y, int w, int h) "tab=%s, x=%d, y=%d, w=%d, h=%d"
-gd_key_event(const char *tab, int gdk_keycode, int qemu_keycode, const char *action) "tab=%s, translated GDK keycode %d to QEMU keycode %d (%s)"
+gd_key_event(const char *tab, int gdk_keycode, int qkeycode, const char *action) "tab=%s, translated GDK keycode %d to QKeyCode %d (%s)"
 gd_grab(const char *tab, const char *device, const char *reason) "tab=%s, dev=%s, reason=%s"
 gd_ungrab(const char *tab, const char *device) "tab=%s, dev=%s"
+gd_keymap_windowing(const char *name) "backend=%s"
 
 # ui/vnc.c
 vnc_key_guest_leds(bool caps, bool num, bool scroll) "caps %d, num %d, scroll %d"
@@ -51,3 +52,9 @@ qemu_spice_create_update(uint32_t left, uint32_t right, uint32_t top, uint32_t b
 keymap_parse(const char *file) "file %s"
 keymap_add(const char *type, int sym, int code, const char *line) "%-6s sym=0x%04x code=0x%04x (line: %s)"
 keymap_unmapped(int sym) "sym=0x%04x"
+
+# ui/x_keymap.c
+xkeymap_extension(const char *name) "extension '%s'"
+xkeymap_vendor(const char *name) "vendor '%s'"
+xkeymap_keycodes(const char *name) "keycodes '%s'"
+xkeymap_keymap(const char *name) "keymap '%s'"
diff --git a/ui/x_keymap.c b/ui/x_keymap.c
index 27884851de..22e0e77c4d 100644
--- a/ui/x_keymap.c
+++ b/ui/x_keymap.c
@@ -1,169 +1,111 @@
 /*
- * QEMU SDL display driver
+ * QEMU X11 keymaps
  *
- * Copyright (c) 2003 Fabrice Bellard
+ * Copyright (C) 2009-2010 Daniel P. Berrange <dan@berrange.com>
+ * Copyright (C) 2017 Red Hat, Inc
  *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License version 2 as
+ * published by the Free Software Foundation.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+
 #include "x_keymap.h"
+#include "trace.h"
+#include "qemu/notify.h"
+#include "ui/input.h"
 
-static const uint8_t x_keycode_to_pc_keycode[115] = {
-   0xc7,      /*  97  Home   */
-   0xc8,      /*  98  Up     */
-   0xc9,      /*  99  PgUp   */
-   0xcb,      /* 100  Left   */
-   0x4c,        /* 101  KP-5   */
-   0xcd,      /* 102  Right  */
-   0xcf,      /* 103  End    */
-   0xd0,      /* 104  Down   */
-   0xd1,      /* 105  PgDn   */
-   0xd2,      /* 106  Ins    */
-   0xd3,      /* 107  Del    */
-   0x9c,      /* 108  Enter  */
-   0x9d,      /* 109  Ctrl-R */
-   0x0,       /* 110  Pause  */
-   0xb7,      /* 111  Print  */
-   0xb5,      /* 112  Divide */
-   0xb8,      /* 113  Alt-R  */
-   0xc6,      /* 114  Break  */
-   0x0,         /* 115 */
-   0x0,         /* 116 */
-   0x0,         /* 117 */
-   0x0,         /* 118 */
-   0x0,         /* 119 */
-   0x0,         /* 120 */
-   0x0,         /* 121 */
-   0x0,         /* 122 */
-   0x0,         /* 123 */
-   0x0,         /* 124 */
-   0x0,         /* 125 */
-   0x0,         /* 126 */
-   0x0,         /* 127 */
-   0x0,         /* 128 */
-   0x79,         /* 129 Henkan */
-   0x0,         /* 130 */
-   0x7b,         /* 131 Muhenkan */
-   0x0,         /* 132 */
-   0x7d,         /* 133 Yen */
-   0x0,         /* 134 */
-   0x0,         /* 135 */
-   0x47,         /* 136 KP_7 */
-   0x48,         /* 137 KP_8 */
-   0x49,         /* 138 KP_9 */
-   0x4b,         /* 139 KP_4 */
-   0x4c,         /* 140 KP_5 */
-   0x4d,         /* 141 KP_6 */
-   0x4f,         /* 142 KP_1 */
-   0x50,         /* 143 KP_2 */
-   0x51,         /* 144 KP_3 */
-   0x52,         /* 145 KP_0 */
-   0x53,         /* 146 KP_. */
-   0x47,         /* 147 KP_HOME */
-   0x48,         /* 148 KP_UP */
-   0x49,         /* 149 KP_PgUp */
-   0x4b,         /* 150 KP_Left */
-   0x4c,         /* 151 KP_ */
-   0x4d,         /* 152 KP_Right */
-   0x4f,         /* 153 KP_End */
-   0x50,         /* 154 KP_Down */
-   0x51,         /* 155 KP_PgDn */
-   0x52,         /* 156 KP_Ins */
-   0x53,         /* 157 KP_Del */
-};
+#include <X11/XKBlib.h>
 
-/* This table is generated based off the xfree86 -> scancode mapping above
- * and the keycode mappings in /usr/share/X11/xkb/keycodes/evdev
- * and  /usr/share/X11/xkb/keycodes/xfree86
- */
+static gboolean check_for_xwin(Display *dpy)
+{
+    const char *vendor = ServerVendor(dpy);
+
+    trace_xkeymap_vendor(vendor);
 
-static const uint8_t evdev_keycode_to_pc_keycode[61] = {
-    0x73,      /*  97 EVDEV - RO   ("Internet" Keyboards) */
-    0,         /*  98 EVDEV - KATA (Katakana) */
-    0,         /*  99 EVDEV - HIRA (Hiragana) */
-    0x79,      /* 100 EVDEV - HENK (Henkan) */
-    0x70,      /* 101 EVDEV - HKTG (Hiragana/Katakana toggle) */
-    0x7b,      /* 102 EVDEV - MUHE (Muhenkan) */
-    0,         /* 103 EVDEV - JPCM (KPJPComma) */
-    0x9c,      /* 104 KPEN */
-    0x9d,      /* 105 RCTL */
-    0xb5,      /* 106 KPDV */
-    0xb7,      /* 107 PRSC */
-    0xb8,      /* 108 RALT */
-    0,         /* 109 EVDEV - LNFD ("Internet" Keyboards) */
-    0xc7,      /* 110 HOME */
-    0xc8,      /* 111 UP */
-    0xc9,      /* 112 PGUP */
-    0xcb,      /* 113 LEFT */
-    0xcd,      /* 114 RGHT */
-    0xcf,      /* 115 END */
-    0xd0,      /* 116 DOWN */
-    0xd1,      /* 117 PGDN */
-    0xd2,      /* 118 INS */
-    0xd3,      /* 119 DELE */
-    0,         /* 120 EVDEV - I120 ("Internet" Keyboards) */
-    0,         /* 121 EVDEV - MUTE */
-    0,         /* 122 EVDEV - VOL- */
-    0,         /* 123 EVDEV - VOL+ */
-    0,         /* 124 EVDEV - POWR */
-    0,         /* 125 EVDEV - KPEQ */
-    0,         /* 126 EVDEV - I126 ("Internet" Keyboards) */
-    0,         /* 127 EVDEV - PAUS */
-    0,         /* 128 EVDEV - ???? */
-    0x7e,      /* 129 EVDEV - KP_COMMA (brazilian) */
-    0xf1,      /* 130 EVDEV - HNGL (Korean Hangul Latin toggle) */
-    0xf2,      /* 131 EVDEV - HJCV (Korean Hangul Hanja toggle) */
-    0x7d,      /* 132 AE13 (Yen)*/
-    0xdb,      /* 133 EVDEV - LWIN */
-    0xdc,      /* 134 EVDEV - RWIN */
-    0xdd,      /* 135 EVDEV - MENU */
-    0,         /* 136 EVDEV - STOP */
-    0,         /* 137 EVDEV - AGAI */
-    0,         /* 138 EVDEV - PROP */
-    0,         /* 139 EVDEV - UNDO */
-    0,         /* 140 EVDEV - FRNT */
-    0,         /* 141 EVDEV - COPY */
-    0,         /* 142 EVDEV - OPEN */
-    0,         /* 143 EVDEV - PAST */
-    0,         /* 144 EVDEV - FIND */
-    0,         /* 145 EVDEV - CUT  */
-    0,         /* 146 EVDEV - HELP */
-    0,         /* 147 EVDEV - I147 */
-    0,         /* 148 EVDEV - I148 */
-    0,         /* 149 EVDEV - I149 */
-    0,         /* 150 EVDEV - I150 */
-    0,         /* 151 EVDEV - I151 */
-    0,         /* 152 EVDEV - I152 */
-    0,         /* 153 EVDEV - I153 */
-    0,         /* 154 EVDEV - I154 */
-    0,         /* 155 EVDEV - I156 */
-    0,         /* 156 EVDEV - I157 */
-    0,         /* 157 EVDEV - I158 */
-};
+    if (strstr(vendor, "Cygwin/X")) {
+        return TRUE;
+    }
 
-uint8_t translate_xfree86_keycode(const int key)
+    return FALSE;
+}
+
+static gboolean check_for_xquartz(Display *dpy)
 {
-    return x_keycode_to_pc_keycode[key];
+    int nextensions;
+    int i;
+    gboolean match = FALSE;
+    char **extensions = XListExtensions(dpy, &nextensions);
+    for (i = 0 ; extensions != NULL && i < nextensions ; i++) {
+        trace_xkeymap_extension(extensions[i]);
+        if (strcmp(extensions[i], "Apple-WM") == 0 ||
+            strcmp(extensions[i], "Apple-DRI") == 0) {
+            match = TRUE;
+        }
+    }
+    if (extensions) {
+        XFreeExtensionList(extensions);
+    }
+
+    return match;
 }
 
-uint8_t translate_evdev_keycode(const int key)
+const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen)
 {
-    return evdev_keycode_to_pc_keycode[key];
+    XkbDescPtr desc;
+    const gchar *keycodes = NULL;
+
+    /* There is no easy way to determine what X11 server
+     * and platform & keyboard driver is in use. Thus we
+     * do best guess heuristics.
+     *
+     * This will need more work for people with other
+     * X servers..... patches welcomed.
+     */
+
+    desc = XkbGetMap(dpy,
+                     XkbGBN_AllComponentsMask,
+                     XkbUseCoreKbd);
+    if (desc) {
+        if (XkbGetNames(dpy, XkbKeycodesNameMask, desc) == Success) {
+            keycodes = XGetAtomName (dpy, desc->names->keycodes);
+            if (!keycodes) {
+                g_warning("could not lookup keycode name");
+            } else {
+                trace_xkeymap_keycodes(keycodes);
+            }
+        }
+        XkbFreeKeyboard(desc, XkbGBN_AllComponentsMask, True);
+    }
+
+    if (check_for_xwin(dpy)) {
+        trace_xkeymap_keymap("xwin");
+        *maplen = qemu_input_map_xorgxwin_to_qcode_len;
+        return qemu_input_map_xorgxwin_to_qcode;
+    } else if (check_for_xquartz(dpy)) {
+        trace_xkeymap_keymap("xquartz");
+        *maplen = qemu_input_map_xorgxquartz_to_qcode_len;
+        return qemu_input_map_xorgxquartz_to_qcode;
+    } else if (keycodes && g_str_has_prefix(keycodes, "evdev")) {
+        trace_xkeymap_keymap("evdev");
+        *maplen = qemu_input_map_xorgevdev_to_qcode_len;
+        return qemu_input_map_xorgevdev_to_qcode;
+    } else if (keycodes && g_str_has_prefix(keycodes, "xfree86")) {
+        trace_xkeymap_keymap("kbd");
+        *maplen = qemu_input_map_xorgkbd_to_qcode_len;
+        return qemu_input_map_xorgkbd_to_qcode;
+    } else {
+        trace_xkeymap_keymap("NULL");
+        g_warning("Unknown X11 keycode mapping '%s'.\n"
+                  "Please report to qemu-devel@nongnu.org\n"
+                  "including the following information:\n"
+                  "\n"
+                  "  - Operating system\n"
+                  "  - X11 Server\n"
+                  "  - xprop -root\n"
+                  "  - xdpyinfo\n",
+                  keycodes ? keycodes : "<null>");
+        return NULL;
+    }
 }
diff --git a/ui/x_keymap.h b/ui/x_keymap.h
index afde2e94bf..0395e335ff 100644
--- a/ui/x_keymap.h
+++ b/ui/x_keymap.h
@@ -1,7 +1,7 @@
 /*
- * QEMU SDL display driver
+ * QEMU X11 keymaps
  *
- * Copyright (c) 2003 Fabrice Bellard
+ * Copyright (c) 2017 Red Hat, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -25,8 +25,8 @@
 #ifndef QEMU_X_KEYMAP_H
 #define QEMU_X_KEYMAP_H
 
-uint8_t translate_xfree86_keycode(const int key);
+#include <X11/Xlib.h>
 
-uint8_t translate_evdev_keycode(const int key);
+const guint16 *qemu_xkeymap_mapping_table(Display *dpy, size_t *maplen);
 
 #endif
-- 
2.13.5
