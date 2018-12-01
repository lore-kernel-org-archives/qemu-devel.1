Received: from eggs.gnu.org ([2001:4830:134:3::10]:50946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QM-0005bP-Rc
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gT4QL-0008Sw-Ug
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gT4QL-0008Qj-Ne
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:31:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat,  1 Dec 2018 12:30:53 +0000
Message-Id: <20181201123056.432-3-peter.maydell@linaro.org>
In-Reply-To: <20181201123056.432-1-peter.maydell@linaro.org>
References: <20181201123056.432-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 2/5] ui/cocoa: Use the pixman image directly in
 switchSurface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>

Currently the switchSurface method takes a DisplaySurface. We want
to change our DisplayChangeListener's dpy_gfx_switch callback
to do this work asynchronously on a different thread. The caller
of the switch callback will free the old DisplaySurface
immediately the callback returns, so to ensure that the
other thread doesn't access freed data we need to switch
to using the underlying pixman image instead. The pixman
image is reference counted, so we will be able to take
a reference to it to avoid it vanishing too early.

In this commit we only change the switchSurface method
to take a pixman image, and keep the flow of control
synchronous for now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 9148ecdeb4c..997b0199c6c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -303,7 +303,7 @@ static void handleAnyDeviceErrors(Error * err)
     BOOL isAbsoluteEnabled;
     BOOL isMouseDeassociated;
 }
-- (void) switchSurface:(DisplaySurface *)surface;
+- (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
 - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
@@ -478,12 +478,13 @@ QemuCocoaView *cocoaView;
     }
 }
 
-- (void) switchSurface:(DisplaySurface *)surface
+- (void) switchSurface:(pixman_image_t *)image
 {
     COCOA_DEBUG("QemuCocoaView: switchSurface\n");
 
-    int w = surface_width(surface);
-    int h = surface_height(surface);
+    int w = pixman_image_get_width(image);
+    int h = pixman_image_get_height(image);
+    pixman_format_code_t image_format = pixman_image_get_format(image);
     /* cdx == 0 means this is our very first surface, in which case we need
      * to recalculate the content dimensions even if it happens to be the size
      * of the initial empty window.
@@ -505,10 +506,10 @@ QemuCocoaView *cocoaView;
         CGDataProviderRelease(dataProviderRef);
 
     //sync host window color space with guests
-    screen.bitsPerPixel = surface_bits_per_pixel(surface);
-    screen.bitsPerComponent = surface_bytes_per_pixel(surface) * 2;
+    screen.bitsPerPixel = PIXMAN_FORMAT_BPP(image_format);
+    screen.bitsPerComponent = DIV_ROUND_UP(screen.bitsPerPixel, 8) * 2;
 
-    dataProviderRef = CGDataProviderCreateWithData(NULL, surface_data(surface), w * 4 * h, NULL);
+    dataProviderRef = CGDataProviderCreateWithData(NULL, pixman_image_get_data(image), w * 4 * h, NULL);
 
     // update windows
     if (isFullscreen) {
@@ -1608,7 +1609,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
-    [cocoaView switchSurface:surface];
+    [cocoaView switchSurface:surface->image];
     [pool release];
 }
 
-- 
2.19.2
