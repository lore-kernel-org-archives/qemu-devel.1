Received: from eggs.gnu.org ([2001:4830:134:3::10]:43270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpE48-0005ya-Nl
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpE47-0007md-Vp
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 10:43:28 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Aug 2018 16:43:20 +0200
Message-Id: <20180813144320.12382-2-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] nvme: simplify plug/unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

bdrv_io_plug/bdrv_io_unplug take care of keeping a nesting count,
so change s->plugged to just a bool.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nvme.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index df2e16fabe..973db3decd 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -104,7 +104,7 @@ typedef struct {
     uint64_t nsze; /* Namespace size reported by identify command */
     int nsid;      /* The namespace id to read/write data. */
     uint64_t max_transfer;
-    int plugged;
+    bool plugged;
 
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
@@ -1110,7 +1110,8 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
 static void nvme_aio_plug(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
-    s->plugged++;
+    assert(!s->plugged);
+    s->plugged = true;
 }
 
 static void nvme_aio_unplug(BlockDriverState *bs)
@@ -1118,14 +1119,13 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     int i;
     BDRVNVMeState *s = bs->opaque;
     assert(s->plugged);
-    if (!--s->plugged) {
-        for (i = 1; i < s->nr_queues; i++) {
-            NVMeQueuePair *q = s->queues[i];
-            qemu_mutex_lock(&q->lock);
-            nvme_kick(s, q);
-            nvme_process_completion(s, q);
-            qemu_mutex_unlock(&q->lock);
-        }
+    s->plugged = false;
+    for (i = 1; i < s->nr_queues; i++) {
+        NVMeQueuePair *q = s->queues[i];
+        qemu_mutex_lock(&q->lock);
+        nvme_kick(s, q);
+        nvme_process_completion(s, q);
+        qemu_mutex_unlock(&q->lock);
     }
 }
 
-- 
2.17.1
