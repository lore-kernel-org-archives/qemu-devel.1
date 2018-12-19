Received: from eggs.gnu.org ([2001:4830:134:3::10]:44764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZafA-0003Id-3U
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf4-0000Ae-7h
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf2-00009M-Ev
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C00183F4C
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:09:01 +0100
Message-Id: <20181219120904.17643-5-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
References: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 4/7] kbd-state: use state tracker for gtk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Use the new keyboard state tracked for gtk.  Allows to drop the
gtk-specific modifier state tracking code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 38 ++++++--------------------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 99edd3c085..9cf0c9e55c 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -22,6 +22,7 @@
 #include <gdk/gdkwayland.h>
 #endif
 
+#include "ui/kbd-state.h"
 #if defined(CONFIG_OPENGL)
 #include "ui/egl-helpers.h"
 #include "ui/egl-context.h"
@@ -32,6 +33,7 @@ typedef struct GtkDisplayState GtkDisplayState;
 typedef struct VirtualGfxConsole {
     GtkWidget *drawing_area;
     DisplayChangeListener dcl;
+    KbdState *kbd;
     DisplaySurface *ds;
     pixman_image_t *convert;
     cairo_surface_t *surface;
diff --git a/ui/gtk.c b/ui/gtk.c
index 579990b865..85d095e624 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -122,17 +122,6 @@
 
 #define HOTKEY_MODIFIERS        (GDK_CONTROL_MASK | GDK_MOD1_MASK)
 
-static const int modifier_keycode[] = {
-    Q_KEY_CODE_SHIFT,
-    Q_KEY_CODE_SHIFT_R,
-    Q_KEY_CODE_CTRL,
-    Q_KEY_CODE_CTRL_R,
-    Q_KEY_CODE_ALT,
-    Q_KEY_CODE_ALT_R,
-    Q_KEY_CODE_META_L,
-    Q_KEY_CODE_META_R,
-};
-
 static const guint16 *keycode_map;
 static size_t keycode_maplen;
 
@@ -187,7 +176,6 @@ struct GtkDisplayState {
 
     bool external_pause_update;
 
-    bool modifier_pressed[ARRAY_SIZE(modifier_keycode)];
     bool ignore_keys;
 
     DisplayOptions *opts;
@@ -426,20 +414,12 @@ static void gd_update_full_redraw(VirtualConsole *vc)
 static void gtk_release_modifiers(GtkDisplayState *s)
 {
     VirtualConsole *vc = gd_vc_find_current(s);
-    int i, qcode;
 
     if (vc->type != GD_VC_GFX ||
         !qemu_console_is_graphic(vc->gfx.dcl.con)) {
         return;
     }
-    for (i = 0; i < ARRAY_SIZE(modifier_keycode); i++) {
-        qcode = modifier_keycode[i];
-        if (!s->modifier_pressed[i]) {
-            continue;
-        }
-        qemu_input_event_send_key_qcode(vc->gfx.dcl.con, qcode, false);
-        s->modifier_pressed[i] = false;
-    }
+    kbd_state_lift_all_keys(vc->gfx.kbd);
 }
 
 static void gd_widget_reparent(GtkWidget *from, GtkWidget *to,
@@ -1113,7 +1093,6 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
     int qcode;
-    int i;
 
     if (s->ignore_keys) {
         s->ignore_keys = (key->type == GDK_KEY_PRESS);
@@ -1134,8 +1113,8 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
         || key->hardware_keycode == VK_PAUSE
 #endif
         ) {
-        qemu_input_event_send_key_qcode(vc->gfx.dcl.con, Q_KEY_CODE_PAUSE,
-                                        key->type == GDK_KEY_PRESS);
+        kbd_state_key_event(vc->gfx.kbd, Q_KEY_CODE_PAUSE,
+                            key->type == GDK_KEY_PRESS);
         return TRUE;
     }
 
@@ -1144,14 +1123,8 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     trace_gd_key_event(vc->label, key->hardware_keycode, qcode,
                        (key->type == GDK_KEY_PRESS) ? "down" : "up");
 
-    for (i = 0; i < ARRAY_SIZE(modifier_keycode); i++) {
-        if (qcode == modifier_keycode[i]) {
-            s->modifier_pressed[i] = (key->type == GDK_KEY_PRESS);
-        }
-    }
-
-    qemu_input_event_send_key_qcode(vc->gfx.dcl.con, qcode,
-                                    key->type == GDK_KEY_PRESS);
+    kbd_state_key_event(vc->gfx.kbd, qcode,
+                        key->type == GDK_KEY_PRESS);
 
     return TRUE;
 }
@@ -2052,6 +2025,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     gtk_notebook_append_page(GTK_NOTEBOOK(s->notebook),
                              vc->tab_item, gtk_label_new(vc->label));
 
+    vc->gfx.kbd = kbd_state_init(con);
     vc->gfx.dcl.con = con;
     register_displaychangelistener(&vc->gfx.dcl);
 
-- 
2.9.3
