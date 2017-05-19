Received: from eggs.gnu.org ([2001:4830:134:3::10]:48248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJY-0006k3-RY
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBeJU-0006mv-Qo
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:16 -0400
Received: from mail-db5eur01on0136.outbound.protection.outlook.com
	([104.47.2.136]:35055
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBeJU-0006mU-CX
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:35:12 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 12:34:31 +0300
Message-ID: <1495186480-114192-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 04/13] qcow2: preallocation at image expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, "Denis V.
	Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: "Denis V. Lunev" <den@openvz.org>

This patch adds image preallocation at expand to provide better locality
of QCOW2 image file and optimize this procedure for some distributed
storages where this procedure is slow.

Image expand requests have to be suspended until the allocation is
performed which is done via special QCowL2Meta.
This meta is invisible to handle_dependencies() code.
This is the main reason for also calling preallocation before metadata
write: it might intersect with preallocation triggered by another IO,
and has to yield

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 block/qcow2-cache.c    |   3 +
 block/qcow2-cluster.c  |   5 ++
 block/qcow2-refcount.c |  14 +++++
 block/qcow2.c          | 151 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.h          |   5 ++
 5 files changed, 178 insertions(+)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147..aa9da5f 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -204,6 +204,9 @@ static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
         return ret;
     }
 
+    /* check and preallocate extra space if touching a fresh metadata cluster */
+    qcow2_handle_prealloc(bs, c->entries[i].offset, s->cluster_size);
+
     if (c == s->refcount_block_cache) {
         BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_UPDATE_PART);
     } else if (c == s->l2_table_cache) {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cf18dee..a4b6d40 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -108,6 +108,9 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
         goto fail;
     }
 
+    qcow2_handle_prealloc(bs, new_l1_table_offset,
+                          QEMU_ALIGN_UP(new_l1_size2, s->cluster_size));
+
     BLKDBG_EVENT(bs->file, BLKDBG_L1_GROW_WRITE_TABLE);
     for(i = 0; i < s->l1_size; i++)
         new_l1_table[i] = cpu_to_be64(new_l1_table[i]);
@@ -1820,6 +1823,8 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 goto fail;
             }
 
+            qcow2_handle_prealloc(bs, offset, s->cluster_size);
+
             ret = bdrv_pwrite_zeroes(bs->file, offset, s->cluster_size, 0);
             if (ret < 0) {
                 if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061..873a1d2 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -547,6 +547,8 @@ static int alloc_refcount_block(BlockDriverState *bs,
     }
 
     /* Write refcount blocks to disk */
+    qcow2_handle_prealloc(bs, meta_offset, blocks_clusters * s->cluster_size);
+
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_WRITE_BLOCKS);
     ret = bdrv_pwrite_sync(bs->file, meta_offset, new_blocks,
         blocks_clusters * s->cluster_size);
@@ -561,6 +563,10 @@ static int alloc_refcount_block(BlockDriverState *bs,
         cpu_to_be64s(&new_table[i]);
     }
 
+    qcow2_handle_prealloc(bs, table_offset,
+                          QEMU_ALIGN_UP(table_size * sizeof(uint64_t),
+                                        s->cluster_size));
+
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_WRITE_TABLE);
     ret = bdrv_pwrite_sync(bs->file, table_offset, new_table,
         table_size * sizeof(uint64_t));
@@ -2104,6 +2110,8 @@ write_refblocks:
             goto fail;
         }
 
+        qcow2_handle_prealloc(bs, refblock_offset, s->cluster_size);
+
         /* The size of *refcount_table is always cluster-aligned, therefore the
          * write operation will not overflow */
         on_disk_refblock = (void *)((char *) *refcount_table +
@@ -2158,6 +2166,8 @@ write_refblocks:
     }
 
     assert(reftable_size < INT_MAX / sizeof(uint64_t));
