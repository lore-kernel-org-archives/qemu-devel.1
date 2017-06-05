Received: from eggs.gnu.org ([2001:4830:134:3::10]:41729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI7-0008VL-L8
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrI6-0005zQ-Oa
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrI6-0005y8-Fb
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:26 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8103783F40
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:39:02 +0200
Message-Id: <20170605123908.18777-14-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/19] block: protect tracked_requests and
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
Cc: famz@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   |  1 +
 block/io.c                | 16 ++++++++++++++--
 include/block/block_int.h | 14 +++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 361005cba9..a5cbd4540f 100644
--- a/block.c
+++ b/block.c
@@ -320,6 +320,7 @@ BlockDriverState *bdrv_new(void)
         QLIST_INIT(&bs->op_blockers[i]);
     }
     notifier_with_return_list_init(&bs->before_write_notifiers);
+    qemu_co_mutex_init(&bs->reqs_lock);
     bs->refcnt = 1;
     bs->aio_context = qemu_get_aio_context();
 
diff --git a/block/io.c b/block/io.c
index 036f5a4870..91611ffb2a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -378,8 +378,10 @@ static void tracked_request_end(BdrvTrackedRequest *req)
         atomic_dec(&req->bs->serialising_in_flight);
     }
 
+    qemu_co_mutex_lock(&req->bs->reqs_lock);
     QLIST_REMOVE(req, list);
     qemu_co_queue_restart_all(&req->wait_queue);
+    qemu_co_mutex_unlock(&req->bs->reqs_lock);
 }
 
 /**
@@ -404,7 +406,9 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 
     qemu_co_queue_init(&req->wait_queue);
 
+    qemu_co_mutex_lock(&bs->reqs_lock);
     QLIST_INSERT_HEAD(&bs->tracked_requests, req, list);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
 }
 
 static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
@@ -526,6 +530,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
 
     do {
         retry = false;
+        qemu_co_mutex_lock(&bs->reqs_lock);
         QLIST_FOREACH(req, &bs->tracked_requests, list) {
             if (req == self || (!req->serialising && !self->serialising)) {
                 continue;
@@ -544,7 +549,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
                     self->waiting_for = req;
-                    qemu_co_queue_wait(&req->wait_queue, NULL);
+                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
                     self->waiting_for = NULL;
                     retry = true;
                     waited = true;
@@ -552,6 +557,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                 }
             }
         }
+        qemu_co_mutex_unlock(&bs->reqs_lock);
     } while (retry);
 
     return waited;
@@ -2291,14 +2297,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
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
@@ -2370,9 +2379,12 @@ out:
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
index 8a9bc0bebc..31fb3640f1 100644
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
2.13.0
