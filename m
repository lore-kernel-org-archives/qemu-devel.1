Received: from eggs.gnu.org ([2001:4830:134:3::10]:59514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLs-00016a-3b
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLr-0007dm-4y
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:17 +0200
Message-Id: <1498234919-27316-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/61] qcow2: Make perform_cow() call
 do_perform_cow() twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

Instead of calling perform_cow() twice with a different COW region
each time, call it just once and make perform_cow() handle both
regions.

This patch simply moves code around. The next one will do the actual
reordering of the COW operations.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a86c5a7..4c03639 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -414,6 +414,10 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
     struct iovec iov;
     int ret;
 
+    if (bytes == 0) {
+        return 0;
+    }
+
     iov.iov_len = bytes;
     iov.iov_base = qemu_try_blockalign(bs, iov.iov_len);
     if (iov.iov_base == NULL) {
@@ -751,31 +755,40 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     return cluster_offset;
 }
 
-static int perform_cow(BlockDriverState *bs, QCowL2Meta *m, Qcow2COWRegion *r)
+static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
 {
     BDRVQcow2State *s = bs->opaque;
+    Qcow2COWRegion *start = &m->cow_start;
+    Qcow2COWRegion *end = &m->cow_end;
     int ret;
 
-    if (r->nb_bytes == 0) {
+    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
         return 0;
     }
 
     qemu_co_mutex_unlock(&s->lock);
-    ret = do_perform_cow(bs, m->offset, m->alloc_offset, r->offset, r->nb_bytes);
-    qemu_co_mutex_lock(&s->lock);
-
+    ret = do_perform_cow(bs, m->offset, m->alloc_offset,
+                         start->offset, start->nb_bytes);
     if (ret < 0) {
-        return ret;
+        goto fail;
     }
 
+    ret = do_perform_cow(bs, m->offset, m->alloc_offset,
+                         end->offset, end->nb_bytes);
+
+fail:
+    qemu_co_mutex_lock(&s->lock);
+
     /*
      * Before we update the L2 table to actually point to the new cluster, we
      * need to be sure that the refcounts have been increased and COW was
      * handled.
      */
-    qcow2_cache_depends_on_flush(s->l2_table_cache);
+    if (ret == 0) {
+        qcow2_cache_depends_on_flush(s->l2_table_cache);
+    }
 
-    return 0;
+    return ret;
 }
 
 int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
@@ -795,12 +808,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
     }
 
     /* copy content of unmodified sectors */
-    ret = perform_cow(bs, m, &m->cow_start);
-    if (ret < 0) {
-        goto err;
-    }
-
-    ret = perform_cow(bs, m, &m->cow_end);
+    ret = perform_cow(bs, m);
     if (ret < 0) {
         goto err;
     }
-- 
1.8.3.1
