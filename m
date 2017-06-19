Received: from eggs.gnu.org ([2001:4830:134:3::10]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuz-0008RM-NX
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuw-0001dx-KU
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 19 Jun 2017 16:40:07 +0300
Message-Id: <484752bd226b7e63b51b9c32f47bc5bc831c1752.1497879398.git.berto@igalia.com>
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
References: <cover.1497879398.git.berto@igalia.com>
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
References: <cover.1497879398.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 6/7] qcow2: Pass a QEMUIOVector to
 do_perform_cow_{read, write}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Instead of passing a single buffer pointer to do_perform_cow_write(),
pass a QEMUIOVector. This will allow us to merge the write requests
for the COW regions and the actual data into a single one.

Although do_perform_cow_read() does not strictly need to change its
API, we're doing it here as well for consistency.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 20fb531932..3ac26d6bf7 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -406,19 +406,14 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
 static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
                                             uint64_t src_cluster_offset,
                                             unsigned offset_in_cluster,
-                                            uint8_t *buffer,
-                                            unsigned bytes)
+                                            QEMUIOVector *qiov)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = { .iov_base = buffer, .iov_len = bytes };
     int ret;
 
-    if (bytes == 0) {
+    if (qiov->size == 0) {
         return 0;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
     BLKDBG_EVENT(bs->file, BLKDBG_COW_READ);
 
     if (!bs->drv) {
@@ -430,7 +425,7 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
      * which can lead to deadlock when block layer copy-on-read is enabled.
      */
     ret = bs->drv->bdrv_co_preadv(bs, src_cluster_offset + offset_in_cluster,
-                                  bytes, &qiov, 0);
+                                  qiov->size, qiov, 0);
     if (ret < 0) {
         return ret;
     }
@@ -462,28 +457,23 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
 static int coroutine_fn do_perform_cow_write(BlockDriverState *bs,
                                              uint64_t cluster_offset,
                                              unsigned offset_in_cluster,
-                                             uint8_t *buffer,
-                                             unsigned bytes)
+                                             QEMUIOVector *qiov)
 {
-    QEMUIOVector qiov;
-    struct iovec iov = { .iov_base = buffer, .iov_len = bytes };
     int ret;
 
-    if (bytes == 0) {
+    if (qiov->size == 0) {
         return 0;
     }
 
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
     ret = qcow2_pre_write_overlap_check(bs, 0,
-            cluster_offset + offset_in_cluster, bytes);
+            cluster_offset + offset_in_cluster, qiov->size);
     if (ret < 0) {
         return ret;
     }
 
     BLKDBG_EVENT(bs->file, BLKDBG_COW_WRITE);
     ret = bdrv_co_pwritev(bs->file, cluster_offset + offset_in_cluster,
-                          bytes, &qiov, 0);
+                          qiov->size, qiov, 0);
     if (ret < 0) {
         return ret;
     }
@@ -780,6 +770,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     unsigned data_bytes = end->offset - (start->offset + start->nb_bytes);
     bool merge_reads;
     uint8_t *start_buffer, *end_buffer;
+    QEMUIOVector qiov;
     int ret;
 
     assert(start->nb_bytes <= UINT_MAX - end->nb_bytes);
@@ -816,22 +807,25 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     /* The part of the buffer where the end region is located */
     end_buffer = start_buffer + buffer_size - end->nb_bytes;
 
+    qemu_iovec_init(&qiov, 1);
+
     qemu_co_mutex_unlock(&s->lock);
     /* First we read the existing data from both COW regions. We
      * either read the whole region in one go, or the start and end
      * regions separately. */
     if (merge_reads) {
-        ret = do_perform_cow_read(bs, m->offset, start->offset,
-                                  start_buffer, buffer_size);
+        qemu_iovec_add(&qiov, start_buffer, buffer_size);
+        ret = do_perform_cow_read(bs, m->offset, start->offset, &qiov);
     } else {
-        ret = do_perform_cow_read(bs, m->offset, start->offset,
-                                  start_buffer, start->nb_bytes);
+        qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
+        ret = do_perform_cow_read(bs, m->offset, start->offset, &qiov);
         if (ret < 0) {
             goto fail;
         }
 
-        ret = do_perform_cow_read(bs, m->offset, end->offset,
-                                  end_buffer, end->nb_bytes);
+        qemu_iovec_reset(&qiov);
+        qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
+        ret = do_perform_cow_read(bs, m->offset, end->offset, &qiov);
     }
     if (ret < 0) {
         goto fail;
@@ -849,14 +843,16 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     }
 
     /* And now we can write everything */
-    ret = do_perform_cow_write(bs, m->alloc_offset, start->offset,
-                               start_buffer, start->nb_bytes);
+    qemu_iovec_reset(&qiov);
+    qemu_iovec_add(&qiov, start_buffer, start->nb_bytes);
+    ret = do_perform_cow_write(bs, m->alloc_offset, start->offset, &qiov);
     if (ret < 0) {
         goto fail;
     }
 
-    ret = do_perform_cow_write(bs, m->alloc_offset, end->offset,
-                               end_buffer, end->nb_bytes);
+    qemu_iovec_reset(&qiov);
+    qemu_iovec_add(&qiov, end_buffer, end->nb_bytes);
+    ret = do_perform_cow_write(bs, m->alloc_offset, end->offset, &qiov);
 fail:
     qemu_co_mutex_lock(&s->lock);
 
@@ -870,6 +866,7 @@ fail:
     }
 
     qemu_vfree(start_buffer);
+    qemu_iovec_destroy(&qiov);
     return ret;
 }
 
-- 
2.11.0
