Received: from eggs.gnu.org ([209.51.188.92]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmz-0004Mf-3m
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0qmy-0005hd-44
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:05 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:42785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0qmx-0005gr-Sv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:50:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id r5so6315883wrg.9
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:50:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	x74sm7238018wmf.22.2019.03.04.08.50.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Mar 2019 08:50:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Mar 2019 16:49:53 +0000
Message-Id: <20190304164958.9362-3-peter.maydell@linaro.org>
In-Reply-To: <20190304164958.9362-1-peter.maydell@linaro.org>
References: <20190304164958.9362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/7] ui/cocoa: Use the pixman image directly in
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-id: 20190225102433.22401-3-peter.maydell@linaro.org
Message-id: 20190214102816.3393-3-peter.maydell@linaro.org
---
 ui/cocoa.m | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index f1171c48654..a913a51a2d8 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -315,7 +315,7 @@ static void handleAnyDeviceErrors(Error * err)
     BOOL isAbsoluteEnabled;
     BOOL isMouseDeassociated;
 }
-- (void) switchSurface:(DisplaySurface *)surface;
+- (void) switchSurface:(pixman_image_t *)image;
 - (void) grabMouse;
 - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
@@ -495,12 +495,13 @@ QemuCocoaView *cocoaView;
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
@@ -522,10 +523,10 @@ QemuCocoaView *cocoaView;
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
@@ -1629,7 +1630,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
     NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
 
     COCOA_DEBUG("qemu_cocoa: cocoa_switch\n");
-    [cocoaView switchSurface:surface];
+    [cocoaView switchSurface:surface->image];
     [pool release];
 }
 
-- 
2.20.1
