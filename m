Received: from eggs.gnu.org ([2001:4830:134:3::10]:42946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007To-8J
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-00021q-DE
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:09 +0300
Message-Id: <20180807174311.32454-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/7] qcow2: refactor qcow2_co_pwritev: split
 out qcow2_co_do_pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Split out block which will be reused in async scheme.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 138 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 52 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a0df8d4e50..4d669432d1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2210,6 +2210,85 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
+/* qcow2_co_do_pwritev
+ * Called without s->lock unlocked
+ * hd_qiov - temp qiov for any use. It is initialized so it is empty and
+ *           support adding up to qiov->niov + 2 elements
+ * l2meta  - if not NULL, qcow2_co_do_pwritev() will consume it. Caller must not
+ *           use it somehow after qcow2_co_do_pwritev() call
+ */
+static coroutine_fn int qcow2_co_do_pwritev(BlockDriverState *bs,
+                                            uint64_t file_cluster_offset,
+                                            uint64_t offset,
+                                            uint64_t bytes,
+                                            QEMUIOVector *qiov,
+                                            uint64_t qiov_offset,
+                                            QCowL2Meta *l2meta)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    void *crypt_buf = NULL;
+    QEMUIOVector hd_qiov;
+    int offset_in_cluster = offset_into_cluster(s, offset);
+
+    qemu_iovec_reset(&hd_qiov);
+    qemu_iovec_init(&hd_qiov, qiov->niov);
+
+    if (bs->encrypted) {
+        assert(s->crypto);
+        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
+        qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
+
+        if (qcrypto_block_encrypt(s->crypto,
+                                  (s->crypt_physical_offset ?
+                                   file_cluster_offset + offset_in_cluster :
+                                   offset),
+                                  crypt_buf,
+                                  bytes, NULL) < 0) {
+            ret = -EIO;
+            goto fail;
+        }
+
+        qemu_iovec_add(&hd_qiov, crypt_buf, bytes);
+    } else {
+        qemu_iovec_concat(&hd_qiov, qiov, qiov_offset, bytes);
+    }
+
+    /* If we need to do COW, check if it's possible to merge the
+     * writing of the guest data together with that of the COW regions.
+     * If it's not possible (or not necessary) then write the
+     * guest data now. */
+    if (!merge_cow(offset, bytes, &hd_qiov, l2meta)) {
+        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
+        trace_qcow2_writev_data(qemu_coroutine_self(),
+                                file_cluster_offset + offset_in_cluster);
+        ret = bdrv_co_pwritev(bs->file,
+                              file_cluster_offset + offset_in_cluster,
+                              bytes, &hd_qiov, 0);
+        if (ret < 0) {
+            qemu_co_mutex_lock(&s->lock);
+            goto fail;
+        }
+    }
+
+    qemu_co_mutex_lock(&s->lock);
+
+    ret = qcow2_handle_l2meta(bs, &l2meta, true);
+    if (ret) {
+        goto fail;
+    }
+
+fail:
+    qcow2_handle_l2meta(bs, &l2meta, false);
+    qemu_co_mutex_unlock(&s->lock);
+
+    qemu_vfree(crypt_buf);
+    qemu_iovec_destroy(&hd_qiov);
+
+    return ret;
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                                          uint64_t bytes, QEMUIOVector *qiov,
                                          int flags)
@@ -2262,63 +2341,16 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
         qemu_co_mutex_unlock(&s->lock);
 
-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
 
-        if (bs->encrypted) {
-            assert(s->crypto);
-            if (!cluster_data) {
-                cluster_data = qemu_try_blockalign(bs->file->bs,
-                                                   QCOW_MAX_CRYPT_CLUSTERS
-                                                   * s->cluster_size);
-                if (cluster_data == NULL) {
-                    ret = -ENOMEM;
-                    goto fail;
-                }
-            }
-
-            assert(hd_qiov.size <=
-                   QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
-            qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
-
-            if (qcrypto_block_encrypt(s->crypto,
-                                      (s->crypt_physical_offset ?
-                                       cluster_offset + offset_in_cluster :
-                                       offset),
-                                      cluster_data,
-                                      cur_bytes, NULL) < 0) {
-                ret = -EIO;
-                goto fail;
-            }
-
-            qemu_iovec_reset(&hd_qiov);
-            qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
-        }
-
-        /* If we need to do COW, check if it's possible to merge the
-         * writing of the guest data together with that of the COW regions.
-         * If it's not possible (or not necessary) then write the
-         * guest data now. */
-        if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-            trace_qcow2_writev_data(qemu_coroutine_self(),
-                                    cluster_offset + offset_in_cluster);
-            ret = bdrv_co_pwritev(bs->file,
-                                  cluster_offset + offset_in_cluster,
-                                  cur_bytes, &hd_qiov, 0);
-            if (ret < 0) {
-                qemu_co_mutex_lock(&s->lock);
-                goto fail;
-            }
+        ret = qcow2_co_do_pwritev(bs, cluster_offset, offset, cur_bytes,
+                                  qiov, bytes_done, l2meta);
+        l2meta = NULL; /* l2meta is consumed by qcow2_co_do_pwritev() */
+        if (ret < 0) {
+            goto fail_nometa;
         }
 
         qemu_co_mutex_lock(&s->lock);
 
-        ret = qcow2_handle_l2meta(bs, &l2meta, true);
-        if (ret) {
-            goto fail;
-        }
-
         bytes -= cur_bytes;
         offset += cur_bytes;
         bytes_done += cur_bytes;
@@ -2331,6 +2363,8 @@ fail:
 
     qemu_co_mutex_unlock(&s->lock);
 
+fail_nometa:
+
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cluster_data);
     trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
-- 
2.11.1
