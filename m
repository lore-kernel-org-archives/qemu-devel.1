Received: from eggs.gnu.org ([2001:4830:134:3::10]:34418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0F-0002nh-RJ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dOM0E-00056Q-MF
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dOM0E-00056A-FY
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70B1840F14
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:39:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Jun 2017 12:39:45 +0200
Message-Id: <20170623103945.7014-8-kraxel@redhat.com>
In-Reply-To: <20170623103945.7014-1-kraxel@redhat.com>
References: <20170623103945.7014-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] ps2: reset queue in ps2_reset_keyboard
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
Message-id: 20170606112105.13331-4-kraxel@redhat.com
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
