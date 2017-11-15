Received: from eggs.gnu.org ([2001:4830:134:3::10]:36603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eEx57-0001UL-IU
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eEx54-00041V-8Q
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:46:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eEx54-00040v-2e
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:46:14 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 15 Nov 2017 18:16:02 +0530
Message-Id: <20171115124602.12501-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] ps2: fix PS2Queue counter field type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

During Qemu guest migration, a destination process invokes ps2
post_load function. In that, if 'rptr' and 'count' fields were
tampered, it could lead to OOB access or infinite loop issues.
Change their type to 'uint8_t' so they remain within bounds.

Reported-by: Cyrille Chatras <cyrille.chatras@orange.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/input/ps2.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f388a23c8e..ce4b167084 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -90,7 +90,7 @@ typedef struct {
     /* Keep the data array 256 bytes long, which compatibility
      with older qemu versions. */
     uint8_t data[256];
-    int rptr, wptr, count;
+    uint8_t rptr, wptr, count;
 } PS2Queue;
 
 struct PS2State {
@@ -1225,24 +1225,18 @@ static void ps2_common_reset(PS2State *s)
 static void ps2_common_post_load(PS2State *s)
 {
     PS2Queue *q = &s->queue;
-    int size;
-    int i;
-    int tmp_data[PS2_QUEUE_SIZE];
+    uint8_t i, size;
+    uint8_t tmp_data[PS2_QUEUE_SIZE];
 
     /* set the useful data buffer queue size, < PS2_QUEUE_SIZE */
     size = q->count > PS2_QUEUE_SIZE ? 0 : q->count;
 
     /* move the queue elements to the start of data array */
-    if (size > 0) {
-        for (i = 0; i < size; i++) {
-            /* move the queue elements to the temporary buffer */
-            tmp_data[i] = q->data[q->rptr];
-            if (++q->rptr == 256) {
-                q->rptr = 0;
-            }
-        }
-        memcpy(q->data, tmp_data, size);
+    for (i = 0; i < size; i++) {
+        tmp_data[i] = q->data[q->rptr++];
     }
+    memcpy(q->data, tmp_data, size);
+
     /* reset rptr/wptr/count */
     q->rptr = 0;
     q->wptr = size;
@@ -1286,9 +1280,9 @@ static const VMStateDescription vmstate_ps2_common = {
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(write_cmd, PS2State),
-        VMSTATE_INT32(queue.rptr, PS2State),
-        VMSTATE_INT32(queue.wptr, PS2State),
-        VMSTATE_INT32(queue.count, PS2State),
+        VMSTATE_UINT8(queue.rptr, PS2State),
+        VMSTATE_UINT8(queue.wptr, PS2State),
+        VMSTATE_UINT8(queue.count, PS2State),
         VMSTATE_BUFFER(queue.data, PS2State),
         VMSTATE_END_OF_LIST()
     }
-- 
2.13.6
