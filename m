Received: from eggs.gnu.org ([2001:4830:134:3::10]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEF-0007z6-6Y
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCED-0002U4-PN
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCED-0002Sq-Hx
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA4AA1752A8
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:24:04 +0100
Message-Id: <20180129162408.415-9-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/12] curses: use DisplayOptions
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
---
 include/ui/console.h | 4 ++--
 ui/curses.c          | 2 +-
 vl.c                 | 4 +++-
 qapi/ui.json         | 5 +++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 4cb623112e..9749503aa7 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -496,9 +496,9 @@ static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
 
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
index 1d801dd96d..6fa65c0dbd 100644
--- a/vl.c
+++ b/vl.c
@@ -2189,6 +2189,7 @@ static LegacyDisplayType select_display(const char *p)
     } else if (strstart(p, "curses", &opts)) {
 #ifdef CONFIG_CURSES
         display = DT_CURSES;
+        dpy.type = DISPLAY_TYPE_CURSES;
 #else
         error_report("curses support is disabled");
         exit(1);
@@ -3275,6 +3276,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_curses:
 #ifdef CONFIG_CURSES
                 display_type = DT_CURSES;
+                dpy.type = DISPLAY_TYPE_CURSES;
 #else
                 error_report("curses support is disabled");
                 exit(1);
@@ -4708,7 +4710,7 @@ int main(int argc, char **argv, char **envp)
     /* init local displays */
     switch (display_type) {
     case DT_CURSES:
-        curses_display_init(ds, full_screen);
+        curses_display_init(ds, &dpy);
         break;
     case DT_SDL:
         sdl_display_init(ds, &dpy);
diff --git a/qapi/ui.json b/qapi/ui.json
index 8f0ae1d76b..3fb0e78fbc 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1017,7 +1017,7 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'default', 'none', 'gtk', 'sdl', 'egl-headless' ] }
+  'data'    : [ 'default', 'none', 'gtk', 'sdl', 'egl-headless', 'curses' ] }
 
 ##
 # @DisplayOptions:
@@ -1042,4 +1042,5 @@
                 'none'           : 'DisplayNoOpts',
                 'gtk'            : 'DisplayGTK',
                 'sdl'            : 'DisplayNoOpts',
-                'egl-headless'   : 'DisplayNoOpts' } }
+                'egl-headless'   : 'DisplayNoOpts',
+                'curses'         : 'DisplayNoOpts' } }
-- 
2.9.3
