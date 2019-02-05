Received: from eggs.gnu.org ([209.51.188.92]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQq-0007N9-RV
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQo-0006Gg-Ny
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQe-00067n-Ou
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:16 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:55 +0100
Message-Id: <20190205105758.4230-12-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/14] kbd-state: use state tracker for gtk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Use the new keyboard state tracked for gtk.  Allows to drop the
gtk-specific modifier state tracking code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190122092814.14919-6-kraxel@redhat.com
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 38 ++++++--------------------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 99edd3c085..d9eedad976 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -22,6 +22,7 @@
 #include <gdk/gdkwayland.h>
 #endif
=20
+#include "ui/kbd-state.h"
 #if defined(CONFIG_OPENGL)
 #include "ui/egl-helpers.h"
 #include "ui/egl-context.h"
@@ -32,6 +33,7 @@ typedef struct GtkDisplayState GtkDisplayState;
 typedef struct VirtualGfxConsole {
     GtkWidget *drawing_area;
     DisplayChangeListener dcl;
+    QKbdState *kbd;
     DisplaySurface *ds;
     pixman_image_t *convert;
     cairo_surface_t *surface;
diff --git a/ui/gtk.c b/ui/gtk.c
index 57af69b0c4..949b143e4e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -122,17 +122,6 @@
=20
 #define HOTKEY_MODIFIERS        (GDK_CONTROL_MASK | GDK_MOD1_MASK)
=20
-static const int modifier_keycode[] =3D {
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
=20
@@ -187,7 +176,6 @@ struct GtkDisplayState {
=20
     bool external_pause_update;
=20
-    bool modifier_pressed[ARRAY_SIZE(modifier_keycode)];
     bool ignore_keys;
=20
     DisplayOptions *opts;
@@ -426,20 +414,12 @@ static void gd_update_full_redraw(VirtualConsole *v=
c)
 static void gtk_release_modifiers(GtkDisplayState *s)
 {
     VirtualConsole *vc =3D gd_vc_find_current(s);
-    int i, qcode;
=20
     if (vc->type !=3D GD_VC_GFX ||
         !qemu_console_is_graphic(vc->gfx.dcl.con)) {
         return;
     }
-    for (i =3D 0; i < ARRAY_SIZE(modifier_keycode); i++) {
-        qcode =3D modifier_keycode[i];
-        if (!s->modifier_pressed[i]) {
-            continue;
-        }
-        qemu_input_event_send_key_qcode(vc->gfx.dcl.con, qcode, false);
-        s->modifier_pressed[i] =3D false;
-    }
+    qkbd_state_lift_all_keys(vc->gfx.kbd);
 }
=20
 static void gd_widget_reparent(GtkWidget *from, GtkWidget *to,
@@ -1115,7 +1095,6 @@ static gboolean gd_key_event(GtkWidget *widget, Gdk=
EventKey *key, void *opaque)
     VirtualConsole *vc =3D opaque;
     GtkDisplayState *s =3D vc->s;
     int qcode;
-    int i;
=20
     if (s->ignore_keys) {
         s->ignore_keys =3D (key->type =3D=3D GDK_KEY_PRESS);
@@ -1136,8 +1115,8 @@ static gboolean gd_key_event(GtkWidget *widget, Gdk=
EventKey *key, void *opaque)
         || key->hardware_keycode =3D=3D VK_PAUSE
 #endif
         ) {
-        qemu_input_event_send_key_qcode(vc->gfx.dcl.con, Q_KEY_CODE_PAUS=
E,
-                                        key->type =3D=3D GDK_KEY_PRESS);
+        qkbd_state_key_event(vc->gfx.kbd, Q_KEY_CODE_PAUSE,
+                             key->type =3D=3D GDK_KEY_PRESS);
         return TRUE;
     }
=20
@@ -1146,14 +1125,8 @@ static gboolean gd_key_event(GtkWidget *widget, Gd=
kEventKey *key, void *opaque)
     trace_gd_key_event(vc->label, key->hardware_keycode, qcode,
                        (key->type =3D=3D GDK_KEY_PRESS) ? "down" : "up")=
;
=20
-    for (i =3D 0; i < ARRAY_SIZE(modifier_keycode); i++) {
-        if (qcode =3D=3D modifier_keycode[i]) {
-            s->modifier_pressed[i] =3D (key->type =3D=3D GDK_KEY_PRESS);
-        }
-    }
-
-    qemu_input_event_send_key_qcode(vc->gfx.dcl.con, qcode,
-                                    key->type =3D=3D GDK_KEY_PRESS);
+    qkbd_state_key_event(vc->gfx.kbd, qcode,
+                         key->type =3D=3D GDK_KEY_PRESS);
=20
     return TRUE;
 }
@@ -2055,6 +2028,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, V=
irtualConsole *vc,
     gtk_notebook_append_page(GTK_NOTEBOOK(s->notebook),
                              vc->tab_item, gtk_label_new(vc->label));
=20
+    vc->gfx.kbd =3D qkbd_state_init(con);
     vc->gfx.dcl.con =3D con;
     register_displaychangelistener(&vc->gfx.dcl);
=20
--=20
2.9.3
