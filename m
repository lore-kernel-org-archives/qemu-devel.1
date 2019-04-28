Received: from eggs.gnu.org ([209.51.188.92]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKacy-0001sr-OL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKaXE-0005t0-Is
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:31:26 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:21651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hKaXE-0005sU-AO
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:31:24 -0400
From: Chen Zhang <tgfbeta@me.com>
Message-Id: <F07AA414-D6D4-4CAE-B56D-AF2D1B5259D4@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Sun, 28 Apr 2019 11:31:17 +0800
In-Reply-To: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
References: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND 1/2] ui/cocoa: Fix absolute input device
 grabbing issue on Mojave
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

This patches fixed boundary check methods for cursor in normal and
fullscreen modes with/without Zoom-to-Fit on Mojave.

On Mojave, absolute input device, i.e. tablet, had trouble re-grabbing
the cursor in re-entry into the virtual screen area. In some cases,
the `window` property of NSEvent object was nil after exit of cursor,
meaning that the `-locationInWindow` method would return value in screen
coordinates. The current implementation used raw locations frrom NSEvent
without considering whether the value was for the window coordinates or
the macOS screen coordinates, nor the zooming factor for Zoom-to-Fit in
fullscreen mode.

In fullscreen mode, the fullscreen cocoa window might not be the key
window, therefore the location of event in virtual coordinates should
suffice.

Note: CGRect, -convertRectToScreen: and -convertRectFromScreen: were
used in coordinates conversion for compatibility reason.

Signed-off-by: Chen Zhang <tgfbeta@me.com <mailto:tgfbeta@me.com>>
---
ui/cocoa.m | 43 +++++++++++++++++++++++++++++++++++++++++--
1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 420b2411c1..474d44cb9f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -405,6 +405,41 @@ QemuCocoaView *cocoaView;
    return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < =
screen.height);
}

+/* Get location of event and convert to virtual screen coordinate */
+- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
+{
+    NSWindow *eventWindow =3D [ev window];
+    // XXX: Use CGRect and -convertRectFromScreen: to support macOS =
10.10
+    CGRect r =3D CGRectZero;
+    r.origin =3D [ev locationInWindow];
+    if (!eventWindow) {
+        if (!isFullscreen) {
+            return [[self window] convertRectFromScreen:r].origin;
+        } else {
+            CGPoint locationInSelfWindow =3D [[self window] =
convertRectFromScreen:r].origin;
+            CGPoint loc =3D [self convertPoint:locationInSelfWindow =
fromView:nil];
+            if (stretch_video) {
+                loc.x /=3D cdx;
+                loc.y /=3D cdy;
+            }
+            return loc;
+        }
+    } else if ([[self window] isEqual:eventWindow]) {
+        if (!isFullscreen) {
+            return r.origin;
+        } else {
+            CGPoint loc =3D [self convertPoint:r.origin fromView:nil];
+            if (stretch_video) {
+                loc.x /=3D cdx;
+                loc.y /=3D cdy;
+            }
+            return loc;
+        }
+    } else {
+        return [[self window] convertRectFromScreen:[eventWindow =
convertRectToScreen:r]].origin;
+    }
+}
+
- (void) hideCursor
{
    if (!cursor_hide) {
@@ -704,7 +739,8 @@ QemuCocoaView *cocoaView;
    int keycode =3D 0;
    bool mouse_event =3D false;
    static bool switched_to_fullscreen =3D false;
-    NSPoint p =3D [event locationInWindow];
+    // Location of event in virtual screen coordinates
+    NSPoint p =3D [self screenLocationOfEvent:event];

    switch ([event type]) {
        case NSEventTypeFlagsChanged:
@@ -815,7 +851,10 @@ QemuCocoaView *cocoaView;
            break;
        case NSEventTypeMouseMoved:
            if (isAbsoluteEnabled) {
-                if (![self screenContainsPoint:p] || ![[self window] =
isKeyWindow]) {
+                // Cursor re-entered into a window might generate =
events bound to screen coordinates
+                // and `nil` window property, and in full screen mode, =
current window might not be
+                // key window, where event location alone should =
suffice.
+                if (![self screenContainsPoint:p] || !([[self window] =
isKeyWindow] || isFullscreen)) {
                    if (isMouseGrabbed) {
                        [self ungrabMouse];
                    }
--=20
2.19.2=
