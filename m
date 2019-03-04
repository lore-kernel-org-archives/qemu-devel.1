Received: from eggs.gnu.org ([209.51.188.92]:52535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qn5-0004SS-UJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qn3-0005ms-Tu
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:11 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qn3-0005mG-Jr
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:09 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t18so6334172wrx.2
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:50:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	x74sm7238018wmf.22.2019.03.04.08.50.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Mar 2019 08:50:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Mar 2019 16:49:58 +0000
Message-Id: <20190304164958.9362-8-peter.maydell@linaro.org>
In-Reply-To: <20190304164958.9362-1-peter.maydell@linaro.org>
References: <20190304164958.9362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/7] ui/cocoa: Perform UI operations only on the
 main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The OSX Mojave release is more picky about enforcing the Cocoa API
restriction that only the main thread may perform UI calls. To
accommodate this we need to restructure the Cocoa code:
 * the special OSX main() creates a second thread and uses
   that to call the vl.c qemu_main(); the original main
   thread goes into the OSX event loop
 * the refresh, switch and update callbacks asynchronously
   tell the main thread to do the necessary work
 * the refresh callback no longer does the "get events from the
   UI event queue and handle them" loop, since we now use
   the stock OSX event loop. Instead our NSApplication sendEvent
   method will either deal with them or pass them on to OSX

All these things have to be changed in one commit, to avoid
breaking bisection.

Note that since we use dispatch_get_main_queue(), this bumps
our minimum version requirement to OSX 10.10 Yosemite (released
in 2014, unsupported by Apple since 2017).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20190225102433.22401-8-peter.maydell@linaro.org
Message-id: 20190214102816.3393-8-peter.maydell@linaro.org
---
 ui/cocoa.m | 195 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 116 insertions(+), 79 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 00e3db69c91..420b2411c10 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -129,6 +129,9 @@ bool stretch_video;
 NSTextField *pauseLabel;
 NSArray * supportedImageFileTypes;
 
+static QemuSemaphore display_init_sem;
+static QemuSemaphore app_started_sem;
+
 // Utility functions to run specified code block with iothread lock held
 typedef void (^CodeBlock)(void);
 typedef bool (^BoolCodeBlock)(void);
@@ -325,6 +328,7 @@ static void handleAnyDeviceErrors(Error * err)
     NSWindow *fullScreenWindow;
     float cx,cy,cw,ch,cdx,cdy;
     CGDataProviderRef dataProviderRef;
+    pixman_image_t *pixman_image;
     BOOL modifiers_state[256];
     BOOL isMouseGrabbed;
     BOOL isFullscreen;
@@ -383,8 +387,10 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaView: dealloc\n");
 
-    if (dataProviderRef)
+    if (dataProviderRef) {
         CGDataProviderRelease(dataProviderRef);
+        pixman_image_unref(pixman_image);
+    }
 
     [super dealloc];
 }
@@ -535,13 +541,16 @@ QemuCocoaView *cocoaView;
     }
 
     // update screenBuffer
-    if (dataProviderRef)
+    if (dataProviderRef) {
         CGDataProviderRelease(dataProviderRef);
+        pixman_image_unref(pixman_image);
+    }
 
     //sync host window color space with guests
     screen.bitsPerPixel = PIXMAN_FORMAT_BPP(image_format);
     screen.bitsPerComponent = DIV_ROUND_UP(screen.bitsPerPixel, 8) * 2;
 
+    pixman_image = image;
     dataProviderRef = CGDataProviderCreateWithData(NULL, pixman_image_get_data(image), w * 4 * h, NULL);
 
     // update windows
@@ -1013,7 +1022,6 @@ QemuCocoaView *cocoaView;
 #endif
 {
 }
-- (void)startEmulationWithArgc:(int)argc argv:(char**)argv;
 - (void)doToggleFullScreen:(id)sender;
 - (void)toggleFullScreen:(id)sender;
 - (void)showQEMUDoc:(id)sender;
@@ -1101,8 +1109,8 @@ QemuCocoaView *cocoaView;
 - (void)applicationDidFinishLaunching: (NSNotification *) note
 {
     COCOA_DEBUG("QemuCocoaAppController: applicationDidFinishLaunching\n");
-    // launch QEMU, with the global args
-    [self startEmulationWithArgc:gArgc argv:(char **)gArgv];
+    /* Tell cocoa_display_init to proceed */
+    qemu_sem_post(&app_started_sem);
 }
 
 - (void)applicationWillTerminate:(NSNotification *)aNotification
