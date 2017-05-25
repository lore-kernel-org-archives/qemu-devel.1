Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvh3-0004yN-B9
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgy-00043z-Ds
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:57 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 May 2017 18:32:20 +0200
Message-Id: <20170525163225.29954-14-pbonzini@redhat.com>
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/18] block: protect tracked_requests and
 flush_queue with reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   |  1 +
 block/io.c                | 16 ++++++++++++++--
 include/block/block_int.h | 14 +++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 45a77f5..d297188 100644
--- a/block.c
+++ b/block.c
@@ -280,6 +280,7 @@ BlockDriverState *bdrv_new(void)
         QLIST_INIT(&bs->op_blockers[i]);
     }
     notifier_with_return_list_init(&bs->before_write_notifiers);
+    qemu_co_mutex_init(&bs->reqs_lock);
     bs->refcnt = 1;
     bs->aio_context = qemu_get_aio_context();
 
diff --git a/block/io.c b/block/io.c
index 8021b5b..caca63a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -391,8 +391,10 @@ static void tracked_request_end(BdrvTrackedRequest *req)
         atomic_dec(&req->bs->serialising_in_flight);
     }
 
+    qemu_co_mutex_lock(&req->bs->reqs_lock);
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
+    qemu_co_mutex_unlock(&req->bs->reqs_lock);
 }
 
 /**
@@ -417,7 +419,9 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 
     qemu_co_queue_init(&req->wait_queue);
 
+    qemu_co_mutex_lock(&bs->reqs_lock);
     QLIST_INSERT_HEAD(&bs->tracked_requests, req, list);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
 }
 
 static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
@@ -539,6 +543,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
 
     do {
         retry = false;
+        qemu_co_mutex_lock(&bs->reqs_lock);
         QLIST_FOREACH(req, &bs->tracked_requests, list) {
             if (req == self || (!req->serialising && !self->serialising)) {
                 continue;
@@ -557,7 +562,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
                     self->waiting_for = req;
-                    qemu_co_queue_wait(&req->wait_queue, NULL);
+                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
                     self->waiting_for = NULL;
                     retry = true;
                     waited = true;
@@ -565,6 +570,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                 }
             }
         }
+        qemu_co_mutex_unlock(&bs->reqs_lock);
     } while (retry);
 
     return waited;
@@ -2304,14 +2310,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto early_exit;
     }
 
+    qemu_co_mutex_lock(&bs->reqs_lock);
     current_gen = atomic_read(&bs->write_gen);
 
     /* Wait until any previous flushes are completed */
     while (bs->active_flush_req) {
-        qemu_co_queue_wait(&bs->flush_queue, NULL);
+        qemu_co_queue_wait(&bs->flush_queue, &bs->reqs_lock);
     }
 
+    /* Flushes reach this point in nondecreasing current_gen order.  */
     bs->active_flush_req = true;
+    qemu_co_mutex_unlock(&bs->reqs_lock);
 
     /* Write back all layers by calling one driver function */
     if (bs->drv->bdrv_co_flush) {
@@ -2383,9 +2392,12 @@ out:
     if (ret == 0) {
         bs->flushed_gen = current_gen;
     }
+
+    qemu_co_mutex_lock(&bs->reqs_lock);
     bs->active_flush_req = false;
     /* Return value is ignored - it's ok if wait queue is empty */
     qemu_co_queue_next(&bs->flush_queue);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
 
 early_exit:
     bdrv_dec_in_flight(bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 74d6e62..4b2c594 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -609,11 +609,6 @@ struct BlockDriverState {
     uint64_t write_threshold_offset;
     NotifierWithReturn write_threshold_notifier;
 
-    QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
-    CoQueue flush_queue;                  /* Serializing flush queue */
-    bool active_flush_req;                /* Flush request in flight? */
-    unsigned int flushed_gen;             /* Flushed write generation */
-
     QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;
 
     /* Offset after the highest byte written to */
@@ -647,6 +642,15 @@ struct BlockDriverState {
     /* Accessed with atomic ops.  */
     int quiesce_counter;
     unsigned int write_gen;               /* Current data generation */
+
+    /* Protected by reqs_lock.  */
+    CoMutex reqs_lock;
+    QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
+    CoQueue flush_queue;                  /* Serializing flush queue */
+    bool active_flush_req;                /* Flush request in flight? */
+
+    /* Only read/written by whoever has set active_flush_req to true.  */
+    unsigned int flushed_gen;             /* Flushed write generation */
 };
 
 struct BlockBackendRootState {
-- 
1.8.3.1
