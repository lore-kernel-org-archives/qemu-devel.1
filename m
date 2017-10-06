Received: from eggs.gnu.org ([2001:4830:134:3::10]:56802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyg-0001TD-6i
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uye-0004Ru-60
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:16 +0200
Message-Id: <20171006155422.10135-49-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 48/54] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
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

Instead of sector offset, take the bytes offset when encrypting
or decrypting data.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170927125340.12360-6-berrange@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 crypto/blockpriv.h     |  4 ++--
 include/crypto/block.h | 14 ++++++++------
 block/crypto.c         | 12 ++++--------
 block/qcow.c           | 11 +++++++----
 block/qcow2-cluster.c  |  8 +++-----
 block/qcow2.c          |  4 ++--
 crypto/block-luks.c    | 12 ++++++++----
 crypto/block-qcow.c    | 12 ++++++++----
 crypto/block.c         | 20 ++++++++++++++------
 9 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index d227522d88..41840abcec 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -82,7 +82,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
-                                 uint64_t startsector,
+                                 uint64_t offset,
                                  uint8_t *buf,
                                  size_t len,
                                  Error **errp);
@@ -91,7 +91,7 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
-                                 uint64_t startsector,
+                                 uint64_t offset,
                                  uint8_t *buf,
                                  size_t len,
                                  Error **errp);
diff --git a/include/crypto/block.h b/include/crypto/block.h
index 13232b2472..cd18f46d56 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -161,18 +161,19 @@ QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
 /**
  * @qcrypto_block_decrypt:
  * @block: the block encryption object
- * @startsector: the sector from which @buf was read
+ * @offset: the position at which @iov was read
  * @buf: the buffer to decrypt
  * @len: the length of @buf in bytes
  * @errp: pointer to a NULL-initialized error object
  *
  * Decrypt @len bytes of cipher text in @buf, writing
- * plain text back into @buf
+ * plain text back into @buf. @len and @offset must be
+ * a multiple of the encryption format sector size.
  *
  * Returns 0 on success, -1 on failure
  */
 int qcrypto_block_decrypt(QCryptoBlock *block,
-                          uint64_t startsector,
+                          uint64_t offset,
                           uint8_t *buf,
                           size_t len,
                           Error **errp);
@@ -180,18 +181,19 @@ int qcrypto_block_decrypt(QCryptoBlock *block,
 /**
  * @qcrypto_block_encrypt:
  * @block: the block encryption object
- * @startsector: the sector to which @buf will be written
+ * @offset: the position at which @iov will be written
  * @buf: the buffer to decrypt
  * @len: the length of @buf in bytes
  * @errp: pointer to a NULL-initialized error object
  *
  * Encrypt @len bytes of plain text in @buf, writing
- * cipher text back into @buf
+ * cipher text back into @buf. @len and @offset must be
+ * a multiple of the encryption format sector size.
  *
  * Returns 0 on success, -1 on failure
  */
 int qcrypto_block_encrypt(QCryptoBlock *block,
-                          uint64_t startsector,
+                          uint64_t offset,
                           uint8_t *buf,
                           size_t len,
                           Error **errp);
diff --git a/block/crypto.c b/block/crypto.c
index 965c173b01..edf53d49d1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -398,7 +398,6 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int ret = 0;
     uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     uint64_t payload_offset = qcrypto_block_get_payload_offset(crypto->block);
-    uint64_t sector_num = offset / sector_size;
 
     assert(!flags);
     assert(payload_offset < INT64_MAX);
@@ -430,15 +429,14 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             goto cleanup;
         }
 
-        if (qcrypto_block_decrypt(crypto->block, sector_num, cipher_data,
-                                  cur_bytes, NULL) < 0) {
+        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
+                                  cipher_data, cur_bytes, NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
 
         qemu_iovec_from_buf(qiov, bytes_done, cipher_data, cur_bytes);
 
-        sector_num += cur_bytes / sector_size;
         bytes -= cur_bytes;
         bytes_done += cur_bytes;
     }