+    qcow2_handle_prealloc(bs, reftable_offset,
+                          reftable_size * sizeof(uint64_t));
     ret = bdrv_pwrite(bs->file, reftable_offset, on_disk_reftable,
                       reftable_size * sizeof(uint64_t));
     if (ret < 0) {
@@ -2845,6 +2855,10 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
         cpu_to_be64s(&new_reftable[i]);
     }
 
+    qcow2_handle_prealloc(bs, new_reftable_offset,
+                          QEMU_ALIGN_UP(new_reftable_size * sizeof(uint64_t),
+                                        s->cluster_size));
+
     ret = bdrv_pwrite(bs->file, new_reftable_offset, new_reftable,
                       new_reftable_size * sizeof(uint64_t));
 
diff --git a/block/qcow2.c b/block/qcow2.c
index b438f22..6e7ce96 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -464,6 +464,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_NUMBER,
             .help = "Clean unused cache entries after this time (in seconds)",
         },
+        {
+            .name = QCOW2_OPT_PREALLOC_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Preallocation amount at image expand",
+        },
         { /* end of list */ }
     },
 };
@@ -754,6 +759,13 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     r->discard_passthrough[QCOW2_DISCARD_OTHER] =
         qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_OTHER, false);
 
+    s->prealloc_size =
+        ROUND_UP(qemu_opt_get_size_del(opts, QCOW2_OPT_PREALLOC_SIZE, 0),
+                 s->cluster_size);
+    if (s->prealloc_size && bs->file->bs->drv->bdrv_co_pwrite_zeroes == NULL) {
+        s->prealloc_size = 0;
+    }
+
     ret = 0;
 fail:
     qemu_opts_del(opts);
@@ -1597,6 +1609,135 @@ static void handle_cow_reduce(BlockDriverState *bs, QCowL2Meta *m)
     }
 }
 
