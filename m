Received: from eggs.gnu.org ([2001:4830:134:3::10]:50112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqz-0004XQ-UE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqt-0001bi-PA
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:18 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 27 Sep 2017 13:53:38 +0100
Message-Id: <20170927125340.12360-5-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-1-berrange@redhat.com>
References: <20170927125340.12360-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/6] block: convert crypto driver to
 bdrv_co_preadv|pwritev
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

Make the crypto driver implement the bdrv_co_preadv|pwritev
callbacks, and also use bdrv_co_preadv|pwritev for I/O
with the protocol driver beneath. This replaces sector based
I/O with byte based I/O, and allows us to stop assuming the
physical sector size matches the encryption sector size.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
2.13.5