@@ -463,7 +461,6 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int ret = 0;
     uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     uint64_t payload_offset = qcrypto_block_get_payload_offset(crypto->block);
-    uint64_t sector_num = offset / sector_size;
 
     assert(!flags);
     assert(payload_offset < INT64_MAX);
@@ -488,8 +485,8 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 
         qemu_iovec_to_buf(qiov, bytes_done, cipher_data, cur_bytes);
 
-        if (qcrypto_block_encrypt(crypto->block, sector_num, cipher_data,
-                                  cur_bytes, NULL) < 0) {
+        if (qcrypto_block_encrypt(crypto->block, offset + bytes_done,
+                                  cipher_data, cur_bytes, NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
@@ -503,7 +500,6 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             goto cleanup;
         }
 
-        sector_num += cur_bytes / sector_size;
         bytes -= cur_bytes;
         bytes_done += cur_bytes;
     }
diff --git a/block/qcow.c b/block/qcow.c
index f450b00cfc..9569deeaf0 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -478,7 +478,9 @@ static int get_cluster_offset(BlockDriverState *bs,
                     for(i = 0; i < s->cluster_sectors; i++) {
                         if (i < n_start || i >= n_end) {
                             memset(s->cluster_data, 0x00, 512);
-                            if (qcrypto_block_encrypt(s->crypto, start_sect + i,
+                            if (qcrypto_block_encrypt(s->crypto,
+                                                      (start_sect + i) *
+                                                      BDRV_SECTOR_SIZE,
                                                       s->cluster_data,
                                                       BDRV_SECTOR_SIZE,
                                                       NULL) < 0) {
@@ -668,7 +670,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
             }
             if (bs->encrypted) {
                 assert(s->crypto);
-                if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
+                if (qcrypto_block_decrypt(s->crypto,
+                                          sector_num * BDRV_SECTOR_SIZE, buf,
                                           n * BDRV_SECTOR_SIZE, NULL) < 0) {
                     ret = -EIO;
                     break;
@@ -740,8 +743,8 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
         }
         if (bs->encrypted) {
             assert(s->crypto);
-            if (qcrypto_block_encrypt(s->crypto, sector_num, buf,
-                                      n * BDRV_SECTOR_SIZE, NULL) < 0) {
+            if (qcrypto_block_encrypt(s->crypto, sector_num * BDRV_SECTOR_SIZE,
+                                      buf, n * BDRV_SECTOR_SIZE, NULL) < 0) {
                 ret = -EIO;
                 break;
             }
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index d2518d1893..0e5aec81cb 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -446,15 +446,13 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        int64_t sector = (s->crypt_physical_offset ?
+        int64_t offset = (s->crypt_physical_offset ?
                           (cluster_offset + offset_in_cluster) :
-                          (src_cluster_offset + offset_in_cluster))
-                         >> BDRV_SECTOR_BITS;
+                          (src_cluster_offset + offset_in_cluster));
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         assert(s->crypto);
-        if (qcrypto_block_encrypt(s->crypto, sector, buffer,
-                                  bytes, NULL) < 0) {
+        if (qcrypto_block_encrypt(s->crypto, offset, buffer, bytes, NULL) < 0) {
             return false;
         }
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index b8da8ca105..33597394b5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1811,7 +1811,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 if (qcrypto_block_decrypt(s->crypto,
                                           (s->crypt_physical_offset ?
                                            cluster_offset + offset_in_cluster :
-                                           offset) >> BDRV_SECTOR_BITS,
+                                           offset),
                                           cluster_data,
                                           cur_bytes,
                                           NULL) < 0) {
@@ -1946,7 +1946,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             if (qcrypto_block_encrypt(s->crypto,
                                       (s->crypt_physical_offset ?
                                        cluster_offset + offset_in_cluster :
-                                       offset) >> BDRV_SECTOR_BITS,
+                                       offset),
                                       cluster_data,
                                       cur_bytes, NULL) < 0) {
                 ret = -EIO;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index a9062bb0f2..d418ac30b8 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1399,29 +1399,33 @@ static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
 
 static int
 qcrypto_block_luks_decrypt(QCryptoBlock *block,
-                           uint64_t startsector,
+                           uint64_t offset,
                            uint8_t *buf,
                            size_t len,
                            Error **errp)
 {
+    assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     return qcrypto_block_decrypt_helper(block->cipher,
                                         block->niv, block->ivgen,
                                         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                        startsector, buf, len, errp);
+                                        offset, buf, len, errp);
 }
 
 
 static int
 qcrypto_block_luks_encrypt(QCryptoBlock *block,
-                           uint64_t startsector,
+                           uint64_t offset,
                            uint8_t *buf,
                            size_t len,
                            Error **errp)
 {
+    assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     return qcrypto_block_encrypt_helper(block->cipher,
                                         block->niv, block->ivgen,
                                         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                        startsector, buf, len, errp);
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 4dd594a9ba..8817d6aaa7 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -143,29 +143,33 @@ qcrypto_block_qcow_cleanup(QCryptoBlock *block)
 
 static int
 qcrypto_block_qcow_decrypt(QCryptoBlock *block,
-                           uint64_t startsector,
+                           uint64_t offset,
                            uint8_t *buf,
                            size_t len,
                            Error **errp)
 {
+    assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     return qcrypto_block_decrypt_helper(block->cipher,
                                         block->niv, block->ivgen,
                                         QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                        startsector, buf, len, errp);
+                                        offset, buf, len, errp);
 }
 
 
 static int
 qcrypto_block_qcow_encrypt(QCryptoBlock *block,
-                           uint64_t startsector,
+                           uint64_t offset,
                            uint8_t *buf,
                            size_t len,
                            Error **errp)
 {
+    assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     return qcrypto_block_encrypt_helper(block->cipher,
                                         block->niv, block->ivgen,
                                         QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                        startsector, buf, len, errp);
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block.c b/crypto/block.c
index a7a9ad240e..f206d5eea8 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -127,22 +127,22 @@ QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
 
 
 int qcrypto_block_decrypt(QCryptoBlock *block,
-                          uint64_t startsector,
+                          uint64_t offset,
                           uint8_t *buf,
                           size_t len,
                           Error **errp)
 {
-    return block->driver->decrypt(block, startsector, buf, len, errp);
+    return block->driver->decrypt(block, offset, buf, len, errp);
 }
 
 
 int qcrypto_block_encrypt(QCryptoBlock *block,
-                          uint64_t startsector,
+                          uint64_t offset,
                           uint8_t *buf,
                           size_t len,
                           Error **errp)
 {
-    return block->driver->encrypt(block, startsector, buf, len, errp);
+    return block->driver->encrypt(block, offset, buf, len, errp);
 }
 
 
@@ -194,13 +194,17 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
-                                 uint64_t startsector,
+                                 uint64_t offset,
                                  uint8_t *buf,
                                  size_t len,
                                  Error **errp)
 {
     uint8_t *iv;
     int ret = -1;
+    uint64_t startsector = offset / sectorsize;
+
+    assert(QEMU_IS_ALIGNED(offset, sectorsize));
+    assert(QEMU_IS_ALIGNED(len, sectorsize));
 
     iv = niv ? g_new0(uint8_t, niv) : NULL;
 
@@ -243,13 +247,17 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
-                                 uint64_t startsector,
+                                 uint64_t offset,
                                  uint8_t *buf,
                                  size_t len,
                                  Error **errp)
 {
     uint8_t *iv;
     int ret = -1;
+    uint64_t startsector = offset / sectorsize;
+
+    assert(QEMU_IS_ALIGNED(offset, sectorsize));
+    assert(QEMU_IS_ALIGNED(len, sectorsize));
 
     iv = niv ? g_new0(uint8_t, niv) : NULL;
 
-- 
2.13.6
