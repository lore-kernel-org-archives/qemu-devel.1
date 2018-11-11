Received: from eggs.gnu.org ([2001:4830:134:3::10]:57700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berkus@gmail.com>) id 1gLxEB-0006cK-Kp
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berkus@gmail.com>) id 1gLxE7-0008Gc-BM
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:25:07 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:33311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berkus@gmail.com>) id 1gLxE4-0008Ee-Pb
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:25:01 -0500
Received: by mail-lf1-x136.google.com with SMTP id i26so4808034lfc.0
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 13:25:00 -0800 (PST)
Received: from [192.168.0.86] (82.131.104.87.cable.starman.ee. [82.131.104.87])
	by smtp.gmail.com with ESMTPSA id
	w193sm2680117lff.24.2018.11.11.13.24.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 11 Nov 2018 13:24:57 -0800 (PST)
From: Berkus Decker <berkus@gmail.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_82AA19C8-CCF0-4176-B867-55568E4B92AC"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <D965412A-A975-4660-BEC5-6FBF34E35C45@gmail.com>
Date: Sun, 11 Nov 2018 23:24:56 +0200
Subject: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on macOS
 Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


--Apple-Mail=_82AA19C8-CCF0-4176-B867-55568E4B92AC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

It seems that Cocoa checks are stricter on Mojave and some callbacks =
that worked from non-GUI thread on High Sierra are no longer working.

The fixes included here are:

* Deferring qemu_main() to another thread so that the actual main thread =
is reserved for the Cocoa UI; it also removes blocking from =
applicationDidFinishLoading: delegate. I beleive this alone caused =
complete UI blockage on Mojave.
* Deferring UI-related updates in callbacks to the UI thread using =
invokeOnMainThread helper function. This function uses =
DDInvocationGrabber object courtesy of Dave Dribin, licensed under MIT =
license.
Here=E2=80=99s relevant blog post for his code: =
https://www.dribin.org/dave/blog/archives/2008/05/22/invoke_on_main_thread=
/

NSInvocation is used here instead of plain =
performSelectorOnMainThread:withObject:waitUntilDone: because we want to =
be able to pass non-id types to the handlers.

These changes are ought to work on OSX 10.6, although I don=E2=80=99t =
have a machine handy to test it.

Fixes https://bugs.launchpad.net/qemu/+bug/1802684

=46rom 8f86e30f3710d782d78dccdbe7a1564ae79220c7 Mon Sep 17 00:00:00 2001
From: Berkus Decker <berkus+github@metta.systems>
Date: Sun, 11 Nov 2018 21:58:17 +0200
Subject: [PATCH 1/2] ui/cocoa: Defer qemu to another thread, leaving =
main
 thread for the UI

This prevents blocking in applicationDidFinishLoading: which is
not recommended and now causes complete UI lock on macOS Mojave.

Signed-off-by: Berkus Decker <berkus+github@metta.systems>
---
 ui/cocoa.m | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ecf12bfc2e..f69f7105f2 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1089,9 +1089,13 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaAppController: startEmulationWithArgc\n");
=20
-    int status;
-    status =3D qemu_main(argc, argv, *_NSGetEnviron());
-    exit(status);
+    dispatch_queue_t qemu_runner =3D =
dispatch_queue_create("qemu-runner", DISPATCH_QUEUE_SERIAL);
+
+    dispatch_async(qemu_runner, ^{
+        int status;
+        status =3D qemu_main(argc, argv, *_NSGetEnviron());
+        exit(status);
+    });
 }
