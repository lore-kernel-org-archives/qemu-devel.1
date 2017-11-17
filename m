Received: from eggs.gnu.org ([2001:4830:134:3::10]:49714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0000lr-L8
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdv9-0007JW-Gx
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdv9-0007Iu-81
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 636206917
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:24 +0100
Message-Id: <20171117103046.15943-3-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 02/24] sdl: remove -alt-grab and -ctrl-grab
 support
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

With absolute pointer devices such as usb-tablet being widely used
mouse grabs (for relative pointing devices) should be rarely needed
these days.  So the benefit of the options to configure the hotkey
modifiers for grab (and other actions) seems questionable.  Which
is expecially true for the -ctrl-grab which isn't handled in the
handle_keyup() code.

Drop the code, print a notice when the option is still used.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl.c  | 22 +++-------------------
 ui/sdl2.c | 23 +++--------------------
 vl.c      | 26 ++++----------------------
 3 files changed, 10 insertions(+), 61 deletions(-)

diff --git a/ui/sdl.c b/ui/sdl.c
index f3adbb7a64..2c85482b5e 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -364,12 +364,7 @@ static void sdl_update_caption(void)
     if (!runstate_is_running())
         status = " [Stopped]";
     else if (gui_grab) {
-        if (alt_grab)
-            status = " - Press Ctrl-Alt-Shift to exit mouse grab";
-        else if (ctrl_grab)
-            status = " - Press Right-Ctrl to exit mouse grab";
-        else
-            status = " - Press Ctrl-Alt to exit mouse grab";
+        status = " - Press Ctrl-Alt to exit mouse grab";
     }
 
     if (qemu_name) {
@@ -556,14 +551,7 @@ static void handle_keydown(SDL_Event *ev)
     int mod_state;
     int keycode;
 
-    if (alt_grab) {
-        mod_state = (SDL_GetModState() & (gui_grab_code | KMOD_LSHIFT)) ==
-                    (gui_grab_code | KMOD_LSHIFT);
-    } else if (ctrl_grab) {
-        mod_state = (SDL_GetModState() & KMOD_RCTRL) == KMOD_RCTRL;
-    } else {
-        mod_state = (SDL_GetModState() & gui_grab_code) == gui_grab_code;
-    }
+    mod_state = (SDL_GetModState() & gui_grab_code) == gui_grab_code;
     gui_key_modifier_pressed = mod_state;
 
     if (gui_key_modifier_pressed) {
@@ -701,11 +689,7 @@ static void handle_keyup(SDL_Event *ev)
 {
     int mod_state;
 
-    if (!alt_grab) {
-        mod_state = (ev->key.keysym.mod & gui_grab_code);
-    } else {
-        mod_state = (ev->key.keysym.mod & (gui_grab_code | KMOD_LSHIFT));
-    }
+    mod_state = (ev->key.keysym.mod & gui_grab_code);
     if (!mod_state && gui_key_modifier_pressed) {
         gui_key_modifier_pressed = 0;
         if (gui_keysym == 0) {
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3802a9b477..e15566877b 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -139,13 +139,7 @@ static void sdl_update_caption(struct sdl2_console *scon)
     if (!runstate_is_running()) {
         status = " [Stopped]";
     } else if (gui_grab) {
-        if (alt_grab) {
-            status = " - Press Ctrl-Alt-Shift to exit grab";
-        } else if (ctrl_grab) {
-            status = " - Press Right-Ctrl to exit grab";
-        } else {
-            status = " - Press Ctrl-Alt to exit grab";
-        }
+        status = " - Press Ctrl-Alt to exit grab";
     }
 
     if (qemu_name) {
@@ -336,14 +330,7 @@ static void handle_keydown(SDL_Event *ev)
     int mod_state, win;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
-    if (alt_grab) {
-        mod_state = (SDL_GetModState() & (gui_grab_code | KMOD_LSHIFT)) ==
-            (gui_grab_code | KMOD_LSHIFT);
-    } else if (ctrl_grab) {
-        mod_state = (SDL_GetModState() & KMOD_RCTRL) == KMOD_RCTRL;
-    } else {
-        mod_state = (SDL_GetModState() & gui_grab_code) == gui_grab_code;
-    }
+    mod_state = (SDL_GetModState() & gui_grab_code) == gui_grab_code;
     gui_key_modifier_pressed = mod_state;
 
     if (gui_key_modifier_pressed) {
@@ -420,11 +407,7 @@ static void handle_keyup(SDL_Event *ev)
     int mod_state;
     struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
 
-    if (!alt_grab) {
-        mod_state = (ev->key.keysym.mod & gui_grab_code);
-    } else {
-        mod_state = (ev->key.keysym.mod & (gui_grab_code | KMOD_LSHIFT));
-    }
+    mod_state = (ev->key.keysym.mod & gui_grab_code);
     if (!mod_state && gui_key_modifier_pressed) {
         gui_key_modifier_pressed = 0;
         if (gui_keysym == 0) {
diff --git a/vl.c b/vl.c
index 4d8553b433..7dab7523a6 100644
--- a/vl.c
+++ b/vl.c
@@ -175,8 +175,6 @@ QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
 int old_param = 0;
 const char *qemu_name;
-int alt_grab = 0;
-int ctrl_grab = 0;
 unsigned int nb_prom_envs = 0;
 const char *prom_envs[MAX_PROM_ENVS];
 int boot_menu;
@@ -2167,22 +2165,10 @@ static DisplayType select_display(const char *p)
                 warn_report("frame sdl option is unsupported, ignoring");
             } else if (strstart(opts, ",alt_grab=", &nextopt)) {
                 opts = nextopt;
-                if (strstart(opts, "on", &nextopt)) {
-                    alt_grab = 1;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    alt_grab = 0;
-                } else {
-                    goto invalid_sdl_args;
-                }
+                warn_report("ctrl_grab sdl option is unsupported, ignoring");
             } else if (strstart(opts, ",ctrl_grab=", &nextopt)) {
                 opts = nextopt;
-                if (strstart(opts, "on", &nextopt)) {
-                    ctrl_grab = 1;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    ctrl_grab = 0;
-                } else {
-                    goto invalid_sdl_args;
-                }
+                warn_report("alt_grab sdl option is unsupported, ignoring");
             } else if (strstart(opts, ",window_close=", &nextopt)) {
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
@@ -3780,10 +3766,10 @@ int main(int argc, char **argv, char **envp)
                 warn_report("-no-frame switch is unsupported, ignoring");
                 break;
             case QEMU_OPTION_alt_grab:
-                alt_grab = 1;
+                warn_report("-alt-grab switch is unsupported, ignoring");
                 break;
             case QEMU_OPTION_ctrl_grab:
-                ctrl_grab = 1;
+                warn_report("-ctrl-grab switch is unsupported, ignoring");
                 break;
             case QEMU_OPTION_no_quit:
                 no_quit = 1;
@@ -4466,10 +4452,6 @@ int main(int argc, char **argv, char **envp)
 #endif
     }
 
-    if ((alt_grab || ctrl_grab) && display_type != DT_SDL) {
-        error_report("-no-frame, -alt-grab and -ctrl-grab are only valid "
-                     "for SDL, ignoring option");
-    }
     if (no_quit && (display_type != DT_GTK && display_type != DT_SDL)) {
         error_report("-no-quit is only valid for GTK and SDL, "
                      "ignoring option");
-- 
2.9.3
