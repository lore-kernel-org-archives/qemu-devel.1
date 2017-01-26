Received: from eggs.gnu.org ([2001:4830:134:3::10]:45620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh97-0001lg-Rs
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh96-0006BN-Lj
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:13 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:19 +0000
Message-Id: <20170126101827.22378-11-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/18] qcow2: make qcow2_encrypt_sectors
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Instead of requiring separate input/output buffers for
encrypting data, change qcow2_encrypt_sectors() to assume
use of a single buffer, encrypting in place. The current
callers all used the same buffer for input/output already.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow2-cluster.c | 17 ++++++-----------
 block/qcow2.c         |  4 ++--
 block/qcow2.h         |  3 +--
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 928c1e2..907e869 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -346,11 +346,9 @@ static int count_contiguous_clusters_by_type(int nb_clusters,
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
@@ -370,14 +368,12 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
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
@@ -385,8 +381,7 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
             return -1;
         }
         sector_num++;
-        in_buf += 512;
-        out_buf += 512;
+        buf += 512;
     }
     return 0;
 }
@@ -434,7 +429,7 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
-        if (qcow2_encrypt_sectors(s, sector, iov.iov_base, iov.iov_base,
+        if (qcow2_encrypt_sectors(s, sector, iov.iov_base,
                                   bytes >> BDRV_SECTOR_BITS, true, &err) < 0) {
             ret = -EIO;
             error_free(err);
diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8..3c14c86 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1530,7 +1530,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
                 Error *err = NULL;
                 if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
-                                          cluster_data, cluster_data,
+                                          cluster_data,
                                           cur_bytes >> BDRV_SECTOR_BITS,
                                           false, &err) < 0) {
                     error_free(err);
@@ -1626,7 +1626,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
             if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
-                                      cluster_data, cluster_data,
+                                      cluster_data,
                                       cur_bytes >>BDRV_SECTOR_BITS,
                                       true, &err) < 0) {
                 error_free(err);
diff --git a/block/qcow2.h b/block/qcow2.h
index 1823414..033d8c0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -530,8 +530,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
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