+/*
+ * Checks that the host space area specified by @m is not being preallocated
+ * at the moment, and does co_queue_wait() if it is.
+ * If the specified area is not allocated yet, allocates it + prealloc_size
+ * bytes ahead.
+ *
+ * Returns
+ *   true if the space is allocated and contains zeroes
+ */
+static bool coroutine_fn handle_prealloc(BlockDriverState *bs,
+                                         const QCowL2Meta *m)
+{
+    BDRVQcow2State *s = bs->opaque;
+    BlockDriverState *file = bs->file->bs;
+    QCowL2Meta *old, *meta;
+    uint64_t start = m->alloc_offset;
+    uint64_t end = start + (m->nb_clusters << s->cluster_bits);
+    uint64_t nbytes;
+    int err;
+
+    assert(offset_into_cluster(s, start) == 0);
+
+restart:
+    /* check that the request is not overlapped with any
+       currently running preallocations */
+    QLIST_FOREACH(old, &s->cluster_allocs, next_in_flight) {
+        uint64_t old_start, old_end;
+
+        old_start = old->alloc_offset;
+        old_end = old_start + (old->nb_clusters << s->cluster_bits);
+
+        if (old == m || end <= old_start || start >= old_end) {
+            /* No intersection */
+            continue;
+        }
+
+        qemu_co_queue_wait(&old->dependent_requests, NULL);
+        goto restart;
+    }
+
+    if (end <= bdrv_getlength(file)) {
+        /* No need to care, file size will not be changed */
+        return false;
+    }
+
+    meta = g_alloca(sizeof(*meta));
+    *meta = (QCowL2Meta) {
+        /* this meta is invisible for handle_dependencies() */
+        .alloc_offset   = bdrv_getlength(file),
+        .nb_clusters    = size_to_clusters(s, start +
+                (m->nb_clusters << s->cluster_bits) +
+                s->prealloc_size - bdrv_getlength(file)),
+    };
+    qemu_co_queue_init(&meta->dependent_requests);
+    QLIST_INSERT_HEAD(&s->cluster_allocs, meta, next_in_flight);
+
+    nbytes = meta->nb_clusters << s->cluster_bits;
+
+    /* try to alloc host space in one chunk for better locality */
+    err = file->drv->bdrv_co_pwrite_zeroes(file, meta->alloc_offset, nbytes, 0);
+
+    QLIST_REMOVE(meta, next_in_flight);
+    qemu_co_queue_restart_all(&meta->dependent_requests);
+
+    if (err == 0) {
+        file->total_sectors =
+            MAX(file->total_sectors,
+                (meta->alloc_offset + nbytes) / BDRV_SECTOR_SIZE);
+        return start >= meta->alloc_offset;
+    }
+    return false;
+}
+
+typedef struct {
+    BlockDriverState *bs;
+    uint64_t offset;
+    uint64_t size;
+    int ret;
+} PreallocCo;
+
+static void coroutine_fn handle_prealloc_co_entry(void* opaque)
+{
+    PreallocCo *prco = opaque;
+    BDRVQcow2State *s = prco->bs->opaque;
+    QCowL2Meta meta = {
+        /* this meta is invisible for handle_dependencies() */
+        .alloc_offset = prco->offset,
+        .nb_clusters  = size_to_clusters(s, prco->size)
+    };
+    handle_prealloc(prco->bs, &meta);
+    prco->ret = 0;
+}
+
+/*
+ * Context(coroutine)-independent interface around handle_prealloc(), see
+ * its description.
+ * Must be called on a first write on the newly allocated cluster(s).
+ * @offset and @size must be cluster_aligned
+ */
+void qcow2_handle_prealloc(BlockDriverState *bs, uint64_t offset, uint64_t size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    PreallocCo prco = {
+        .bs     = bs,
+        .offset = offset,
+        .size   = size,
+        .ret    = -EAGAIN
+    };
+
+    assert(offset_into_cluster(s, offset) == 0);
+    assert(offset_into_cluster(s, size) == 0);
+
+    if (s->prealloc_size == 0 ||
+        bs->file->bs->drv->bdrv_co_pwrite_zeroes == NULL) {
+        return;
+    }
+
+    if (qemu_in_coroutine()) {
+        handle_prealloc_co_entry(&prco);
+    } else {
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+        Coroutine *co = qemu_coroutine_create(handle_prealloc_co_entry, &prco);
+        qemu_coroutine_enter(co);
+        while (prco.ret == -EAGAIN) {
+            aio_poll(aio_context, true);
+        }
+    }
+}
+
 static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -1607,6 +1748,11 @@ static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     for (m = l2meta; m != NULL; m = m->next) {
         uint64_t bytes = m->nb_clusters << s->cluster_bits;
 
+        if (s->prealloc_size != 0 && handle_prealloc(bs, m)) {
+            handle_cow_reduce(bs, m);
+            continue;
+        }
+
         if (m->cow_start.nb_bytes == 0 && m->cow_end.nb_bytes == 0) {
             continue;
         }
@@ -2725,6 +2871,11 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         goto fail;
     }
 
+    qcow2_handle_prealloc(bs, start_of_cluster(s, cluster_offset),
+                          QEMU_ALIGN_UP(
+                              offset_into_cluster(s, cluster_offset) + out_len,
+                              s->cluster_size));
+
     iov = (struct iovec) {
         .iov_base   = out_buf,
         .iov_len    = out_len,
diff --git a/block/qcow2.h b/block/qcow2.h
index ba15c08..a0d222d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -97,6 +97,7 @@
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
+#define QCOW2_OPT_PREALLOC_SIZE "prealloc-size"
 
 typedef struct QCowHeader {
     uint32_t magic;
@@ -294,6 +295,8 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+
+    uint64_t prealloc_size;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
@@ -493,6 +496,8 @@ int qcow2_mark_dirty(BlockDriverState *bs);
 int qcow2_mark_corrupt(BlockDriverState *bs);
 int qcow2_mark_consistent(BlockDriverState *bs);
 int qcow2_update_header(BlockDriverState *bs);
+void qcow2_handle_prealloc(BlockDriverState *bs,
+                           uint64_t offset, uint64_t size);
 
 void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
                              int64_t size, const char *message_format, ...)
-- 
2.7.4
