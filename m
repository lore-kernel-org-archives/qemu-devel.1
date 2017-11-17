Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvI-0000rh-44
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvF-0007Rc-5b
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvE-0007QC-RZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:32 +0100
Message-Id: <20171117103046.15943-11-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 10/24] cocoa: use DisplayOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

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
index b1036626eb..7d7e4ba9a1 100644
--- a/vl.c
+++ b/vl.c
@@ -4465,6 +4465,7 @@ int main(int argc, char **argv, char **envp)
         dpy.type = DISPLAY_TYPE_SDL;
 #elif defined(CONFIG_COCOA)
         display_type = DT_COCOA;
+        dpy.type = DISPLAY_TYPE_COCOA;
 #elif defined(CONFIG_VNC)
         vnc_parse("localhost:0,to=99,id=default", &error_abort);
 #else
@@ -4824,7 +4825,7 @@ int main(int argc, char **argv, char **envp)
         sdl_display_init(ds, &dpy);
         break;
     case DT_COCOA:
-        cocoa_display_init(ds, full_screen);
+        cocoa_display_init(ds, &dpy);
         break;
     case DT_GTK:
         gtk_display_init(ds, &dpy);
diff --git a/qapi/ui.json b/qapi/ui.json
index 4bb3f938f1..2baa5127cf 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1009,7 +1009,8 @@
 #
 ##
 { 'enum'    : 'DisplayType',
-  'data'    : [ 'default', 'none', 'gtk', 'sdl', 'egl-headless', 'curses' ] }
+  'data'    : [ 'default', 'none', 'gtk', 'sdl',
+                'egl-headless', 'curses', 'cocoa' ] }
 
 ##
 # @DisplayOptions:
@@ -1028,4 +1029,5 @@
                 'gtk'            : 'DisplayGTK',
                 'sdl'            : 'DisplayNoOpts',
                 'egl-headless'   : 'DisplayNoOpts',
-                'curses'         : 'DisplayNoOpts' } }
+                'curses'         : 'DisplayNoOpts',
+                'cocoa'          : 'DisplayNoOpts' } }
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..9560c07105 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1671,12 +1671,12 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
-void cocoa_display_init(DisplayState *ds, int full_screen)
+void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
     /* if fullscreen mode is to be used */
-    if (full_screen == true) {
+    if (opts->have_full_screen && opts->full_screen) {
         [NSApp activateIgnoringOtherApps: YES];
         [(QemuCocoaAppController *)[[NSApplication sharedApplication] delegate] toggleFullScreen: nil];
     }
-- 
2.9.3
