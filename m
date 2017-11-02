Received: from eggs.gnu.org ([2001:4830:134:3::10]:54622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1eAJ90-00080B-2S
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lyan@suse.com>) id 1eAJ8v-0006ib-Ok
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:19:05 -0400
From: Liang Yan <lyan@suse.com>
Date: Thu,  2 Nov 2017 13:18:46 -0400
Message-Id: <20171102171846.21445-1-lyan@suse.com>
Subject: [Qemu-devel] [PATCH v2] hw/display/xenfb: Simulate auto-repeat key
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

New tigervnc changes the way to send long pressed key,
from "down up down up ..." to "down down ... up", it only
affects xen pv console mode. I send a patch to latest
kernel side, but it may have a fix in qemu backend for
back compatible becase guest VMs may use very old kernel.
This patch inserts an up event after each regular key down
event to simulate an auto-repeat key event for xen keyboard
frontend driver.

Signed-off-by: Liang Yan <lyan@suse.com>
---
v2:
- exclude extended key
- change log comment

 hw/display/xenfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 8e2547ac05..1bc5b41ab7 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -292,6 +292,11 @@ static void xenfb_key_event(void *opaque, int scancode)
     }
     trace_xenfb_key_event(opaque, scancode2linux[scancode], down);
     xenfb_send_key(xenfb, down, scancode2linux[scancode]);
+
+    /* insert an up event for regular down key event */
+    if (down && !xenfb->extended) {
+        xenfb_send_key(xenfb, 0, scancode2linux[scancode]);
+    }
 }
 
 /*
-- 
2.14.2
