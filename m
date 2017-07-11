Received: from eggs.gnu.org ([2001:4830:134:3::10]:44265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxic-0006TB-IN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxib-0005EZ-Dt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:58 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:06:59 +0200
Message-Id: <20170711160814.20941-11-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 10/85] qcow2: make qcow2_encrypt_sectors encrypt
 in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Instead of requiring separate input/output buffers for
encrypting data, change qcow2_encrypt_sectors() to assume
use of a single buffer, encrypting in place. The current
callers all used the same buffer for input/output already.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-11-berrange@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         |  3 +--
 block/qcow2-cluster.c | 17 ++++++-----------
 block/qcow2.c         |  4 ++--
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 87b15eb..5a3f07e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -545,8 +545,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
-                          uint8_t *out_buf, const uint8_t *in_buf,
-                          int nb_sectors, bool enc, Error **errp);
+                          uint8_t *buf, int nb_sectors, bool enc, Error **errp);
 
 int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
                              unsigned int *bytes, uint64_t *cluster_offset);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3d341fd..a570929 100644
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
@@ -446,7 +441,7 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
         assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
-        if (qcow2_encrypt_sectors(s, sector, buffer, buffer,
+        if (qcow2_encrypt_sectors(s, sector, buffer,
                                   bytes >> BDRV_SECTOR_BITS, true, NULL) < 0) {
             return false;
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index 8f1822c..df9caa8 100644
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
@@ -1677,7 +1677,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
             if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
-                                      cluster_data, cluster_data,
+                                      cluster_data,
                                       cur_bytes >>BDRV_SECTOR_BITS,
                                       true, &err) < 0) {
                 error_free(err);
-- 
2.9.4
