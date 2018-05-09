Received: from eggs.gnu.org ([2001:4830:134:3::10]:56728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQYR-0006zH-Tg
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQYQ-0006at-O2
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:58:55 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 22:58:09 +0800
Message-Id: <20180509145815.3330-4-famz@redhat.com>
In-Reply-To: <20180509145815.3330-1-famz@redhat.com>
References: <20180509145815.3330-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/9] qcow2: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The two callbacks are implemented quite similarly to the read/write
functions: bdrv_co_copy_range_from maps for read and calls into bs->file
or bs->backing depending on the allocation status; bdrv_co_copy_range_to
maps for write and calls into bs->file.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 228 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 198 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2f36e632f9..07e38b548a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1755,6 +1755,31 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     return status;
 }
 
+static int qcow2_handle_l2meta(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    int ret = 0;
+
+    while (l2meta != NULL) {
+        QCowL2Meta *next;
+
+        if (!ret) {
+            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
+        }
+
+        /* Take the request off the list of running requests */
+        if (l2meta->nb_clusters != 0) {
+            QLIST_REMOVE(l2meta, next_in_flight);
+        }
+
+        qemu_co_queue_restart_all(&l2meta->dependent_requests);
+
+        next = l2meta->next;
+        g_free(l2meta);
+        l2meta = next;
+    }
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                         uint64_t bytes, QEMUIOVector *qiov,
                                         int flags)
@@ -2041,24 +2066,10 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             }
         }
 
-        while (l2meta != NULL) {
-            QCowL2Meta *next;
-
-            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
-            if (ret < 0) {
-                goto fail;
-            }
-
-            /* Take the request off the list of running requests */
-            if (l2meta->nb_clusters != 0) {
-                QLIST_REMOVE(l2meta, next_in_flight);
-            }
-
-            qemu_co_queue_restart_all(&l2meta->dependent_requests);
-
-            next = l2meta->next;
-            g_free(l2meta);
-            l2meta = next;
+        ret = qcow2_handle_l2meta(bs, l2meta);
+        l2meta = NULL;
+        if (ret) {
+            goto fail;
         }
 
         bytes -= cur_bytes;
@@ -2069,18 +2080,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
     ret = 0;
 
 fail:
-    while (l2meta != NULL) {
-        QCowL2Meta *next;
-
-        if (l2meta->nb_clusters != 0) {
-            QLIST_REMOVE(l2meta, next_in_flight);
-        }
-        qemu_co_queue_restart_all(&l2meta->dependent_requests);
-
-        next = l2meta->next;
-        g_free(l2meta);
-        l2meta = next;
-    }
+    qcow2_handle_l2meta(bs, l2meta);
 
     qemu_co_mutex_unlock(&s->lock);
 
@@ -3267,6 +3267,172 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     return ret;
 }
 