@@ -1145,15 +1153,6 @@ QemuCocoaView *cocoaView;
     [cocoaView raiseAllKeys];
 }
 
-- (void)startEmulationWithArgc:(int)argc argv:(char**)argv
-{
-    COCOA_DEBUG("QemuCocoaAppController: startEmulationWithArgc\n");
-
-    int status;
-    status = qemu_main(argc, argv, *_NSGetEnviron());
-    exit(status);
-}
-
 /* We abstract the method called by the Enter Fullscreen menu item
  * because Mac OS 10.7 and higher disables it. This is because of the
  * menu item's old selector's name toggleFullScreen:
@@ -1489,7 +1488,9 @@ QemuCocoaView *cocoaView;
 - (void)sendEvent:(NSEvent *)event
 {
     COCOA_DEBUG("QemuApplication: sendEvent\n");
-    [super sendEvent: event];
+    if (![cocoaView handleEvent:event]) {
+        [super sendEvent: event];
+    }
 }
 @end
 
@@ -1672,32 +1673,59 @@ static void addRemovableDevicesMenuItems(void)
     qapi_free_BlockInfoList(pointerToFree);
 }
 
-int main (int argc, const char * argv[]) {
+/*
+ * The startup process for the OSX/Cocoa UI is complicated, because
+ * OSX insists that the UI runs on the initial main thread, and so we
+ * need to start a second thread which runs the vl.c qemu_main():
+ *
+ * Initial thread:                    2nd thread:
+ * in main():
+ *  create qemu-main thread
+ *  wait on display_init semaphore
+ *                                    call qemu_main()
+ *                                    ...
+ *                                    in cocoa_display_init():
+ *                                     post the display_init semaphore
+ *                                     wait on app_started semaphore
+ *  create application, menus, etc
+ *  enter OSX run loop
+ * in applicationDidFinishLaunching:
+ *  post app_started semaphore
+ *                                     tell main thread to fullscreen if needed
+ *                                    [...]
+ *                                    run qemu main-loop
+ *
+ * We do this in two stages so that we don't do the creation of the
+ * GUI application menus and so on for command line options like --help
+ * where we want to just print text to stdout and exit immediately.
+ */
 
+static void *call_qemu_main(void *opaque)
+{
+    int status;
+
+    COCOA_DEBUG("Second thread: calling qemu_main()\n");
+    status = qemu_main(gArgc, gArgv, *_NSGetEnviron());
+    COCOA_DEBUG("Second thread: qemu_main() returned, exiting\n");
+    exit(status);
+}
+
+int main (int argc, const char * argv[]) {
+    QemuThread thread;
+
+    COCOA_DEBUG("Entered main()\n");
     gArgc = argc;
     gArgv = (char **)argv;
-    int i;
 
-    /* In case we don't need to display a window, let's not do that */
-    for (i = 1; i < argc; i++) {
-        const char *opt = argv[i];
+    qemu_sem_init(&display_init_sem, 0);
+    qemu_sem_init(&app_started_sem, 0);
 
-        if (opt[0] == '-') {
-            /* Treat --foo the same as -foo.  */
-            if (opt[1] == '-') {
-                opt++;
-            }
-            if (!strcmp(opt, "-h") || !strcmp(opt, "-help") ||
-                !strcmp(opt, "-vnc") ||
-                !strcmp(opt, "-nographic") ||
-                !strcmp(opt, "-version") ||
-                !strcmp(opt, "-curses") ||
-                !strcmp(opt, "-display") ||
-                !strcmp(opt, "-qtest")) {
-                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
-            }
-        }
-    }
+    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
+                       NULL, QEMU_THREAD_DETACHED);
+
+    COCOA_DEBUG("Main thread: waiting for display_init_sem\n");
+    qemu_sem_wait(&display_init_sem);
+    COCOA_DEBUG("Main thread: initializing app\n");
 
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
@@ -1710,12 +1738,24 @@ int main (int argc, const char * argv[]) {
 
     create_initial_menus();
 
+    /*
+     * Create the menu entries which depend on QEMU state (for consoles
+     * and removeable devices). These make calls back into QEMU functions,
+     * which is OK because at this point we know that the second thread
+     * holds the iothread lock and is synchronously waiting for us to
+     * finish.
+     */
+    add_console_menu_entries();
+    addRemovableDevicesMenuItems();
+
     // Create an Application controller
     QemuCocoaAppController *appController = [[QemuCocoaAppController alloc] init];
     [NSApp setDelegate:appController];
 
     // Start the main event loop
+    COCOA_DEBUG("Main thread: entering OSX run loop\n");
     [NSApp run];
+    COCOA_DEBUG("Main thread: left OSX run loop, exiting\n");
 
     [appController release];
     [pool release];
@@ -1733,17 +1773,19 @@ static void cocoa_update(DisplayChangeListener *dcl,
 
     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
 
-    NSRect rect;
-    if ([cocoaView cdx] == 1.0) {
-        rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
-    } else {
-        rect = NSMakeRect(
-            x * [cocoaView cdx],
-            ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
-            w * [cocoaView cdx],
-            h * [cocoaView cdy]);
-    }
-    [cocoaView setNeedsDisplayInRect:rect];
+    dispatch_async(dispatch_get_main_queue(), ^{
+        NSRect rect;
+        if ([cocoaView cdx] == 1.0) {
+            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
+        } else {
+            rect = NSMakeRect(
+                x * [cocoaView cdx],
+                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
+                w * [cocoaView cdx],
+                h * [cocoaView cdy]);
+        }
+        [cocoaView setNeedsDisplayInRect:rect];
+    });
 
     [pool release];
 }
@@ -1752,9 +1794,19 @@ static void cocoa_switch(DisplayChangeListener *dcl,
                          DisplaySurface *surface)
 {
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
+    pixman_image_t *image = surface->image;
 
     COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
-    [cocoaView switchSurface:surface->image];
+
+    // The DisplaySurface will be freed as soon as this callback returns.
+    // We take a reference to the underlying pixman image here so it does
+    // not disappear from under our feet; the switchSurface method will
+    // deref the old image when it is done with it.
+    pixman_image_ref(image);
+
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView switchSurface:image];
+    });
     [pool release];
 }
 
