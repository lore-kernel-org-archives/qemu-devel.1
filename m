Received: from eggs.gnu.org ([209.51.188.92]:37263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJtq-0007Ag-Gn
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hDJjK-0007mE-7r
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:09:51 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:50197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hDJjI-0007eD-46
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:09:48 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Chen Zhang <tgfbeta@me.com>
In-Reply-To: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
Date: Mon, 8 Apr 2019 10:09:42 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <91053E16-BF23-405F-971F-8042EEA50408@me.com>
References: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
Subject: [Qemu-devel] [PATCH 2/2] ui/cocoa: Fix mouse grabbing in fullscreen
 mode for relative input device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

In fullscreen mode, the window property of cocoaView may not be the key
window, and the current implementation would not grab mouse in =
fullscreen
mode after user ungrabs cursor in fullscreen mode with hot-key, and left
clicks the relative input devices to re-grab it.

This patch used value of isFullscreen as a short-cirtuit condition for
relative input device grabbing.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
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
2.19.2
