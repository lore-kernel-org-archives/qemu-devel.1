Received: from eggs.gnu.org ([209.51.188.92]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRnV-0001Rv-AT
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guRnT-0001Yx-Ap
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:56:09 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:16053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guRnO-0001Rg-KV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:56:05 -0500
Date: Fri, 15 Feb 2019 01:55:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190214102816.3393-8-peter.maydell@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1902150142410.41761@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-8-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 7/7] ui/cocoa: Perform UI operations
 only on the main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Thu, 14 Feb 2019, Peter Maydell wrote:
> The OSX Mojave release is more picky about enforcing the Cocoa API
> restriction that only the main thread may perform UI calls. To
> accommodate this we need to restructure the Cocoa code:
> * the special OSX main() creates a second thread and uses
>   that to call the vl.c qemu_main(); the original main
>   thread goes into the OSX event loop
> * the refresh, switch and update callbacks asynchronously
>   tell the main thread to do the necessary work
> * the refresh callback no longer does the "get events from the
>   UI event queue and handle them" loop, since we now use
>   the stock OSX event loop. Instead our NSApplication sendEvent
>   method will either deal with them or pass them on to OSX
>
> All these things have to be changed in one commit, to avoid
> breaking bisection.
>
> Note that since we use dispatch_get_main_queue(), this bumps
> our minimum version requirement to OSX 10.10 Yosemite (released
> in 2014, unsupported by Apple since 2017).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2 changes: call handleEvent from sendEvent

There's still something not right I'm afraid. After this menus stop 
working for me (they don't react to mouse although keyboard short-cuts are 
still working) but I don't know how to fix this. I could also reproduce a 
stuck modifier key problem but not sure if that's preexisting and probably 
obscure enough in itself to not hold back this series if the menu problem 
is fixed. I'm just documenting it here for later debugging:

1. start qemu-system-ppc -M mac99 (or maybe other but that's what I've tried)
2. Switch to monitor with Ctrl-Alt-2
3. Switch to full screen with Cmd-F
4. type to verify it works
5. Still in full screen, switch to main screen with Ctrl-Alt-1
6. Now sometimes Alt seems to be stuck even after exiting full screen

I'm also sending another patch on top of this series that brings the app 
to the front to avoid it starting behind the active Terminal window when 
started from the command line that has annoyed me in the past.

Regards,
BALATON Zoltan

