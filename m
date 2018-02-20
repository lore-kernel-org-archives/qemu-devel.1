Received: from eggs.gnu.org ([2001:4830:134:3::10]:47921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gt-0005NF-Gi
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gi-00072W-Ji
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Gi-00071o-E5
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48DFE80401C1
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:29 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:15 +0100
Message-Id: <20180220134723.11776-5-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] sdl: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Switch sdl ui to use qapi DisplayOptions for configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-6-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  8 ++++----
 ui/sdl.c             | 19 +++++++++++++------
 ui/sdl2.c            | 33 +++++++++++++++++++--------------
 vl.c                 | 13 +++++++++++--
 qapi/ui.json         |  5 +++--
 5 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 82cb000e3b..4e4d027936 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -431,16 +431,16 @@ void surface_gl_setup_viewport(QemuGLShader *gls,
 
 /* sdl.c */
 #ifdef CONFIG_SDL
-void sdl_display_early_init(int opengl);
-void sdl_display_init(DisplayState *ds, int full_screen);
+void sdl_display_early_init(DisplayOptions *opts);
+void sdl_display_init(DisplayState *ds, DisplayOptions *opts);
 #else
-static inline void sdl_display_early_init(int opengl)
+static inline void sdl_display_early_init(DisplayOptions *opts)
 {
     /* This must never be called if CONFIG_SDL is disabled */
     error_report("SDL support is disabled");
     abort();
 }
-static inline void sdl_display_init(DisplayState *ds, int full_screen)
+static inline void sdl_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     /* This must never be called if CONFIG_SDL is disabled */
     error_report("SDL support is disabled");
diff --git a/ui/sdl.c b/ui/sdl.c
index a6bff301eb..963cdf77a7 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -41,6 +41,7 @@
 
 static DisplayChangeListener *dcl;
 static DisplaySurface *surface;
+static DisplayOptions *opts;
 static SDL_Surface *real_screen;
 static SDL_Surface *guest_screen = NULL;
 static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
@@ -769,6 +770,7 @@ static void handle_activation(SDL_Event *ev)
 static void sdl_refresh(DisplayChangeListener *dcl)
 {
     SDL_Event ev1, *ev = &ev1;
+    bool allow_close = true;
     int idle = 1;
 
     if (last_vm_running != runstate_is_running()) {
@@ -793,7 +795,10 @@ static void sdl_refresh(DisplayChangeListener *dcl)
             handle_keyup(ev);
             break;
         case SDL_QUIT:
-            if (!no_quit) {
+            if (opts->has_window_close && !opts->window_close) {
+                allow_close = false;
+            }
+            if (allow_close) {
                 no_shutdown = 0;
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
@@ -892,9 +897,9 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_cursor_define    = sdl_mouse_define,
 };
 
-void sdl_display_early_init(int opengl)
+void sdl_display_early_init(DisplayOptions *opts)
 {
-    if (opengl == 1 /* on */) {
+    if (opts->has_gl && opts->gl) {
         fprintf(stderr,
                 "SDL1 display code has no opengl support.\n"
                 "Please recompile qemu with SDL2, using\n"
@@ -902,7 +907,7 @@ void sdl_display_early_init(int opengl)
     }
 }
 
-void sdl_display_init(DisplayState *ds, int full_screen)
+void sdl_display_init(DisplayState *ds, DisplayOptions *o)
 {
     int flags;
     uint8_t data = 0;
@@ -910,6 +915,8 @@ void sdl_display_init(DisplayState *ds, int full_screen)
     SDL_SysWMinfo info;
     char *filename;
 
+    assert(o->type == DISPLAY_TYPE_SDL);
+    opts = o;
 #if defined(__APPLE__)
     /* always use generic keymaps */
     if (!keyboard_layout)
@@ -924,7 +931,7 @@ void sdl_display_init(DisplayState *ds, int full_screen)
     g_printerr("Running QEMU with SDL 1.2 is deprecated, and will be removed\n"
                "in a future release. Please switch to SDL 2.0 instead\n");
 
-    if (!full_screen) {
+    if (opts->has_full_screen && opts->full_screen) {
         setenv("SDL_VIDEO_ALLOW_SCREENSAVER", "1", 0);
     }
 #ifdef __linux__
@@ -967,7 +974,7 @@ void sdl_display_init(DisplayState *ds, int full_screen)
         g_free(filename);
     }
 
-    if (full_screen) {
+    if (opts->has_full_screen && opts->full_screen) {
         gui_fullscreen = 1;
         sdl_grab_start();
     }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 858e04d7c0..6e96a4a24c 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -32,6 +32,7 @@
 
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
+static DisplayOptions *opts;
 
 static SDL_Surface *guest_sprite_surface;
 static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
@@ -526,6 +527,7 @@ static void handle_mousewheel(SDL_Event *ev)
 static void handle_windowevent(SDL_Event *ev)
 {
     struct sdl2_console *scon = get_scon_from_window(ev->window.windowID);
+    bool allow_close = true;
 
     if (!scon) {
         return;
@@ -572,7 +574,10 @@ static void handle_windowevent(SDL_Event *ev)
         break;
     case SDL_WINDOWEVENT_CLOSE:
         if (qemu_console_is_graphic(scon->dcl.con)) {
-            if (!no_quit) {
+            if (opts->has_window_close && !opts->window_close) {
+                allow_close = false;
+            }
+            if (allow_close) {
                 no_shutdown = 0;
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
@@ -593,6 +598,7 @@ static void handle_windowevent(SDL_Event *ev)
 void sdl2_poll_events(struct sdl2_console *scon)
 {
     SDL_Event ev1, *ev = &ev1;
+    bool allow_close = true;
     int idle = 1;
 
     if (scon->last_vm_running != runstate_is_running()) {
@@ -615,7 +621,10 @@ void sdl2_poll_events(struct sdl2_console *scon)
             handle_textinput(ev);
             break;
         case SDL_QUIT:
-            if (!no_quit) {
+            if (opts->has_window_close && !opts->window_close) {
+                allow_close = false;
+            }
+            if (allow_close) {
                 no_shutdown = 0;
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
@@ -750,24 +759,17 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
 };
 #endif
 
-void sdl_display_early_init(int opengl)
+void sdl_display_early_init(DisplayOptions *o)
 {
-    switch (opengl) {
-    case -1: /* default */
-    case 0:  /* off */
-        break;
-    case 1: /* on */
+    assert(o->type == DISPLAY_TYPE_SDL);
+    if (o->has_gl && o->gl) {
 #ifdef CONFIG_OPENGL
         display_opengl = 1;
 #endif
-        break;
-    default:
-        g_assert_not_reached();
-        break;
     }
 }
 
-void sdl_display_init(DisplayState *ds, int full_screen)
+void sdl_display_init(DisplayState *ds, DisplayOptions *o)
 {
     int flags;
     uint8_t data = 0;
@@ -775,6 +777,9 @@ void sdl_display_init(DisplayState *ds, int full_screen)
     int i;
     SDL_SysWMinfo info;
 
+    assert(o->type == DISPLAY_TYPE_SDL);
+    opts = o;
+
 #ifdef __linux__
     /* on Linux, SDL may use fbcon|directfb|svgalib when run without
      * accessible $DISPLAY to open X11 window.  This is often the case
@@ -849,7 +854,7 @@ void sdl_display_init(DisplayState *ds, int full_screen)
         g_free(filename);
     }
 
-    if (full_screen) {
+    if (opts->has_full_screen && opts->full_screen) {
         gui_fullscreen = 1;
         sdl_grab_start(0);
     }
diff --git a/vl.c b/vl.c
index a82b7cf16f..61b72758a8 100644
--- a/vl.c
+++ b/vl.c
@@ -2101,6 +2101,7 @@ static LegacyDisplayType select_display(const char *p)
     if (strstart(p, "sdl", &opts)) {
 #ifdef CONFIG_SDL
         display = DT_SDL;
+        dpy.type = DISPLAY_TYPE_SDL;
         while (*opts) {
             const char *nextopt;
 
@@ -2135,19 +2136,25 @@ static LegacyDisplayType select_display(const char *p)
                 }
             } else if (strstart(opts, ",window_close=", &nextopt)) {
                 opts = nextopt;
+                dpy.has_window_close = true;
                 if (strstart(opts, "on", &nextopt)) {
                     no_quit = 0;
+                    dpy.window_close = true;
                 } else if (strstart(opts, "off", &nextopt)) {
                     no_quit = 1;
+                    dpy.window_close = false;
                 } else {
                     goto invalid_sdl_args;
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
                     goto invalid_sdl_args;
                 }
@@ -3668,6 +3675,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_sdl:
 #ifdef CONFIG_SDL
                 display_type = DT_SDL;
+                dpy.type = DISPLAY_TYPE_SDL;
                 break;
 #else
                 error_report("SDL support is disabled");
@@ -4334,6 +4342,7 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_GTK;
 #elif defined(CONFIG_SDL)
         display_type = DT_SDL;
+        dpy.type = DISPLAY_TYPE_SDL;
 #elif defined(CONFIG_COCOA)
         display_type = DT_COCOA;
 #elif defined(CONFIG_VNC)
@@ -4358,7 +4367,7 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (display_type == DT_SDL) {
-        sdl_display_early_init(request_opengl);
+        sdl_display_early_init(&dpy);
     }
 
     qemu_console_early_init();
@@ -4693,7 +4702,7 @@ int main(int argc, char **argv, char **envp)
         curses_display_init(ds, full_screen);
         break;
     case DT_SDL:
-        sdl_display_init(ds, full_screen);
+        sdl_display_init(ds, &dpy);
         break;
     case DT_COCOA:
         cocoa_display_init(ds, full_screen);
diff --git a/qapi/ui.json b/qapi/ui.json
index 878a3bd2a6..2efe9675b7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1020,7 +1020,7 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'none', 'gtk' ] }
+  'data'    : [ 'none', 'gtk', 'sdl' ] }
 
 ##
 # @DisplayOptions:
@@ -1042,4 +1042,5 @@
                 '*gl'            : 'bool' },
   'discriminator' : 'type',
   'data'    : { 'none'           : 'DisplayNoOpts',
-                'gtk'            : 'DisplayGTK' } }
+                'gtk'            : 'DisplayGTK',
+                'sdl'            : 'DisplayNoOpts' } }
-- 
2.9.3
