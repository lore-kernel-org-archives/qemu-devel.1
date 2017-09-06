Received: from eggs.gnu.org ([2001:4830:134:3::10]:50083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpavA-0005W1-Dm
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpav4-0000rh-B0
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:03:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Sep 2017 16:02:37 +0200
Message-Id: <20170906140246.7326-6-kwolf@redhat.com>
In-Reply-To: <20170906140246.7326-1-kwolf@redhat.com>
References: <20170906140246.7326-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] qcow: Change signature of
 get_cluster_offset()
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

From: Eric Blake <eblake@redhat.com>

The old signature has an ambiguous meaning for a return of 0:
either no allocation was requested or necessary, or an error
occurred (but any errno associated with the error is lost to
the caller, which then has to assume EIO).

Better is to follow the example of qcow2, by changing the
signature to have a separate return value that cleanly
distinguishes between failure and success, along with a
parameter that cleanly holds a 64-bit value.  Then update all
callers.

While auditing that all return paths return a negative errno
(rather than -1), I also simplified places where we can pass
NULL rather than a local Error that just gets thrown away.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow.c | 123 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 50 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 63904a26ee..d07bef6306 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -347,19 +347,21 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
  * 'compressed_size'. 'compressed_size' must be > 0 and <
  * cluster_size
  *
- * return 0 if not allocated.
+ * return 0 if not allocated, 1 if *result is assigned, and negative
+ * errno on failure.
  */
-static uint64_t get_cluster_offset(BlockDriverState *bs,
-                                   uint64_t offset, int allocate,
-                                   int compressed_size,
-                                   int n_start, int n_end)
+static int get_cluster_offset(BlockDriverState *bs,
+                              uint64_t offset, int allocate,
+                              int compressed_size,
+                              int n_start, int n_end, uint64_t *result)
 {
     BDRVQcowState *s = bs->opaque;
-    int min_index, i, j, l1_index, l2_index;
+    int min_index, i, j, l1_index, l2_index, ret;
     uint64_t l2_offset, *l2_table, cluster_offset, tmp;
     uint32_t min_count;
     int new_l2_table;
 
+    *result = 0;
     l1_index = offset >> (s->l2_bits + s->cluster_bits);
     l2_offset = s->l1_table[l1_index];
     new_l2_table = 0;
@@ -373,10 +375,12 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
         /* update the L1 entry */
         s->l1_table[l1_index] = l2_offset;
         tmp = cpu_to_be64(l2_offset);
-        if (bdrv_pwrite_sync(bs->file,
-                s->l1_table_offset + l1_index * sizeof(tmp),
-                &tmp, sizeof(tmp)) < 0)
-            return 0;
+        ret = bdrv_pwrite_sync(bs->file,
+                               s->l1_table_offset + l1_index * sizeof(tmp),
+                               &tmp, sizeof(tmp));
+        if (ret < 0) {
+            return ret;
+        }
         new_l2_table = 1;
     }
     for(i = 0; i < L2_CACHE_SIZE; i++) {
@@ -403,14 +407,17 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
     l2_table = s->l2_cache + (min_index << s->l2_bits);
     if (new_l2_table) {
         memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
-        if (bdrv_pwrite_sync(bs->file, l2_offset, l2_table,
-                s->l2_size * sizeof(uint64_t)) < 0)
-            return 0;
+        ret = bdrv_pwrite_sync(bs->file, l2_offset, l2_table,
+                               s->l2_size * sizeof(uint64_t));
+        if (ret < 0) {
+            return ret;
+        }
     } else {
-        if (bdrv_pread(bs->file, l2_offset, l2_table,
-                       s->l2_size * sizeof(uint64_t)) !=
-            s->l2_size * sizeof(uint64_t))
-            return 0;
+        ret = bdrv_pread(bs->file, l2_offset, l2_table,
+                         s->l2_size * sizeof(uint64_t));
+        if (ret < 0) {
+            return ret;
+        }
     }
     s->l2_cache_offsets[min_index] = l2_offset;
     s->l2_cache_counts[min_index] = 1;
@@ -427,16 +434,18 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
             /* if the cluster is already compressed, we must
                decompress it in the case it is not completely
                overwritten */
-            if (decompress_cluster(bs, cluster_offset) < 0)
-                return 0;
+            if (decompress_cluster(bs, cluster_offset) < 0) {
+                return -EIO;
+            }
             cluster_offset = bdrv_getlength(bs->file->bs);
             cluster_offset = (cluster_offset + s->cluster_size - 1) &
                 ~(s->cluster_size - 1);
             /* write the cluster content */
-            if (bdrv_pwrite(bs->file, cluster_offset, s->cluster_cache,
-                            s->cluster_size) !=
-                s->cluster_size)
-                return -1;
+            ret = bdrv_pwrite(bs->file, cluster_offset, s->cluster_cache,
+                              s->cluster_size);
+            if (ret < 0) {
+                return ret;
+            }
         } else {
             cluster_offset = bdrv_getlength(bs->file->bs);
             if (allocate == 1) {
@@ -459,13 +468,14 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                                                       s->cluster_data,
                                                       BDRV_SECTOR_SIZE,
                                                       NULL) < 0) {
-                                errno = EIO;
-                                return -1;
+                                return -EIO;
+                            }
+                            ret = bdrv_pwrite(bs->file,
+                                              cluster_offset + i * 512,
+                                              s->cluster_data, 512);
+                            if (ret < 0) {
+                                return ret;
                             }
