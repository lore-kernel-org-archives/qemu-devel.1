Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1N-0000VZ-7Q
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcY1K-0002Wm-P5
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:19:41 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  1 Aug 2017 17:19:09 +0300
Message-Id: <1501597152-25342-13-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 12/15] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

It can be detected that
  1. COW alignment of a write request is zeroes
  2. Respective areas on the underlying BDS already read as zeroes
     after being preallocated previously

If both of these true, COW may be skipped

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2.h         | 12 +++++++++++
 block/qcow2-cluster.c |  5 ++++-
 block/qcow2.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++-------
 block/trace-events    |  1 +
 4 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 595ed9c..db1c6f5 100644
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
@@ -381,6 +387,12 @@ typedef struct QCowL2Meta
     Qcow2COWRegion cow_end;
 
     /**
+     * Indicates that both COW areas are empty (nb_bytes == 0)
+     * or filled with zeroes and do not require any more copying
+     */
+    bool zero_cow;
+
+    /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
      * from @cow_start and @cow_end into one single write operation.
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 75baaf4..d54b96a 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -735,7 +735,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     assert(start->offset + start->nb_bytes <= end->offset);
     assert(!m->data_qiov || m->data_qiov->size == data_bytes);
 
-    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
+    if ((start->nb_bytes == 0 && end->nb_bytes == 0) || m->zero_cow) {
         return 0;
     }
 
@@ -1203,6 +1203,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *host_offset, uint64_t *bytes, QCowL2Meta **m)
 {
     BDRVQcow2State *s = bs->opaque;
+    const uint64_t old_data_end = s->data_end;
     int l2_index;
     uint64_t *l2_table;
     uint64_t entry;
@@ -1324,6 +1325,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         .alloc_offset   = alloc_cluster_offset,
         .offset         = start_of_cluster(s, guest_offset),
         .nb_clusters    = nb_clusters,
+        .clusters_are_trailing = alloc_cluster_offset >= old_data_end,
 
         .keep_old_clusters  = keep_old_clusters,
 
@@ -1335,6 +1337,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
             .offset     = nb_bytes,
             .nb_bytes   = avail_bytes - nb_bytes,
         },
+        .zero_cow = false,
     };
     qemu_co_queue_init(&(*m)->dependent_requests);
     QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
diff --git a/block/qcow2.c b/block/qcow2.c
index 2ec8b03..e49ad50 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1921,6 +1921,11 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
             continue;
         }
 
+        /* If both COW regions are zeroes already, skip this too */
+        if (m->zero_cow) {
+            continue;
+        }
+
         /* The data (middle) region must be immediately after the
          * start region */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
@@ -1971,26 +1976,61 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
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
+}
+
+static bool check_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+{
+    if (bs->encrypted) {
+        return false;
+    }
+
+    if (m->cow_start.nb_bytes != 0 &&
+        !is_zero(bs, m->offset + m->cow_start.offset, m->cow_start.nb_bytes))
+    {
+        return false;
+    }
+
+    if (m->cow_end.nb_bytes != 0 &&
+        !is_zero(bs, m->offset + m->cow_end.offset, m->cow_end.nb_bytes))
+    {
+        return false;
+    }
+
+    return true;
 }
 
 static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
@@ -1999,8 +2039,12 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     QCowL2Meta *m;
 
     for (m = l2meta; m != NULL; m = m->next) {
-        if (s->prealloc_size) {
-            handle_prealloc(bs, m);
+        if (s->prealloc_size && handle_prealloc(bs, m)) {
+            if (check_zero_cow(bs, m)) {
+                trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset,
+                                     m->nb_clusters);
+                m->zero_cow = true;
+            }
         }
     }
 }
diff --git a/block/trace-events b/block/trace-events
index 13a5a87..faf1811 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -61,6 +61,7 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset %" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset %" PRIx64 " count %d"
 qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset %" PRIx64 " count %d"
+qcow2_skip_cow(void* co, uint64_t offset, int nb_clusters) "co %p offset %" PRIx64 " nb_clusters %d"
 
 # block/qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset %" PRIx64 " bytes %d"
-- 
2.7.4
