Received: from eggs.gnu.org ([2001:4830:134:3::10]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNHy-0006bc-IE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNHx-0007dC-Bm
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:05:34 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 12:05:16 +0100
Message-Id: <20170831110518.10741-3-berrange@redhat.com>
In-Reply-To: <20170831110518.10741-1-berrange@redhat.com>
References: <20170831110518.10741-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] block: use BDRV_SECTOR_SIZE in crypto
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index cc8afe0e0d..e63f094379 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -392,16 +392,16 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
     QEMUIOVector hd_qiov;
     int ret = 0;
     size_t payload_offset =
-        qcrypto_block_get_payload_offset(crypto->block) / 512;
+        qcrypto_block_get_payload_offset(crypto->block) / BDRV_SECTOR_SIZE;
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
     /* Bounce buffer because we don't wish to expose cipher text
      * in qiov which points to guest memory.
      */
-    cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
-                                              qiov->size));
+    cipher_data = qemu_try_blockalign(
+        bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * BDRV_SECTOR_SIZE,
+                          qiov->size));
     if (cipher_data == NULL) {
         ret = -ENOMEM;
         goto cleanup;
@@ -415,7 +415,7 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
         }
 
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * BDRV_SECTOR_SIZE);
 
         ret = bdrv_co_readv(bs->file,
                             payload_offset + sector_num,
@@ -426,18 +426,18 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
 
         if (qcrypto_block_decrypt(crypto->block,
                                   sector_num,
-                                  cipher_data, cur_nr_sectors * 512,
+                                  cipher_data, cur_nr_sectors * BDRV_SECTOR_SIZE,
                                   NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
         qemu_iovec_from_buf(qiov, bytes_done,
-                            cipher_data, cur_nr_sectors * 512);
+                            cipher_data, cur_nr_sectors * BDRV_SECTOR_SIZE);
 
         remaining_sectors -= cur_nr_sectors;
         sector_num += cur_nr_sectors;
-        bytes_done += cur_nr_sectors * 512;
+        bytes_done += cur_nr_sectors * BDRV_SECTOR_SIZE;
     }
 
  cleanup:
@@ -459,16 +459,16 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
     QEMUIOVector hd_qiov;
     int ret = 0;
     size_t payload_offset =
-        qcrypto_block_get_payload_offset(crypto->block) / 512;
+        qcrypto_block_get_payload_offset(crypto->block) / BDRV_SECTOR_SIZE;
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
     /* Bounce buffer because we're not permitted to touch
      * contents of qiov - it points to guest memory.
      */
-    cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
-                                              qiov->size));
+    cipher_data = qemu_try_blockalign(
+        bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * BDRV_SECTOR_SIZE,
+                          qiov->size));
     if (cipher_data == NULL) {
         ret = -ENOMEM;
         goto cleanup;
@@ -482,18 +482,18 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
         }
 
         qemu_iovec_to_buf(qiov, bytes_done,
-                          cipher_data, cur_nr_sectors * 512);
+                          cipher_data, cur_nr_sectors * BDRV_SECTOR_SIZE);
 
         if (qcrypto_block_encrypt(crypto->block,
                                   sector_num,
-                                  cipher_data, cur_nr_sectors * 512,
+                                  cipher_data, cur_nr_sectors * BDRV_SECTOR_SIZE,
                                   NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * BDRV_SECTOR_SIZE);
 
         ret = bdrv_co_writev(bs->file,
                              payload_offset + sector_num,
@@ -504,7 +504,7 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
 
         remaining_sectors -= cur_nr_sectors;
         sector_num += cur_nr_sectors;
-        bytes_done += cur_nr_sectors * 512;
+        bytes_done += cur_nr_sectors * BDRV_SECTOR_SIZE;
     }
 
  cleanup:
-- 
2.13.5
