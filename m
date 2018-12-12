Received: from eggs.gnu.org ([2001:4830:134:3::10]:37578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2e1-0003G9-LF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2dz-0004ew-2A
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:37 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 12 Dec 2018 11:24:48 +0000
Message-Id: <20181212112450.2103-5-berrange@redhat.com>
In-Reply-To: <20181212112450.2103-1-berrange@redhat.com>
References: <20181212112450.2103-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/6] crypto/block: rename
 qcrypto_block_*crypt_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename qcrypto_block_*crypt_helper to qcrypto_block_cipher_*crypt_helper,
as it's not about QCryptoBlock. This is needed to introduce
qcrypto_block_*crypt_helper in the next commit, which will have
QCryptoBlock pointer and than will be able to use additional fields of
it, which in turn will be used to implement thread-safe QCryptoBlock
operations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block-luks.c | 44 ++++++++++++++--------------
 crypto/block-qcow.c | 16 +++++------
 crypto/block.c      | 70 +++++++++++++++++++++++----------------------
 crypto/blockpriv.h  | 34 +++++++++++-----------
 4 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 51e24d23ca..353a400595 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -504,14 +504,14 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
      * to reset the encryption cipher every time the master
      * key crosses a sector boundary.
      */
-    if (qcrypto_block_decrypt_helper(cipher,
-                                     niv,
-                                     ivgen,
-                                     QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                     0,
-                                     splitkey,
-                                     splitkeylen,
-                                     errp) < 0) {
+    if (qcrypto_block_cipher_decrypt_helper(cipher,
+                                            niv,
+                                            ivgen,
+                                            QCRYPTO_BLOCK_LUKS_SECTOR_SI=
ZE,
+                                            0,
+                                            splitkey,
+                                            splitkeylen,
+                                            errp) < 0) {
         goto cleanup;
     }
=20
@@ -1219,12 +1219,12 @@ qcrypto_block_luks_create(QCryptoBlock *block,
=20
     /* Now we encrypt the split master key with the key generated
      * from the user's password, before storing it */
-    if (qcrypto_block_encrypt_helper(cipher, block->niv, ivgen,
-                                     QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                     0,
-                                     splitkey,
-                                     splitkeylen,
-                                     errp) < 0) {
+    if (qcrypto_block_cipher_encrypt_helper(cipher, block->niv, ivgen,
+                                            QCRYPTO_BLOCK_LUKS_SECTOR_SI=
ZE,
+                                            0,
+                                            splitkey,
+                                            splitkeylen,
+                                            errp) < 0) {
         goto error;
     }
=20
@@ -1409,10 +1409,10 @@ qcrypto_block_luks_decrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
-    return qcrypto_block_decrypt_helper(block->cipher,
-                                        block->niv, block->ivgen,
-                                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                        offset, buf, len, errp);
+    return qcrypto_block_cipher_decrypt_helper(block->cipher,
+                                               block->niv, block->ivgen,
+                                               QCRYPTO_BLOCK_LUKS_SECTOR=
_SIZE,
+                                               offset, buf, len, errp);
 }
=20
=20
@@ -1425,10 +1425,10 @@ qcrypto_block_luks_encrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE));
-    return qcrypto_block_encrypt_helper(block->cipher,
-                                        block->niv, block->ivgen,
-                                        QCRYPTO_BLOCK_LUKS_SECTOR_SIZE,
-                                        offset, buf, len, errp);
+    return qcrypto_block_cipher_encrypt_helper(block->cipher,
+                                               block->niv, block->ivgen,
+                                               QCRYPTO_BLOCK_LUKS_SECTOR=
_SIZE,
+                                               offset, buf, len, errp);
 }
=20
=20
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 7606231e79..3b6722deb0 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -152,10 +152,10 @@ qcrypto_block_qcow_decrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
-    return qcrypto_block_decrypt_helper(block->cipher,
-                                        block->niv, block->ivgen,
-                                        QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                        offset, buf, len, errp);
+    return qcrypto_block_cipher_decrypt_helper(block->cipher,
+                                               block->niv, block->ivgen,
+                                               QCRYPTO_BLOCK_QCOW_SECTOR=
_SIZE,
+                                               offset, buf, len, errp);
 }
