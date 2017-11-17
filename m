Received: from eggs.gnu.org ([2001:4830:134:3::10]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdO7-0003gp-BM
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdO3-0003Op-51
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:56:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdO2-0003O0-VF
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:56:39 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 10:56:34 +0100
Message-Id: <20171117095634.13947-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ps2: simplify ps2_common_post_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

It's broken right now, due to q->data and tmp_data data types not
being the same.  So, with that being unnoticed for years I guess
the queue backward compatibility handling (for old qemu versions
with a larger queue) can't be that important.

So, in case we find any queue data we can't accept just drop the
events.  That also catches some cases we didn't notice before and
avoids oob access due to invalid migration streams.

Remove the (broken) code which moved around the queue elements.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Reported-by: Cyrille Chatras <cyrille.chatras@orange.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/ps2.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f388a23c8e..dfc3956bad 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1225,28 +1225,17 @@ static void ps2_common_reset(PS2State *s)
 static void ps2_common_post_load(PS2State *s)
 {
     PS2Queue *q = &s->queue;
-    int size;
-    int i;
-    int tmp_data[PS2_QUEUE_SIZE];
 
-    /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
-    size = q->count > PS2_QUEUE_SIZE ? 0 : q->count;
-
-    /* move the queue elements to the start of data array */
-    if (size > 0) {
-        for (i = 0; i < size; i++) {
-            /* move the queue elements to the temporary buffer */
-            tmp_data[i] = q->data[q->rptr];
-            if (++q->rptr == 256) {
-                q->rptr = 0;
-            }
-        }
-        memcpy(q->data, tmp_data, size);
+    if (q->count < 0 || q->count > PS2_QUEUE_SIZE ||
+        q->rptr  < 0 || q->rptr  >= PS2_QUEUE_SIZE ||
+        q->wptr  < 0 || q->wptr  >= PS2_QUEUE_SIZE) {
+        /* sanity check failed -> drop input events */
+        ps2_reset_queue(s);
+        return;
     }
-    /* reset rptr/wptr/count */
-    q->rptr = 0;
-    q->wptr = size;
-    q->count = size;
+
+    /* wptr is redundant.  Set it for consistency reasons. */
+    q->wptr = (q->rptr + q->count) % PS2_QUEUE_SIZE;
     s->update_irq(s->update_arg, q->count != 0);
 }
 
-- 
2.9.3
