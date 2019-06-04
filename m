Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FA7C28CC3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50BE206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 01:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50BE206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYKJh-0007f8-Vg
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 21:02:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cuser@cusers-Mac-mini.local>) id 1hYKIB-0006ax-IU
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cuser@cusers-Mac-mini.local>) id 1hYKI9-0007CC-QH
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:00:39 -0400
Received: from [36.106.167.139] (port=63964 helo=cusers-Mac-mini.local)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cuser@cusers-Mac-mini.local>) id 1hYKI7-000703-OW
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 21:00:37 -0400
Received: by cusers-Mac-mini.local (Postfix, from userid 501)
	id 65397EFD867; Tue,  4 Jun 2019 17:13:58 +0800 (CST)
To: peter.maydell@linaro.org,
	kraxel@redhat.com
Date: Tue,  4 Jun 2019 17:12:44 +0800
Message-Id: <cd6cc9df4d256b39f9c43abb95b6fdf980e60fd4.1559638310.git.tgfbeta@me.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559638310.git.tgfbeta@me.com>
References: <cover.1559638310.git.tgfbeta@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Mac OS X  [generic] [fuzzy]
X-Received-From: 36.106.167.139
Subject: [Qemu-devel] [PATCH 1/2] ui/cocoa: Fix absolute input device
 grabbing issue on Mojave
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org, Chen Zhang <tgfbeta@me.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mojave, absolute input device, i.e. tablet, had trouble re-grabbing
the cursor in re-entry into the virtual screen area. In some cases,
the `window` property of NSEvent object was nil after cursor exiting from
window, hinting that the `-locationInWindow` method would return value in=
=20
screen coordinates. The current implementation used raw locations from=20
NSEvent without considering whether the value was for the window coordina=
tes
or the macOS screen coordinates, nor the zooming factor for Zoom-to-Fit i=
n
fullscreen mode.

In fullscreen mode, the fullscreen cocoa window might not be the key
window, therefore the location of event in virtual coordinates should
suffice.

This patches fixed boundary check methods for cursor in normal
and fullscreen with/without Zoom-to-Fit in Mojave.

Note: CGRect, -convertRectToScreen: and -convertRectFromScreen: were
used in coordinates conversion for compatibility reason.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 ui/cocoa.m | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 420b2411c1..474d44cb9f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -405,6 +405,41 @@ QemuCocoaView *cocoaView;
     return (p.x > -1 && p.x < screen.width && p.y > -1 && p.y < screen.h=
eight);
 }
=20
+/* Get location of event and convert to virtual screen coordinate */
+- (CGPoint) screenLocationOfEvent:(NSEvent *)ev
+{
+    NSWindow *eventWindow =3D [ev window];
+    // XXX: Use CGRect and -convertRectFromScreen: to support macOS 10.1=
0
+    CGRect r =3D CGRectZero;
+    r.origin =3D [ev locationInWindow];
+    if (!eventWindow) {
+        if (!isFullscreen) {
+            return [[self window] convertRectFromScreen:r].origin;
+        } else {
+            CGPoint locationInSelfWindow =3D [[self window] convertRectF=
romScreen:r].origin;
+            CGPoint loc =3D [self convertPoint:locationInSelfWindow from=
View:nil];
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
+        return [[self window] convertRectFromScreen:[eventWindow convert=
RectToScreen:r]].origin;
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
=20
     switch ([event type]) {
         case NSEventTypeFlagsChanged:
@@ -815,7 +851,10 @@ QemuCocoaView *cocoaView;
             break;
         case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
-                if (![self screenContainsPoint:p] || ![[self window] isK=
eyWindow]) {
+                // Cursor re-entered into a window might generate events=
 bound to screen coordinates
+                // and `nil` window property, and in full screen mode, c=
urrent window might not be
+                // key window, where event location alone should suffice=
.
+                if (![self screenContainsPoint:p] || !([[self window] is=
KeyWindow] || isFullscreen)) {
                     if (isMouseGrabbed) {
                         [self ungrabMouse];
                     }
--=20
2.21.0


