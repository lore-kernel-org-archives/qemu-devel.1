Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OD-0008JD-WA
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OA-00053J-Ld
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:31 +0300
Message-Id: <20181015160633.63130-10-vsementsov@virtuozzo.com>
In-Reply-To: <20181015160633.63130-1-vsementsov@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 09/11] block: add lock/unlock range functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

From: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>

Introduce lock/unlock range functionality, based on serialized
requests. This is needed to refactor backup, dropping local
tracked-request-like synchronization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <etendren@gmail.com>
---
 include/block/block_int.h |  3 +++
 block/io.c                | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92ecbd866e..20617e5853 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -856,6 +856,9 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
+void *coroutine_fn bdrv_co_try_lock(BdrvChild *child,
+                                    int64_t offset, unsigned int bytes);
+void coroutine_fn bdrv_co_unlock(void *opaque);
 
 extern unsigned int bdrv_drain_all_count;
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
diff --git a/block/io.c b/block/io.c
index d4e46cb3dc..fd4ec53167 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3243,3 +3243,38 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode prealloc,
 
     return tco.ret;
 }
+
+void *coroutine_fn bdrv_co_try_lock(BdrvChild *child,
+                                    int64_t offset, unsigned int bytes)
+{
+    BlockDriverState *bs = child->bs;
+    BdrvTrackedRequest *req;
+
+    qemu_co_mutex_lock(&bs->reqs_lock);
+
+    QLIST_FOREACH(req, &bs->tracked_requests, list) {
+        if (req->type == BDRV_TRACKED_READ) {
+            continue;
+        }
+        if (tracked_request_overlaps(req, offset, bytes)) {
+            qemu_co_mutex_unlock(&bs->reqs_lock);
+            return NULL;
+        }
+    }
+
+    qemu_co_mutex_unlock(&bs->reqs_lock);
+
+    req = g_new(BdrvTrackedRequest, 1);
+    tracked_request_begin(req, bs, offset, bytes, BDRV_TRACKED_READ);
+    mark_request_serialising(req, bdrv_get_cluster_size(bs));
+
+    return req;
+}
+
+void coroutine_fn bdrv_co_unlock(void *opaque)
+{
+    BdrvTrackedRequest *req = opaque;
+
+    tracked_request_end(req);
+    g_free(req);
+}
-- 
2.18.0