-                            if (bdrv_pwrite(bs->file,
-                                            cluster_offset + i * 512,
-                                            s->cluster_data, 512) != 512)
-                                return -1;
                         }
                     }
                 }
@@ -477,23 +487,29 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
         /* update L2 table */
         tmp = cpu_to_be64(cluster_offset);
         l2_table[l2_index] = tmp;
-        if (bdrv_pwrite_sync(bs->file, l2_offset + l2_index * sizeof(tmp),
-                &tmp, sizeof(tmp)) < 0)
-            return 0;
+        ret = bdrv_pwrite_sync(bs->file, l2_offset + l2_index * sizeof(tmp),
+                               &tmp, sizeof(tmp));
+        if (ret < 0) {
+            return ret;
+        }
     }
-    return cluster_offset;
+    *result = cluster_offset;
+    return 1;
 }
 
 static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
 {
     BDRVQcowState *s = bs->opaque;
-    int index_in_cluster, n;
+    int index_in_cluster, n, ret;
     uint64_t cluster_offset;
 
     qemu_co_mutex_lock(&s->lock);
-    cluster_offset = get_cluster_offset(bs, sector_num << 9, 0, 0, 0, 0);
+    ret = get_cluster_offset(bs, sector_num << 9, 0, 0, 0, 0, &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
+    if (ret < 0) {
+        return ret;
+    }
     index_in_cluster = sector_num & (s->cluster_sectors - 1);
     n = s->cluster_sectors - index_in_cluster;
     if (n > nb_sectors)
@@ -585,8 +601,11 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
 
     while (nb_sectors != 0) {
         /* prepare next request */
-        cluster_offset = get_cluster_offset(bs, sector_num << 9,
-                                                 0, 0, 0, 0);
+        ret = get_cluster_offset(bs, sector_num << 9,
+                                 0, 0, 0, 0, &cluster_offset);
+        if (ret < 0) {
+            break;
+        }
         index_in_cluster = sector_num & (s->cluster_sectors - 1);
         n = s->cluster_sectors - index_in_cluster;
         if (n > nb_sectors) {
@@ -603,7 +622,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
                 ret = bdrv_co_readv(bs->backing, sector_num, n, &hd_qiov);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
-                    goto fail;
+                    break;
                 }
             } else {
                 /* Note: in this case, no need to wait */
@@ -612,13 +631,15 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
         } else if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
             /* add AIO support for compressed blocks ? */
             if (decompress_cluster(bs, cluster_offset) < 0) {
-                goto fail;
+                ret = -EIO;
+                break;
             }
             memcpy(buf,
                    s->cluster_cache + index_in_cluster * 512, 512 * n);
         } else {
             if ((cluster_offset & 511) != 0) {
-                goto fail;
+                ret = -EIO;
+                break;
             }
             hd_iov.iov_base = (void *)buf;
             hd_iov.iov_len = n * 512;
@@ -635,7 +656,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
                 assert(s->crypto);
                 if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
                                           n * BDRV_SECTOR_SIZE, NULL) < 0) {
-                    goto fail;
+                    ret = -EIO;
+                    break;
                 }
             }
         }
@@ -646,7 +668,6 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
         buf += n * 512;
     }
 
-done:
     qemu_co_mutex_unlock(&s->lock);
 
     if (qiov->niov > 1) {
@@ -655,10 +676,6 @@ done:
     }
 
     return ret;
-
-fail:
-    ret = -EIO;
-    goto done;
 }
 
 static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
@@ -697,9 +714,12 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
         if (n > nb_sectors) {
             n = nb_sectors;
         }
-        cluster_offset = get_cluster_offset(bs, sector_num << 9, 1, 0,
-                                            index_in_cluster,
-                                            index_in_cluster + n);
+        ret = get_cluster_offset(bs, sector_num << 9, 1, 0,
+                                 index_in_cluster,
+                                 index_in_cluster + n, &cluster_offset);
+        if (ret < 0) {
+            break;
+        }
         if (!cluster_offset || (cluster_offset & 511) != 0) {
             ret = -EIO;
             break;
@@ -995,8 +1015,11 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
         goto success;
     }
     qemu_co_mutex_lock(&s->lock);
-    cluster_offset = get_cluster_offset(bs, offset, 2, out_len, 0, 0);
+    ret = get_cluster_offset(bs, offset, 2, out_len, 0, 0, &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
+    if (ret < 0) {
+        goto fail;
+    }
     if (cluster_offset == 0) {
         ret = -EIO;
         goto fail;
-- 
2.13.5
