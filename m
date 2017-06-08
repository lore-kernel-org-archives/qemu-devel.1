Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJG-0004NK-Ch
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002EA-Lx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:10 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=325bb5210=owen.smith@citrix.com>)
	id 1dIxJA-0002D2-EW
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:17:04 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Thu, 8 Jun 2017 13:15:34 +0000
Message-ID: <1496927734-29174-5-git-send-email-owen.smith@citrix.com>
In-Reply-To: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
References: <1496927734-29174-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/4] xenfb: Fix leak by adding/removing
 keyboard handler
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

Calls qemu_remove_kbd_event_handler that frees its memory, instead of
adding (and allocating some memory) a new NULL handler.

Signed-off-by: Owen Smith <owen.smith@citrix.com>
---
 hw/display/xenfb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index b0a5726..570ecdb 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -55,6 +55,7 @@ struct XenInput {
     int vkbd_standalone;    /* Guest supports vkbd without vfb device */
     int button_state;       /* Last seen pointer button state */
     int extended;
+    QEMUPutKbdEntry *qkbd;
     QEMUPutMouseEntry *qmouse;
 };
 
@@ -365,7 +366,6 @@ static int input_initialise(struct XenDevice *xendev)
     if (rc != 0)
 	return rc;
 
-    qemu_add_kbd_event_handler(xenfb_key_event, in);
     return 0;
 }
 
@@ -378,10 +378,14 @@ static void input_connected(struct XenDevice *xendev)
         in->abs_pointer_wanted = 0;
     }
 
+    if (in->qkbd) {
+        qemu_remove_kbd_event_handler(in->qkbd);
+    }
     if (in->qmouse) {
         qemu_remove_mouse_event_handler(in->qmouse);
     }
     trace_xenfb_input_connected(xendev, in->abs_pointer_wanted);
+    in->qkbd = qemu_add_kbd_event_handler(xenfb_key_event, in);
     in->qmouse = qemu_add_mouse_event_handler(xenfb_mouse_event, in,
 					      in->abs_pointer_wanted,
 					      "Xen PVFB Mouse");
@@ -392,11 +396,14 @@ static void input_disconnect(struct XenDevice *xendev)
 {
     struct XenInput *in = container_of(xendev, struct XenInput, c.xendev);
 
+    if (in->qkbd) {
+        qemu_remove_kbd_event_handler(in->qkbd);
+        in->qkbd = NULL;
+    }
     if (in->qmouse) {
 	qemu_remove_mouse_event_handler(in->qmouse);
 	in->qmouse = NULL;
     }
-    qemu_add_kbd_event_handler(NULL, NULL);
     common_unbind(&in->c);
 }
 
-- 
2.1.4
