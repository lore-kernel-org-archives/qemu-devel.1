Received: from eggs.gnu.org ([2001:4830:134:3::10]:53866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNU-00033r-3Y
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNR-0004Sd-FY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:16 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 12:28:52 +0100
Message-Id: <20170912112855.24269-5-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-1-berrange@redhat.com>
References: <20170912112855.24269-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] block: don't use constant 512 as sector
 size in crypto driver
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

Use the qcrypto_block_get_sector_size() value in the block
crypto driver instead of hardcoding 512 as the sector size.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index d68cbac2ac..49d6d4c058 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -392,8 +392,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
+    uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     uint64_t payload_offset =
-        qcrypto_block_get_payload_offset(crypto->block) / 512;
+        qcrypto_block_get_payload_offset(crypto->block) / sector_size;
     assert(payload_offset < (INT64_MAX / 512));
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
@@ -401,9 +402,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
     /* Bounce buffer because we don't wish to expose cipher text
      * in qiov which points to guest memory.
      */
-    cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
-                                              qiov->size));
+    cipher_data = qemu_try_blockalign(
+        bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * sector_size,
+                          qiov->size));
     if (cipher_data == NULL) {
         ret = -ENOMEM;
         goto cleanup;
@@ -417,7 +418,7 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
         }
 
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * sector_size);
 
         ret = bdrv_co_readv(bs->file,
                             payload_offset + sector_num,
@@ -428,18 +429,18 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
 
         if (qcrypto_block_decrypt(crypto->block,
                                   sector_num,
-                                  cipher_data, cur_nr_sectors * 512,
+                                  cipher_data, cur_nr_sectors * sector_size,
                                   NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
         qemu_iovec_from_buf(qiov, bytes_done,
-                            cipher_data, cur_nr_sectors * 512);
+                            cipher_data, cur_nr_sectors * sector_size);
 
         remaining_sectors -= cur_nr_sectors;
         sector_num += cur_nr_sectors;
-        bytes_done += cur_nr_sectors * 512;
+        bytes_done += cur_nr_sectors * sector_size;
     }
 
  cleanup:
@@ -460,8 +461,9 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
+    uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     uint64_t payload_offset =
-        qcrypto_block_get_payload_offset(crypto->block) / 512;
+        qcrypto_block_get_payload_offset(crypto->block) / sector_size;
     assert(payload_offset < (INT64_MAX / 512));
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
@@ -469,9 +471,9 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
     /* Bounce buffer because we're not permitted to touch
      * contents of qiov - it points to guest memory.
      */
-    cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
-                                              qiov->size));
+    cipher_data = qemu_try_blockalign(
+        bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * sector_size,
+                          qiov->size));
     if (cipher_data == NULL) {
         ret = -ENOMEM;
         goto cleanup;
@@ -485,18 +487,18 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
         }
 
         qemu_iovec_to_buf(qiov, bytes_done,
-                          cipher_data, cur_nr_sectors * 512);
+                          cipher_data, cur_nr_sectors * sector_size);
 
         if (qcrypto_block_encrypt(crypto->block,
                                   sector_num,
-                                  cipher_data, cur_nr_sectors * 512,
+                                  cipher_data, cur_nr_sectors * sector_size,
                                   NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * sector_size);
 
         ret = bdrv_co_writev(bs->file,
                              payload_offset + sector_num,
@@ -507,7 +509,7 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
 
         remaining_sectors -= cur_nr_sectors;
         sector_num += cur_nr_sectors;
-        bytes_done += cur_nr_sectors * 512;
+        bytes_done += cur_nr_sectors * sector_size;
     }
 
  cleanup:
-- 
2.13.5
