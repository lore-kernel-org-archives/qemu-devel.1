Received: from eggs.gnu.org ([2001:4830:134:3::10]:44133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYHC-0002dj-6R
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYH7-0000wA-TE
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhYH7-0000vj-Fs
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:36:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75BF36E5D2
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:36:36 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 15 Aug 2017 10:36:14 +0100
Message-Id: <20170815093615.16453-12-berrange@redhat.com>
In-Reply-To: <20170815093615.16453-1-berrange@redhat.com>
References: <20170815093615.16453-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/12] ui: convert GTK and SDL1 frontends to
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
 include/ui/input.h |  21 +++++
 ui/Makefile.objs   |  12 ++-
 ui/gtk.c           | 205 +++++++++++++++++++++++++------------------
 ui/input-keymap.c  |   7 ++
 ui/sdl.c           | 105 +++++++---------------
 ui/trace-events    |   9 +-
 ui/x_keymap.c      | 250 ++++++++++++++++++++---------------------------------
 ui/x_keymap.h      |   8 +-
 8 files changed, 300 insertions(+), 317 deletions(-)

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
index 0e5821f6eb..6cd39bf49d 100644
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
 
 GENERATED_FILES += $(KEYCODEMAP_FILES)
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
2.13.3
