Received: from eggs.gnu.org ([2001:4830:134:3::10]:36559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAvxx-0003px-PA
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAvxt-0004iP-Nm
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:50:49 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:49395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gAvxs-0004SG-1Z
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:50:44 -0400
From: Fei Li <fli@suse.com>
Date: Fri, 12 Oct 2018 19:50:13 +0800
Message-Id: <20181012115013.29555-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH v2] ui/vnc.c: polish vnc_init_func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com

Add a new Error parameter for vnc_display_init() to handle errors
in its caller: vnc_init_func(), just like vnc_display_open() does.
And let its callees propagate the Error, like init_keyboard_layout().

Signed-off-by: Fei Li <fli@suse.com>
---
 include/ui/console.h |  2 +-
 ui/curses.c          |  4 +++-
 ui/keymaps.c         | 11 ++++++-----
 ui/keymaps.h         |  2 +-
 ui/sdl.c             |  4 +++-
 ui/vnc.c             | 16 +++++++++++-----
 6 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index fb969caf70..c17803c530 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 
 /* vnc.c */
-void vnc_display_init(const char *id);
+void vnc_display_init(const char *id, Error **errp);
 void vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password);
diff --git a/ui/curses.c b/ui/curses.c
index 59d819fd4d..60c0962334 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -28,6 +28,7 @@
 #include <termios.h>
 #endif
 
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -421,7 +422,8 @@ static void curses_keyboard_setup(void)
         keyboard_layout = "en-us";
 #endif
     if(keyboard_layout) {
-        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
+        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
+                                          &error_fatal);
         if (!kbd_layout)
             exit(1);
     }
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 43fe604724..52d432e856 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 struct keysym2code {
     uint32_t count;
@@ -81,7 +82,7 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
 
 static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
                                            const char *language,
-                                           kbd_layout_t *k)
+                                           kbd_layout_t *k, Error **errp)
 {
     FILE *f;
     char * filename;
@@ -94,7 +95,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
     f = filename ? fopen(filename, "r") : NULL;
     g_free(filename);
     if (!f) {
-        fprintf(stderr, "Could not read keymap file: '%s'\n", language);
+        error_setg(errp, "could not read keymap file: '%s'", language);
         return NULL;
     }
 
@@ -118,7 +119,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
             continue;
         }
         if (!strncmp(line, "include ", 8)) {
-            parse_keyboard_layout(table, line + 8, k);
+            parse_keyboard_layout(table, line + 8, k, errp);
         } else {
             int offset = 0;
             while (line[offset] != 0 &&
@@ -170,9 +171,9 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
 
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
-                                   const char *language)
+                                   const char *language, Error **errp)
 {
-    return parse_keyboard_layout(table, language, NULL);
+    return parse_keyboard_layout(table, language, NULL, errp);
 }
 
 
diff --git a/ui/keymaps.h b/ui/keymaps.h
index 0693588225..98213a4191 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -53,7 +53,7 @@ typedef struct {
 typedef struct kbd_layout_t kbd_layout_t;
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
-                                   const char *language);
+                                   const char *language, Error **errp);
 int keysym2scancode(kbd_layout_t *k, int keysym,
                     bool shift, bool altgr, bool ctrl);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
diff --git a/ui/sdl.c b/ui/sdl.c
index a5fd503c25..b33df70f4d 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -29,6 +29,7 @@
 #include <SDL.h>
 #include <SDL_syswm.h>
 
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "ui/console.h"
@@ -917,7 +918,8 @@ static void sdl1_display_init(DisplayState *ds, DisplayOptions *o)
         keyboard_layout = "en-us";
 #endif
     if(keyboard_layout) {
-        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
+        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
+                                          &error_fatal);
         if (!kbd_layout)
             exit(1);
     }
diff --git a/ui/vnc.c b/ui/vnc.c
index cf221c83cc..03c70b16f6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_cursor_define    = vnc_dpy_cursor_define,
 };
 
-void vnc_display_init(const char *id)
+void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
 
@@ -3222,13 +3222,14 @@ void vnc_display_init(const char *id)
 
     if (keyboard_layout) {
         trace_vnc_key_map_init(keyboard_layout);
-        vd->kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
+        vd->kbd_layout = init_keyboard_layout(name2keysym,
+                                              keyboard_layout, errp);
     } else {
-        vd->kbd_layout = init_keyboard_layout(name2keysym, "en-us");
+        vd->kbd_layout = init_keyboard_layout(name2keysym, "en-us", errp);
     }
 
     if (!vd->kbd_layout) {
-        exit(1);
+        return;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -4079,7 +4080,12 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     char *id = (char *)qemu_opts_id(opts);
 
     assert(id);
-    vnc_display_init(id);
+    vnc_display_init(id, &local_err);
+    if (local_err) {
+        error_prepend(&local_err, "Failed to init VNC server: ");
+        error_propagate(errp, local_err);
+        return -1;
+    }
     vnc_display_open(id, &local_err);
     if (local_err != NULL) {
         error_reportf_err(local_err, "Failed to start VNC server: ");
-- 
2.13.7
