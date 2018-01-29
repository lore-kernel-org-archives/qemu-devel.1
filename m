Received: from eggs.gnu.org ([2001:4830:134:3::10]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEF-0007yt-0g
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCED-0002Ts-N2
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCED-0002Sf-GH
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:17 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:24:05 +0100
Message-Id: <20180129162408.415-10-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/12] cocoa: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Switch cocoa ui to use qapi DisplayOptions for configuration.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 4 ++--
 vl.c                 | 3 ++-
 qapi/ui.json         | 6 ++++--
 ui/cocoa.m           | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 9749503aa7..f96fd907d0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -454,9 +454,9 @@ static inline void sdl_display_init(DisplayState *ds, DisplayOptions *opts)
 
 /* cocoa.m */
 #ifdef CONFIG_COCOA
-void cocoa_display_init(DisplayState *ds, int full_screen);
+void cocoa_display_init(DisplayState *ds, DisplayOptions *opts);
 #else
-static inline void cocoa_display_init(DisplayState *ds, int full_screen)
+static inline void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     /* This must never be called if CONFIG_COCOA is disabled */
     error_report("Cocoa support is disabled");
diff --git a/vl.c b/vl.c
index 6fa65c0dbd..eb8aca9479 100644
--- a/vl.c
+++ b/vl.c
@@ -4355,6 +4355,7 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_SDL;
 #elif defined(CONFIG_COCOA)
         display_type = DT_COCOA;
+        dpy.type = DISPLAY_TYPE_COCOA;
 #elif defined(CONFIG_VNC)
         vnc_parse("localhost:0,to=99,id=default", &error_abort);
 #else
@@ -4716,7 +4717,7 @@ int main(int argc, char **argv, char **envp)
         sdl_display_init(ds, &dpy);
         break;
     case DT_COCOA:
-        cocoa_display_init(ds, full_screen);
+        cocoa_display_init(ds, &dpy);
         break;
     case DT_GTK:
         gtk_display_init(ds, &dpy);
diff --git a/qapi/ui.json b/qapi/ui.json
index 3fb0e78fbc..08b89a01be 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1017,7 +1017,8 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'default', 'none', 'gtk', 'sdl', 'egl-headless', 'curses' ] }
+  'data'    : [ 'default', 'none', 'gtk', 'sdl',
+                'egl-headless', 'curses', 'cocoa' ] }
 
 ##
 # @DisplayOptions:
@@ -1043,4 +1044,5 @@
                 'gtk'            : 'DisplayGTK',
                 'sdl'            : 'DisplayNoOpts',
                 'egl-headless'   : 'DisplayNoOpts',
-                'curses'         : 'DisplayNoOpts' } }
+                'curses'         : 'DisplayNoOpts',
+                'cocoa'          : 'DisplayNoOpts' } }
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 6be9848391..3e34d15716 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1682,12 +1682,12 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
-void cocoa_display_init(DisplayState *ds, int full_screen)
+void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
     /* if fullscreen mode is to be used */
-    if (full_screen == true) {
+    if (opts->has_full_screen && opts->full_screen) {
         [NSApp activateIgnoringOtherApps: YES];
         [(QemuCocoaAppController *)[[NSApplication sharedApplication] delegate] toggleFullScreen: nil];
     }
-- 
2.9.3
