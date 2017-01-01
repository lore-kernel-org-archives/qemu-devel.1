Received: from eggs.gnu.org ([2001:4830:134:3::10]:36633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cNnik-0004xF-8u
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 16:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cNnih-0004Vy-7J
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 16:31:14 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:35414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cNnih-0004Vs-1I
	for qemu-devel@nongnu.org; Sun, 01 Jan 2017 16:31:11 -0500
Received: by mail-io0-x244.google.com with SMTP id f73so52839840ioe.2
	for <qemu-devel@nongnu.org>; Sun, 01 Jan 2017 13:31:10 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Sun, 1 Jan 2017 16:31:07 -0500
Message-Id: <84C57F4C-C8F8-4FB3-804A-FC3DE0AB6408@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] [PATCH v2] ui/cocoa.m: fix sending mouse event to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

The mouse down event should not be sent to the guest if the mouse down =
event
causes QEMU to move the foreground from the background. This patch =
prevents
these activation clicks from going to the guest.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
Fix a bug that caused fullscreen mode not to receive mouse events.

 ui/cocoa.m | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 26d4a1c..ae3f5a1 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -695,13 +695,13 @@ QemuCocoaView *cocoaView;
=20
     if (mouse_event) {
         /* Don't send button events to the guest unless we've got a
-         * mouse grab or window focus. If we have neither then this =
event
-         * is the user clicking on the background window to activate =
and
-         * bring us to the front, which will be done by the sendEvent
-         * call below. We definitely don't want to pass that click =
through
-         * to the guest.
+         * mouse grab, window focus, or in fullscreen mode. If we have =
neither
+         * then this event is the user clicking on the background =
window to
+         * activate and bring us to the front, which will be done by =
the
+         * sendEvent call below. We definitely don't want to pass that =
click
+         * through to the guest.
          */
-        if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
+        if (isMouseGrabbed && ([[self window] isKeyWindow] || =
isFullscreen) &&
             (last_buttons !=3D buttons)) {
             static uint32_t bmap[INPUT_BUTTON__MAX] =3D {
                 [INPUT_BUTTON_LEFT]       =3D MOUSE_EVENT_LBUTTON,
--=20
2.7.2
