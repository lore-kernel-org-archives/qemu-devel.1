Received: from eggs.gnu.org ([2001:4830:134:3::10]:41137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05S-0007P0-U5
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05R-0001fT-VU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC05R-0001ez-R0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:41 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 11:54:31 +0200
Message-Id: <20180427095434.14013-4-kraxel@redhat.com>
In-Reply-To: <20180427095434.14013-1-kraxel@redhat.com>
References: <20180427095434.14013-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] sdl: Move DisplayOptions global to
 sdl2_console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Elie Tournier <tournier.elie@gmail.com>, Elie Tournier <elie.tournier@collabora.com>

From: Elie Tournier <tournier.elie@gmail.com>

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Elie Tournier <elie.tournier@collabora.com>
Message-id: 20180413135842.21325-3-tournier.elie@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/sdl2.h |  1 +
 ui/sdl2.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 51084e6320..f43eecdbd6 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -14,6 +14,7 @@
 struct sdl2_console {
     DisplayChangeListener dcl;
     DisplaySurface *surface;
+    DisplayOptions *opts;
     SDL_Texture *texture;
     SDL_Window *real_window;
     SDL_Renderer *real_renderer;
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 83b917fa37..da037248c2 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -32,7 +32,6 @@
 
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
-static DisplayOptions *opts;
 
 static SDL_Surface *guest_sprite_surface;
 static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
@@ -566,7 +565,7 @@ static void handle_windowevent(SDL_Event *ev)
         break;
     case SDL_WINDOWEVENT_CLOSE:
         if (qemu_console_is_graphic(scon->dcl.con)) {
-            if (opts->has_window_close && !opts->window_close) {
+            if (scon->opts->has_window_close && !scon->opts->window_close) {
                 allow_close = false;
             }
             if (allow_close) {
@@ -613,7 +612,7 @@ void sdl2_poll_events(struct sdl2_console *scon)
             handle_textinput(ev);
             break;
         case SDL_QUIT:
-            if (opts->has_window_close && !opts->window_close) {
+            if (scon->opts->has_window_close && !scon->opts->window_close) {
                 allow_close = false;
             }
             if (allow_close) {
@@ -770,7 +769,6 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SysWMinfo info;
 
     assert(o->type == DISPLAY_TYPE_SDL);
-    opts = o;
 
 #ifdef __linux__
     /* on Linux, SDL may use fbcon|directfb|svgalib when run without
@@ -806,6 +804,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         return;
     }
     sdl2_console = g_new0(struct sdl2_console, sdl2_num_outputs);
+    sdl2_console->opts = o;
     for (i = 0; i < sdl2_num_outputs; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
         assert(con != NULL);
@@ -846,7 +845,8 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         g_free(filename);
     }
 
-    if (opts->has_full_screen && opts->full_screen) {
+    if (sdl2_console->opts->has_full_screen &&
+        sdl2_console->opts->full_screen) {
         gui_fullscreen = 1;
         sdl_grab_start(0);
     }
-- 
2.9.3
