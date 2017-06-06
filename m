Received: from eggs.gnu.org ([2001:4830:134:3::10]:42133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICY0-0004ua-9i
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICXv-0000Gm-Ba
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dICXv-0000GG-6U
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EC98C0587CD
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 11:21:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 13:21:04 +0200
Message-Id: <20170606112105.13331-3-kraxel@redhat.com>
In-Reply-To: <20170606112105.13331-1-kraxel@redhat.com>
References: <20170606112105.13331-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] ps2: add ps2_reset_queue
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

Factor out ps2 queue reset to a separate function.
No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 37f8cb842e..2416b58cc0 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -551,6 +551,15 @@ static uint8_t translate_table[256] = {
     0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
 };
 
+static void ps2_reset_queue(PS2State *s)
+{
+    PS2Queue *q = &s->queue;
+
+    q->rptr = 0;
+    q->wptr = 0;
+    q->count = 0;
+}
+
 void ps2_queue(PS2State *s, int b)
 {
     PS2Queue *q = &s->queue;
@@ -1079,12 +1088,8 @@ void ps2_write_mouse(void *opaque, int val)
 
 static void ps2_common_reset(PS2State *s)
 {
-    PS2Queue *q;
     s->write_cmd = -1;
-    q = &s->queue;
-    q->rptr = 0;
-    q->wptr = 0;
-    q->count = 0;
+    ps2_reset_queue(s);
     s->update_irq(s->update_arg, 0);
 }
 
-- 
2.9.3
