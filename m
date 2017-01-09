Received: from eggs.gnu.org ([2001:4830:134:3::10]:54536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhy-000516-R2
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhu-0008Re-5b
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQZht-0008R8-TC
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:50 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:09:38 +0100
Message-Id: <1483967385-12891-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/11] console: move window ID code from baum
 to sdl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

This moves the SDL bits for window ID from the baum driver to SDL, as
well as fixing the build for non-X11.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20161221003806.22412-3-samuel.thibault@ens-lyon.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/baum.c | 31 ++++++++-----------------------
 ui/sdl.c        | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index b92369d..b045ef4 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -27,12 +27,10 @@
 #include "sysemu/char.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "ui/console.h"
 #include <brlapi.h>
 #include <brlapi_constants.h>
 #include <brlapi_keycodes.h>
-#ifdef CONFIG_SDL
-#include <SDL_syswm.h>
-#endif
 
 #if 0
 #define DPRINTF(fmt, ...) \
@@ -227,12 +225,8 @@ static const uint8_t nabcc_translation[2][256] = {
 /* The guest OS has started discussing with us, finish initializing BrlAPI */
 static int baum_deferred_init(BaumDriverState *baum)
 {
-#if defined(CONFIG_SDL)
-#if SDL_COMPILEDVERSION < SDL_VERSIONNUM(2, 0, 0)
-    SDL_SysWMinfo info;
-#endif
-#endif
-    int tty;
+    int tty = BRLAPI_TTY_DEFAULT;
+    QemuConsole *con;
 
     if (baum->deferred_init) {
         return 1;
@@ -243,21 +237,12 @@ static int baum_deferred_init(BaumDriverState *baum)
         return 0;
     }
 
-#if defined(CONFIG_SDL)
-#if SDL_COMPILEDVERSION < SDL_VERSIONNUM(2, 0, 0)
-    memset(&info, 0, sizeof(info));
-    SDL_VERSION(&info.version);
-    if (SDL_GetWMInfo(&info)) {
-        tty = info.info.x11.wmwindow;
-    } else {
-#endif
-#endif
-        tty = BRLAPI_TTY_DEFAULT;
-#if defined(CONFIG_SDL)
-#if SDL_COMPILEDVERSION < SDL_VERSIONNUM(2, 0, 0)
+    con = qemu_console_lookup_by_index(0);
+    if (con && qemu_console_is_graphic(con)) {
+        tty = qemu_console_get_window_id(con);
+        if (tty == -1)
+            tty = BRLAPI_TTY_DEFAULT;
     }
-#endif
-#endif
 
     if (brlapi__enterTtyMode(baum->brlapi, tty, NULL) == -1) {
         brlapi_perror("baum: brlapi__enterTtyMode");
diff --git a/ui/sdl.c b/ui/sdl.c
index d8cf5bc..19e8a84 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -947,6 +947,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     int flags;
     uint8_t data = 0;
     const SDL_VideoInfo *vi;
+    SDL_SysWMinfo info;
     char *filename;
 
 #if defined(__APPLE__)
@@ -1023,5 +1024,29 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     sdl_cursor_hidden = SDL_CreateCursor(&data, &data, 8, 1, 0, 0);
     sdl_cursor_normal = SDL_GetCursor();
 
+    memset(&info, 0, sizeof(info));
+    SDL_VERSION(&info.version);
+    if (SDL_GetWMInfo(&info)) {
+        int i;
+        for (i = 0; ; i++) {
+            /* All consoles share the same window */
+            QemuConsole *con = qemu_console_lookup_by_index(i);
+            if (con) {
+#if defined(SDL_VIDEO_DRIVER_X11)
+                qemu_console_set_window_id(con, info.info.x11.wmwindow);
+#elif defined(SDL_VIDEO_DRIVER_NANOX) || \
+      defined(SDL_VIDEO_DRIVER_WINDIB) || defined(SDL_VIDEO_DRIVER_DDRAW) || \
+      defined(SDL_VIDEO_DRIVER_GAPI) || \
+      defined(SDL_VIDEO_DRIVER_RISCOS)
+                qemu_console_set_window_id(con, (int) (uintptr_t) info.window);
+#else
+                qemu_console_set_window_id(con, info.data);
+#endif
+            } else {
+                break;
+            }
+        }
+    }
+
     atexit(sdl_cleanup);
 }
-- 
1.8.3.1
