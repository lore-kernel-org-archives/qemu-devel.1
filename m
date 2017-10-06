Received: from eggs.gnu.org ([2001:4830:134:3::10]:56632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyW-0001IN-Gl
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyV-0004EA-Bz
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:15 +0200
Message-Id: <20171006155422.10135-48-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 47/54] block: convert crypto driver to
 bdrv_co_preadv|pwritev
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

From: "Daniel P. Berrange" <berrange@redhat.com>

Make the crypto driver implement the bdrv_co_preadv|pwritev
callbacks, and also use bdrv_co_preadv|pwritev for I/O
with the protocol driver beneath. This replaces sector based
I/O with byte based I/O, and allows us to stop assuming the
physical sector size matches the encryption sector size.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170927125340.12360-5-berrange@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/crypto.c | 106 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 52 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 61f5d77bc0..965c173b01 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -387,18 +387,23 @@ static void block_crypto_close(BlockDriverState *bs)
 #define BLOCK_CRYPTO_MAX_IO_SIZE (1024 * 1024)
 
 static coroutine_fn int
-block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
-                      int remaining_sectors, QEMUIOVector *qiov)
+block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                       QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto = bs->opaque;
-    int cur_nr_sectors; /* number of sectors in current iteration */
+    uint64_t cur_bytes; /* number of bytes in current iteration */
     uint64_t bytes_done = 0;
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
-    uint64_t payload_offset =
-        qcrypto_block_get_payload_offset(crypto->block) / 512;
-    assert(payload_offset < (INT64_MAX / 512));
+    uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
+    uint64_t payload_offset = qcrypto_block_get_payload_offset(crypto->block);
+    uint64_t sector_num = offset / sector_size;
+
+    assert(!flags);
+    assert(payload_offset < INT64_MAX);
+    assert(QEMU_IS_ALIGNED(offset, sector_size));
+    assert(QEMU_IS_ALIGNED(bytes, sector_size));
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
@@ -413,37 +418,29 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
         goto cleanup;
     }
 
-    while (remaining_sectors) {
-        cur_nr_sectors = remaining_sectors;
-
-        if (cur_nr_sectors > (BLOCK_CRYPTO_MAX_IO_SIZE / 512)) {
-            cur_nr_sectors = (BLOCK_CRYPTO_MAX_IO_SIZE / 512);
-        }
+    while (bytes) {
+        cur_bytes = MIN(bytes, BLOCK_CRYPTO_MAX_IO_SIZE);
 
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
 
-        ret = bdrv_co_readv(bs->file,
-                            payload_offset + sector_num,
-                            cur_nr_sectors, &hd_qiov);
+        ret = bdrv_co_preadv(bs->file, payload_offset + offset + bytes_done,
+                             cur_bytes, &hd_qiov, 0);
         if (ret < 0) {
             goto cleanup;
         }
 
-        if (qcrypto_block_decrypt(crypto->block,
-                                  sector_num,
-                                  cipher_data, cur_nr_sectors * 512,
-                                  NULL) < 0) {
+        if (qcrypto_block_decrypt(crypto->block, sector_num, cipher_data,
+                                  cur_bytes, NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
-        qemu_iovec_from_buf(qiov, bytes_done,
-                            cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_from_buf(qiov, bytes_done, cipher_data, cur_bytes);
 
-        remaining_sectors -= cur_nr_sectors;
-        sector_num += cur_nr_sectors;
-        bytes_done += cur_nr_sectors * 512;
+        sector_num += cur_bytes / sector_size;
+        bytes -= cur_bytes;
+        bytes_done += cur_bytes;
     }
 
  cleanup:
@@ -455,18 +452,23 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
 
 
 static coroutine_fn int
-block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
-                       int remaining_sectors, QEMUIOVector *qiov)
+block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                        QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto = bs->opaque;
-    int cur_nr_sectors; /* number of sectors in current iteration */
+    uint64_t cur_bytes; /* number of bytes in current iteration */
     uint64_t bytes_done = 0;
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
-    uint64_t payload_offset =
-        qcrypto_block_get_payload_offset(crypto->block) / 512;
-    assert(payload_offset < (INT64_MAX / 512));
+    uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
+    uint64_t payload_offset = qcrypto_block_get_payload_offset(crypto->block);
+    uint64_t sector_num = offset / sector_size;
+
+    assert(!flags);
+    assert(payload_offset < INT64_MAX);
+    assert(QEMU_IS_ALIGNED(offset, sector_size));
+    assert(QEMU_IS_ALIGNED(bytes, sector_size));
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
@@ -481,37 +483,29 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
         goto cleanup;
     }
 
-    while (remaining_sectors) {
-        cur_nr_sectors = remaining_sectors;
+    while (bytes) {
+        cur_bytes = MIN(bytes, BLOCK_CRYPTO_MAX_IO_SIZE);
 
-        if (cur_nr_sectors > (BLOCK_CRYPTO_MAX_IO_SIZE / 512)) {
-            cur_nr_sectors = (BLOCK_CRYPTO_MAX_IO_SIZE / 512);
-        }
-
-        qemu_iovec_to_buf(qiov, bytes_done,
-                          cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_to_buf(qiov, bytes_done, cipher_data, cur_bytes);
 
-        if (qcrypto_block_encrypt(crypto->block,
-                                  sector_num,
-                                  cipher_data, cur_nr_sectors * 512,
-                                  NULL) < 0) {
+        if (qcrypto_block_encrypt(crypto->block, sector_num, cipher_data,
+                                  cur_bytes, NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_nr_sectors * 512);
+        qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
 
-        ret = bdrv_co_writev(bs->file,
-                             payload_offset + sector_num,
-                             cur_nr_sectors, &hd_qiov);
+        ret = bdrv_co_pwritev(bs->file, payload_offset + offset + bytes_done,
+                              cur_bytes, &hd_qiov, 0);
         if (ret < 0) {
             goto cleanup;
         }
 
-        remaining_sectors -= cur_nr_sectors;
-        sector_num += cur_nr_sectors;
-        bytes_done += cur_nr_sectors * 512;
+        sector_num += cur_bytes / sector_size;
+        bytes -= cur_bytes;
+        bytes_done += cur_bytes;
     }
 
  cleanup:
@@ -521,6 +515,13 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
     return ret;
 }
 
+static void block_crypto_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
+    bs->bl.request_alignment = sector_size; /* No sub-sector I/O */
+}
+
 
 static int64_t block_crypto_getlength(BlockDriverState *bs)
 {
@@ -620,8 +621,9 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
 
-    .bdrv_co_readv      = block_crypto_co_readv,
-    .bdrv_co_writev     = block_crypto_co_writev,
+    .bdrv_refresh_limits = block_crypto_refresh_limits,
+    .bdrv_co_preadv     = block_crypto_co_preadv,
+    .bdrv_co_pwritev    = block_crypto_co_pwritev,
     .bdrv_getlength     = block_crypto_getlength,
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
-- 
2.13.6
