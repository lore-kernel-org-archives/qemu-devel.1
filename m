Received: from eggs.gnu.org ([2001:4830:134:3::10]:45796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb70S-0008Nh-Ux
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb70O-0005av-8E
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:49:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eb70N-0005aL-Vm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:49:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A38913AA3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 15:48:59 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Jan 2018 16:48:55 +0100
Message-Id: <20180115154855.30850-3-kraxel@redhat.com>
In-Reply-To: <20180115154855.30850-1-kraxel@redhat.com>
References: <20180115154855.30850-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] sdl: reorganize -no-frame support
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

Drop no_frame flag from sdl_display_init argument list, use a global
variable instead.  This is temporary until -no-frame support is dropped
altogether when we remove sdl1 support.

Remove any traces of noframe from sdl2 code.  It is just dead code as
sdl2 doesn't support the SDL_NOFRAME window flag any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/sysemu/sysemu.h | 1 +
 include/ui/console.h    | 5 ++---
 ui/sdl.c                | 9 +++------
 ui/sdl2.c               | 7 +------
 vl.c                    | 4 ++--
 5 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 31612caf10..1c925309e3 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -112,6 +112,7 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
+extern int no_frame;
 extern int smp_cpus;
 extern unsigned int max_cpus;
 extern int cursor_hide;
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
index 9c664c86a0..9baaef8108 100644
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
@@ -114,8 +113,9 @@ static void do_sdl_resize(int width, int height, int bpp)
     } else {
         flags |= SDL_RESIZABLE;
     }
-    if (gui_noframe)
+    if (no_frame) {
         flags |= SDL_NOFRAME;
+    }
 
     tmp_screen = SDL_SetVideoMode(width, height, bpp, flags);
     if (!real_screen) {
@@ -940,7 +940,7 @@ void sdl_display_early_init(int opengl)
     }
 }
 
-void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
+void sdl_display_init(DisplayState *ds, int full_screen)
 {
     int flags;
     uint8_t data = 0;
@@ -959,9 +959,6 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
             exit(1);
     }
 
-    if (no_frame)
-        gui_noframe = 1;
-
     if (!full_screen) {
         setenv("SDL_VIDEO_ALLOW_SCREENSAVER", "1", 0);
     }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 1db5dd6f5f..812c315891 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -38,7 +38,6 @@ static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 
 static int gui_saved_grab;
 static int gui_fullscreen;
-static int gui_noframe;
 static int gui_key_modifier_pressed;
 static int gui_keysym;
 static int gui_grab_code = KMOD_LALT | KMOD_LCTRL;
@@ -767,7 +766,7 @@ void sdl_display_early_init(int opengl)
     }
 }
 
-void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
+void sdl_display_init(DisplayState *ds, int full_screen)
 {
     int flags;
     uint8_t data = 0;
@@ -775,10 +774,6 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
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
index 444b7507da..49be579024 100644
--- a/vl.c
+++ b/vl.c
@@ -150,7 +150,7 @@ static int rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static int full_screen = 0;
-static int no_frame = 0;
+int no_frame;
 int no_quit = 0;
 static bool grab_on_hover;
 Chardev *serial_hds[MAX_SERIAL_PORTS];
@@ -4692,7 +4692,7 @@ int main(int argc, char **argv, char **envp)
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