=20
=20
@@ -168,10 +168,10 @@ qcrypto_block_qcow_encrypt(QCryptoBlock *block,
 {
     assert(QEMU_IS_ALIGNED(offset, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(len, QCRYPTO_BLOCK_QCOW_SECTOR_SIZE));
-    return qcrypto_block_encrypt_helper(block->cipher,
-                                        block->niv, block->ivgen,
-                                        QCRYPTO_BLOCK_QCOW_SECTOR_SIZE,
-                                        offset, buf, len, errp);
+    return qcrypto_block_cipher_encrypt_helper(block->cipher,
+                                               block->niv, block->ivgen,
+                                               QCRYPTO_BLOCK_QCOW_SECTOR=
_SIZE,
+                                               offset, buf, len, errp);
 }
=20
=20
diff --git a/crypto/block.c b/crypto/block.c
index 8d0e4bdbb2..d43139dbc7 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -191,20 +191,20 @@ void qcrypto_block_free(QCryptoBlock *block)
=20
=20
 typedef int (*QCryptoCipherEncDecFunc)(QCryptoCipher *cipher,
-                                       const void *in,
-                                       void *out,
-                                       size_t len,
-                                       Error **errp);
-
-static int do_qcrypto_block_encdec(QCryptoCipher *cipher,
-                                   size_t niv,
-                                   QCryptoIVGen *ivgen,
-                                   int sectorsize,
-                                   uint64_t offset,
-                                   uint8_t *buf,
-                                   size_t len,
-                                   QCryptoCipherEncDecFunc func,
-                                   Error **errp)
+                                        const void *in,
+                                        void *out,
+                                        size_t len,
+                                        Error **errp);
+
+static int do_qcrypto_block_cipher_encdec(QCryptoCipher *cipher,
+                                          size_t niv,
+                                          QCryptoIVGen *ivgen,
+                                          int sectorsize,
+                                          uint64_t offset,
+                                          uint8_t *buf,
+                                          size_t len,
+                                          QCryptoCipherEncDecFunc func,
+                                          Error **errp)
 {
     uint8_t *iv;
     int ret =3D -1;
@@ -249,29 +249,31 @@ static int do_qcrypto_block_encdec(QCryptoCipher *c=
ipher,
 }
=20
=20
-int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
-                                 size_t niv,
-                                 QCryptoIVGen *ivgen,
-                                 int sectorsize,
-                                 uint64_t offset,
-                                 uint8_t *buf,
-                                 size_t len,
-                                 Error **errp)
+int qcrypto_block_cipher_decrypt_helper(QCryptoCipher *cipher,
+                                        size_t niv,
+                                        QCryptoIVGen *ivgen,
+                                        int sectorsize,
+                                        uint64_t offset,
+                                        uint8_t *buf,
+                                        size_t len,
+                                        Error **errp)
 {
-    return do_qcrypto_block_encdec(cipher, niv, ivgen, sectorsize, offse=
t,
-                                   buf, len, qcrypto_cipher_decrypt, err=
p);
+    return do_qcrypto_block_cipher_encdec(cipher, niv, ivgen, sectorsize=
,
+                                          offset, buf, len,
+                                          qcrypto_cipher_decrypt, errp);
 }
=20
=20
-int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
-                                 size_t niv,
-                                 QCryptoIVGen *ivgen,
-                                 int sectorsize,
-                                 uint64_t offset,
-                                 uint8_t *buf,
-                                 size_t len,
-                                 Error **errp)
+int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,
+                                        size_t niv,
+                                        QCryptoIVGen *ivgen,
+                                        int sectorsize,
+                                        uint64_t offset,
+                                        uint8_t *buf,
+                                        size_t len,
+                                        Error **errp)
 {
-    return do_qcrypto_block_encdec(cipher, niv, ivgen, sectorsize, offse=
t,
-                                   buf, len, qcrypto_cipher_encrypt, err=
p);
+    return do_qcrypto_block_cipher_encdec(cipher, niv, ivgen, sectorsize=
,
+                                          offset, buf, len,
+                                          qcrypto_cipher_encrypt, errp);
 }
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 41840abcec..54bbe1eb6a 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -78,22 +78,22 @@ struct QCryptoBlockDriver {
 };
=20
=20
-int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
-                                 size_t niv,
-                                 QCryptoIVGen *ivgen,
-                                 int sectorsize,
-                                 uint64_t offset,
-                                 uint8_t *buf,
-                                 size_t len,
-                                 Error **errp);
-
-int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
-                                 size_t niv,
-                                 QCryptoIVGen *ivgen,
-                                 int sectorsize,
-                                 uint64_t offset,
-                                 uint8_t *buf,
-                                 size_t len,
-                                 Error **errp);
+int qcrypto_block_cipher_decrypt_helper(QCryptoCipher *cipher,
+                                        size_t niv,
+                                        QCryptoIVGen *ivgen,
+                                        int sectorsize,
+                                        uint64_t offset,
+                                        uint8_t *buf,
+                                        size_t len,
+                                        Error **errp);
+
+int qcrypto_block_cipher_encrypt_helper(QCryptoCipher *cipher,
+                                        size_t niv,
+                                        QCryptoIVGen *ivgen,
+                                        int sectorsize,
+                                        uint64_t offset,
+                                        uint8_t *buf,
+                                        size_t len,
+                                        Error **errp);
=20
 #endif /* QCRYPTO_BLOCKPRIV_H */
--=20
2.19.2
