Received: from eggs.gnu.org ([2001:4830:134:3::10]:50024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvL-0000uG-Ru
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0007R4-Q9
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvE-0007PM-Ek
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E8FAC04AC4D
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:34 +0100
Message-Id: <20171117103046.15943-13-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 12/24] vl: drop display_type variable
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

Switch over all leftover users to qapi DisplayType.
The delete the unused display_type variable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 52 +++++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/vl.c b/vl.c
index 85c41953b3..36eec0d1e0 100644
--- a/vl.c
+++ b/vl.c
@@ -2137,24 +2137,12 @@ static void select_vgahw(const char *p)
     }
 }
 
-typedef enum LegacyDisplayType {
-    DT_DEFAULT,
-    DT_CURSES,
-    DT_SDL,
-    DT_COCOA,
-    DT_GTK,
-    DT_EGL,
-    DT_NONE,
-} LegacyDisplayType;
-
-static LegacyDisplayType select_display(const char *p)
+static void parse_display(const char *p)
 {
     const char *opts;
-    LegacyDisplayType display = DT_DEFAULT;
 
     if (strstart(p, "sdl", &opts)) {
 #ifdef CONFIG_SDL
-        display = DT_SDL;
         dpy.type = DISPLAY_TYPE_SDL;
         while (*opts) {
             const char *nextopt;
@@ -2212,7 +2200,6 @@ static LegacyDisplayType select_display(const char *p)
 #ifdef CONFIG_OPENGL_DMABUF
         request_opengl = 1;
         display_opengl = 1;
-        display = DT_EGL;
         dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
 #else
         fprintf(stderr, "egl support is disabled\n");
@@ -2220,7 +2207,6 @@ static LegacyDisplayType select_display(const char *p)
 #endif
     } else if (strstart(p, "curses", &opts)) {
 #ifdef CONFIG_CURSES
-        display = DT_CURSES;
         dpy.type = DISPLAY_TYPE_CURSES;
 #else
         error_report("curses support is disabled");
@@ -2228,7 +2214,6 @@ static LegacyDisplayType select_display(const char *p)
 #endif
     } else if (strstart(p, "gtk", &opts)) {
 #ifdef CONFIG_GTK
-        display = DT_GTK;
         dpy.type = DISPLAY_TYPE_GTK;
         while (*opts) {
             const char *nextopt;
@@ -2267,14 +2252,11 @@ static LegacyDisplayType select_display(const char *p)
         exit(1);
 #endif
     } else if (strstart(p, "none", &opts)) {
-        display = DT_NONE;
         dpy.type = DISPLAY_TYPE_NONE;
     } else {
         error_report("unknown display type");
         exit(1);
     }
-
-    return display;
 }
 
 static int balloon_parse(const char *arg)
@@ -3103,7 +3085,6 @@ int main(int argc, char **argv, char **envp)
     const char *incoming = NULL;
     bool userconfig = true;
     bool nographic = false;
-    LegacyDisplayType display_type = DT_DEFAULT;
     int display_remote = 0;
     const char *log_mask = NULL;
     const char *log_file = NULL;
@@ -3378,18 +3359,16 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_display:
-                display_type = select_display(optarg);
+                parse_display(optarg);
                 break;
             case QEMU_OPTION_nographic:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "graphics=off", false);
                 nographic = true;
-                display_type = DT_NONE;
                 dpy.type = DISPLAY_TYPE_NONE;
                 break;
             case QEMU_OPTION_curses:
 #ifdef CONFIG_CURSES
-                display_type = DT_CURSES;
                 dpy.type = DISPLAY_TYPE_CURSES;
 #else
                 error_report("curses support is disabled");
@@ -3791,7 +3770,6 @@ int main(int argc, char **argv, char **envp)
                 break;
             case QEMU_OPTION_sdl:
 #ifdef CONFIG_SDL
-                display_type = DT_SDL;
                 dpy.type = DISPLAY_TYPE_SDL;
                 break;
 #else
@@ -4408,7 +4386,7 @@ int main(int argc, char **argv, char **envp)
             exit(1);
         }
 #ifdef CONFIG_CURSES
-        if (display_type == DT_CURSES) {
+        if (dpy.type == DISPLAY_TYPE_CURSES) {
             error_report("curses display cannot be used with -daemonize");
             exit(1);
         }
@@ -4454,35 +4432,31 @@ int main(int argc, char **argv, char **envp)
         display_remote++;
     }
 #endif
-    if (display_type == DT_DEFAULT && !display_remote) {
+    if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
 #if defined(CONFIG_GTK)
-        display_type = DT_GTK;
         dpy.type = DISPLAY_TYPE_GTK;
 #elif defined(CONFIG_SDL)
-        display_type = DT_SDL;
         dpy.type = DISPLAY_TYPE_SDL;
 #elif defined(CONFIG_COCOA)
-        display_type = DT_COCOA;
         dpy.type = DISPLAY_TYPE_COCOA;
 #elif defined(CONFIG_VNC)
         vnc_parse("localhost:0,to=99,id=default", &error_abort);
 #else
-        display_type = DT_NONE;
         dpy.type = DISPLAY_TYPE_NONE;
 #endif
     }
 
     if (dpy.has_window_close &&
-        (display_type != DT_GTK && display_type != DT_SDL)) {
+        (dpy.type != DISPLAY_TYPE_GTK && dpy.type != DISPLAY_TYPE_SDL)) {
         error_report("-no-quit is only valid for GTK and SDL, "
                      "ignoring option");
     }
 
-    if (display_type == DT_GTK) {
+    if (dpy.type == DISPLAY_TYPE_GTK) {
         early_gtk_display_init(&dpy);
     }
 
-    if (display_type == DT_SDL) {
+    if (dpy.type == DISPLAY_TYPE_SDL) {
         sdl_display_early_init(&dpy);
     }
 
@@ -4815,17 +4789,17 @@ int main(int argc, char **argv, char **envp)
     ds = init_displaystate();
 
     /* init local displays */
-    switch (display_type) {
-    case DT_CURSES:
+    switch (dpy.type) {
+    case DISPLAY_TYPE_CURSES:
         curses_display_init(ds, &dpy);
         break;
-    case DT_SDL:
+    case DISPLAY_TYPE_SDL:
         sdl_display_init(ds, &dpy);
         break;
-    case DT_COCOA:
+    case DISPLAY_TYPE_COCOA:
         cocoa_display_init(ds, &dpy);
         break;
-    case DT_GTK:
+    case DISPLAY_TYPE_GTK:
         gtk_display_init(ds, &dpy);
         break;
     default:
@@ -4846,7 +4820,7 @@ int main(int argc, char **argv, char **envp)
     }
 
 #ifdef CONFIG_OPENGL_DMABUF
-    if (display_type == DT_EGL) {
+    if (dpy.type == DISPLAY_TYPE_EGL_HEADLESS) {
         egl_headless_init(&dpy);
     }
 #endif
-- 
2.9.3
