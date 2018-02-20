Received: from eggs.gnu.org ([2001:4830:134:3::10]:47795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gh-0005Gh-HB
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006y8-D2
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006xG-7h
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:36 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:19 +0100
Message-Id: <20180220134723.11776-9-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 08/12] cocoa: use DisplayOptions
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-10-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h | 4 ++--
 vl.c                 | 3 ++-
 qapi/ui.json         | 6 ++++--
 ui/cocoa.m           | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 65ed6ddca6..e6b1227bef 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -450,9 +450,9 @@ static inline void sdl_display_init(DisplayState *ds, DisplayOptions *opts)
 
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
index 3752ebec49..2dd00e00d9 100644
--- a/vl.c
+++ b/vl.c
@@ -4344,6 +4344,7 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_SDL;
 #elif defined(CONFIG_COCOA)
         display_type = DT_COCOA;
+        dpy.type = DISPLAY_TYPE_COCOA;
 #elif defined(CONFIG_VNC)
         vnc_parse("localhost:0,to=99,id=default", &error_abort);
 #else
@@ -4705,7 +4706,7 @@ int main(int argc, char **argv, char **envp)
         sdl_display_init(ds, &dpy);
         break;
     case DT_COCOA:
-        cocoa_display_init(ds, full_screen);
+        cocoa_display_init(ds, &dpy);
         break;
     case DT_GTK:
         gtk_display_init(ds, &dpy);
diff --git a/qapi/ui.json b/qapi/ui.json
index 11aad8b496..398baa9698 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1020,7 +1020,8 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'none', 'gtk', 'sdl', 'egl-headless', 'curses' ] }
+  'data'    : [ 'none', 'gtk', 'sdl',
+                'egl-headless', 'curses', 'cocoa' ] }
 
 ##
 # @DisplayOptions:
@@ -1045,4 +1046,5 @@
                 'gtk'            : 'DisplayGTK',
                 'sdl'            : 'DisplayNoOpts',
                 'egl-headless'   : 'DisplayNoOpts',
-                'curses'         : 'DisplayNoOpts' } }
+                'curses'         : 'DisplayNoOpts',
+                'cocoa'          : 'DisplayNoOpts' } }
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 51db47cd71..90d9aa57ea 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1683,12 +1683,12 @@ static void addRemovableDevicesMenuItems(void)
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
