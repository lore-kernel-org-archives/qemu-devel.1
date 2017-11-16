Received: from eggs.gnu.org ([2001:4830:134:3::10]:46599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFHET-0003XO-SJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFHEP-0004cQ-Pe
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:17:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eFHEP-0004a0-Go
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:17:13 -0500
From: P J P <ppandit@redhat.com>
Date: Thu, 16 Nov 2017 15:46:55 +0530
Message-Id: <20171116101655.26357-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ps2: check PS2Queue indices in post_load
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
invalid, it could lead to OOB access issue. Add check to avoid
it.

Reported-by: Cyrille Chatras <cyrille.chatras@orange.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/input/ps2.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

Update: return -1(bad indices) error, instead of correcting values
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02964.html

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index f388a23c8e..35392d55fc 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1222,32 +1222,37 @@ static void ps2_common_reset(PS2State *s)
     s->update_irq(s->update_arg, 0);
 }
 
-static void ps2_common_post_load(PS2State *s)
+static int ps2_common_post_load(PS2State *s)
 {
     PS2Queue *q = &s->queue;
     int size;
     int i;
     int tmp_data[PS2_QUEUE_SIZE];
 
+    if (q->count < 0 || q->rptr < 0 || q->rptr >= sizeof(q->data)) {
+        return -1;
+    }
+
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
+    for (i = 0; i < size; i++) {
+        /* move the queue elements to the temporary buffer */
+        tmp_data[i] = q->data[q->rptr];
+        if (++q->rptr == 256) {
+            q->rptr = 0;
         }
-        memcpy(q->data, tmp_data, size);
     }
+    memcpy(q->data, tmp_data, size);
+
     /* reset rptr/wptr/count */
     q->rptr = 0;
     q->wptr = size;
     q->count = size;
     s->update_irq(s->update_arg, q->count != 0);
+
+    return 0;
 }
 
 static void ps2_kbd_reset(void *opaque)
@@ -1346,9 +1351,7 @@ static int ps2_kbd_post_load(void* opaque, int version_id)
     if (version_id == 2)
         s->scancode_set=2;
 
-    ps2_common_post_load(ps2);
-
-    return 0;
+    return ps2_common_post_load(ps2);
 }
 
 static int ps2_kbd_pre_save(void *opaque)
@@ -1356,9 +1359,7 @@ static int ps2_kbd_pre_save(void *opaque)
     PS2KbdState *s = (PS2KbdState *)opaque;
     PS2State *ps2 = &s->common;
 
-    ps2_common_post_load(ps2);
-
-    return 0;
+    return ps2_common_post_load(ps2);
 }
 
 static const VMStateDescription vmstate_ps2_keyboard = {
@@ -1386,9 +1387,7 @@ static int ps2_mouse_post_load(void *opaque, int version_id)
     PS2MouseState *s = (PS2MouseState *)opaque;
     PS2State *ps2 = &s->common;
 
-    ps2_common_post_load(ps2);
-
-    return 0;
+    return ps2_common_post_load(ps2);
 }
 
 static int ps2_mouse_pre_save(void *opaque)
@@ -1396,9 +1395,7 @@ static int ps2_mouse_pre_save(void *opaque)
     PS2MouseState *s = (PS2MouseState *)opaque;
     PS2State *ps2 = &s->common;
 
-    ps2_common_post_load(ps2);
-
-    return 0;
+    return ps2_common_post_load(ps2);
 }
 
 static const VMStateDescription vmstate_ps2_mouse = {
-- 
2.13.6
