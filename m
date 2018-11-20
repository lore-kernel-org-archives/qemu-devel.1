Received: from eggs.gnu.org ([2001:4830:134:3::10]:58986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5df-0002yL-3w
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP5dZ-0002up-Nr
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:00:23 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP5dZ-0002u5-9O
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:00:17 -0500
Received: by mail-ot1-x343.google.com with SMTP id u3so1550995ota.5
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 05:00:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
References: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 12:59:53 +0000
Message-ID: <CAFEAcA983Q16B8y1j3msg31BtM5LXhUcB5ouyg6Dp1y-aUaDpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Berkus Decker <berkus@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 November 2018 at 21:24, Berkus Decker <berkus@gmail.com> wrote:
> It seems that Cocoa checks are stricter on Mojave and some callbacks that=
 worked from non-GUI thread on High Sierra are no longer working.
>
> The fixes included here are:
>
> * Deferring qemu_main() to another thread so that the actual main thread =
is reserved for the Cocoa UI; it also removes blocking from applicationDidF=
inishLoading: delegate. I beleive this alone caused complete UI blockage on=
 Mojave.
> * Deferring UI-related updates in callbacks to the UI thread using invoke=
OnMainThread helper function. This function uses DDInvocationGrabber object=
 courtesy of Dave Dribin, licensed under MIT license.
> Here=E2=80=99s relevant blog post for his code: https://www.dribin.org/da=
ve/blog/archives/2008/05/22/invoke_on_main_thread/
>
> NSInvocation is used here instead of plain performSelectorOnMainThread:wi=
thObject:waitUntilDone: because we want to be able to pass non-id types to =
the handlers.
>
> These changes are ought to work on OSX 10.6, although I don=E2=80=99t hav=
e a machine handy to test it.
>
> Fixes https://bugs.launchpad.net/qemu/+bug/1802684

Hi; thanks for these patches. I haven't tried running them yet
(I should be able to get to that tomorrow) I have done a compile
test on High Sierra. I have some code review comments below:

> From 8f86e30f3710d782d78dccdbe7a1564ae79220c7 Mon Sep 17 00:00:00 2001
> From: Berkus Decker <berkus+github@metta.systems>
> Date: Sun, 11 Nov 2018 21:58:17 +0200
> Subject: [PATCH 1/2] ui/cocoa: Defer qemu to another thread, leaving main
>  thread for the UI
>
> This prevents blocking in applicationDidFinishLoading: which is
> not recommended and now causes complete UI lock on macOS Mojave.
>
> Signed-off-by: Berkus Decker <berkus+github@metta.systems>

If you could send your patchset in git format-patch style as
multiple emails (a cover letter, and each patch in the series
a followup to the cover letter) that would be helpful, as
our patch-handling tooling assumes that setup. But if not
I can manually sort things out at my end.

> ---
>  ui/cocoa.m | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index ecf12bfc2e..f69f7105f2 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1089,9 +1089,13 @@ QemuCocoaView *cocoaView;
>  {
>      COCOA_DEBUG("QemuCocoaAppController: startEmulationWithArgc\n");
>
> -    int status;
> -    status =3D qemu_main(argc, argv, *_NSGetEnviron());
> -    exit(status);
> +    dispatch_queue_t qemu_runner =3D dispatch_queue_create("qemu-runner"=
, DISPATCH_QUEUE_SERIAL);

I suspect this won't compile on 10.6:
https://developer.apple.com/documentation/dispatch/1453030-dispatch_queue_c=
reate
says that DISPATCH_QUEUE_SERIAL is 10.7 or later and earlier
versions need to pass NULL.

> +
> +    dispatch_async(qemu_runner, ^{
> +        int status;
> +        status =3D qemu_main(argc, argv, *_NSGetEnviron());
> +        exit(status);
> +    });
>  }
>
>  /* We abstract the method called by the Enter Fullscreen menu item
> --
> 2.18.0
>
>
> From 467b0f67d94616ef98d2ec1e8d16eeb5e9506b4e Mon Sep 17 00:00:00 2001
> From: Berkus Decker <berkus+github@metta.systems>
> Date: Sun, 11 Nov 2018 20:22:01 +0200
> Subject: [PATCH 2/2] ui/cocoa: Fix UI crashes on macOS Mojave
>
> Signed-off-by: Berkus Decker <berkus+github@metta.systems>
> ---
>  ui/DDInvocationGrabber.h | 124 ++++++++++++++++++++++++++++
>  ui/DDInvocationGrabber.m | 171 +++++++++++++++++++++++++++++++++++++++
>  ui/Makefile.objs         |   2 +-
>  ui/cocoa.m               |  57 ++++++++-----
>  4 files changed, 333 insertions(+), 21 deletions(-)
>  create mode 100644 ui/DDInvocationGrabber.h
>  create mode 100644 ui/DDInvocationGrabber.m

I think it would be good to separate out this commit into two:
 * ui/cocoa: Add Dave Drivbin's DDInvocationGrabber
   (which would add the two new files and change ui/Makefile.objs
   to compile the .m file)
 * ui/cocoa: Fix UI crashes on macOS Mojave
   (which just has the ui/cocoa.m changes)

Then we have one patch whose review is just "check the license"
and one patch which is the parts that require review of the code.

(If we were willing to drop support for OSX before 10.10
we could use dispatch_sync(dispatch_get_main_queue(), ...).
Thanks for finding this bit of code to keep things working
for 10.6. It does feel a little heavyweight but on the other
hand it's existing working code.)

> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index f69f7105f2..41aa7524d8 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -38,6 +38,8 @@
>  #include <Carbon/Carbon.h>
>  #include "qom/cpu.h"
>
> +#import "DDInvocationGrabber.h"
> +
>  #ifndef MAC_OS_X_VERSION_10_5
>  #define MAC_OS_X_VERSION_10_5 1050
>  #endif
> @@ -314,6 +316,8 @@ static void handleAnyDeviceErrors(Error * err)
>  - (float) cdy;
>  - (QEMUScreen) gscreen;
>  - (void) raiseAllKeys;
> +- (void) refresh;
> +- (id) invokeOnMainThread;
>  @end
>
>  QemuCocoaView *cocoaView;
> @@ -345,6 +349,14 @@ QemuCocoaView *cocoaView;
>      [super dealloc];
>  }
>
> +- (id) invokeOnMainThread
> +{
> +    DDInvocationGrabber * grabber =3D [DDInvocationGrabber invocationGra=
bber];
> +    [grabber setForwardInvokesOnMainThread:YES];
> +    [grabber setWaitUntilDone:YES];
> +    return [grabber prepareWithInvocationTarget:self];
> +}
> +
>  - (BOOL) isOpaque
>  {
>      return YES;
> @@ -509,6 +521,28 @@ QemuCocoaView *cocoaView;
>      }
>  }
>
> +- (void) refresh
> +{
> +    if (qemu_input_is_absolute()) {
> +        if (![self isAbsoluteEnabled]) {
> +            if ([self isMouseGrabbed]) {
> +                [self ungrabMouse];
> +            }
> +        }
> +        [self setAbsoluteEnabled:YES];
> +    }
> +
> +    NSDate *distantPast =3D [NSDate distantPast];
> +    NSEvent *event;
> +    do {
> +        event =3D [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:=
distantPast
> +                        inMode: NSDefaultRunLoopMode dequeue:YES];
> +        if (event !=3D nil) {
> +            [self handleEvent:event];
> +        }
> +    } while(event !=3D nil);
> +}
> +
>  - (void) toggleFullScreen:(id)sender
>  {
>      COCOA_DEBUG("QemuCocoaView: toggleFullScreen\n");
> @@ -1566,7 +1600,7 @@ static void cocoa_update(DisplayChangeListener *dcl=
,
>              w * [cocoaView cdx],
>              h * [cocoaView cdy]);
>      }
> -    [cocoaView setNeedsDisplayInRect:rect];
> +    [[cocoaView invokeOnMainThread] setNeedsDisplayInRect:rect];

Isn't there a race condition here? You've left the code
which calculates the rectangle size in the cocoa_update()
function, but it looks at properties like [cocoaView cdx]
which can be changed by user interactions like window resizing.
I think it would be better to push everything into the main
thread, so that "update screen" is atomic with respect to other
UI operations that might affect the screen coordinates.

We had this race before, of course, since the old cocoa_update()
ran on a different thread to the main event loop; but we have
the opportunity to fix it since we're pushing the code into
the main thread now.

>      [pool release];
>  }
> @@ -1577,7 +1611,7 @@ static void cocoa_switch(DisplayChangeListener *dcl=
,
>      NSAutoreleasePool * pool =3D [[NSAutoreleasePool alloc] init];
>
>      COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
> -    [cocoaView switchSurface:surface];
> +    [[cocoaView invokeOnMainThread] switchSurface:surface];
>      [pool release];
>  }
>
> @@ -1588,25 +1622,8 @@ static void cocoa_refresh(DisplayChangeListener *d=
cl)
>      COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
>      graphic_hw_update(NULL);
>
> -    if (qemu_input_is_absolute()) {
> -        if (![cocoaView isAbsoluteEnabled]) {
> -            if ([cocoaView isMouseGrabbed]) {
> -                [cocoaView ungrabMouse];
> -            }
> -        }
> -        [cocoaView setAbsoluteEnabled:YES];
> -    }
> +    [[cocoaView invokeOnMainThread] refresh];
>
> -    NSDate *distantPast;
> -    NSEvent *event;
> -    distantPast =3D [NSDate distantPast];
> -    do {
> -        event =3D [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:=
distantPast
> -                        inMode: NSDefaultRunLoopMode dequeue:YES];
> -        if (event !=3D nil) {
> -            [cocoaView handleEvent:event];
> -        }
> -    } while(event !=3D nil);
>      [pool release];
>  }
>
> --
> 2.18.0

thanks
-- PMM
