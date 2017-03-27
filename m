Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGN-0007uy-TV
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1csWGM-0000DR-DO
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1csWGM-0000Cq-5P
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50C088046F
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 15:08:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Mar 2017 15:28:34 +0200
Message-Id: <1490621317-25483-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
References: <1490621317-25483-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 2/5] virtio-input: fix eventq batching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

virtio_input_send buffers input events until it sees a SYNC. Then it
either sends or drops the entire batch, depending on whether eventq
has enough space available. The case to avoid here is partial sends
where only part of the batch would get to the guest.

Using virtqueue_get_avail_bytes to check the state of eventq was not
correct. The queue may have a smaller number of larger buffers
available so bytes may be enough but the batch would still not be
possible to send, leading to the "Huh?  No vq elem available" error.

Instead of checking available bytes, this patch optimistically pops
buffers from the queue and puts them back in case it runs out of
space and the batch needs to be dropped.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 1490365490-4854-3-git-send-email-lprosek@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/input/virtio-input.c          | 29 ++++++++++++++---------------
 include/hw/virtio/virtio-input.h |  5 ++++-
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 728832a..0e42f0d 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -22,7 +22,6 @@
 void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event)
 {
     VirtQueueElement *elem;
-    unsigned have, need;
     int i, len;
 
     if (!vinput->active) {
@@ -33,9 +32,9 @@ void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event)
     if (vinput->qindex == vinput->qsize) {
         vinput->qsize++;
         vinput->queue = g_realloc(vinput->queue, vinput->qsize *
-                                  sizeof(virtio_input_event));
+                                  sizeof(vinput->queue[0]));
     }
-    vinput->queue[vinput->qindex++] = *event;
+    vinput->queue[vinput->qindex++].event = *event;
 
     /* ... until we see a report sync ... */
     if (event->type != cpu_to_le16(EV_SYN) ||
@@ -44,24 +43,24 @@ void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event)
     }
 
     /* ... then check available space ... */
-    need = sizeof(virtio_input_event) * vinput->qindex;
-    virtqueue_get_avail_bytes(vinput->evt, &have, NULL, need, 0);
-    if (have < need) {
-        vinput->qindex = 0;
-        trace_virtio_input_queue_full();
-        return;
-    }
-
-    /* ... and finally pass them to the guest */
     for (i = 0; i < vinput->qindex; i++) {
         elem = virtqueue_pop(vinput->evt, sizeof(VirtQueueElement));
         if (!elem) {
-            /* should not happen, we've checked for space beforehand */
-            fprintf(stderr, "%s: Huh?  No vq elem available ...\n", __func__);
+            while (--i >= 0) {
+                virtqueue_unpop(vinput->evt, vinput->queue[i].elem, 0);
+            }
+            vinput->qindex = 0;
+            trace_virtio_input_queue_full();
             return;
         }
+        vinput->queue[i].elem = elem;
+    }
+
+    /* ... and finally pass them to the guest */
+    for (i = 0; i < vinput->qindex; i++) {
+        elem = vinput->queue[i].elem;
         len = iov_from_buf(elem->in_sg, elem->in_num,
-                           0, vinput->queue+i, sizeof(virtio_input_event));
+                           0, &vinput->queue[i].event, sizeof(virtio_input_event));
         virtqueue_push(vinput->evt, elem, len);
         g_free(elem);
     }
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index 55db310..91df57e 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -62,7 +62,10 @@ struct VirtIOInput {
     VirtQueue                         *evt, *sts;
     char                              *serial;
 
-    virtio_input_event                *queue;
+    struct {
+        virtio_input_event event;
+        VirtQueueElement *elem;
+    }                                 *queue;
     uint32_t                          qindex, qsize;
 
     bool                              active;
-- 
1.8.3.1
