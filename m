Received: from eggs.gnu.org ([2001:4830:134:3::10]:45033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSI-0000o6-Pv
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSG-0003nR-7x
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  5 Dec 2018 17:46:59 +0300
Message-Id: <20181205144700.26563-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181205144700.26563-1-vsementsov@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/5] crypto/block: introduce
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
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Introduce QCryptoBlock-based functions and use them where possible.
This is needed to implement thread-safe encrypt/decrypt operations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 crypto/blockpriv.h  | 14 ++++++++++++++
 crypto/block-luks.c | 14 ++++++--------
 crypto/block-qcow.c | 14 ++++++--------
 crypto/block.c      | 26 ++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 347a7c010a..e9fe3e5687 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -96,4 +96,18 @@ int qcrypto_cipher_encrypt_helper(QCryptoCipher *cipher,
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
index 72dd51051d..bbffd80fff 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1409,10 +1409,9 @@ qcrypto_block_luks_decrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
-    return qcrypto_cipher_decrypt_helper(block->cipher,
-                                         block->niv, block->ivgen,
-                                         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                         offset, buf, len, errp);
+    return qcrypto_block_decrypt_helper(block,
+                                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
@@ -1425,10 +1424,9 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
-    return qcrypto_cipher_encrypt_helper(block->cipher,
-                                         block->niv, block->ivgen,
-                                         QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                         offset, buf, len, errp);
+    return qcrypto_block_encrypt_helper(block,
+                                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 536ef4ee98..36bf5f09b7 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -152,10 +152,9 @@ qcrypto_block_qcow_decrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
-    return qcrypto_cipher_decrypt_helper(block->cipher,
-                                         block->niv, block->ivgen,
-                                         QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                         offset, buf, len, errp);
+    return qcrypto_block_decrypt_helper(block,
+                                        QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
@@ -168,10 +167,9 @@ qcrypto_block_qcow_encrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
-    return qcrypto_cipher_encrypt_helper(block->cipher,
-                                         block->niv, block->ivgen,
-                                         QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                         offset, buf, len, errp);
+    return qcrypto_block_encrypt_helper(block,
+                                        QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
+                                        offset, buf, len, errp);
 }
 
 
diff --git a/crypto/block.c b/crypto/block.c
index 540b27e581..3edd9ec251 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -275,3 +275,29 @@ int qcrypto_cipher_encrypt_helper(QCryptoCipher *cipher,
     return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize, offset,
                                      buf, len, qcrypto_cipher_encrypt, errp);
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
+    return do_qcrypto_cipher_encrypt(block->cipher, block->niv, block->ivgen,
+                                     sectorsize, offset, buf, len,
+                                     qcrypto_cipher_decrypt, errp);
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
+    return do_qcrypto_cipher_encrypt(block->cipher, block->niv, block->ivgen,
+                                     sectorsize, offset, buf, len,
+                                     qcrypto_cipher_encrypt, errp);
+}
-- 
2.18.0
