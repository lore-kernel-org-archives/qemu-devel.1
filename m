Received: from eggs.gnu.org ([2001:4830:134:3::10]:41000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKK-0007vm-FW
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKI-0007bk-V0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 15:15:20 -0500
Message-Id: <20180628201525.281787-4-eblake@redhat.com>
In-Reply-To: <20180628201525.281787-1-eblake@redhat.com>
References: <20180628201525.281787-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/8] qcow: Switch qcow_co_readv to
 byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the internals of the qcow
driver read function, by iterating over offset/bytes instead of
sector_num/nb_sectors, and with a rename of index_in_cluster and
repurposing of n to track bytes instead of sectors.

A later patch will then switch the qcow driver as a whole over
to byte-based operation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>

---
v2: prefer 64-bit * over 32-bit <<, rename variable for legibility [Kevin]
---
 block/qcow.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 7c3dc8b3504..175f1c8f848 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -618,13 +618,15 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
                          int nb_sectors, QEMUIOVector *qiov)
 {
     BDRVQcowState *s = bs->opaque;
-    int index_in_cluster;
+    int offset_in_cluster;
     int ret = 0, n;
     uint64_t cluster_offset;
     struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
+    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
+    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;

     if (qiov->niov > 1) {
         buf = orig_buf = qemu_try_blockalign(bs, qiov->size);
@@ -638,36 +640,35 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,

     qemu_co_mutex_lock(&s->lock);

-    while (nb_sectors != 0) {
+    while (bytes != 0) {
         /* prepare next request */
-        ret = get_cluster_offset(bs, sector_num << 9,
-                                 0, 0, 0, 0, &cluster_offset);
+        ret = get_cluster_offset(bs, offset, 0, 0, 0, 0, &cluster_offset);
         if (ret < 0) {
             break;
         }
-        index_in_cluster = sector_num & (s->cluster_sectors - 1);
-        n = s->cluster_sectors - index_in_cluster;
-        if (n > nb_sectors) {
-            n = nb_sectors;
+        offset_in_cluster = offset & (s->cluster_size - 1);
+        n = s->cluster_size - offset_in_cluster;
+        if (n > bytes) {
+            n = bytes;
         }

         if (!cluster_offset) {
             if (bs->backing) {
                 /* read from the base image */
                 hd_iov.iov_base = (void *)buf;
-                hd_iov.iov_len = n * 512;
+                hd_iov.iov_len = n;
                 qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
                 qemu_co_mutex_unlock(&s->lock);
                 /* qcow2 emits this on bs->file instead of bs->backing */
                 BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret = bdrv_co_readv(bs->backing, sector_num, n, &hd_qiov);
+                ret = bdrv_co_preadv(bs->backing, offset, n, &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     break;
                 }
             } else {
                 /* Note: in this case, no need to wait */
-                memset(buf, 0, 512 * n);
+                memset(buf, 0, n);
             }
         } else if (cluster_offset & QCOW_OFLAG_COMPRESSED) {
             /* add AIO support for compressed blocks ? */
@@ -675,21 +676,19 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
                 ret = -EIO;
                 break;
             }
-            memcpy(buf,
-                   s->cluster_cache + index_in_cluster * 512, 512 * n);
+            memcpy(buf, s->cluster_cache + offset_in_cluster, n);
         } else {
             if ((cluster_offset & 511) != 0) {
                 ret = -EIO;
                 break;
             }
             hd_iov.iov_base = (void *)buf;
-            hd_iov.iov_len = n * 512;
+            hd_iov.iov_len = n;
             qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
             qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-            ret = bdrv_co_readv(bs->file,
-                                (cluster_offset >> 9) + index_in_cluster,
-                                n, &hd_qiov);
+            ret = bdrv_co_preadv(bs->file, cluster_offset + offset_in_cluster,
+                                 n, &hd_qiov, 0);
             qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
                 break;
@@ -697,8 +696,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
             if (bs->encrypted) {
                 assert(s->crypto);
                 if (qcrypto_block_decrypt(s->crypto,
-                                          sector_num * BDRV_SECTOR_SIZE, buf,
-                                          n * BDRV_SECTOR_SIZE, NULL) < 0) {
+                                          offset, buf, n, NULL) < 0) {
                     ret = -EIO;
                     break;
                 }
@@ -706,9 +704,9 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
         }
         ret = 0;

-        nb_sectors -= n;
-        sector_num += n;
-        buf += n * 512;
+        bytes -= n;
+        offset += n;
+        buf += n;
     }

     qemu_co_mutex_unlock(&s->lock);
-- 
2.14.4
