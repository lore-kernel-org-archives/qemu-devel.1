Received: from eggs.gnu.org ([2001:4830:134:3::10]:38742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amp-0007gB-Re
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1Amd-00032H-4U
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:02:11 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Apr 2017 14:00:55 +0200
Message-Id: <20170420120058.28404-15-pbonzini@redhat.com>
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 14/17] block: optimize access to reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Hot path reqs_lock critical sections are very small; the only large critical
sections happen when a request waits for serialising requests, and these
should never happen in usual circumstances.

We do not want these small critical sections to yield in any case,
which calls for using a spinlock while writing the list.  The reqs_lock
is still used to protect the individual requests' CoQueue.  For this
purpose, serializing removals against concurrent walks of the request
list can use lock_unlock for efficiency and determinism.

The reqs_lock is also used to protect the flush generation counts, but
that's unrelated.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   |  1 +
 block/io.c                | 25 ++++++++++++++++++++-----
 include/block/block_int.h | 11 ++++++++---
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 3b2ed29..7ba6afe 100644
--- a/block.c
+++ b/block.c
@@ -234,6 +234,7 @@ BlockDriverState *bdrv_new(void)
         QLIST_INIT(&bs->op_blockers[i]);
     }
     notifier_with_return_list_init(&bs->before_write_notifiers);
+    qemu_spin_init(&bs->reqs_list_write_lock);
     qemu_co_mutex_init(&bs->reqs_lock);
     bs->refcnt = 1;
     bs->aio_context = qemu_get_aio_context();
diff --git a/block/io.c b/block/io.c
index 7af9d47..476807d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -374,14 +374,29 @@ void bdrv_drain_all(void)
  */
 static void tracked_request_end(BdrvTrackedRequest *req)
 {
+    BlockDriverState *bs = req->bs;
+
     if (req->serialising) {
-        atomic_dec(&req->bs->serialising_in_flight);
+        atomic_dec(&bs->serialising_in_flight);
     }
 
-    qemu_co_mutex_lock(&req->bs->reqs_lock);
+    /* Note that there can be a concurrent visit while we remove the list,
+     * so we need to...
+     */
+    qemu_spin_lock(&bs->reqs_list_write_lock);
     QLIST_REMOVE(req, list);
+    qemu_spin_unlock(&bs->reqs_list_write_lock);
+
+    /* ... wait for it to end before we leave.  qemu_co_mutex_lock_unlock
+     * avoids cacheline bouncing in the common case of no concurrent
+     * reader.
+     */
+    qemu_co_mutex_lock_unlock(&bs->reqs_lock);
+
+    /* Now no coroutine can add itself to the wait queue, so it is
+     * safe to call qemu_co_queue_restart_all outside the reqs_lock.
+     */
     qemu_co_queue_restart_all(&req->wait_queue);
-    qemu_co_mutex_unlock(&req->bs->reqs_lock);
 }
 
 /**
@@ -406,9 +421,9 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
 
     qemu_co_queue_init(&req->wait_queue);
 
-    qemu_co_mutex_lock(&bs->reqs_lock);
+    qemu_spin_lock(&bs->reqs_list_write_lock);
     QLIST_INSERT_HEAD(&bs->tracked_requests, req, list);
-    qemu_co_mutex_unlock(&bs->reqs_lock);
+    qemu_spin_unlock(&bs->reqs_list_write_lock);
 }
 
 static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 42b49f5..b298de8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -78,9 +78,10 @@ typedef struct BdrvTrackedRequest {
 
     QLIST_ENTRY(BdrvTrackedRequest) list;
     Coroutine *co; /* owner, used for deadlock detection */
-    CoQueue wait_queue; /* coroutines blocked on this request */
-
     struct BdrvTrackedRequest *waiting_for;
+
+    /* Protected by BlockDriverState's reqs_lock.  */
+    CoQueue wait_queue; /* coroutines blocked on this request */
 } BdrvTrackedRequest;
 
 struct BlockDriver {
@@ -626,11 +627,15 @@ struct BlockDriverState {
     int quiesce_counter;
     unsigned int write_gen;               /* Current data generation */
 
-    /* Protected by reqs_lock.  */
+    /* Writes are protected by reqs_list_write_lock.  Reads take
+     * reqs_lock so that removals can easily synchronize with walks.
+     */
     QLIST_HEAD(, BdrvTrackedRequest) tracked_requests;
     CoQueue flush_queue;                  /* Serializing flush queue */
     bool active_flush_req;                /* Flush request in flight? */
     unsigned int flushed_gen;             /* Flushed write generation */
+
+    QemuSpin reqs_list_write_lock;
     CoMutex reqs_lock;
 };
 
-- 
2.9.3
