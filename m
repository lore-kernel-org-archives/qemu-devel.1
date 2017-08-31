Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNIF-0006qw-3B
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNID-0007vR-9s
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:05:50 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 12:05:18 +0100
Message-Id: <20170831110518.10741-5-berrange@redhat.com>
In-Reply-To: <20170831110518.10741-1-berrange@redhat.com>
References: <20170831110518.10741-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
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

Instead of sector offset, take the bytes offset when encrypting
or decrypting data.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c         |  8 ++++----
 block/qcow.c           |  7 +++++--
 block/qcow2-cluster.c  |  8 +++-----
 block/qcow2.c          |  4 ++--
 crypto/block-luks.c    | 12 ++++++++----
 crypto/block-qcow.c    | 12 ++++++++----
 crypto/block.c         | 14 ++++++++------
 crypto/blockpriv.h     |  4 ++--
 include/crypto/block.h | 14 ++++++++------
 9 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 40daa77188..6b8d88efbc 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -426,8 +426,8 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             goto cleanup;
         }
 
-        if (qcrypto_block_decrypt(crypto->block, sector_num, cipher_data,
-                                  cur_bytes, NULL) < 0) {
+        if (qcrypto_block_decrypt(crypto->block, offset + bytes_done,
+                                  cipher_data, cur_bytes, NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
@@ -484,8 +484,8 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 
         qemu_iovec_to_buf(qiov, bytes_done, cipher_data, cur_bytes);
 
-        if (qcrypto_block_encrypt(crypto->block, sector_num, cipher_data,
-                                  cur_bytes, NULL) < 0) {
+        if (qcrypto_block_encrypt(crypto->block, offset + bytes_done,
+                                  cipher_data, cur_bytes, NULL) < 0) {
             ret = -EIO;
             goto cleanup;
         }
diff --git a/block/qcow.c b/block/qcow.c
index c08cdc4a7b..c2a446e824 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -456,7 +456,9 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                         if (i < n_start || i >= n_end) {
                             Error *err = NULL;
                             memset(s->cluster_data, 0x00, 512);
-                            if (qcrypto_block_encrypt(s->crypto, start_sect + i,
+                            if (qcrypto_block_encrypt(s->crypto,
+                                                      start_sect + i *
+                                                      BDRV_SECTOR_SIZE,
                                                       s->cluster_data,
                                                       BDRV_SECTOR_SIZE,
                                                       &err) < 0) {
@@ -636,7 +638,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
             }
             if (bs->encrypted) {
                 assert(s->crypto);
-                if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
+                if (qcrypto_block_decrypt(s->crypto,
+                                          sector_num * BDRV_SECTOR_SIZE, buf,
                                           n * BDRV_SECTOR_SIZE, &err) < 0) {
                     goto fail;
                 }
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f06c08f64c..85ffc33c2c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -396,15 +396,13 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
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
index 40ba26c111..1c9f6c8f7d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1824,7 +1824,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 if (qcrypto_block_decrypt(s->crypto,
                                           (s->crypt_physical_offset ?
                                            cluster_offset + offset_in_cluster :
-                                           offset) >> BDRV_SECTOR_BITS,
+                                           offset),
                                           cluster_data,
                                           cur_bytes,
                                           &err) < 0) {
@@ -1961,7 +1961,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
             if (qcrypto_block_encrypt(s->crypto,
                                       (s->crypt_physical_offset ?
                                        cluster_offset + offset_in_cluster :
-                                       offset) >> BDRV_SECTOR_BITS,
+                                       offset),
                                       cluster_data,
                                       cur_bytes, &err) < 0) {
                 error_free(err);
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index afb8543108..672b0986e0 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1403,29 +1403,33 @@ static void qcrypto_block_luks_cleanup(QCryptoBlock *block)
 
 static int
 qcrypto_block_luks_decrypt(QCryptoBlock *block,
-                           uint64_t startsector,
+                           uint64_t offset,
                            uint8_t *buf,
                            size_t len,
                            Error **errp)
 {
+    assert(!(offset % QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
+    assert(!(len % QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
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
+    assert(!(offset % QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
+    assert(!(len % QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     return qcrypto_block_encrypt_helper(block->cipher,
                                         block->niv, block->ivgen,
                                         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                        startsector, buf, len, errp);
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index a456fe338b..9d2efa27d6 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -142,29 +142,33 @@ qcrypto_block_qcow_cleanup(QCryptoBlock *block)
 
 static int
 qcrypto_block_qcow_decrypt(QCryptoBlock *block,
-                           uint64_t startsector,
+                           uint64_t offset,
                            uint8_t *buf,
                            size_t len,
                            Error **errp)
 {
+    assert(!(offset % QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
+    assert(!(len % QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
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
+    assert(!(offset % QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
+    assert(!(len % QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     return qcrypto_block_encrypt_helper(block->cipher,
                                         block->niv, block->ivgen,
                                         QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                        startsector, buf, len, errp);
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block.c b/crypto/block.c
index b097d451af..84ef5d870a 100644
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
 
 
@@ -188,13 +188,14 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
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
 
     iv = niv ? g_new0(uint8_t, niv) : NULL;
 
@@ -237,13 +238,14 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
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
 
     iv = niv ? g_new0(uint8_t, niv) : NULL;
 
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 0edb810e22..53e66e58fb 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -81,7 +81,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
-                                 uint64_t startsector,
+                                 uint64_t offset,
                                  uint8_t *buf,
                                  size_t len,
                                  Error **errp);
@@ -90,7 +90,7 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
-                                 uint64_t startsector,
+                                 uint64_t offset,
                                  uint8_t *buf,
                                  size_t len,
                                  Error **errp);
diff --git a/include/crypto/block.h b/include/crypto/block.h
index f0e543bee1..2dea165a8a 100644
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
-- 
2.13.5
