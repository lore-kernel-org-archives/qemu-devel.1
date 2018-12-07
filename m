Received: from eggs.gnu.org ([2001:4830:134:3::10]:41794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlO-0006rg-UE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlK-0002bl-Nl
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Dec 2018 19:13:50 +0300
Message-Id: <20181207161351.4380-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181207161351.4380-1-vsementsov@virtuozzo.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/5] crypto/block: introduce
 qcrypto_block_*crypt_helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Introduce QCryptoBlock-based functions and use them where possible.
This is needed to implement thread-safe encrypt/decrypt operations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/blockpriv.h  | 14 ++++++++++++++
 crypto/block-luks.c | 14 ++++++--------
 crypto/block-qcow.c | 14 ++++++--------
 crypto/block.c      | 28 ++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 54bbe1eb6a..438c08bec2 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -96,4 +96,18 @@ int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,
                                         size_t len,
                                         Error **errp);
 
+int qcrypto_block_decrypt_helper(QCryptoBlock *block,
+                                 int sectorsize,
+                                 uint64_t offset,
+                                 uint8_t *buf,
+                                 size_t len,
+                                 Error **errp);
+
+int qcrypto_block_encrypt_helper(QCryptoBlock *block,
+                                 int sectorsize,
+                                 uint64_t offset,
+                                 uint8_t *buf,
+                                 size_t len,
+                                 Error **errp);
+
 #endif /* QCRYPTO_BLOCKPRIV_H */
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 353a400595..e486e7ee94 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1409,10 +1409,9 @@ qcrypto_block_luks_decrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
-    return qcrypto_block_cipher_decrypt_helper(block->cipher,
-                                               block->niv, block->ivgen,
-                                               QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                               offset, buf, len, errp);
+    return qcrypto_block_decrypt_helper(block,
+                                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
@@ -1425,10 +1424,9 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
-    return qcrypto_block_cipher_encrypt_helper(block->cipher,
-                                               block->niv, block->ivgen,
-                                               QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                               offset, buf, len, errp);
+    return qcrypto_block_encrypt_helper(block,
+                                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 3b6722deb0..36bf5f09b7 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -152,10 +152,9 @@ qcrypto_block_qcow_decrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
-    return qcrypto_block_cipher_decrypt_helper(block->cipher,
-                                               block->niv, block->ivgen,
-                                               QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                               offset, buf, len, errp);
+    return qcrypto_block_decrypt_helper(block,
+                                        QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
@@ -168,10 +167,9 @@ qcrypto_block_qcow_encrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
-    return qcrypto_block_cipher_encrypt_helper(block->cipher,
-                                               block->niv, block->ivgen,
-                                               QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                               offset, buf, len, errp);
+    return qcrypto_block_encrypt_helper(block,
+                                        QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block.c b/crypto/block.c
index d43139dbc7..3fe3de2ef8 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -277,3 +277,31 @@ int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,
                                           offset, buf, len,
                                           qcrypto_cipher_encrypt, errp);
 }
+
+
+int qcrypto_block_decrypt_helper(QCryptoBlock *block,
+                                 int sectorsize,
+                                 uint64_t offset,
+                                 uint8_t *buf,
+                                 size_t len,
+                                 Error **errp)
+{
+    return do_qcrypto_block_cipher_encdec(block->cipher, block->niv,
+                                          block->ivgen,
+                                          sectorsize, offset, buf, len,
+                                          qcrypto_cipher_decrypt, errp);
+}
+
+
+int qcrypto_block_encrypt_helper(QCryptoBlock *block,
+                                 int sectorsize,
+                                 uint64_t offset,
+                                 uint8_t *buf,
+                                 size_t len,
+                                 Error **errp)
+{
+    return do_qcrypto_block_cipher_encdec(block->cipher, block->niv,
+                                          block->ivgen,
+                                          sectorsize, offset, buf, len,
+                                          qcrypto_cipher_encrypt, errp);
+}
-- 
2.18.0
