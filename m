Received: from eggs.gnu.org ([2001:4830:134:3::10]:36980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dNwjw-0005cZ-D8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dNwjs-0007G5-DA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:41:20 -0400
From: Alexander Graf <agraf@suse.de>
Date: Thu, 22 Jun 2017 09:41:35 +0200
Message-Id: <1498117295-162030-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] hid: Reset kbd modifiers on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org

When resetting the keyboard, we need to reset not just the pending keystrokes,
but also any pending modifiers. Otherwise there's a race when we're getting
reset while running an escape sequence (modifier 0x100).

Cc: qemu-stable@nongnu.org
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 hw/input/hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 93887ec..0d049ff 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -487,6 +487,7 @@ void hid_reset(HIDState *hs)
         memset(hs->kbd.keycodes, 0, sizeof(hs->kbd.keycodes));
         memset(hs->kbd.key, 0, sizeof(hs->kbd.key));
         hs->kbd.keys = 0;
+        hs->kbd.modifiers = 0;
         break;
     case HID_MOUSE:
     case HID_TABLET:
-- 
1.8.5.6
