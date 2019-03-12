Received: from eggs.gnu.org ([209.51.188.92]:43097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1h3Wc3-0001Am-PB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1h3WVc-0007fC-GX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:47:13 -0400
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:37999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1h3WVc-0007du-7E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:47:12 -0400
From: Chen Zhang <tgfbeta@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <BE04B88B-9AAC-4348-A165-E115CBE54077@me.com>
Date: Tue, 12 Mar 2019 09:47:02 +0800
Subject: [Qemu-devel] [PATCH] ui/cocoa: Adding cursor support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

This patch added cocoa_mouse_set() and cocoa_cursor_define(),
supporting virtio-gpu simple rendering on macOS host.

Image content, rect and visibility of the cursor buffer were added as
ivars in QemuCocoaView class. Corresponding accessors were added.

Note that the rect of the cursor was in coordinates of the QEMU
screen, not the NSScreen or the NSView, for convenience of blending.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 ui/cocoa.m | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 420b2411c1..8beed6e514 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -334,6 +334,9 @@ static void handleAnyDeviceErrors(Error * err)
     BOOL isFullscreen;
     BOOL isAbsoluteEnabled;
     BOOL isMouseDeassociated;
+    CGRect cursorRect;
+    CGImageRef cursorImage;
+    BOOL cursorVisible;
 }
 - (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
@@ -362,6 +365,12 @@ static void handleAnyDeviceErrors(Error * err)
 - (float) cdy;
 - (QEMUScreen) gscreen;
 - (void) raiseAllKeys;
+- (CGRect) cursorRect;
+- (void) setCursorRect:(CGRect)rect;
+- (CGImageRef) cursorImage;
+- (void) setCursorImage:(CGImageRef)image;
+- (BOOL) isCursorVisible;
+- (void) setCursorVisible:(BOOL)visible;
 @end
=20
 QemuCocoaView *cocoaView;
@@ -392,6 +401,10 @@ QemuCocoaView *cocoaView;
         pixman_image_unref(pixman_image);
     }
=20
+    if (cursorImage) {
+        CGImageRelease(cursorImage);
+    }
+
     [super dealloc];
 }
=20
@@ -479,6 +492,10 @@ QemuCocoaView *cocoaView;
                                                         );
             CGContextDrawImage (viewContextRef, cgrect(rectList[i]), =
clipImageRef);
             CGImageRelease (clipImageRef);
+
+        }
+        if (cursorVisible && cursorImage && NSIntersectsRect(rect, =
cursorRect)) {
+            CGContextDrawImage (viewContextRef, cursorRect, =
cursorImage);
         }
         CGImageRelease (imageRef);
     }
@@ -987,6 +1004,19 @@ QemuCocoaView *cocoaView;
 - (float) cdy {return cdy;}
 - (QEMUScreen) gscreen {return screen;}
=20
+- (CGRect) cursorRect {return cursorRect;}
+- (void) setCursorRect:(CGRect)rect {cursorRect =3D rect;}
+- (CGImageRef) cursorImage {return cursorImage;}
+- (void) setCursorImage:(CGImageRef)image
+{
+    if (cursorImage && cursorImage !=3D image) {
+        CGImageRelease(cursorImage);
+    }
+    cursorImage =3D image;
+}
+- (BOOL) isCursorVisible {return cursorVisible;}
+- (void) setCursorVisible:(BOOL)visible {cursorVisible =3D visible;}
+
 /*
  * Makes the target think all down keys are being released.
  * This prevents a stuck key problem, since we will not see
@@ -1830,6 +1860,53 @@ static void cocoa_refresh(DisplayChangeListener =
*dcl)
     [pool release];
 }
=20
+static void cocoa_cursor_define(DisplayChangeListener *dcl, QEMUCursor =
*c)
+{
+    NSAutoreleasePool * pool =3D [[NSAutoreleasePool alloc] init];
+    int bitsPerComponent =3D [cocoaView gscreen].bitsPerComponent;
+    int bitsPerPixel =3D [cocoaView gscreen].bitsPerPixel;
+    CGDataProviderRef provider =3D CGDataProviderCreateWithData(NULL, =
c->data, c->width * 4 * c->height, NULL);
+
+    CGImageRef img =3D CGImageCreate(c->width, c->height,
+                                   bitsPerComponent, bitsPerPixel, =
c->width * bitsPerComponent / 2,
+#ifdef __LITTLE_ENDIAN__
+                                   =
CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB), //colorspace for OS =
X >=3D 10.4
+                                   kCGBitmapByteOrder32Little | =
kCGImageAlphaFirst,
+#else
+                                   CGColorSpaceCreateDeviceRGB(), =
//colorspace for OS X < 10.4 (actually ppc)
+                                   kCGImageAlphaFirst, //bitmapInfo
+#endif
+                                   provider, NULL, 0, =
kCGRenderingIntentDefault);
+
+    CGDataProviderRelease(provider);
+    CGFloat width =3D c->width;
+    CGFloat height =3D c->height;
+    dispatch_async(dispatch_get_main_queue(), ^{
+        [cocoaView setCursorImage:img];
+        CGRect rect =3D [cocoaView cursorRect];
+        rect.size =3D CGSizeMake(width, height);
+        [cocoaView setCursorRect:rect];
+    });
+    [pool release];
+}
+static void cocoa_mouse_set(DisplayChangeListener *dcl,
+                            int x, int y, int visible)
+{
+    NSAutoreleasePool * pool =3D [[NSAutoreleasePool alloc] init];
+    dispatch_async(dispatch_get_main_queue(), ^{
+        QEMUScreen screen =3D [cocoaView gscreen];
+        CGRect rect =3D [cocoaView cursorRect];
+        // Mark old cursor rect as dirty
+        [cocoaView setNeedsDisplayInRect:rect];
+        rect.origin =3D CGPointMake(x, screen.height - (y + =
rect.size.height));
+        [cocoaView setCursorRect:rect];
+        [cocoaView setCursorVisible:visible ? YES : NO];
+        // Mark new cursor rect as dirty
+        [cocoaView setNeedsDisplayInRect:rect];
+    });
+    [pool release];
+}
+
 static void cocoa_cleanup(void)
 {
     COCOA_DEBUG("qemu_cocoa: cocoa_cleanup\n");
@@ -1841,6 +1918,8 @@ static const DisplayChangeListenerOps dcl_ops =3D =
{
     .dpy_gfx_update =3D cocoa_update,
     .dpy_gfx_switch =3D cocoa_switch,
     .dpy_refresh =3D cocoa_refresh,
+    .dpy_mouse_set =3D cocoa_mouse_set,
+    .dpy_cursor_define =3D cocoa_cursor_define,
 };
=20
 static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
--=20
2.19.2
