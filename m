Received: from eggs.gnu.org ([2001:4830:134:3::10]:41035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKN-0007yv-7E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKK-0007dz-0v
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 15:15:21 -0500
Message-Id: <20180628201525.281787-5-eblake@redhat.com>
In-Reply-To: <20180628201525.281787-1-eblake@redhat.com>
References: <20180628201525.281787-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/8] qcow: Switch qcow_co_writev to
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
driver write function, by iterating over offset/bytes instead of
sector_num/nb_sectors, and with a rename of index_in_cluster and
repurposing of n to track bytes instead of sectors.

A later patch will then switch the qcow driver as a whole over
to byte-based operation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>

---
v2: prefer 64-bit * over 23-bit <<, rename variable for legibility [Kevin]
---
 block/qcow.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 175f1c8f848..d2af7b8e025 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -724,13 +724,15 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
                                        int flags)
 {
     BDRVQcowState *s = bs->opaque;
-    int index_in_cluster;
+    int offset_in_cluster;
     uint64_t cluster_offset;
     int ret = 0, n;
     struct iovec hd_iov;
     QEMUIOVector hd_qiov;
     uint8_t *buf;
     void *orig_buf;
+    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
+    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;

     assert(!flags);
     s->cluster_cache_offset = -1; /* disable compressed cache */
@@ -750,16 +752,14 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,

     qemu_co_mutex_lock(&s->lock);

-    while (nb_sectors != 0) {
-
-        index_in_cluster = sector_num & (s->cluster_sectors - 1);
-        n = s->cluster_sectors - index_in_cluster;
-        if (n > nb_sectors) {
-            n = nb_sectors;
+    while (bytes != 0) {
+        offset_in_cluster = offset & (s->cluster_size - 1);
+        n = s->cluster_size - offset_in_cluster;
+        if (n > bytes) {
+            n = bytes;
         }
-        ret = get_cluster_offset(bs, sector_num << 9, 1, 0,
-                                 index_in_cluster << 9,
-                                 (index_in_cluster + n) << 9, &cluster_offset);
+        ret = get_cluster_offset(bs, offset, 1, 0, offset_in_cluster,
+                                 offset_in_cluster + n, &cluster_offset);
         if (ret < 0) {
             break;
         }
@@ -769,30 +769,28 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
         }
         if (bs->encrypted) {
             assert(s->crypto);
-            if (qcrypto_block_encrypt(s->crypto, sector_num * BDRV_SECTOR_SIZE,
-                                      buf, n * BDRV_SECTOR_SIZE, NULL) < 0) {
+            if (qcrypto_block_encrypt(s->crypto, offset, buf, n, NULL) < 0) {
                 ret = -EIO;
                 break;
             }
         }

         hd_iov.iov_base = (void *)buf;
-        hd_iov.iov_len = n * 512;
+        hd_iov.iov_len = n;
         qemu_iovec_init_external(&hd_qiov, &hd_iov, 1);
         qemu_co_mutex_unlock(&s->lock);
         BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
-        ret = bdrv_co_writev(bs->file,
-                             (cluster_offset >> 9) + index_in_cluster,
-                             n, &hd_qiov);
+        ret = bdrv_co_pwritev(bs->file, cluster_offset + offset_in_cluster,
+                              n, &hd_qiov, 0);
         qemu_co_mutex_lock(&s->lock);
         if (ret < 0) {
             break;
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
