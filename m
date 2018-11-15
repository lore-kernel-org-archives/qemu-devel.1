Received: from eggs.gnu.org ([2001:4830:134:3::10]:53765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70u-0002QD-OZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70r-0005kt-JF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:04:12 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:30 -0600
Message-Id: <20181115020334.1189829-10-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/13] RFC: crypto: Rely on block layer for
 fragmentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

No need to reimplement fragmentation to BLOCK_CRYPTO_MAX_IO_SIZE
ourselves when we can ask the block layer to do it for us.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Question - is this patch for 'crypto' acceptable, or should we stick
with just the previous one that marks things as 64-bit clean?
---
 block/crypto.c | 80 +++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 50 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 259ef2649e1..b004cef22c2 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -328,8 +328,6 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                        QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto = bs->opaque;
-    uint64_t cur_bytes; /* number of bytes in current iteration */
-    uint64_t bytes_done = 0;
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
@@ -346,38 +344,30 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     /* Bounce buffer because we don't wish to expose cipher text
      * in qiov which points to guest memory.
      */
-    cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE,
-                                              qiov->size));
+    assert(qiov->size <= BLOCK_CRYPTO_MAX_IO_SIZE);
+    cipher_data = qemu_try_blockalign(bs->file->bs, qiov->size);
     if (cipher_data == NULL) {
         ret = -ENOMEM;
         goto cleanup;
     }

-    while (bytes) {
-        cur_bytes = MIN(bytes, BLOCK_CRYPTO_MAX_IO_SIZE);
+    qemu_iovec_reset(&hd_qiov);
+    qemu_iovec_add(&hd_qiov, cipher_data, bytes);

-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
-
-        ret = bdrv_co_preadv(bs->file, payload_offset + offset + bytes_done,
-                             cur_bytes, &hd_qiov, 0);
-        if (ret < 0) {
-            goto cleanup;
-        }
-
-        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
-                                  cipher_data, cur_bytes, NULL) < 0) {
-            ret = -EIO;
-            goto cleanup;
-        }
-
-        qemu_iovec_from_buf(qiov, bytes_done, cipher_data, cur_bytes);
+    ret = bdrv_co_preadv(bs->file, payload_offset + offset, bytes,
+                         &hd_qiov, 0);
+    if (ret < 0) {
+        goto cleanup;
+    }

-        bytes -= cur_bytes;
-        bytes_done += cur_bytes;
+    if (qcrypto_block_decrypt(crypto->block, offset,
+                              cipher_data, bytes, NULL) < 0) {
+        ret = -EIO;
+        goto cleanup;
     }

+    qemu_iovec_from_buf(qiov, 0, cipher_data, bytes);
+
  cleanup:
     qemu_iovec_destroy(&hd_qiov);
     qemu_vfree(cipher_data);
@@ -391,8 +381,6 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                         QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto = bs->opaque;
-    uint64_t cur_bytes; /* number of bytes in current iteration */
-    uint64_t bytes_done = 0;
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
@@ -409,36 +397,28 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     /* Bounce buffer because we're not permitted to touch
      * contents of qiov - it points to guest memory.
      */
-    cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE,
-                                              qiov->size));
+    assert(qiov->size <= BLOCK_CRYPTO_MAX_IO_SIZE);
+    cipher_data = qemu_try_blockalign(bs->file->bs, qiov->size);
     if (cipher_data == NULL) {
         ret = -ENOMEM;
         goto cleanup;
     }

-    while (bytes) {
-        cur_bytes = MIN(bytes, BLOCK_CRYPTO_MAX_IO_SIZE);
+    qemu_iovec_to_buf(qiov, 0, cipher_data, bytes);

-        qemu_iovec_to_buf(qiov, bytes_done, cipher_data, cur_bytes);
+    if (qcrypto_block_encrypt(crypto->block, offset,
+                              cipher_data, bytes, NULL) < 0) {
+        ret = -EIO;
+        goto cleanup;
+    }

-        if (qcrypto_block_encrypt(crypto->block, offset + bytes_done,
-                                  cipher_data, cur_bytes, NULL) < 0) {
-            ret = -EIO;
-            goto cleanup;
-        }
+    qemu_iovec_reset(&hd_qiov);
+    qemu_iovec_add(&hd_qiov, cipher_data, bytes);

-        qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
-
-        ret = bdrv_co_pwritev(bs->file, payload_offset + offset + bytes_done,
-                              cur_bytes, &hd_qiov, flags);
-        if (ret < 0) {
-            goto cleanup;
-        }
-
-        bytes -= cur_bytes;
-        bytes_done += cur_bytes;
+    ret = bdrv_co_pwritev(bs->file, payload_offset + offset,
+                          bytes, &hd_qiov, flags);
+    if (ret < 0) {
+        goto cleanup;
     }

  cleanup:
@@ -453,7 +433,7 @@ static void block_crypto_refresh_limits(BlockDriverState *bs, Error **errp)
     BlockCrypto *crypto = bs->opaque;
     uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     bs->bl.request_alignment = sector_size; /* No sub-sector I/O */
-    bs->bl.max_transfer = INT64_MAX;
+    bs->bl.max_transfer = BLOCK_CRYPTO_MAX_IO_SIZE;
 }


-- 
2.17.2
