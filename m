Received: from eggs.gnu.org ([2001:4830:134:3::10]:56902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFB-00070S-5u
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF7-0000qZ-JK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmF7-0000pI-Ax
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:35 +0800
Message-Id: <20180815031248.14908-5-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 04/17] nvme: simplify plug/unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

bdrv_io_plug/bdrv_io_unplug take care of keeping a nesting count,
so change s->plugged to just a bool.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180813144320.12382-2-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nvme.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 37805e8890..781d77d6d2 100644
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
@@ -1101,7 +1101,8 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
 static void nvme_aio_plug(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
-    s->plugged++;
+    assert(!s->plugged);
+    s->plugged = true;
 }
 
 static void nvme_aio_unplug(BlockDriverState *bs)
@@ -1109,14 +1110,13 @@ static void nvme_aio_unplug(BlockDriverState *bs)
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
