Received: from eggs.gnu.org ([2001:4830:134:3::10]:34423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002nl-SE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0C-00055Q-3p
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:41 +0200
Message-Id: <20170623103945.7014-4-kraxel@redhat.com>
In-Reply-To: <20170623103945.7014-1-kraxel@redhat.com>
References: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] hid: Reset kbd modifiers on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

When resetting the keyboard, we need to reset not just the pending keystrokes,
but also any pending modifiers. Otherwise there's a race when we're getting
reset while running an escape sequence (modifier 0x100).

Cc: qemu-stable@nongnu.org
Signed-off-by: Alexander Graf <agraf@suse.de>
Message-id: 1498117295-162030-1-git-send-email-agraf@suse.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 93887ecc43..0d049ff61c 100644
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
2.9.3
