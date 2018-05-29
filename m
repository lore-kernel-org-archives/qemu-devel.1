Received: from eggs.gnu.org ([2001:4830:134:3::10]:59309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fNXgX-0006Qt-FT
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fNXgW-0002rh-34
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:00:41 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 29 May 2018 13:59:53 +0800
Message-Id: <20180529055959.32002-5-famz@redhat.com>
In-Reply-To: <20180529055959.32002-1-famz@redhat.com>
References: <20180529055959.32002-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 04/10] qcow2: Implement copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eblake@redhat.com

The two callbacks are implemented quite similarly to the read/write
functions: bdrv_co_copy_range_from maps for read and calls into bs->file
or bs->backing depending on the allocation status; bdrv_co_copy_range_to
maps for write and calls into bs->file.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 199 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6d532470a8..8f89c4fe72 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1762,6 +1762,39 @@ static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
     return status;
 }
 
+static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
+                                            QCowL2Meta **pl2meta,
+                                            bool link_l2)
+{
+    int ret = 0;
+    QCowL2Meta *l2meta = *pl2meta;
+
+    while (l2meta != NULL) {
+        QCowL2Meta *next;
+
+        if (!ret && link_l2) {
+            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
+            if (ret) {
+                goto out;
+            }
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
+out:
+    *pl2meta = l2meta;
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                         uint64_t bytes, QEMUIOVector *qiov,
                                         int flags)
@@ -2048,24 +2081,9 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
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
+        ret = qcow2_handle_l2meta(bs, &l2meta, true);
+        if (ret) {
+            goto fail;
         }
 
         bytes -= cur_bytes;
@@ -2076,18 +2094,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
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
+    qcow2_handle_l2meta(bs, &l2meta, false);
 
     qemu_co_mutex_unlock(&s->lock);
 
@@ -3274,6 +3281,166 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     return ret;
 }
 
+static int coroutine_fn
+qcow2_co_copy_range_from(BlockDriverState *bs,
+                         BdrvChild *src, uint64_t src_offset,
+                         BdrvChild *dst, uint64_t dst_offset,
+                         uint64_t bytes, BdrvRequestFlags flags)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+    unsigned int cur_bytes; /* number of bytes in current iteration */
+    BdrvChild *child = NULL;
+    BdrvRequestFlags cur_flags;
+
+    assert(!bs->encrypted);
+    qemu_co_mutex_lock(&s->lock);
+
+    while (bytes != 0) {
+        uint64_t copy_offset = 0;
+        /* prepare next request */
+        cur_bytes = MIN(bytes, INT_MAX);
+        cur_flags = flags;
+
+        ret = qcow2_get_cluster_offset(bs, src_offset, &cur_bytes, &copy_offset);
+        if (ret < 0) {
+            goto out;
+        }
+
+        switch (ret) {
+        case QCOW2_CLUSTER_UNALLOCATED:
+            if (bs->backing && bs->backing->bs) {
+                int64_t backing_length = bdrv_getlength(bs->backing->bs);
+                if (src_offset >= backing_length) {
+                    cur_flags |= BDRV_REQ_ZERO_WRITE;
+                } else {
+                    child = bs->backing;
+                    cur_bytes = MIN(cur_bytes, backing_length - src_offset);
+                    copy_offset = src_offset;
+                }
+            } else {
+                cur_flags |= BDRV_REQ_ZERO_WRITE;
+            }
+            break;
+
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_ZERO_ALLOC:
+            cur_flags |= BDRV_REQ_ZERO_WRITE;
+            break;
+
+        case QCOW2_CLUSTER_COMPRESSED:
+            ret = -ENOTSUP;
+            goto out;
+            break;
+
+        case QCOW2_CLUSTER_NORMAL:
+            child = bs->file;
+            copy_offset += offset_into_cluster(s, src_offset);
+            if ((copy_offset & 511) != 0) {
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
+                                      copy_offset,
+                                      dst, dst_offset,
+                                      cur_bytes, cur_flags);
+        qemu_co_mutex_lock(&s->lock);
+        if (ret < 0) {
+            goto out;
+        }
+
+        bytes -= cur_bytes;
+        src_offset += cur_bytes;
+        dst_offset += cur_bytes;
+    }
+    ret = 0;
+
+out:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
+}
+
+static int coroutine_fn
+qcow2_co_copy_range_to(BlockDriverState *bs,
+                       BdrvChild *src, uint64_t src_offset,
+                       BdrvChild *dst, uint64_t dst_offset,
+                       uint64_t bytes, BdrvRequestFlags flags)
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
+        ret = qcow2_handle_l2meta(bs, &l2meta, true);
+        if (ret) {
+            goto fail;
+        }
+
+        bytes -= cur_bytes;
+        dst_offset += cur_bytes;
+    }
+    ret = 0;
+
+fail:
+    qcow2_handle_l2meta(bs, &l2meta, false);
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
@@ -4522,6 +4689,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_co_pwrite_zeroes  = qcow2_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = qcow2_co_pdiscard,
+    .bdrv_co_copy_range_from = qcow2_co_copy_range_from,
+    .bdrv_co_copy_range_to  = qcow2_co_copy_range_to,
     .bdrv_truncate          = qcow2_truncate,
     .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
     .bdrv_make_empty        = qcow2_make_empty,
-- 
2.14.3
