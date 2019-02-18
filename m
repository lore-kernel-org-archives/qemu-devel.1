Received: from eggs.gnu.org ([209.51.188.92]:33100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcX-000568-9s
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvjcW-0007Sa-Aa
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:10:09 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:09:19 +0300
Message-Id: <20190218140926.333779-11-vsementsov@virtuozzo.com>
In-Reply-To: <20190218140926.333779-1-vsementsov@virtuozzo.com>
References: <20190218140926.333779-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 10/17] block/qed: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-table.c | 16 +++-------------
 block/qed.c       | 31 +++++++++----------------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index 7df5680adb..c497bd4aec 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -21,16 +21,11 @@
 /* Called with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 {
-    QEMUIOVector qiov;
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(
+        qiov, table->offsets, s->header.cluster_size * s->header.table_size);
     int noffsets;
     int i, ret;
 
-    struct iovec iov = {
-        .iov_base = table->offsets,
-        .iov_len = s->header.cluster_size * s->header.table_size,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
     trace_qed_read_table(s, offset, table);
 
     qemu_co_mutex_unlock(&s->table_lock);
@@ -71,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     unsigned int sector_mask = BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1;
     unsigned int start, end, i;
     QEDTable *new_table;
-    struct iovec iov;
     QEMUIOVector qiov;
     size_t len_bytes;
     int ret;
@@ -85,11 +79,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     len_bytes = (end - start) * sizeof(uint64_t);
 
     new_table = qemu_blockalign(s->bs, len_bytes);
-    iov = (struct iovec) {
-        .iov_base = new_table->offsets,
-        .iov_len = len_bytes,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
 
     /* Byteswap table */
     for (i = start; i < end; i++) {
diff --git a/block/qed.c b/block/qed.c
index 1280870024..c5e6d6ad41 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -113,18 +113,13 @@ static int coroutine_fn qed_write_header(BDRVQEDState *s)
     int nsectors = DIV_ROUND_UP(sizeof(QEDHeader), BDRV_SECTOR_SIZE);
     size_t len = nsectors * BDRV_SECTOR_SIZE;
     uint8_t *buf;
-    struct iovec iov;
     QEMUIOVector qiov;
     int ret;
 
     assert(s->allocating_acb || s->allocating_write_reqs_plugged);
 
     buf = qemu_blockalign(s->bs, len);
-    iov = (struct iovec) {
-        .iov_base = buf,
-        .iov_len = len,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, buf, len);
 
     ret = bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
     if (ret < 0) {
@@ -913,7 +908,6 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
 {
     QEMUIOVector qiov;
     QEMUIOVector *backing_qiov = NULL;
-    struct iovec iov;
     int ret;
 
     /* Skip copy entirely if there is no work to do */
@@ -921,11 +915,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
         return 0;
     }
 
-    iov = (struct iovec) {
-        .iov_base = qemu_blockalign(s->bs, len),
-        .iov_len = len,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, qemu_blockalign(s->bs, len), len);
 
     ret = qed_read_backing_file(s, pos, &qiov, &backing_qiov);
 
@@ -946,7 +936,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
     }
     ret = 0;
 out:
-    qemu_vfree(iov.iov_base);
+    qemu_vfree(qemu_iovec_buf(&qiov));
     return ret;
 }
 
@@ -1447,8 +1437,12 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
                                                   BdrvRequestFlags flags)
 {
     BDRVQEDState *s = bs->opaque;
-    QEMUIOVector qiov;
-    struct iovec iov;
+
+    /*
+     * Zero writes start without an I/O buffer.  If a buffer becomes necessary
+     * then it will be allocated during request processing.
+     */
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
     /* Fall back if the request is not aligned */
     if (qed_offset_into_cluster(s, offset) ||
@@ -1456,13 +1450,6 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
         return -ENOTSUP;
     }
 
-    /* Zero writes start without an I/O buffer.  If a buffer becomes necessary
-     * then it will be allocated during request processing.
-     */
-    iov.iov_base = NULL;
-    iov.iov_len = bytes;
-
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return qed_co_request(bs, offset >> BDRV_SECTOR_BITS, &qiov,
                           bytes >> BDRV_SECTOR_BITS,
                           QED_AIOCB_WRITE | QED_AIOCB_ZERO);
-- 
2.18.0