@@ -1766,26 +1818,15 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     graphic_hw_update(NULL);
 
     if (qemu_input_is_absolute()) {
-        if (![cocoaView isAbsoluteEnabled]) {
-            if ([cocoaView isMouseGrabbed]) {
-                [cocoaView ungrabMouse];
+        dispatch_async(dispatch_get_main_queue(), ^{
+            if (![cocoaView isAbsoluteEnabled]) {
+                if ([cocoaView isMouseGrabbed]) {
+                    [cocoaView ungrabMouse];
+                }
             }
-        }
-        [cocoaView setAbsoluteEnabled:YES];
+            [cocoaView setAbsoluteEnabled:YES];
+        });
     }
-
-    NSDate *distantPast;
-    NSEvent *event;
-    distantPast = [NSDate distantPast];
-    do {
-        event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
-                        inMode: NSDefaultRunLoopMode dequeue:YES];
-        if (event != nil) {
-            if (![cocoaView handleEvent:event]) {
-                [NSApp sendEvent:event];
-            }
-        }
-    } while(event != nil);
     [pool release];
 }
 
@@ -1806,10 +1847,17 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
 
+    /* Tell main thread to go ahead and create the app and enter the run loop */
+    qemu_sem_post(&display_init_sem);
+    qemu_sem_wait(&app_started_sem);
+    COCOA_DEBUG("cocoa_display_init: app start completed\n");
+
     /* if fullscreen mode is to be used */
     if (opts->has_full_screen && opts->full_screen) {
-        [NSApp activateIgnoringOtherApps: YES];
-        [(QemuCocoaAppController *)[[NSApplication sharedApplication] delegate] toggleFullScreen: nil];
+        dispatch_async(dispatch_get_main_queue(), ^{
+            [NSApp activateIgnoringOtherApps: YES];
+            [(QemuCocoaAppController *)[[NSApplication sharedApplication] delegate] toggleFullScreen: nil];
+        });
     }
 
     dcl = g_malloc0(sizeof(DisplayChangeListener));
@@ -1820,17 +1868,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     // register cleanup function
     atexit(cocoa_cleanup);
-
-    /* At this point QEMU has created all the consoles, so we can add View
-     * menu entries for them.
-     */
-    add_console_menu_entries();
-
-    /* Give all removable devices a menu item.
-     * Has to be called after QEMU has started to
-     * find out what removable devices it has.
-     */
-    addRemovableDevicesMenuItems();
 }
 
 static QemuDisplay qemu_display_cocoa = {
-- 
2.20.1
