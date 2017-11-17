Received: from eggs.gnu.org ([2001:4830:134:3::10]:49836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0000o4-Nu
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0007NB-Ri
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvB-0007LC-EZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B4837C82B
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:23 +0100
Message-Id: <20171117103046.15943-2-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 01/24] sdl: remove -no-frame support
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

SDL2 doesn't support this any more, the SDL_NOFRAME window flag is gone.
Drop the code, print a notice when the option is still used.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  5 ++---
 ui/sdl.c             |  8 +-------
 ui/sdl2.c            |  7 +------
 vl.c                 | 15 ++++-----------
 4 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 580dfc57ee..7b35778444 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -436,7 +436,7 @@ void surface_gl_setup_viewport(QemuGLShader *gls,
 /* sdl.c */
 #ifdef CONFIG_SDL
 void sdl_display_early_init(int opengl);
-void sdl_display_init(DisplayState *ds, int full_screen, int no_frame);
+void sdl_display_init(DisplayState *ds, int full_screen);
 #else
 static inline void sdl_display_early_init(int opengl)
 {
@@ -444,8 +444,7 @@ static inline void sdl_display_early_init(int opengl)
     error_report("SDL support is disabled");
     abort();
 }
-static inline void sdl_display_init(DisplayState *ds, int full_screen,
-                                    int no_frame)
+static inline void sdl_display_init(DisplayState *ds, int full_screen)
 {
     /* This must never be called if CONFIG_SDL is disabled */
     error_report("SDL support is disabled");
diff --git a/ui/sdl.c b/ui/sdl.c
index 7b71a9ac58..f3adbb7a64 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -48,7 +48,6 @@ static int gui_saved_width;
 static int gui_saved_height;
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_noframe;
 static int gui_key_modifier_pressed;
 static int gui_keysym;
 static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
@@ -114,8 +113,6 @@ static void do_sdl_resize(int width, int height, int bpp)
     } else {
         flags |= SDL_RESIZABLE;
     }
-    if (gui_noframe)
-        flags |= SDL_NOFRAME;
 
     tmp_screen = SDL_SetVideoMode(width, height, bpp, flags);
     if (!real_screen) {
@@ -944,7 +941,7 @@ void sdl_display_early_init(int opengl)
     }
 }
 
-void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
+void sdl_display_init(DisplayState *ds, int full_screen)
 {
     int flags;
     uint8_t data = 0;
@@ -963,9 +960,6 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
             exit(1);
     }
 
-    if (no_frame)
-        gui_noframe = 1;
-
     if (!full_screen) {
         setenv("SDL_VIDEO_ALLOW_SCREENSAVER", "1", 0);
     }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 53dd447fd2..3802a9b477 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -38,7 +38,6 @@ static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_noframe;
 static int gui_key_modifier_pressed;
 static int gui_keysym;
 static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
@@ -756,7 +755,7 @@ void sdl_display_early_init(int opengl)
     }
 }
 
-void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
+void sdl_display_init(DisplayState *ds, int full_screen)
 {
     int flags;
     uint8_t data = 0;
@@ -764,10 +763,6 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     int i;
     SDL_SysWMinfo info;
 
-    if (no_frame) {
-        gui_noframe = 1;
-    }
-
 #ifdef __linux__
     /* on Linux, SDL may use fbcon|directfb|svgalib when run without
      * accessible $DISPLAY to open X11 window.  This is often the case
diff --git a/vl.c b/vl.c
index 7372424fa7..4d8553b433 100644
--- a/vl.c
+++ b/vl.c
@@ -151,7 +151,6 @@ static int rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static int full_screen = 0;
-static int no_frame = 0;
 int no_quit = 0;
 static bool grab_on_hover;
 Chardev *serial_hds[MAX_SERIAL_PORTS];
@@ -2165,13 +2164,7 @@ static DisplayType select_display(const char *p)
 
             if (strstart(opts, ",frame=", &nextopt)) {
                 opts = nextopt;
-                if (strstart(opts, "on", &nextopt)) {
-                    no_frame = 0;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    no_frame = 1;
-                } else {
-                    goto invalid_sdl_args;
-                }
+                warn_report("frame sdl option is unsupported, ignoring");
             } else if (strstart(opts, ",alt_grab=", &nextopt)) {
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
@@ -3784,7 +3777,7 @@ int main(int argc, char **argv, char **envp)
                 full_screen = 1;
                 break;
             case QEMU_OPTION_no_frame:
-                no_frame = 1;
+                warn_report("-no-frame switch is unsupported, ignoring");
                 break;
             case QEMU_OPTION_alt_grab:
                 alt_grab = 1;
@@ -4473,7 +4466,7 @@ int main(int argc, char **argv, char **envp)
 #endif
     }
 
-    if ((no_frame || alt_grab || ctrl_grab) && display_type != DT_SDL) {
+    if ((alt_grab || ctrl_grab) && display_type != DT_SDL) {
         error_report("-no-frame, -alt-grab and -ctrl-grab are only valid "
                      "for SDL, ignoring option");
     }
@@ -4824,7 +4817,7 @@ int main(int argc, char **argv, char **envp)
         curses_display_init(ds, full_screen);
         break;
     case DT_SDL:
-        sdl_display_init(ds, full_screen, no_frame);
+        sdl_display_init(ds, full_screen);
         break;
     case DT_COCOA:
         cocoa_display_init(ds, full_screen);
-- 
2.9.3
