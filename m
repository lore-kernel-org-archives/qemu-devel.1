Received: from eggs.gnu.org ([2001:4830:134:3::10]:42132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICY0-0004uZ-9c
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICXv-0000Gs-Ed
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dICXv-0000GM-97
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56AD180460
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 11:21:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 13:21:05 +0200
Message-Id: <20170606112105.13331-4-kraxel@redhat.com>
In-Reply-To: <20170606112105.13331-1-kraxel@redhat.com>
References: <20170606112105.13331-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] ps2: reset queue in ps2_reset_keyboard
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

When the guest resets the keyboard also clear the queue.  It is highly
unlikely that the guest is still interested in the events stuck in the
queue, and it avoids confusing the guest in case the queue is full and
the ACK can't be queued up.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1372583
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 2416b58cc0..3ba05efd06 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -740,6 +740,7 @@ static void ps2_reset_keyboard(PS2KbdState *s)
     trace_ps2_reset_keyboard(s);
     s->scan_enabled = 1;
     s->scancode_set = 2;
+    ps2_reset_queue(&s->common);
     ps2_set_ledstate(s, 0);
 }
 
-- 
2.9.3