+static int qcow2_co_copy_range_from(BlockDriverState *bs,
+                                    BdrvChild *src, uint64_t src_offset,
+                                    BdrvChild *dst, uint64_t dst_offset,
+                                    uint64_t bytes, BdrvRequestFlags flags)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int offset_in_cluster;
+    int ret;
+    unsigned int cur_bytes; /* number of bytes in current iteration */
+    uint64_t cluster_offset = 0;
+    BdrvChild *child = NULL;
+
+    assert(!bs->encrypted);
+    qemu_co_mutex_lock(&s->lock);
+
+    while (bytes != 0) {
+
+        /* prepare next request */
+        cur_bytes = MIN(bytes, INT_MAX);
+
+        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &cluster_offset);
+        if (ret < 0) {
+            goto out;
+        }
+
+        offset_in_cluster = offset_into_cluster(s, src_offset);
+
+        switch (ret) {
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (bs->backing) {
+                child = bs->backing;
+            } else {
+                flags |= BDRV_REQ_ZERO_WRITE;
+            }
+            break;
+
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+            flags |= BDRV_REQ_ZERO_WRITE;
+            break;
+
+        case QCOW2_CLUSTER_COMPRESSED:
+            ret = -ENOTSUP;
+            goto out;
+            break;
+
+        case QCOW2_CLUSTER_NORMAL:
+            child = bs->file;
+            if ((cluster_offset & 511) != 0) {
+                ret = -EIO;
+                goto out;
+            }
+            break;
+
+        default:
+            abort();
+        }
+        qemu_co_mutex_unlock(&s->lock);
+        ret = bdrv_co_copy_range_from(child,
+                                      cluster_offset + offset_in_cluster,
+                                      dst, dst_offset,
+                                      cur_bytes, flags);
+        qemu_co_mutex_lock(&s->lock);
+        if (ret < 0) {
+            goto out;
+        }
+
+        bytes -= cur_bytes;
+        src_offset += cur_bytes;
+    }
+    ret = 0;
+
+out:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
+}
+
+static int qcow2_co_copy_range_to(BlockDriverState *bs,
+                                  BdrvChild *src, uint64_t src_offset,
+                                  BdrvChild *dst, uint64_t dst_offset,
+                                  uint64_t bytes, BdrvRequestFlags flags)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int offset_in_cluster;
+    int ret;
+    unsigned int cur_bytes; /* number of sectors in current iteration */
+    uint64_t cluster_offset;
+    uint8_t *cluster_data = NULL;
+    QCowL2Meta *l2meta = NULL;
+
+    assert(!bs->encrypted);
+    s->cluster_cache_offset = -1; /* disable compressed cache */
+
+    qemu_co_mutex_lock(&s->lock);
+
+    while (bytes != 0) {
+
+        l2meta = NULL;
+
+        offset_in_cluster = offset_into_cluster(s, dst_offset);
+        cur_bytes = MIN(bytes, INT_MAX);
+
+        /* TODO:
+         * If src->bs == dst->bs, we could simply copy by incrementing
+         * the refcnt, without copying user data.
+         * Or if src->bs == dst->bs->backing->bs, we could copy by discarding. */
+        ret = qcow2_alloc_cluster_offset(bs, dst_offset, &cur_bytes,
+                                         &cluster_offset, &l2meta);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        assert((cluster_offset & 511) == 0);
+
+        ret = qcow2_pre_write_overlap_check(bs, 0,
+                cluster_offset + offset_in_cluster, cur_bytes);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        qemu_co_mutex_unlock(&s->lock);
+        ret = bdrv_co_copy_range_to(src, src_offset,
+                                    bs->file,
+                                    cluster_offset + offset_in_cluster,
+                                    cur_bytes, flags);
+        qemu_co_mutex_lock(&s->lock);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        while (l2meta != NULL) {
+            QCowL2Meta *next;
+
+            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
+            if (ret < 0) {
+                goto fail;
+            }
+
+            /* Take the request off the list of running requests */
+            if (l2meta->nb_clusters != 0) {
+                QLIST_REMOVE(l2meta, next_in_flight);
+            }
+
+            qemu_co_queue_restart_all(&l2meta->dependent_requests);
+
+            next = l2meta->next;
+            g_free(l2meta);
+            l2meta = next;
+        }
+
+        bytes -= cur_bytes;
+        dst_offset += cur_bytes;
+    }
+    ret = 0;
+
+fail:
+    qcow2_handle_l2meta(bs, l2meta);
+
+    qemu_co_mutex_unlock(&s->lock);
+
+    qemu_vfree(cluster_data);
+    trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
+
+    return ret;
+}
+
 static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                           PreallocMode prealloc, Error **errp)
 {
@@ -4515,6 +4681,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_co_pwrite_zeroes  = qcow2_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = qcow2_co_pdiscard,
+    .bdrv_co_copy_range_from = qcow2_co_copy_range_from,
+    .bdrv_co_copy_range_to  = qcow2_co_copy_range_to,
     .bdrv_truncate          = qcow2_truncate,
     .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
     .bdrv_make_empty        = qcow2_make_empty,
-- 
2.14.3
