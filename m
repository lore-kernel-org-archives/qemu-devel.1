Received: from eggs.gnu.org ([2001:4830:134:3::10]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB4-0000Ky-Uz
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB2-0001zP-O7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChB2-0001GQ-8V
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:50 +0200
Message-Id: <20181017082702.5581-27-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 26/38] ui: Convert vnc_display_init(),
 init_keyboard_layout() to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fei Li <fli@suse.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Fei Li <fli@suse.com>

Signed-off-by: Fei Li <fli@suse.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/ui/console.h |  2 +-
 ui/curses.c          |  6 +++---
 ui/keymaps.c         | 11 ++++++-----
 ui/keymaps.h         |  2 +-
 ui/sdl.c             |  6 +++---
 ui/vnc.c             | 15 ++++++++++-----
 6 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index fb969caf70..c17803c530 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
=20
 /* vnc.c */
-void vnc_display_init(const char *id);
+void vnc_display_init(const char *id, Error **errp);
 void vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password);
diff --git a/ui/curses.c b/ui/curses.c
index 59d819fd4d..f4e7a12f74 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -28,6 +28,7 @@
 #include <termios.h>
 #endif
=20
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -421,9 +422,8 @@ static void curses_keyboard_setup(void)
         keyboard_layout =3D "en-us";
 #endif
     if(keyboard_layout) {
-        kbd_layout =3D init_keyboard_layout(name2keysym, keyboard_layout=
);
-        if (!kbd_layout)
-            exit(1);
+        kbd_layout =3D init_keyboard_layout(name2keysym, keyboard_layout=
,
+                                          &error_fatal);
     }
 }
=20
diff --git a/ui/keymaps.c b/ui/keymaps.c
index b05fb028dc..085889b555 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
=20
 struct keysym2code {
     uint32_t count;
@@ -81,7 +82,7 @@ static void add_keysym(char *line, int keysym, int keyc=
ode, kbd_layout_t *k)
=20
 static int parse_keyboard_layout(kbd_layout_t *k,
                                  const name2keysym_t *table,
-                                 const char *language)
+                                 const char *language, Error **errp)
 {
     int ret;
     FILE *f;
@@ -95,7 +96,7 @@ static int parse_keyboard_layout(kbd_layout_t *k,
     f =3D filename ? fopen(filename, "r") : NULL;
     g_free(filename);
     if (!f) {
-        fprintf(stderr, "Could not read keymap file: '%s'\n", language);
+        error_setg(errp, "could not read keymap file: '%s'", language);
         return -1;
     }
=20
@@ -114,7 +115,7 @@ static int parse_keyboard_layout(kbd_layout_t *k,
             continue;
         }
         if (!strncmp(line, "include ", 8)) {
-            if (parse_keyboard_layout(k, table, line + 8) < 0) {
+            if (parse_keyboard_layout(k, table, line + 8, errp) < 0) {
                 ret =3D -1;
                 goto out;
             }
@@ -172,13 +173,13 @@ out:
=20
=20
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
-                                   const char *language)
+                                   const char *language, Error **errp)
 {
     kbd_layout_t *k;
=20
     k =3D g_new0(kbd_layout_t, 1);
     k->hash =3D g_hash_table_new(NULL, NULL);
-    if (parse_keyboard_layout(k, table, language) < 0) {
+    if (parse_keyboard_layout(k, table, language, errp) < 0) {
         g_hash_table_unref(k->hash);
         g_free(k);
         return NULL;
diff --git a/ui/keymaps.h b/ui/keymaps.h
index 0693588225..98213a4191 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -53,7 +53,7 @@ typedef struct {
 typedef struct kbd_layout_t kbd_layout_t;
=20
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
-                                   const char *language);
+                                   const char *language, Error **errp);
 int keysym2scancode(kbd_layout_t *k, int keysym,
                     bool shift, bool altgr, bool ctrl);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
diff --git a/ui/sdl.c b/ui/sdl.c
index a5fd503c25..190b16f575 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -29,6 +29,7 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
=20
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "ui/console.h"
@@ -917,9 +918,8 @@ static void sdl1_display_init(DisplayState *ds, Displ=
ayOptions *o)
         keyboard_layout =3D "en-us";
 #endif
     if(keyboard_layout) {
-        kbd_layout =3D init_keyboard_layout(name2keysym, keyboard_layout=
);
-        if (!kbd_layout)
-            exit(1);
+        kbd_layout =3D init_keyboard_layout(name2keysym, keyboard_layout=
,
+                                          &error_fatal);
     }
=20
     g_printerr("Running QEMU with SDL 1.2 is deprecated, and will be rem=
oved\n"
diff --git a/ui/vnc.c b/ui/vnc.c
index cf221c83cc..98e3d3b1d8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps dcl_ops =3D {
     .dpy_cursor_define    =3D vnc_dpy_cursor_define,
 };
=20
-void vnc_display_init(const char *id)
+void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
=20
@@ -3222,13 +3222,14 @@ void vnc_display_init(const char *id)
=20
     if (keyboard_layout) {
         trace_vnc_key_map_init(keyboard_layout);
-        vd->kbd_layout =3D init_keyboard_layout(name2keysym, keyboard_la=
yout);
+        vd->kbd_layout =3D init_keyboard_layout(name2keysym,
+                                              keyboard_layout, errp);
     } else {
-        vd->kbd_layout =3D init_keyboard_layout(name2keysym, "en-us");
+        vd->kbd_layout =3D init_keyboard_layout(name2keysym, "en-us", er=
rp);
     }
=20
     if (!vd->kbd_layout) {
-        exit(1);
+        return;
     }
=20
     vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -4079,7 +4080,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Er=
ror **errp)
     char *id =3D (char *)qemu_opts_id(opts);
=20
     assert(id);
-    vnc_display_init(id);
+    vnc_display_init(id, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
     vnc_display_open(id, &local_err);
     if (local_err !=3D NULL) {
         error_reportf_err(local_err, "Failed to start VNC server: ");
--=20
2.17.1
