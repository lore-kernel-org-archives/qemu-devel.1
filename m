Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJD-0004L3-Fa
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002Dz-G8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:07 -0400
Received: from smtp.citrix.com ([66.165.176.89]:9025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002D1-9t
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:04 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Thu, 8 Jun 2017 13:15:32 +0000
Message-ID: <1496927734-29174-3-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] xenfb: Activate mouse handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com, xen-devel@lists.xenproject.org, Owen Smith <owen.smith@citrix.com>

Mouse events are only delivered to the first handler in the chain.
Activating the xenfb mouse event handler so that mouse events can
be passed over the shared ring protocol.
Note: The keyboard handler is activated internally by the add
call.

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 hw/display/xenfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 2ebc81b..b0a5726 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -385,6 +385,7 @@ static void input_connected(struct XenDevice *xendev)
     in->qmouse = qemu_add_mouse_event_handler(xenfb_mouse_event, in,
 					      in->abs_pointer_wanted,
 					      "Xen PVFB Mouse");
+    qemu_activate_mouse_event_handler(in->qmouse);
 }
 
 static void input_disconnect(struct XenDevice *xendev)
-- 
2.1.4
