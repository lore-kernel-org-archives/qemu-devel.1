Received: from eggs.gnu.org ([2001:4830:134:3::10]:37394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFEy7-0005AJ-0U
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFEy3-0005lX-Uf
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:52:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eFEy3-0005kd-O3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:52:11 -0500
From: P J P <ppandit@redhat.com>
Date: Thu, 16 Nov 2017 13:21:55 +0530
Message-Id: <20171116075155.22378-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] ps2: check PS2Queue pointers in post_load
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

During Qemu guest migration, a destination process invokes ps2
post_load function. In that, if 'rptr' and 'count' values were
invalid, it could lead to OOB access or infinite loop issue.
Add check to avoid it.

Reported-by: Cyrille Chatras <cyrille.chatras@orange.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/input/ps2.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Update: avoid changing field type, add range check on values
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02815.html

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f388a23c8e..de171a28dd 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1225,24 +1225,21 @@ static void ps2_common_reset(PS2State *s)
 static void ps2_common_post_load(PS2State *s)
 {
     PS2Queue *q = &s->queue;
-    int size;
-    int i;
-    int tmp_data[PS2_QUEUE_SIZE];
+    uint8_t i, size;
+    uint8_t tmp_data[PS2_QUEUE_SIZE];
 
     /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
-    size = q->count > PS2_QUEUE_SIZE ? 0 : q->count;
+    size = (q->count < 0 || q->count > PS2_QUEUE_SIZE) ? 0 : q->count;
 
     /* move the queue elements to the start of data array */
-    if (size > 0) {
-        for (i = 0; i < size; i++) {
-            /* move the queue elements to the temporary buffer */
-            tmp_data[i] = q->data[q->rptr];
-            if (++q->rptr == 256) {
-                q->rptr = 0;
-            }
+    for (i = 0; i < size; i++) {
+        if (q->rptr < 0 || q->rptr >= sizeof(q->data)) {
+            q->rptr = 0;
         }
-        memcpy(q->data, tmp_data, size);
+        tmp_data[i] = q->data[q->rptr++];
     }
+    memcpy(q->data, tmp_data, size);
+
     /* reset rptr/wptr/count */
     q->rptr = 0;
     q->wptr = size;
-- 
2.13.6
