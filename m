Received: from eggs.gnu.org ([2001:4830:134:3::10]:60717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCI-0008FP-SM
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1e9vCG-0006mj-Rx
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:44:54 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:44:06 +0300
Message-Id: <1509551048-129830-14-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 13/15] qcow2: do not zero out clusters if
 already preallocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

if space preallocation feature is used, it can be detected that the space
is already zeroes, so COW can be skipped without additional zeroing of
the clusters.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.h         |  6 ++++++
 block/qcow2-cluster.c |  2 ++
 block/qcow2.c         | 45 +++++++++++++++++++++++++++++++--------------
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 579838d..5d96748 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -363,6 +363,12 @@ typedef struct QCowL2Meta
     bool keep_old_clusters;
 
     /**
+     * True if the area is allocated at the end of data area
+     * (i.e. >= BDRVQcow2State::data_end)
+     */
+    bool clusters_are_trailing;
+
+    /**
      * Requests that overlap with this allocation and wait to be restarted
      * when the allocating request has completed.
      */
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 9b24cab..5698919 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1251,6 +1251,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
+    const uint64_t old_data_end = s->data_end;
     int l2_index;
     uint64_t *l2_table;
     uint64_t entry;
@@ -1372,6 +1373,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .alloc_offset   = alloc_cluster_offset,
         .offset         = start_of_cluster(s, guest_offset),
         .nb_clusters    = nb_clusters,
+        .clusters_are_trailing = alloc_cluster_offset >= old_data_end,
 
         .keep_old_clusters  = keep_old_clusters,
 
diff --git a/block/qcow2.c b/block/qcow2.c
index ef65b5f..6019cf4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1975,26 +1975,40 @@ static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
 /*
  * If the specified area is beyond EOF, allocates it + prealloc_size
  * bytes ahead.
+ *
+ * Returns
+ *   true if the space is allocated and contains zeroes
  */
-static void coroutine_fn handle_prealloc(BlockDriverState *bs,
+static bool coroutine_fn handle_prealloc(BlockDriverState *bs,
                                          const QCowL2Meta *m)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start = m->alloc_offset;
     uint64_t end = start + m->nb_clusters * s->cluster_size;
+    int ret;
     int64_t flen = bdrv_getlength(bs->file->bs);
 
     if (flen < 0) {
-        return;
+        return false;
     }
 
     if (end > flen) {
         /* try to alloc host space in one chunk for better locality */
-        bdrv_co_pwrite_zeroes(bs->file, flen,
-                              QEMU_ALIGN_UP(end + s->prealloc_size - flen,
-                                            s->cluster_size),
-                              BDRV_REQ_ALLOCATE);
+        ret = bdrv_co_pwrite_zeroes(bs->file, flen,
+                                    QEMU_ALIGN_UP(end + s->prealloc_size - flen,
+                                                  s->cluster_size),
+                                    BDRV_REQ_ALLOCATE);
+        if (ret < 0) {
+            return false;
+        }
     }
+
+    /* We're safe to assume that the area is zeroes if the area
+     * was allocated at the end of data (s->data_end).
+     * In this case, the only way for file length to be bigger is that
+     * the area was preallocated by this or another request.
+     */
+    return m->clusters_are_trailing;
 }
 
 static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
@@ -2004,9 +2018,10 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 
     for (m = l2meta; m != NULL; m = m->next) {
         int ret;
+        bool preallocated_zeroes = false;
 
         if (s->prealloc_size) {
-            handle_prealloc(bs, m);
+            preallocated_zeroes = handle_prealloc(bs, m);
         }
 
         if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
@@ -2017,13 +2032,15 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
             continue;
         }
 
-        /* instead of writing zero COW buffers,
-           efficiently zero out the whole clusters */
-        ret = bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
-                                    m->nb_clusters * s->cluster_size,
-                                    BDRV_REQ_ALLOCATE);
-        if (ret < 0) {
-            continue;
+        if (!preallocated_zeroes) {
+            /* instead of writing zero COW buffers,
+               efficiently zero out the whole clusters */
+            ret = bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
+                                        m->nb_clusters * s->cluster_size,
+                                        BDRV_REQ_ALLOCATE);
+            if (ret < 0) {
+                continue;
+            }
         }
 
         trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clusters);
-- 
2.7.4
