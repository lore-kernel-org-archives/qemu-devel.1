Received: from eggs.gnu.org ([2001:4830:134:3::10]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gh-0005Gg-Gl
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006yl-MD
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006xm-Gn
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E91380D2EC8
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:18 +0100
Message-Id: <20180220134723.11776-8-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] curses: use DisplayOptions
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

Switch curses ui to use qapi DisplayOptions for configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-9-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 4 ++--
 ui/curses.c          | 2 +-
 vl.c                 | 4 +++-
 qapi/ui.json         | 5 +++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 183d9f2913..65ed6ddca6 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -471,9 +471,9 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
 
 /* curses.c */
 #ifdef CONFIG_CURSES
-void curses_display_init(DisplayState *ds, int full_screen);
+void curses_display_init(DisplayState *ds, DisplayOptions *opts);
 #else
-static inline void curses_display_init(DisplayState *ds, int full_screen)
+static inline void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     /* This must never be called if CONFIG_CURSES is disabled */
     error_report("curses support is disabled");
diff --git a/ui/curses.c b/ui/curses.c
index 85503876c0..479b77bd03 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -434,7 +434,7 @@ static const DisplayChangeListenerOps dcl_ops = {
     .dpy_text_cursor = curses_cursor_position,
 };
 
-void curses_display_init(DisplayState *ds, int full_screen)
+void curses_display_init(DisplayState *ds, DisplayOptions *opts)
 {
 #ifndef _WIN32
     if (!isatty(1)) {
diff --git a/vl.c b/vl.c
index 38c18ef2e6..3752ebec49 100644
--- a/vl.c
+++ b/vl.c
@@ -2186,6 +2186,7 @@ static LegacyDisplayType select_display(const char *p)
     } else if (strstart(p, "curses", &opts)) {
 #ifdef CONFIG_CURSES
         display = DT_CURSES;
+        dpy.type = DISPLAY_TYPE_CURSES;
 #else
         error_report("curses support is disabled");
         exit(1);
@@ -3268,6 +3269,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_curses:
 #ifdef CONFIG_CURSES
                 display_type = DT_CURSES;
+                dpy.type = DISPLAY_TYPE_CURSES;
 #else
                 error_report("curses support is disabled");
                 exit(1);
@@ -4697,7 +4699,7 @@ int main(int argc, char **argv, char **envp)
     /* init local displays */
     switch (display_type) {
     case DT_CURSES:
-        curses_display_init(ds, full_screen);
+        curses_display_init(ds, &dpy);
         break;
     case DT_SDL:
         sdl_display_init(ds, &dpy);
diff --git a/qapi/ui.json b/qapi/ui.json
index 43de75fa27..11aad8b496 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1020,7 +1020,7 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'none', 'gtk', 'sdl', 'egl-headless' ] }
+  'data'    : [ 'none', 'gtk', 'sdl', 'egl-headless', 'curses' ] }
 
 ##
 # @DisplayOptions:
@@ -1044,4 +1044,5 @@
   'data'    : { 'none'           : 'DisplayNoOpts',
                 'gtk'            : 'DisplayGTK',
                 'sdl'            : 'DisplayNoOpts',
-                'egl-headless'   : 'DisplayNoOpts' } }
+                'egl-headless'   : 'DisplayNoOpts',
+                'curses'         : 'DisplayNoOpts' } }
-- 
2.9.3
