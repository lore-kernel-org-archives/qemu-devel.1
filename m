Received: from eggs.gnu.org ([208.118.235.92]:43042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDv0-0002vB-Jl
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDcD-0007x9-BD
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:21:26 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Dec 2018 15:20:25 +0300
Message-Id: <20181229122027.42245-10-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-1-vsementsov@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 09/11] block: add lock/unlock range functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

From: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>

Introduce lock/unlock range functionality, based on serialized
requests. This is needed to refactor backup, dropping local
tracked-request-like synchronization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>
---
 include/block/block_int.h |  4 ++++
 block/io.c                | 45 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..3475ee5360 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -64,6 +64,7 @@ enum BdrvTrackedRequestType {
     BDRV_TRACKED_WRITE,
     BDRV_TRACKED_DISCARD,
     BDRV_TRACKED_TRUNCATE,
+    BDRV_TRACKED_LOCK,
 };
 
 typedef struct BdrvTrackedRequest {
@@ -856,6 +857,9 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+void *coroutine_fn bdrv_co_try_lock(BdrvChild *child,
+                                    int64_t offset, unsigned int bytes);
+void coroutine_fn bdrv_co_unlock(void *opaque);
 
 extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
diff --git a/block/io.c b/block/io.c
index b87c11a6ec..38a63d16f1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -720,6 +720,15 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
     bdrv_wakeup(bs);
 }
 
+static bool ignore_intersection(BdrvTrackedRequest *a, BdrvTrackedRequest *b)
+{
+    return a == b || (!a->serialising && !b->serialising) ||
+        (a->type == BDRV_TRACKED_LOCK && b->type == BDRV_TRACKED_READ &&
+         !b->serialising) ||
+        (b->type == BDRV_TRACKED_LOCK && a->type == BDRV_TRACKED_READ &&
+         !a->serialising);
+}
+
 static bool coroutine_fn do_wait_serialising_requests(BdrvTrackedRequest *self,
                                                       bool wait)
 {
@@ -736,7 +745,7 @@ static bool coroutine_fn do_wait_serialising_requests(BdrvTrackedRequest *self,
         retry = false;
         qemu_co_mutex_lock(&bs->reqs_lock);
         QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req == self || (!req->serialising && !self->serialising)) {
+            if (ignore_intersection(self, req)) {
                 continue;
             }
             if (tracked_request_overlaps(req, self->overlap_offset,
@@ -774,6 +783,12 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
     return do_wait_serialising_requests(self, true);
 }
 
+static bool coroutine_fn should_wait_serialising_requests(
+        BdrvTrackedRequest *self)
+{
+    return do_wait_serialising_requests(self, false);
+}
+
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
                                    size_t size)
 {
@@ -3250,3 +3265,31 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
 
     return tco.ret;
 }
+
+void *coroutine_fn bdrv_co_try_lock(BdrvChild *child,
+                                    int64_t offset, unsigned int bytes)
+{
+    BlockDriverState *bs = child->bs;
+    BdrvTrackedRequest *req = g_new(BdrvTrackedRequest, 1);
+
+    tracked_request_begin(req, bs, offset, bytes, BDRV_TRACKED_LOCK);
+    mark_request_serialising(req, bdrv_get_cluster_size(bs));
+
+    if (should_wait_serialising_requests(req)) {
+        tracked_request_end(req);
+        g_free(req);
+        return NULL;
+    }
+
+    return req;
+}
+
+void coroutine_fn bdrv_co_unlock(void *opaque)
+{
+    BdrvTrackedRequest *req = opaque;
+
+    assert(req->type == BDRV_TRACKED_LOCK);
+
+    tracked_request_end(req);
+    g_free(req);
+}
-- 
2.18.0
