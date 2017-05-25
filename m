Received: from eggs.gnu.org ([2001:4830:134:3::10]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDvnS-0002P0-QQ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDvnR-00074M-O2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:39:34 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 25 May 2017 17:38:41 +0100
Message-Id: <20170525163851.8047-11-berrange@redhat.com>
In-Reply-To: <20170525163851.8047-1-berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/20] qcow2: make qcow2_encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

Instead of requiring separate input/output buffers for
encrypting data, change qcow2_encrypt_sectors() to assume
use of a single buffer, encrypting in place. The current
callers all used the same buffer for input/output already.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow2-cluster.c | 17 ++++++-----------
 block/qcow2.c         |  4 ++--
 block/qcow2.h         |  3 +--
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 347d94b..438499d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -358,11 +358,9 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
 }
 
 /* The crypt function is compatible with the linux cryptoloop
-   algorithm for < 4 GB images. NOTE: out_buf == in_buf is
-   supported */
+   algorithm for < 4 GB images. */
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
-                          uint8_t *out_buf, const uint8_t *in_buf,
-                          int nb_sectors, bool enc,
+                          uint8_t *buf, int nb_sectors, bool enc,
                           Error **errp)
 {
     union {
@@ -382,14 +380,12 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
         }
         if (enc) {
             ret = qcrypto_cipher_encrypt(s->cipher,
-                                         in_buf,
-                                         out_buf,
+                                         buf, buf,
                                          512,
                                          errp);
         } else {
             ret = qcrypto_cipher_decrypt(s->cipher,
-                                         in_buf,
-                                         out_buf,
+                                         buf, buf,
                                          512,
                                          errp);
         }
@@ -397,8 +393,7 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
             return -1;
         }
         sector_num++;
-        in_buf += 512;
-        out_buf += 512;
+        buf += 512;
     }
     return 0;
 }
@@ -446,7 +441,7 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
-        if (qcow2_encrypt_sectors(s, sector, iov.iov_base, iov.iov_base,
+        if (qcow2_encrypt_sectors(s, sector, iov.iov_base,
                                   bytes >> BDRV_SECTOR_BITS, true, &err) < 0) {
             ret = -EIO;
             error_free(err);
diff --git a/block/qcow2.c b/block/qcow2.c
index b7c3230..d98b6d9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1543,7 +1543,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
                 Error *err = NULL;
                 if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
-                                          cluster_data, cluster_data,
+                                          cluster_data,
                                           cur_bytes >> BDRV_SECTOR_BITS,
                                           false, &err) < 0) {
                     error_free(err);
@@ -1639,7 +1639,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
             if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
-                                      cluster_data, cluster_data,
+                                      cluster_data,
                                       cur_bytes >>BDRV_SECTOR_BITS,
                                       true, &err) < 0) {
                 error_free(err);
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc3..6b3d5de 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -538,8 +538,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
-                          uint8_t *out_buf, const uint8_t *in_buf,
-                          int nb_sectors, bool enc, Error **errp);
+                          uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
 int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
                              unsigned int *bytes, uint64_t *cluster_offset);
-- 
2.9.3
