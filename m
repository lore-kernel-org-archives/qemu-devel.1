Received: from eggs.gnu.org ([2001:4830:134:3::10]:41275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1e8AzP-00054Q-U7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1e8AzM-0001KV-Px
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:12:23 -0400
From: Liang Yan <lyan@suse.com>
Date: Fri, 27 Oct 2017 16:12:07 -0400
Message-Id: <20171027201207.5979-1-lyan@suse.com>
Subject: [Qemu-devel] [PATCH] hw/display/xenfb: Simulate auto-repeat key
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

New tigervnc server changes the way to send long pressed key,
from "down up down up ..." to "down down ... up". So we insert
an up event after each key down event to simulate auto-repeat
key events for xen keyboard frontend driver.

Signed-off-by: Liang Yan <lyan@suse.com>
---
 hw/display/xenfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 8e2547ac05..a5f787a3f3 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -292,6 +292,9 @@ static void xenfb_key_event(void *opaque, int scancode)
     }
     trace_xenfb_key_event(opaque, scancode2linux[scancode], down);
     xenfb_send_key(xenfb, down, scancode2linux[scancode]);
+    if (down) { /* simulate auto-repeat key events */
+    xenfb_send_key(xenfb, 0, scancode2linux[scancode]);
+    }
 }
 
 /*
-- 
2.14.2