> ---
> ui/cocoa.m | 191 +++++++++++++++++++++++++++++++----------------------
> 1 file changed, 113 insertions(+), 78 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 184fbd877d..201a294ed4 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -129,6 +129,9 @@
> NSTextField *pauseLabel;
> NSArray * supportedImageFileTypes;
>
> +QemuSemaphore display_init_sem;
> +QemuSemaphore app_started_sem;
> +
> // Utility functions to run specified code block with iothread lock held
> typedef void (^CodeBlock)(void);
> typedef bool (^BoolCodeBlock)(void);
> @@ -325,6 +328,7 @@ @interface QemuCocoaView : NSView
>     NSWindow *fullScreenWindow;
>     float cx,cy,cw,ch,cdx,cdy;
>     CGDataProviderRef dataProviderRef;
> +    pixman_image_t *pixman_image;
>     BOOL modifiers_state[256];
>     BOOL isMouseGrabbed;
>     BOOL isFullscreen;
> @@ -535,13 +539,16 @@ - (void) switchSurface:(pixman_image_t *)image
>     }
>
>     // update screenBuffer
> -    if (dataProviderRef)
> +    if (dataProviderRef) {
>         CGDataProviderRelease(dataProviderRef);
> +        pixman_image_unref(pixman_image);
> +    }
>
>     //sync host window color space with guests
>     screen.bitsPerPixel = PIXMAN_FORMAT_BPP(image_format);
>     screen.bitsPerComponent = DIV_ROUND_UP(screen.bitsPerPixel, 8) * 2;
>
> +    pixman_image = image;
>     dataProviderRef = CGDataProviderCreateWithData(NULL, pixman_image_get_data(image), w * 4 * h, NULL);
>
>     // update windows
> @@ -1013,7 +1020,6 @@ @interface QemuCocoaAppController : NSObject
> #endif
> {
> }
> -- (void)startEmulationWithArgc:(int)argc argv:(char**)argv;
> - (void)doToggleFullScreen:(id)sender;
> - (void)toggleFullScreen:(id)sender;
> - (void)showQEMUDoc:(id)sender;
> @@ -1101,8 +1107,8 @@ - (void) dealloc
> - (void)applicationDidFinishLaunching: (NSNotification *) note
> {
>     COCOA_DEBUG("QemuCocoaAppController: applicationDidFinishLaunching\n");
> -    // launch QEMU, with the global args
> -    [self startEmulationWithArgc:gArgc argv:(char **)gArgv];
> +    /* Tell cocoa_display_init to proceed */
> +    qemu_sem_post(&app_started_sem);
> }
>
> - (void)applicationWillTerminate:(NSNotification *)aNotification
> @@ -1145,15 +1151,6 @@ - (void) applicationWillResignActive: (NSNotification *)aNotification
>     [cocoaView raiseAllKeys];
> }
>
> -- (void)startEmulationWithArgc:(int)argc argv:(char**)argv
> -{
> -    COCOA_DEBUG("QemuCocoaAppController: startEmulationWithArgc\n");
> -
> -    int status;
> -    status = qemu_main(argc, argv, *_NSGetEnviron());
> -    exit(status);
> -}
> -
> /* We abstract the method called by the Enter Fullscreen menu item
>  * because Mac OS 10.7 and higher disables it. This is because of the
>  * menu item's old selector's name toggleFullScreen:
> @@ -1485,7 +1482,9 @@ @implementation QemuApplication
> - (void)sendEvent:(NSEvent *)event
> {
>     COCOA_DEBUG("QemuApplication: sendEvent\n");
> -    [super sendEvent: event];
> +    if (!cocoaView || ![cocoaView handleEvent:event]) {
> +        [super sendEvent: event];
> +    }
> }
> @end
>
> @@ -1668,32 +1667,59 @@ static void addRemovableDevicesMenuItems(void)
>     qapi_free_BlockInfoList(pointerToFree);
> }
>
> -int main (int argc, const char * argv[]) {
> +/*
> + * The startup process for the OSX/Cocoa UI is complicated, because
> + * OSX insists that the UI runs on the initial main thread, and so we
> + * need to start a second thread which runs the vl.c qemu_main():
> + *
> + * Initial thread:                    2nd thread:
> + * in main():
> + *  create qemu-main thread
> + *  wait on display_init semaphore
> + *                                    call qemu_main()
> + *                                    ...
> + *                                    in cocoa_display_init():
> + *                                     post the display_init semaphore
> + *                                     wait on app_started semaphore
> + *  create application, menus, etc
> + *  enter OSX run loop
> + * in applicationDidFinishLaunching:
> + *  post app_started semaphore
> + *                                     tell main thread to fullscreen if needed
> + *                                    [...]
> + *                                    run qemu main-loop
> + *
> + * We do this in two stages so that we don't do the creation of the
> + * GUI application menus and so on for command line options like --help
> + * where we want to just print text to stdout and exit immediately.
> + */
>
> +static void *call_qemu_main(void *opaque)
> +{
> +    int status;
> +
> +    COCOA_DEBUG("Second thread: calling qemu_main()\n");
> +    status = qemu_main(gArgc, gArgv, *_NSGetEnviron());
> +    COCOA_DEBUG("Second thread: qemu_main() returned, exiting\n");
> +    exit(status);
> +}
> +
> +int main (int argc, const char * argv[]) {
> +    QemuThread thread;
> +
> +    COCOA_DEBUG("Entered main()\n");
>     gArgc = argc;
>     gArgv = (char **)argv;
> -    int i;
>
> -    /* In case we don't need to display a window, let's not do that */
> -    for (i = 1; i < argc; i++) {
> -        const char *opt = argv[i];
> +    qemu_sem_init(&display_init_sem, 0);
> +    qemu_sem_init(&app_started_sem, 0);
>
> -        if (opt[0] == '-') {
> -            /* Treat --foo the same as -foo.  */
> -            if (opt[1] == '-') {
> -                opt++;
> -            }
> -            if (!strcmp(opt, "-h") || !strcmp(opt, "-help") ||
> -                !strcmp(opt, "-vnc") ||
> -                !strcmp(opt, "-nographic") ||
> -                !strcmp(opt, "-version") ||
> -                !strcmp(opt, "-curses") ||
> -                !strcmp(opt, "-display") ||
> -                !strcmp(opt, "-qtest")) {
> -                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
> -            }
> -        }
> -    }
> +    qemu_thread_create(&thread, "qemu_main", call_qemu_main,
> +                       NULL, QEMU_THREAD_DETACHED);
> +
> +    COCOA_DEBUG("Main thread: waiting for display_init_sem\n");
> +    qemu_sem_wait(&display_init_sem);
> +    COCOA_DEBUG("Main thread: initializing app\n");
>
>     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
>
> @@ -1706,12 +1732,24 @@ int main (int argc, const char * argv[]) {
>
>     create_initial_menus();
>
> +    /*
> +     * Create the menu entries which depend on QEMU state (for consoles
> +     * and removeable devices). These make calls back into QEMU functions,
> +     * which is OK because at this point we know that the second thread
> +     * holds the iothread lock and is synchronously waiting for us to
> +     * finish.
> +     */
> +    add_console_menu_entries();
> +    addRemovableDevicesMenuItems();
> +
>     // Create an Application controller
>     QemuCocoaAppController *appController = [[QemuCocoaAppController alloc] init];
>     [NSApp setDelegate:appController];
>
>     // Start the main event loop
> +    COCOA_DEBUG("Main thread: entering OSX run loop\n");
>     [NSApp run];
> +    COCOA_DEBUG("Main thread: left OSX run loop, exiting\n");
>
>     [appController release];
>     [pool release];
> @@ -1729,17 +1767,19 @@ static void cocoa_update(DisplayChangeListener *dcl,
>
>     COCOA_DEBUG("qemu_cocoa: cocoa_update\n");
>
> -    NSRect rect;
> -    if ([cocoaView cdx] == 1.0) {
> -        rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
> -    } else {
> -        rect = NSMakeRect(
> -            x * [cocoaView cdx],
> -            ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
> -            w * [cocoaView cdx],
> -            h * [cocoaView cdy]);
> -    }
> -    [cocoaView setNeedsDisplayInRect:rect];
> +    dispatch_async(dispatch_get_main_queue(), ^{
> +        NSRect rect;
> +        if ([cocoaView cdx] == 1.0) {
> +            rect = NSMakeRect(x, [cocoaView gscreen].height - y - h, w, h);
> +        } else {
> +            rect = NSMakeRect(
> +                x * [cocoaView cdx],
> +                ([cocoaView gscreen].height - y - h) * [cocoaView cdy],
> +                w * [cocoaView cdx],
> +                h * [cocoaView cdy]);
> +        }
> +        [cocoaView setNeedsDisplayInRect:rect];
> +    });
>
>     [pool release];
> }
> @@ -1748,9 +1788,19 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>                          DisplaySurface *surface)
> {
>     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
> +    pixman_image_t *image = surface->image;
>
>     COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
> -    [cocoaView switchSurface:surface->image];
> +
> +    // The DisplaySurface will be freed as soon as this callback returns.
> +    // We take a reference to the underlying pixman image here so it does
> +    // not disappear from under our feet; the switchSurface method will
> +    // deref the old image when it is done with it.
> +    pixman_image_ref(image);
> +
> +    dispatch_async(dispatch_get_main_queue(), ^{
> +        [cocoaView switchSurface:image];
> +    });
>     [pool release];
> }
>
> @@ -1762,26 +1812,15 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
>     graphic_hw_update(NULL);
>
>     if (qemu_input_is_absolute()) {
> -        if (![cocoaView isAbsoluteEnabled]) {
> -            if ([cocoaView isMouseGrabbed]) {
> -                [cocoaView ungrabMouse];
> +        dispatch_async(dispatch_get_main_queue(), ^{
> +            if (![cocoaView isAbsoluteEnabled]) {
> +                if ([cocoaView isMouseGrabbed]) {
> +                    [cocoaView ungrabMouse];
> +                }
>             }
> -        }
> -        [cocoaView setAbsoluteEnabled:YES];
> +            [cocoaView setAbsoluteEnabled:YES];
> +        });
>     }
> -
> -    NSDate *distantPast;
> -    NSEvent *event;
> -    distantPast = [NSDate distantPast];
> -    do {
> -        event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
> -                        inMode: NSDefaultRunLoopMode dequeue:YES];
> -        if (event != nil) {
> -            if (![cocoaView handleEvent:event]) {
> -                [NSApp sendEvent:event];
> -            }
> -        }
> -    } while(event != nil);
>     [pool release];
> }
>
> @@ -1802,10 +1841,17 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
> {
>     COCOA_DEBUG("qemu_cocoa: cocoa_display_init\n");
>
> +    /* Tell main thread to go ahead and create the app and enter the run loop */
> +    qemu_sem_post(&display_init_sem);
> +    qemu_sem_wait(&app_started_sem);
> +    COCOA_DEBUG("cocoa_display_init: app start completed\n");
> +
>     /* if fullscreen mode is to be used */
>     if (opts->has_full_screen && opts->full_screen) {
> -        [NSApp activateIgnoringOtherApps: YES];
> -        [(QemuCocoaAppController *)[[NSApplication sharedApplication] delegate] toggleFullScreen: nil];
> +        dispatch_async(dispatch_get_main_queue(), ^{
> +            [NSApp activateIgnoringOtherApps: YES];
> +            [(QemuCocoaAppController *)[[NSApplication sharedApplication] delegate] toggleFullScreen: nil];
> +        });
>     }
>
>     dcl = g_malloc0(sizeof(DisplayChangeListener));
> @@ -1816,17 +1862,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>
>     // register cleanup function
>     atexit(cocoa_cleanup);
> -
> -    /* At this point QEMU has created all the consoles, so we can add View
> -     * menu entries for them.
> -     */
> -    add_console_menu_entries();
> -
> -    /* Give all removable devices a menu item.
> -     * Has to be called after QEMU has started to
> -     * find out what removable devices it has.
> -     */
> -    addRemovableDevicesMenuItems();
> }
>
> static QemuDisplay qemu_display_cocoa = {
>
