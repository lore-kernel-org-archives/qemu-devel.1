Received: from eggs.gnu.org ([2001:4830:134:3::10]:48454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1frFR5-0004lw-DT
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 00:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1frFR0-0005Tu-Da
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 00:35:31 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1frFR0-0005Tf-8t
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 00:35:26 -0400
Received: by mail-it0-x243.google.com with SMTP id 139-v6so16588005itf.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 21:35:26 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Sun, 19 Aug 2018 00:35:09 -0400
Message-Id: <20180819043509.12888-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/input/ps2.c: fix erratic mouse behavior for
 Windows 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

When the user moves the mouse and moves the scroll wheel at the same time, the mouse cursor's movement becomes erratic in Windows 3.1. With this patch if the mouse is in ps/2 mode and the scroll wheel is used, the command queue is reset. This does not fix the erratic mouse problem in Windows NT 4.0.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 hw/input/ps2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index fdfcadf9a1..bb9ebfa5a9 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -685,8 +685,17 @@ static int ps2_mouse_send_packet(PS2MouseState *s)
     /* update deltas */
     s->mouse_dx -= dx1;
     s->mouse_dy -= dy1;
-    s->mouse_dz -= dz1;
+    /*
+     * This prevents the mouse from going crazy in Windows that doesn't support
+     * the Microsoft Intellimouse standard.
+     */
+    if (s->mouse_type == 0 && s->mouse_dz != 0) {
+        s->mouse_dz = 0;
+        ps2_reset_queue(&s->common);
+        return 1;
+    }
 
+    s->mouse_dz -= dz1;
     return 1;
 }
 
-- 
2.14.3 (Apple Git-98)
