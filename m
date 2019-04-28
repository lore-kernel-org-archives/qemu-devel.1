Received: from eggs.gnu.org ([209.51.188.92]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKacx-0001sr-9t
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hKaYA-0006PO-DO
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:32:23 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:23042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hKaYA-0006OL-5B
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 23:32:22 -0400
From: Chen Zhang <tgfbeta@me.com>
Message-Id: <C73C2019-CB01-4E30-8D17-02F7EA044BDE@me.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Sun, 28 Apr 2019 11:32:19 +0800
In-Reply-To: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
References: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND 2/2] ui/cocoa: Fix mouse grabbing in
 fullscreen mode for relative input device
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

In fullscreen mode, the window property of cocoaView may not be the key
window, and the current implementation would not grab mouse in =
fullscreen
mode after user ungrabs cursor in fullscreen mode with hot-key, and left
clicks the relative input devices to re-grab it.

This patch used value of isFullscreen as a short-cirtuit condition for
relative input device grabbing.

Signed-off-by: Chen Zhang <tgfbeta@me.com <mailto:tgfbeta@me.com>>
---
ui/cocoa.m | 7 ++++++-
1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 474d44cb9f..aa7cf07368 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -901,7 +901,12 @@ QemuCocoaView *cocoaView;
        case NSEventTypeLeftMouseUp:
            mouse_event =3D true;
            if (!isMouseGrabbed && [self screenContainsPoint:p]) {
-                if([[self window] isKeyWindow]) {
+                /*
+                 * In fullscreen mode, the window of cocoaView may not =
be the
+                 * key window, therefore the position relative to the =
virtual
+                 * screen alone will be sufficient.
+                 */
+                if(isFullscreen || [[self window] isKeyWindow]) {
                    [self grabMouse];
                }
            }
--=20
2.19.2=
