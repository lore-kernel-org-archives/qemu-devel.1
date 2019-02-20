Received: from eggs.gnu.org ([209.51.188.92]:39982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwOiA-00070J-4U
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwOi8-00035R-Gv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:02:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwOi8-000356-7r
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:02:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83B1FC05D41E
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:02:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 11:02:35 +0100
Message-Id: <20190220100235.20914-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] kbd-state: don't block auto-repeat events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/kbd-state.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index ac14add70e..09e3cfedfc 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -42,14 +42,18 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
 {
     bool state = test_bit(qcode, kbd->keys);
 
-    if (state == down) {
+    if (down == false  /* got key-up event   */ &&
+        state == false /* key is not pressed */) {
         /*
-         * Filter out events which don't change the keyboard state.
+         * Filter out suspious key-up events.
          *
-         * Most notably this allows to simply send along all key-up
-         * events, and this function will filter out everything where
-         * the corresponding key-down event wasn't send to the guest,
-         * for example due to being a host hotkey.
+         * This allows to simply send along all key-up events, and
+         * this function will filter out everything where the
+         * corresponding key-down event wasn't send to the guest, for
+         * example due to being a host hotkey.
+         *
+         * Note that key-down events on already pressed keys are *not*
+         * suspious, those are keyboard autorepeat events.
          */
         return;
     }
-- 
2.9.3