=20
 /* We abstract the method called by the Enter Fullscreen menu item
--=20
2.18.0


=46rom 467b0f67d94616ef98d2ec1e8d16eeb5e9506b4e Mon Sep 17 00:00:00 2001
From: Berkus Decker <berkus+github@metta.systems>
Date: Sun, 11 Nov 2018 20:22:01 +0200
Subject: [PATCH 2/2] ui/cocoa: Fix UI crashes on macOS Mojave

Signed-off-by: Berkus Decker <berkus+github@metta.systems>
---
 ui/DDInvocationGrabber.h | 124 ++++++++++++++++++++++++++++
 ui/DDInvocationGrabber.m | 171 +++++++++++++++++++++++++++++++++++++++
 ui/Makefile.objs         |   2 +-
 ui/cocoa.m               |  57 ++++++++-----
 4 files changed, 333 insertions(+), 21 deletions(-)
 create mode 100644 ui/DDInvocationGrabber.h
 create mode 100644 ui/DDInvocationGrabber.m

diff --git a/ui/DDInvocationGrabber.h b/ui/DDInvocationGrabber.h
new file mode 100644
index 0000000000..7218421d74
--- /dev/null
+++ b/ui/DDInvocationGrabber.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (c) 2007-2008 Dave Dribin
+ *
+ * Permission is hereby granted, free of charge, to any person
+ * obtaining a copy of this software and associated documentation
+ * files (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy,
+ * modify, merge, publish, distribute, sublicense, and/or sell copies
+ * of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+ * included in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+
+/*
+ *  This class is based on CInvocationGrabber:
+ *
+ *  Copyright (c) 2007, Toxic Software
+ *  All rights reserved.
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions =
are
+ *  met:
+ *
+ *  * Redistributions of source code must retain the above copyright =
notice,
+ *  this list of conditions and the following disclaimer.
+ *
+ *  * Redistributions in binary form must reproduce the above copyright
+ *  notice, this list of conditions and the following disclaimer in the
+ *  documentation and/or other materials provided with the =
distribution.
+ *
+ *  * Neither the name of the Toxic Software nor the names of its
+ *  contributors may be used to endorse or promote products derived =
from
+ *  this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' =
AND
+ *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, =
THE
+ *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ *  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR =
CONTRIBUTORS BE
+ *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT =
OF
+ *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR =
BUSINESS
+ *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, =
WHETHER IN
+ *  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR =
OTHERWISE)
+ *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED =
OF
+ *  THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#import <Foundation/Foundation.h>
+
+/**
+ * @class DDInvocationGrabber
+ * @discussion DDInvocationGrabber is a helper object that makes it =
very easy
+ * to construct instances of NSInvocation for later use. The object is
+ * inspired by NSUndoManager's prepareWithInvocationTarget method. To =
use
+ * a DDInvocationGrabber object, you set its target to some object, =
then send
+ * it a message as if it were the target object (the =
DDInvocationGrabber object
+ * acts as a proxy), if the target message understands the message the
+ * DDInvocationGrabber object stores the message invocation.
+
+ DDInvocationGrabber *theGrabber =3D [DDInvocationGrabber =
invocationGrabber];
+ [theGrabber setTarget:someObject]
+ // Send messages to 'theGrabber' as if it were 'someObject'
+ [theGrabber doSomethingWithParameter:someParameter];
+ NSInvocation *theInvocation =3D [theGrabber invocation];
+
+ A slightly more concise version (using the covenience category) =
follows:
+
+ DDInvocationGrabber *theGrabber =3D [DDInvocationGrabber =
invocationGrabber];
+ [[theGrabber prepareWithInvocationTarget:someObject]
+    doSomethingWithParameter:someParameter];
+ NSInvocation *theInvocation =3D [theGrabber invocation];
+
+ */
+@interface DDInvocationGrabber : NSProxy
+{
+    id _target;
+    NSInvocation * _invocation;
+    BOOL _forwardInvokesOnMainThread;
+    BOOL _waitUntilDone;
+}
+
+/**
+ * @method invocationGrabber
+ * @abstract Returns a newly allocated, inited, autoreleased
+ * DDInvocationGrabber object.
+ */
++ (id) invocationGrabber;
+
+- (id) target;
+- (void) setTarget:(id)inTarget;
+
+- (NSInvocation *) invocation;
+- (void) setInvocation:(NSInvocation *)inInvocation;
+
+- (BOOL) forwardInvokesOnMainThread;
+- (void) =
setForwardInvokesOnMainThread:(BOOL)forwardInvokesOnMainThread;
+
+- (BOOL) waitUntilDone;
+- (void) setWaitUntilDone:(BOOL)waitUntilDone;
+
+@end
+
+@interface DDInvocationGrabber (DDInvocationGrabber_Conveniences)
+
+/**
+ * @method prepareWithInvocationTarget:
+ * @abstract Sets the target object of the receiver and returns itself.
+ * The sender can then send a message to the receiver.
+ */
+- (id)prepareWithInvocationTarget:(id)inTarget;
+
+@end
diff --git a/ui/DDInvocationGrabber.m b/ui/DDInvocationGrabber.m
new file mode 100644
index 0000000000..297a0b41f5
--- /dev/null
+++ b/ui/DDInvocationGrabber.m
@@ -0,0 +1,171 @@
+/*
+ * Copyright (c) 2007-2008 Dave Dribin
+ *
+ * Permission is hereby granted, free of charge, to any person
+ * obtaining a copy of this software and associated documentation
+ * files (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy,
+ * modify, merge, publish, distribute, sublicense, and/or sell copies
+ * of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+ * included in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+
+/*
+ *  This class is based on CInvocationGrabber:
+ *
+ *  Copyright (c) 2007, Toxic Software
+ *  All rights reserved.
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions =
are
+ *  met:
+ *
+ *  * Redistributions of source code must retain the above copyright =
notice,
+ *  this list of conditions and the following disclaimer.
+ *
+ *  * Redistributions in binary form must reproduce the above copyright
+ *  notice, this list of conditions and the following disclaimer in the
+ *  documentation and/or other materials provided with the =
distribution.
+ *
+ *  * Neither the name of the Toxic Software nor the names of its
+ *  contributors may be used to endorse or promote products derived =
from
+ *  this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' =
AND
+ *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, =
THE
+ *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ *  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR =
CONTRIBUTORS BE
+ *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT =
OF
+ *  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR =
BUSINESS
+ *  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, =
WHETHER IN
+ *  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR =
OTHERWISE)
+ *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED =
OF
+ *  THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+
+#import "DDInvocationGrabber.h"
+
+
+@implementation DDInvocationGrabber
+
++ (id)invocationGrabber
+{
+    return([[[self alloc] init] autorelease]);
+}
+
+- (id)init
+{
+    _target =3D nil;
+    _invocation =3D nil;
+    _forwardInvokesOnMainThread =3D NO;
+    _waitUntilDone =3D NO;
+
+    return self;
+}
+
+- (void)dealloc
+{
+    [self setTarget:NULL];
+    [self setInvocation:NULL];
+    //
+    [super dealloc];
+}
+
+#pragma mark -
+
+- (id)target
+{
+    return _target;
+}
+
+- (void)setTarget:(id)inTarget
+{
+    if (_target !=3D inTarget)
+	{
+        [_target autorelease];
+        _target =3D [inTarget retain];
+	}
+}
+
+- (NSInvocation *)invocation
+{
+    return _invocation;
+}
+
+- (void)setInvocation:(NSInvocation *)inInvocation
+{
+    if (_invocation !=3D inInvocation)
+	{
+        [_invocation autorelease];
+        _invocation =3D [inInvocation retain];
+	}
+}
+
+- (BOOL)forwardInvokesOnMainThread;
+{
+    return _forwardInvokesOnMainThread;
+}
+
+- (void)setForwardInvokesOnMainThread:(BOOL)forwardInvokesOnMainThread;
+{
+    _forwardInvokesOnMainThread =3D forwardInvokesOnMainThread;
+}
+
+- (BOOL)waitUntilDone;
+{
+    return _waitUntilDone;
+}
+
+- (void)setWaitUntilDone:(BOOL)waitUntilDone;
+{
+    _waitUntilDone =3D waitUntilDone;
+}
+
+#pragma mark -
+
+- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
+{
+    return [[self target] methodSignatureForSelector:selector];
+}
+
+- (void)forwardInvocation:(NSInvocation *)ioInvocation
+{
+    [ioInvocation setTarget:[self target]];
+    [self setInvocation:ioInvocation];
+    if (_forwardInvokesOnMainThread)
+    {
+        if (!_waitUntilDone)
+            [_invocation retainArguments];
+        [_invocation performSelectorOnMainThread:@selector(invoke)
+                                      withObject:nil
+                                   waitUntilDone:_waitUntilDone];
+    }
+}
+
+@end
+
+#pragma mark -
+
+@implementation DDInvocationGrabber (DDnvocationGrabber_Conveniences)
+
+- (id)prepareWithInvocationTarget:(id)inTarget
+{
+    [self setTarget:inTarget];
+    return(self);
+}
+
+@end
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 00f6976c30..bd9983232f 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -11,7 +11,7 @@ common-obj-y +=3D keymaps.o console.o cursor.o =
qemu-pixman.o
 common-obj-y +=3D input.o input-keymap.o input-legacy.o
 common-obj-$(CONFIG_LINUX) +=3D input-linux.o
 common-obj-$(CONFIG_SPICE) +=3D spice-core.o spice-input.o =
spice-display.o
-common-obj-$(CONFIG_COCOA) +=3D cocoa.o
+common-obj-$(CONFIG_COCOA) +=3D cocoa.o DDInvocationGrabber.o
 common-obj-$(CONFIG_VNC) +=3D $(vnc-obj-y)
 common-obj-$(call lnot,$(CONFIG_VNC)) +=3D vnc-stubs.o
=20
diff --git a/ui/cocoa.m b/ui/cocoa.m
index f69f7105f2..41aa7524d8 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -38,6 +38,8 @@
 #include <Carbon/Carbon.h>
 #include "qom/cpu.h"
=20
+#import "DDInvocationGrabber.h"
+
 #ifndef MAC_OS_X_VERSION_10_5
 #define MAC_OS_X_VERSION_10_5 1050
 #endif
@@ -314,6 +316,8 @@ static void handleAnyDeviceErrors(Error * err)
 - (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
+- (void) refresh;
+- (id) invokeOnMainThread;
 @end
=20
 QemuCocoaView *cocoaView;
@@ -345,6 +349,14 @@ QemuCocoaView *cocoaView;
     [super dealloc];
 }
=20
+- (id) invokeOnMainThread
+{
+    DDInvocationGrabber * grabber =3D [DDInvocationGrabber =
invocationGrabber];
+    [grabber setForwardInvokesOnMainThread:YES];
+    [grabber setWaitUntilDone:YES];
+    return [grabber prepareWithInvocationTarget:self];
+}
+
 - (BOOL) isOpaque
 {
     return YES;
@@ -509,6 +521,28 @@ QemuCocoaView *cocoaView;
     }
 }
=20
+- (void) refresh
+{
+    if (qemu_input_is_absolute()) {
+        if (![self isAbsoluteEnabled]) {
+            if ([self isMouseGrabbed]) {
+                [self ungrabMouse];
+            }
+        }
+        [self setAbsoluteEnabled:YES];
+    }
+
+    NSDate *distantPast =3D [NSDate distantPast];
+    NSEvent *event;
+    do {
+        event =3D [NSApp nextEventMatchingMask:NSEventMaskAny =
untilDate:distantPast
+                        inMode: NSDefaultRunLoopMode dequeue:YES];
+        if (event !=3D nil) {
+            [self handleEvent:event];
+        }
+    } while(event !=3D nil);
+}
+
 - (void) toggleFullScreen:(id)sender
 {
     COCOA_DEBUG("QemuCocoaView: toggleFullScreen\n");
@@ -1566,7 +1600,7 @@ static void cocoa_update(DisplayChangeListener =
*dcl,
             w * [cocoaView cdx],
             h * [cocoaView cdy]);
     }
-    [cocoaView setNeedsDisplayInRect:rect];
+    [[cocoaView invokeOnMainThread] setNeedsDisplayInRect:rect];
=20
     [pool release];
 }
@@ -1577,7 +1611,7 @@ static void cocoa_switch(DisplayChangeListener =
*dcl,
     NSAutoreleasePool * pool =3D [[NSAutoreleasePool alloc] init];
=20
     COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
-    [cocoaView switchSurface:surface];
+    [[cocoaView invokeOnMainThread] switchSurface:surface];
     [pool release];
 }
=20
@@ -1588,25 +1622,8 @@ static void cocoa_refresh(DisplayChangeListener =
*dcl)
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
     graphic_hw_update(NULL);
=20
-    if (qemu_input_is_absolute()) {
-        if (![cocoaView isAbsoluteEnabled]) {
-            if ([cocoaView isMouseGrabbed]) {
-                [cocoaView ungrabMouse];
-            }
-        }
-        [cocoaView setAbsoluteEnabled:YES];
-    }
+    [[cocoaView invokeOnMainThread] refresh];
=20
-    NSDate *distantPast;
-    NSEvent *event;
-    distantPast =3D [NSDate distantPast];
-    do {
-        event =3D [NSApp nextEventMatchingMask:NSEventMaskAny =
untilDate:distantPast
-                        inMode: NSDefaultRunLoopMode dequeue:YES];
-        if (event !=3D nil) {
-            [cocoaView handleEvent:event];
-        }
-    } while(event !=3D nil);
     [pool release];
 }
=20
--=20
2.18.0


--Apple-Mail=_82AA19C8-CCF0-4176-B867-55568E4B92AC
Content-Disposition: attachment;
	filename=0001-ui-cocoa-Defer-qemu-to-another-thread-leaving-main-t.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-ui-cocoa-Defer-qemu-to-another-thread-leaving-main-t.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=208f86e30f3710d782d78dccdbe7a1564ae79220c7=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Berkus=20Decker=20=
<berkus+github@metta.systems>=0ADate:=20Sun,=2011=20Nov=202018=20=
21:58:17=20+0200=0ASubject:=20[PATCH=201/2]=20ui/cocoa:=20Defer=20qemu=20=
to=20another=20thread,=20leaving=20main=0A=20thread=20for=20the=20UI=0A=0A=
This=20prevents=20blocking=20in=20applicationDidFinishLoading:=20which=20=
is=0Anot=20recommended=20and=20now=20causes=20complete=20UI=20lock=20on=20=
macOS=20Mojave.=0A=0ASigned-off-by:=20Berkus=20Decker=20=
<berkus+github@metta.systems>=0A---=0A=20ui/cocoa.m=20|=2010=20=
+++++++---=0A=201=20file=20changed,=207=20insertions(+),=203=20=
deletions(-)=0A=0Adiff=20--git=20a/ui/cocoa.m=20b/ui/cocoa.m=0Aindex=20=
ecf12bfc2e..f69f7105f2=20100644=0A---=20a/ui/cocoa.m=0A+++=20=
b/ui/cocoa.m=0A@@=20-1089,9=20+1089,13=20@@=20QemuCocoaView=20=
*cocoaView;=0A=20{=0A=20=20=20=20=20COCOA_DEBUG("QemuCocoaAppController:=20=
startEmulationWithArgc\n");=0A=20=0A-=20=20=20=20int=20status;=0A-=20=20=20=
=20status=20=3D=20qemu_main(argc,=20argv,=20*_NSGetEnviron());=0A-=20=20=20=
=20exit(status);=0A+=20=20=20=20dispatch_queue_t=20qemu_runner=20=3D=20=
dispatch_queue_create("qemu-runner",=20DISPATCH_QUEUE_SERIAL);=0A+=0A+=20=
=20=20=20dispatch_async(qemu_runner,=20^{=0A+=20=20=20=20=20=20=20=20int=20=
status;=0A+=20=20=20=20=20=20=20=20status=20=3D=20qemu_main(argc,=20=
argv,=20*_NSGetEnviron());=0A+=20=20=20=20=20=20=20=20exit(status);=0A+=20=
=20=20=20});=0A=20}=0A=20=0A=20/*=20We=20abstract=20the=20method=20=
called=20by=20the=20Enter=20Fullscreen=20menu=20item=0A--=20=0A2.18.0=0A=0A=

--Apple-Mail=_82AA19C8-CCF0-4176-B867-55568E4B92AC
Content-Disposition: attachment;
	filename=0002-ui-cocoa-Fix-UI-crashes-on-macOS-Mojave.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0002-ui-cocoa-Fix-UI-crashes-on-macOS-Mojave.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20467b0f67d94616ef98d2ec1e8d16eeb5e9506b4e=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Berkus=20Decker=20=
<berkus+github@metta.systems>=0ADate:=20Sun,=2011=20Nov=202018=20=
20:22:01=20+0200=0ASubject:=20[PATCH=202/2]=20ui/cocoa:=20Fix=20UI=20=
crashes=20on=20macOS=20Mojave=0A=0ASigned-off-by:=20Berkus=20Decker=20=
<berkus+github@metta.systems>=0A---=0A=20ui/DDInvocationGrabber.h=20|=20=
124=20++++++++++++++++++++++++++++=0A=20ui/DDInvocationGrabber.m=20|=20=
171=20+++++++++++++++++++++++++++++++++++++++=0A=20ui/Makefile.objs=20=20=
=20=20=20=20=20=20=20|=20=20=202=20+-=0A=20ui/cocoa.m=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20|=20=2057=20++++++++-----=0A=204=20files=20=
changed,=20333=20insertions(+),=2021=20deletions(-)=0A=20create=20mode=20=
100644=20ui/DDInvocationGrabber.h=0A=20create=20mode=20100644=20=
ui/DDInvocationGrabber.m=0A=0Adiff=20--git=20a/ui/DDInvocationGrabber.h=20=
b/ui/DDInvocationGrabber.h=0Anew=20file=20mode=20100644=0Aindex=20=
0000000000..7218421d74=0A---=20/dev/null=0A+++=20=
b/ui/DDInvocationGrabber.h=0A@@=20-0,0=20+1,124=20@@=0A+/*=0A+=20*=20=
Copyright=20(c)=202007-2008=20Dave=20Dribin=0A+=20*=0A+=20*=20Permission=20=
is=20hereby=20granted,=20free=20of=20charge,=20to=20any=20person=0A+=20*=20=
obtaining=20a=20copy=20of=20this=20software=20and=20associated=20=
documentation=0A+=20*=20files=20(the=20"Software"),=20to=20deal=20in=20=
the=20Software=20without=0A+=20*=20restriction,=20including=20without=20=
limitation=20the=20rights=20to=20use,=20copy,=0A+=20*=20modify,=20merge,=20=
publish,=20distribute,=20sublicense,=20and/or=20sell=20copies=0A+=20*=20=
of=20the=20Software,=20and=20to=20permit=20persons=20to=20whom=20the=20=
Software=20is=0A+=20*=20furnished=20to=20do=20so,=20subject=20to=20the=20=
following=20conditions:=0A+=20*=0A+=20*=20The=20above=20copyright=20=
notice=20and=20this=20permission=20notice=20shall=20be=0A+=20*=20=
included=20in=20all=20copies=20or=20substantial=20portions=20of=20the=20=
Software.=0A+=20*=0A+=20*=20THE=20SOFTWARE=20IS=20PROVIDED=20"AS=20IS",=20=
WITHOUT=20WARRANTY=20OF=20ANY=20KIND,=0A+=20*=20EXPRESS=20OR=20IMPLIED,=20=
INCLUDING=20BUT=20NOT=20LIMITED=20TO=20THE=20WARRANTIES=20OF=0A+=20*=20=
MERCHANTABILITY,=20FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE=20AND=0A+=20=
*=20NONINFRINGEMENT.=20IN=20NO=20EVENT=20SHALL=20THE=20AUTHORS=20OR=20=
COPYRIGHT=20HOLDERS=0A+=20*=20BE=20LIABLE=20FOR=20ANY=20CLAIM,=20DAMAGES=20=
OR=20OTHER=20LIABILITY,=20WHETHER=20IN=20AN=0A+=20*=20ACTION=20OF=20=
CONTRACT,=20TORT=20OR=20OTHERWISE,=20ARISING=20FROM,=20OUT=20OF=20OR=20=
IN=0A+=20*=20CONNECTION=20WITH=20THE=20SOFTWARE=20OR=20THE=20USE=20OR=20=
OTHER=20DEALINGS=20IN=20THE=0A+=20*=20SOFTWARE.=0A+=20*/=0A+=0A+=0A+/*=0A=
+=20*=20=20This=20class=20is=20based=20on=20CInvocationGrabber:=0A+=20*=0A=
+=20*=20=20Copyright=20(c)=202007,=20Toxic=20Software=0A+=20*=20=20All=20=
rights=20reserved.=0A+=20*=20=20Redistribution=20and=20use=20in=20source=20=
and=20binary=20forms,=20with=20or=20without=0A+=20*=20=20modification,=20=
are=20permitted=20provided=20that=20the=20following=20conditions=20are=0A=
+=20*=20=20met:=0A+=20*=0A+=20*=20=20*=20Redistributions=20of=20source=20=
code=20must=20retain=20the=20above=20copyright=20notice,=0A+=20*=20=20=
this=20list=20of=20conditions=20and=20the=20following=20disclaimer.=0A+=20=
*=0A+=20*=20=20*=20Redistributions=20in=20binary=20form=20must=20=
reproduce=20the=20above=20copyright=0A+=20*=20=20notice,=20this=20list=20=
of=20conditions=20and=20the=20following=20disclaimer=20in=20the=0A+=20*=20=
=20documentation=20and/or=20other=20materials=20provided=20with=20the=20=
distribution.=0A+=20*=0A+=20*=20=20*=20Neither=20the=20name=20of=20the=20=
Toxic=20Software=20nor=20the=20names=20of=20its=0A+=20*=20=20=
contributors=20may=20be=20used=20to=20endorse=20or=20promote=20products=20=
derived=20from=0A+=20*=20=20this=20software=20without=20specific=20prior=20=
written=20permission.=0A+=20*=0A+=20*=20=20THIS=20SOFTWARE=20IS=20=
PROVIDED=20BY=20THE=20REGENTS=20AND=20CONTRIBUTORS=20``AS=20IS''=20AND=0A=
+=20*=20=20ANY=20EXPRESS=20OR=20IMPLIED=20WARRANTIES,=20INCLUDING,=20BUT=20=
NOT=20LIMITED=20TO,=20THE=0A+=20*=20=20IMPLIED=20WARRANTIES=20OF=20=
MERCHANTABILITY=20AND=20FITNESS=20FOR=20A=20PARTICULAR=0A+=20*=20=20=
PURPOSE=20ARE=20DISCLAIMED.=20IN=20NO=20EVENT=20SHALL=20THE=20REGENTS=20=
OR=20CONTRIBUTORS=20BE=0A+=20*=20=20LIABLE=20FOR=20ANY=20DIRECT,=20=
INDIRECT,=20INCIDENTAL,=20SPECIAL,=20EXEMPLARY,=20OR=0A+=20*=20=20=
CONSEQUENTIAL=20DAMAGES=20(INCLUDING,=20BUT=20NOT=20LIMITED=20TO,=20=
PROCUREMENT=20OF=0A+=20*=20=20SUBSTITUTE=20GOODS=20OR=20SERVICES;=20LOSS=20=
OF=20USE,=20DATA,=20OR=20PROFITS;=20OR=20BUSINESS=0A+=20*=20=20=
INTERRUPTION)=20HOWEVER=20CAUSED=20AND=20ON=20ANY=20THEORY=20OF=20=
LIABILITY,=20WHETHER=20IN=0A+=20*=20=20CONTRACT,=20STRICT=20LIABILITY,=20=
OR=20TORT=20(INCLUDING=20NEGLIGENCE=20OR=20OTHERWISE)=0A+=20*=20=20=
ARISING=20IN=20ANY=20WAY=20OUT=20OF=20THE=20USE=20OF=20THIS=20SOFTWARE,=20=
EVEN=20IF=20ADVISED=20OF=0A+=20*=20=20THE=20POSSIBILITY=20OF=20SUCH=20=
DAMAGE.=0A+=20*=0A+=20*/=0A+=0A+#import=20<Foundation/Foundation.h>=0A+=0A=
+/**=0A+=20*=20@class=20DDInvocationGrabber=0A+=20*=20@discussion=20=
DDInvocationGrabber=20is=20a=20helper=20object=20that=20makes=20it=20=
very=20easy=0A+=20*=20to=20construct=20instances=20of=20NSInvocation=20=
for=20later=20use.=20The=20object=20is=0A+=20*=20inspired=20by=20=
NSUndoManager's=20prepareWithInvocationTarget=20method.=20To=20use=0A+=20=
*=20a=20DDInvocationGrabber=20object,=20you=20set=20its=20target=20to=20=
some=20object,=20then=20send=0A+=20*=20it=20a=20message=20as=20if=20it=20=
were=20the=20target=20object=20(the=20DDInvocationGrabber=20object=0A+=20=
*=20acts=20as=20a=20proxy),=20if=20the=20target=20message=20understands=20=
the=20message=20the=0A+=20*=20DDInvocationGrabber=20object=20stores=20=
the=20message=20invocation.=0A+=0A+=20DDInvocationGrabber=20*theGrabber=20=
=3D=20[DDInvocationGrabber=20invocationGrabber];=0A+=20[theGrabber=20=
setTarget:someObject]=0A+=20//=20Send=20messages=20to=20'theGrabber'=20=
as=20if=20it=20were=20'someObject'=0A+=20[theGrabber=20=
doSomethingWithParameter:someParameter];=0A+=20NSInvocation=20=
*theInvocation=20=3D=20[theGrabber=20invocation];=0A+=0A+=20A=20slightly=20=
more=20concise=20version=20(using=20the=20covenience=20category)=20=
follows:=0A+=0A+=20DDInvocationGrabber=20*theGrabber=20=3D=20=
[DDInvocationGrabber=20invocationGrabber];=0A+=20[[theGrabber=20=
prepareWithInvocationTarget:someObject]=0A+=20=20=20=20=
doSomethingWithParameter:someParameter];=0A+=20NSInvocation=20=
*theInvocation=20=3D=20[theGrabber=20invocation];=0A+=0A+=20*/=0A=
+@interface=20DDInvocationGrabber=20:=20NSProxy=0A+{=0A+=20=20=20=20id=20=
_target;=0A+=20=20=20=20NSInvocation=20*=20_invocation;=0A+=20=20=20=20=
BOOL=20_forwardInvokesOnMainThread;=0A+=20=20=20=20BOOL=20=
_waitUntilDone;=0A+}=0A+=0A+/**=0A+=20*=20@method=20invocationGrabber=0A=
+=20*=20@abstract=20Returns=20a=20newly=20allocated,=20inited,=20=
autoreleased=0A+=20*=20DDInvocationGrabber=20object.=0A+=20*/=0A++=20=
(id)=20invocationGrabber;=0A+=0A+-=20(id)=20target;=0A+-=20(void)=20=
setTarget:(id)inTarget;=0A+=0A+-=20(NSInvocation=20*)=20invocation;=0A+-=20=
(void)=20setInvocation:(NSInvocation=20*)inInvocation;=0A+=0A+-=20(BOOL)=20=
forwardInvokesOnMainThread;=0A+-=20(void)=20=
setForwardInvokesOnMainThread:(BOOL)forwardInvokesOnMainThread;=0A+=0A+-=20=
(BOOL)=20waitUntilDone;=0A+-=20(void)=20=
setWaitUntilDone:(BOOL)waitUntilDone;=0A+=0A+@end=0A+=0A+@interface=20=
DDInvocationGrabber=20(DDInvocationGrabber_Conveniences)=0A+=0A+/**=0A+=20=
*=20@method=20prepareWithInvocationTarget:=0A+=20*=20@abstract=20Sets=20=
the=20target=20object=20of=20the=20receiver=20and=20returns=20itself.=0A=
+=20*=20The=20sender=20can=20then=20send=20a=20message=20to=20the=20=
receiver.=0A+=20*/=0A+-=20(id)prepareWithInvocationTarget:(id)inTarget;=0A=
+=0A+@end=0Adiff=20--git=20a/ui/DDInvocationGrabber.m=20=
b/ui/DDInvocationGrabber.m=0Anew=20file=20mode=20100644=0Aindex=20=
0000000000..297a0b41f5=0A---=20/dev/null=0A+++=20=
b/ui/DDInvocationGrabber.m=0A@@=20-0,0=20+1,171=20@@=0A+/*=0A+=20*=20=
Copyright=20(c)=202007-2008=20Dave=20Dribin=0A+=20*=0A+=20*=20Permission=20=
is=20hereby=20granted,=20free=20of=20charge,=20to=20any=20person=0A+=20*=20=
obtaining=20a=20copy=20of=20this=20software=20and=20associated=20=
documentation=0A+=20*=20files=20(the=20"Software"),=20to=20deal=20in=20=
the=20Software=20without=0A+=20*=20restriction,=20including=20without=20=
limitation=20the=20rights=20to=20use,=20copy,=0A+=20*=20modify,=20merge,=20=
publish,=20distribute,=20sublicense,=20and/or=20sell=20copies=0A+=20*=20=
of=20the=20Software,=20and=20to=20permit=20persons=20to=20whom=20the=20=
Software=20is=0A+=20*=20furnished=20to=20do=20so,=20subject=20to=20the=20=
following=20conditions:=0A+=20*=0A+=20*=20The=20above=20copyright=20=
notice=20and=20this=20permission=20notice=20shall=20be=0A+=20*=20=
included=20in=20all=20copies=20or=20substantial=20portions=20of=20the=20=
Software.=0A+=20*=0A+=20*=20THE=20SOFTWARE=20IS=20PROVIDED=20"AS=20IS",=20=
WITHOUT=20WARRANTY=20OF=20ANY=20KIND,=0A+=20*=20EXPRESS=20OR=20IMPLIED,=20=
INCLUDING=20BUT=20NOT=20LIMITED=20TO=20THE=20WARRANTIES=20OF=0A+=20*=20=
MERCHANTABILITY,=20FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE=20AND=0A+=20=
*=20NONINFRINGEMENT.=20IN=20NO=20EVENT=20SHALL=20THE=20AUTHORS=20OR=20=
COPYRIGHT=20HOLDERS=0A+=20*=20BE=20LIABLE=20FOR=20ANY=20CLAIM,=20DAMAGES=20=
OR=20OTHER=20LIABILITY,=20WHETHER=20IN=20AN=0A+=20*=20ACTION=20OF=20=
CONTRACT,=20TORT=20OR=20OTHERWISE,=20ARISING=20FROM,=20OUT=20OF=20OR=20=
IN=0A+=20*=20CONNECTION=20WITH=20THE=20SOFTWARE=20OR=20THE=20USE=20OR=20=
OTHER=20DEALINGS=20IN=20THE=0A+=20*=20SOFTWARE.=0A+=20*/=0A+=0A+=0A+/*=0A=
+=20*=20=20This=20class=20is=20based=20on=20CInvocationGrabber:=0A+=20*=0A=
+=20*=20=20Copyright=20(c)=202007,=20Toxic=20Software=0A+=20*=20=20All=20=
rights=20reserved.=0A+=20*=20=20Redistribution=20and=20use=20in=20source=20=
and=20binary=20forms,=20with=20or=20without=0A+=20*=20=20modification,=20=
are=20permitted=20provided=20that=20the=20following=20conditions=20are=0A=
+=20*=20=20met:=0A+=20*=0A+=20*=20=20*=20Redistributions=20of=20source=20=
code=20must=20retain=20the=20above=20copyright=20notice,=0A+=20*=20=20=
this=20list=20of=20conditions=20and=20the=20following=20disclaimer.=0A+=20=
*=0A+=20*=20=20*=20Redistributions=20in=20binary=20form=20must=20=
reproduce=20the=20above=20copyright=0A+=20*=20=20notice,=20this=20list=20=
of=20conditions=20and=20the=20following=20disclaimer=20in=20the=0A+=20*=20=
=20documentation=20and/or=20other=20materials=20provided=20with=20the=20=
distribution.=0A+=20*=0A+=20*=20=20*=20Neither=20the=20name=20of=20the=20=
Toxic=20Software=20nor=20the=20names=20of=20its=0A+=20*=20=20=
contributors=20may=20be=20used=20to=20endorse=20or=20promote=20products=20=
derived=20from=0A+=20*=20=20this=20software=20without=20specific=20prior=20=
written=20permission.=0A+=20*=0A+=20*=20=20THIS=20SOFTWARE=20IS=20=
PROVIDED=20BY=20THE=20REGENTS=20AND=20CONTRIBUTORS=20``AS=20IS''=20AND=0A=
+=20*=20=20ANY=20EXPRESS=20OR=20IMPLIED=20WARRANTIES,=20INCLUDING,=20BUT=20=
NOT=20LIMITED=20TO,=20THE=0A+=20*=20=20IMPLIED=20WARRANTIES=20OF=20=
MERCHANTABILITY=20AND=20FITNESS=20FOR=20A=20PARTICULAR=0A+=20*=20=20=
PURPOSE=20ARE=20DISCLAIMED.=20IN=20NO=20EVENT=20SHALL=20THE=20REGENTS=20=
OR=20CONTRIBUTORS=20BE=0A+=20*=20=20LIABLE=20FOR=20ANY=20DIRECT,=20=
INDIRECT,=20INCIDENTAL,=20SPECIAL,=20EXEMPLARY,=20OR=0A+=20*=20=20=
CONSEQUENTIAL=20DAMAGES=20(INCLUDING,=20BUT=20NOT=20LIMITED=20TO,=20=
PROCUREMENT=20OF=0A+=20*=20=20SUBSTITUTE=20GOODS=20OR=20SERVICES;=20LOSS=20=
OF=20USE,=20DATA,=20OR=20PROFITS;=20OR=20BUSINESS=0A+=20*=20=20=
INTERRUPTION)=20HOWEVER=20CAUSED=20AND=20ON=20ANY=20THEORY=20OF=20=
LIABILITY,=20WHETHER=20IN=0A+=20*=20=20CONTRACT,=20STRICT=20LIABILITY,=20=
OR=20TORT=20(INCLUDING=20NEGLIGENCE=20OR=20OTHERWISE)=0A+=20*=20=20=
ARISING=20IN=20ANY=20WAY=20OUT=20OF=20THE=20USE=20OF=20THIS=20SOFTWARE,=20=
EVEN=20IF=20ADVISED=20OF=0A+=20*=20=20THE=20POSSIBILITY=20OF=20SUCH=20=
DAMAGE.=0A+=20*=0A+=20*/=0A+=0A+#import=20"DDInvocationGrabber.h"=0A+=0A=
+=0A+@implementation=20DDInvocationGrabber=0A+=0A++=20=
(id)invocationGrabber=0A+{=0A+=20=20=20=20return([[[self=20alloc]=20=
init]=20autorelease]);=0A+}=0A+=0A+-=20(id)init=0A+{=0A+=20=20=20=20=
_target=20=3D=20nil;=0A+=20=20=20=20_invocation=20=3D=20nil;=0A+=20=20=20=
=20_forwardInvokesOnMainThread=20=3D=20NO;=0A+=20=20=20=20_waitUntilDone=20=
=3D=20NO;=0A+=0A+=20=20=20=20return=20self;=0A+}=0A+=0A+-=20=
(void)dealloc=0A+{=0A+=20=20=20=20[self=20setTarget:NULL];=0A+=20=20=20=20=
[self=20setInvocation:NULL];=0A+=20=20=20=20//=0A+=20=20=20=20[super=20=
dealloc];=0A+}=0A+=0A+#pragma=20mark=20-=0A+=0A+-=20(id)target=0A+{=0A+=20=
=20=20=20return=20_target;=0A+}=0A+=0A+-=20(void)setTarget:(id)inTarget=0A=
+{=0A+=20=20=20=20if=20(_target=20!=3D=20inTarget)=0A+=09{=0A+=20=20=20=20=
=20=20=20=20[_target=20autorelease];=0A+=20=20=20=20=20=20=20=20_target=20=
=3D=20[inTarget=20retain];=0A+=09}=0A+}=0A+=0A+-=20(NSInvocation=20=
*)invocation=0A+{=0A+=20=20=20=20return=20_invocation;=0A+}=0A+=0A+-=20=
(void)setInvocation:(NSInvocation=20*)inInvocation=0A+{=0A+=20=20=20=20=
if=20(_invocation=20!=3D=20inInvocation)=0A+=09{=0A+=20=20=20=20=20=20=20=
=20[_invocation=20autorelease];=0A+=20=20=20=20=20=20=20=20_invocation=20=
=3D=20[inInvocation=20retain];=0A+=09}=0A+}=0A+=0A+-=20=
(BOOL)forwardInvokesOnMainThread;=0A+{=0A+=20=20=20=20return=20=
_forwardInvokesOnMainThread;=0A+}=0A+=0A+-=20=
(void)setForwardInvokesOnMainThread:(BOOL)forwardInvokesOnMainThread;=0A=
+{=0A+=20=20=20=20_forwardInvokesOnMainThread=20=3D=20=
forwardInvokesOnMainThread;=0A+}=0A+=0A+-=20(BOOL)waitUntilDone;=0A+{=0A=
+=20=20=20=20return=20_waitUntilDone;=0A+}=0A+=0A+-=20=
(void)setWaitUntilDone:(BOOL)waitUntilDone;=0A+{=0A+=20=20=20=20=
_waitUntilDone=20=3D=20waitUntilDone;=0A+}=0A+=0A+#pragma=20mark=20-=0A+=0A=
+-=20(NSMethodSignature=20*)methodSignatureForSelector:(SEL)selector=0A=
+{=0A+=20=20=20=20return=20[[self=20target]=20=
methodSignatureForSelector:selector];=0A+}=0A+=0A+-=20=
(void)forwardInvocation:(NSInvocation=20*)ioInvocation=0A+{=0A+=20=20=20=20=
[ioInvocation=20setTarget:[self=20target]];=0A+=20=20=20=20[self=20=
setInvocation:ioInvocation];=0A+=20=20=20=20if=20=
(_forwardInvokesOnMainThread)=0A+=20=20=20=20{=0A+=20=20=20=20=20=20=20=20=
if=20(!_waitUntilDone)=0A+=20=20=20=20=20=20=20=20=20=20=20=20=
[_invocation=20retainArguments];=0A+=20=20=20=20=20=20=20=20[_invocation=20=
performSelectorOnMainThread:@selector(invoke)=0A+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20withObject:nil=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
waitUntilDone:_waitUntilDone];=0A+=20=20=20=20}=0A+}=0A+=0A+@end=0A+=0A=
+#pragma=20mark=20-=0A+=0A+@implementation=20DDInvocationGrabber=20=
(DDnvocationGrabber_Conveniences)=0A+=0A+-=20=
(id)prepareWithInvocationTarget:(id)inTarget=0A+{=0A+=20=20=20=20[self=20=
setTarget:inTarget];=0A+=20=20=20=20return(self);=0A+}=0A+=0A+@end=0A=
diff=20--git=20a/ui/Makefile.objs=20b/ui/Makefile.objs=0Aindex=20=
00f6976c30..bd9983232f=20100644=0A---=20a/ui/Makefile.objs=0A+++=20=
b/ui/Makefile.objs=0A@@=20-11,7=20+11,7=20@@=20common-obj-y=20+=3D=20=
keymaps.o=20console.o=20cursor.o=20qemu-pixman.o=0A=20common-obj-y=20+=3D=20=
input.o=20input-keymap.o=20input-legacy.o=0A=20=
common-obj-$(CONFIG_LINUX)=20+=3D=20input-linux.o=0A=20=
common-obj-$(CONFIG_SPICE)=20+=3D=20spice-core.o=20spice-input.o=20=
spice-display.o=0A-common-obj-$(CONFIG_COCOA)=20+=3D=20cocoa.o=0A=
+common-obj-$(CONFIG_COCOA)=20+=3D=20cocoa.o=20DDInvocationGrabber.o=0A=20=
common-obj-$(CONFIG_VNC)=20+=3D=20$(vnc-obj-y)=0A=20common-obj-$(call=20=
lnot,$(CONFIG_VNC))=20+=3D=20vnc-stubs.o=0A=20=0Adiff=20--git=20=
a/ui/cocoa.m=20b/ui/cocoa.m=0Aindex=20f69f7105f2..41aa7524d8=20100644=0A=
---=20a/ui/cocoa.m=0A+++=20b/ui/cocoa.m=0A@@=20-38,6=20+38,8=20@@=0A=20=
#include=20<Carbon/Carbon.h>=0A=20#include=20"qom/cpu.h"=0A=20=0A=
+#import=20"DDInvocationGrabber.h"=0A+=0A=20#ifndef=20=
MAC_OS_X_VERSION_10_5=0A=20#define=20MAC_OS_X_VERSION_10_5=201050=0A=20=
#endif=0A@@=20-314,6=20+316,8=20@@=20static=20void=20=
handleAnyDeviceErrors(Error=20*=20err)=0A=20-=20(float)=20cdy;=0A=20-=20=
(QEMUScreen)=20gscreen;=0A=20-=20(void)=20raiseAllKeys;=0A+-=20(void)=20=
refresh;=0A+-=20(id)=20invokeOnMainThread;=0A=20@end=0A=20=0A=20=
QemuCocoaView=20*cocoaView;=0A@@=20-345,6=20+349,14=20@@=20QemuCocoaView=20=
*cocoaView;=0A=20=20=20=20=20[super=20dealloc];=0A=20}=0A=20=0A+-=20(id)=20=
invokeOnMainThread=0A+{=0A+=20=20=20=20DDInvocationGrabber=20*=20grabber=20=
=3D=20[DDInvocationGrabber=20invocationGrabber];=0A+=20=20=20=20[grabber=20=
setForwardInvokesOnMainThread:YES];=0A+=20=20=20=20[grabber=20=
setWaitUntilDone:YES];=0A+=20=20=20=20return=20[grabber=20=
prepareWithInvocationTarget:self];=0A+}=0A+=0A=20-=20(BOOL)=20isOpaque=0A=
=20{=0A=20=20=20=20=20return=20YES;=0A@@=20-509,6=20+521,28=20@@=20=
QemuCocoaView=20*cocoaView;=0A=20=20=20=20=20}=0A=20}=0A=20=0A+-=20=
(void)=20refresh=0A+{=0A+=20=20=20=20if=20(qemu_input_is_absolute())=20{=0A=
+=20=20=20=20=20=20=20=20if=20(![self=20isAbsoluteEnabled])=20{=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20if=20([self=20isMouseGrabbed])=20{=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20[self=20ungrabMouse];=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20}=0A+=20=20=20=20=20=20=20=20}=0A+=20=20=20=
=20=20=20=20=20[self=20setAbsoluteEnabled:YES];=0A+=20=20=20=20}=0A+=0A+=20=
=20=20=20NSDate=20*distantPast=20=3D=20[NSDate=20distantPast];=0A+=20=20=20=
=20NSEvent=20*event;=0A+=20=20=20=20do=20{=0A+=20=20=20=20=20=20=20=20=
event=20=3D=20[NSApp=20nextEventMatchingMask:NSEventMaskAny=20=
untilDate:distantPast=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20inMode:=20NSDefaultRunLoopMode=20dequeue:YES];=0A=
+=20=20=20=20=20=20=20=20if=20(event=20!=3D=20nil)=20{=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20[self=20handleEvent:event];=0A+=20=20=20=20=20=20=20=
=20}=0A+=20=20=20=20}=20while(event=20!=3D=20nil);=0A+}=0A+=0A=20-=20=
(void)=20toggleFullScreen:(id)sender=0A=20{=0A=20=20=20=20=20=
COCOA_DEBUG("QemuCocoaView:=20toggleFullScreen\n");=0A@@=20-1566,7=20=
+1600,7=20@@=20static=20void=20cocoa_update(DisplayChangeListener=20=
*dcl,=0A=20=20=20=20=20=20=20=20=20=20=20=20=20w=20*=20[cocoaView=20=
cdx],=0A=20=20=20=20=20=20=20=20=20=20=20=20=20h=20*=20[cocoaView=20=
cdy]);=0A=20=20=20=20=20}=0A-=20=20=20=20[cocoaView=20=
setNeedsDisplayInRect:rect];=0A+=20=20=20=20[[cocoaView=20=
invokeOnMainThread]=20setNeedsDisplayInRect:rect];=0A=20=0A=20=20=20=20=20=
[pool=20release];=0A=20}=0A@@=20-1577,7=20+1611,7=20@@=20static=20void=20=
cocoa_switch(DisplayChangeListener=20*dcl,=0A=20=20=20=20=20=
NSAutoreleasePool=20*=20pool=20=3D=20[[NSAutoreleasePool=20alloc]=20=
init];=0A=20=0A=20=20=20=20=20COCOA_DEBUG("qemu_cocoa:=20=
cocoa_switch\n");=0A-=20=20=20=20[cocoaView=20switchSurface:surface];=0A=
+=20=20=20=20[[cocoaView=20invokeOnMainThread]=20switchSurface:surface];=0A=
=20=20=20=20=20[pool=20release];=0A=20}=0A=20=0A@@=20-1588,25=20+1622,8=20=
@@=20static=20void=20cocoa_refresh(DisplayChangeListener=20*dcl)=0A=20=20=
=20=20=20COCOA_DEBUG("qemu_cocoa:=20cocoa_refresh\n");=0A=20=20=20=20=20=
graphic_hw_update(NULL);=0A=20=0A-=20=20=20=20if=20=
(qemu_input_is_absolute())=20{=0A-=20=20=20=20=20=20=20=20if=20=
(![cocoaView=20isAbsoluteEnabled])=20{=0A-=20=20=20=20=20=20=20=20=20=20=20=
=20if=20([cocoaView=20isMouseGrabbed])=20{=0A-=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20[cocoaView=20ungrabMouse];=0A-=20=20=20=20=20=20=20=20=
=20=20=20=20}=0A-=20=20=20=20=20=20=20=20}=0A-=20=20=20=20=20=20=20=20=
[cocoaView=20setAbsoluteEnabled:YES];=0A-=20=20=20=20}=0A+=20=20=20=20=
[[cocoaView=20invokeOnMainThread]=20refresh];=0A=20=0A-=20=20=20=20=
NSDate=20*distantPast;=0A-=20=20=20=20NSEvent=20*event;=0A-=20=20=20=20=
distantPast=20=3D=20[NSDate=20distantPast];=0A-=20=20=20=20do=20{=0A-=20=20=
=20=20=20=20=20=20event=20=3D=20[NSApp=20=
nextEventMatchingMask:NSEventMaskAny=20untilDate:distantPast=0A-=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20inMode:=20=
NSDefaultRunLoopMode=20dequeue:YES];=0A-=20=20=20=20=20=20=20=20if=20=
(event=20!=3D=20nil)=20{=0A-=20=20=20=20=20=20=20=20=20=20=20=20=
[cocoaView=20handleEvent:event];=0A-=20=20=20=20=20=20=20=20}=0A-=20=20=20=
=20}=20while(event=20!=3D=20nil);=0A=20=20=20=20=20[pool=20release];=0A=20=
}=0A=20=0A--=20=0A2.18.0=0A=0A=

--Apple-Mail=_82AA19C8-CCF0-4176-B867-55568E4B92AC--
