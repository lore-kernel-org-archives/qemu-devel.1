Received: from eggs.gnu.org ([2001:4830:134:3::10]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFS-0003Fv-0L
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFO-0007Uj-Vc
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoUFO-0007Ss-LX
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9732857A1
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 13:15:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 14:15:27 +0100
Message-Id: <20180221131537.31341-3-kraxel@redhat.com>
In-Reply-To: <20180221131537.31341-1-kraxel@redhat.com>
References: <20180221131537.31341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 02/12] sdl: switch over to new display registry
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 19 -------------------
 ui/sdl.c             | 24 +++++++++++++-----------
 ui/sdl2.c            | 17 +++++++++++++++--
 vl.c                 | 15 +--------------
 4 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index ce3589aadd..82bbea0242 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -441,25 +441,6 @@ void qemu_display_register(QemuDisplay *ui);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 
-/* sdl.c */
-#ifdef CONFIG_SDL
-void sdl_display_early_init(DisplayOptions *opts);
-void sdl_display_init(DisplayState *ds, DisplayOptions *opts);
-#else
-static inline void sdl_display_early_init(DisplayOptions *opts)
-{
-    /* This must never be called if CONFIG_SDL is disabled */
-    error_report("SDL support is disabled");
-    abort();
-}
-static inline void sdl_display_init(DisplayState *ds, DisplayOptions *opts)
-{
-    /* This must never be called if CONFIG_SDL is disabled */
-    error_report("SDL support is disabled");
-    abort();
-}
-#endif
-
 /* cocoa.m */
 #ifdef CONFIG_COCOA
 void cocoa_display_init(DisplayState *ds, DisplayOptions *opts);
diff --git a/ui/sdl.c b/ui/sdl.c
index 963cdf77a7..153cbc6d1c 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -897,17 +897,7 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_cursor_define    = sdl_mouse_define,
 };
 
-void sdl_display_early_init(DisplayOptions *opts)
-{
-    if (opts->has_gl && opts->gl) {
-        fprintf(stderr,
-                "SDL1 display code has no opengl support.\n"
-                "Please recompile qemu with SDL2, using\n"
-                "./configure --enable-sdl --with-sdlabi=2.0\n");
-    }
-}
-
-void sdl_display_init(DisplayState *ds, DisplayOptions *o)
+static void sdl1_display_init(DisplayState *ds, DisplayOptions *o)
 {
     int flags;
     uint8_t data = 0;
@@ -1019,3 +1009,15 @@ void sdl_display_init(DisplayState *ds, DisplayOptions *o)
 
     atexit(sdl_cleanup);
 }
+
+static QemuDisplay qemu_display_sdl1 = {
+    .type       = DISPLAY_TYPE_SDL,
+    .init       = sdl1_display_init,
+};
+
+static void register_sdl1(void)
+{
+    qemu_display_register(&qemu_display_sdl1);
+}
+
+type_init(register_sdl1);
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 6e96a4a24c..f17d039650 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -759,7 +759,7 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
 };
 #endif
 
-void sdl_display_early_init(DisplayOptions *o)
+static void sdl2_display_early_init(DisplayOptions *o)
 {
     assert(o->type == DISPLAY_TYPE_SDL);
     if (o->has_gl && o->gl) {
@@ -769,7 +769,7 @@ void sdl_display_early_init(DisplayOptions *o)
     }
 }
 
-void sdl_display_init(DisplayState *ds, DisplayOptions *o)
+static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 {
     int flags;
     uint8_t data = 0;
@@ -869,3 +869,16 @@ void sdl_display_init(DisplayState *ds, DisplayOptions *o)
 
     atexit(sdl_cleanup);
 }
+
+static QemuDisplay qemu_display_sdl2 = {
+    .type       = DISPLAY_TYPE_SDL,
+    .early_init = sdl2_display_early_init,
+    .init       = sdl2_display_init,
+};
+
+static void register_sdl1(void)
+{
+    qemu_display_register(&qemu_display_sdl2);
+}
+
+type_init(register_sdl1);
diff --git a/vl.c b/vl.c
index 70458ba708..45900ba7e6 100644
--- a/vl.c
+++ b/vl.c
@@ -2085,7 +2085,6 @@ static void parse_display(const char *p)
     const char *opts;
 
     if (strstart(p, "sdl", &opts)) {
-#ifdef CONFIG_SDL
         dpy.type = DISPLAY_TYPE_SDL;
         while (*opts) {
             const char *nextopt;
@@ -2146,10 +2145,6 @@ static void parse_display(const char *p)
             }
             opts = nextopt;
         }
-#else
-        error_report("SDL support is disabled");
-        exit(1);
-#endif
     } else if (strstart(p, "vnc", &opts)) {
         if (*opts == '=') {
             vnc_parse(opts + 1, &error_fatal);
@@ -4327,12 +4322,7 @@ int main(int argc, char **argv, char **envp)
                      "ignoring option");
     }
 
-    if (dpy.type == DISPLAY_TYPE_SDL) {
-        sdl_display_early_init(&dpy);
-    } else {
-        qemu_display_early_init(&dpy);
-    }
-
+    qemu_display_early_init(&dpy);
     qemu_console_early_init();
 
     if (dpy.has_gl && dpy.gl && display_opengl == 0) {
@@ -4664,9 +4654,6 @@ int main(int argc, char **argv, char **envp)
     case DISPLAY_TYPE_CURSES:
         curses_display_init(ds, &dpy);
         break;
-    case DISPLAY_TYPE_SDL:
-        sdl_display_init(ds, &dpy);
-        break;
     case DISPLAY_TYPE_COCOA:
         cocoa_display_init(ds, &dpy);
         break;
-- 
2.9.3
