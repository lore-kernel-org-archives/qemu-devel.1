Received: from eggs.gnu.org ([2001:4830:134:3::10]:41788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlO-0006rb-Sh
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gVIlK-0002bU-Lg
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:14:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Dec 2018 19:13:48 +0300
Message-Id: <20181207161351.4380-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181207161351.4380-1-vsementsov@virtuozzo.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/5] crypto/block: refactor
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

qcrypto_block_encrypt_helper and qcrypto_block_decrypt_helper are
almost identical, let's reduce code duplication and simplify further
improvements.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 crypto/block.c | 81 +++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 50 deletions(-)

diff --git a/crypto/block.c b/crypto/block.c
index e59d1140fe..8d0e4bdbb2 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -190,14 +190,21 @@ void qcrypto_block_free(QCryptoBlock *block)
 }
 
 
-int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
-                                 size_t niv,
-                                 QCryptoIVGen *ivgen,
-                                 int sectorsize,
-                                 uint64_t offset,
-                                 uint8_t *buf,
-                                 size_t len,
-                                 Error **errp)
+typedef int (*QCryptoCipherEncDecFunc)(QCryptoCipher *cipher,
+                                       const void *in,
+                                       void *out,
+                                       size_t len,
+                                       Error **errp);
+
+static int do_qcrypto_block_encdec(QCryptoCipher *cipher,
+                                   size_t niv,
+                                   QCryptoIVGen *ivgen,
+                                   int sectorsize,
+                                   uint64_t offset,
+                                   uint8_t *buf,
+                                   size_t len,
+                                   QCryptoCipherEncDecFunc func,
+                                   Error **errp)
 {
     uint8_t *iv;
     int ret = -1;
@@ -226,8 +233,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
         }
 
         nbytes = len > sectorsize ? sectorsize : len;
-        if (qcrypto_cipher_decrypt(cipher, buf, buf,
-                                   nbytes, errp) < 0) {
+        if (func(cipher, buf, buf, nbytes, errp) < 0) {
             goto cleanup;
         }
 
@@ -243,7 +249,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
+int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
@@ -252,45 +258,20 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
                                  size_t len,
                                  Error **errp)
 {
-    uint8_t *iv;
-    int ret = -1;
-    uint64_t startsector = offset / sectorsize;
-
-    assert(QEMU_IS_ALIGNED(offset, sectorsize));
-    assert(QEMU_IS_ALIGNED(len, sectorsize));
-
-    iv = niv ? g_new0(uint8_t, niv) : NULL;
-
-    while (len > 0) {
-        size_t nbytes;
-        if (niv) {
-            if (qcrypto_ivgen_calculate(ivgen,
-                                        startsector,
-                                        iv, niv,
-                                        errp) < 0) {
-                goto cleanup;
-            }
+    return do_qcrypto_block_encdec(cipher, niv, ivgen, sectorsize, offset,
+                                   buf, len, qcrypto_cipher_decrypt, errp);
+}
 
-            if (qcrypto_cipher_setiv(cipher,
-                                     iv, niv,
-                                     errp) < 0) {
-                goto cleanup;
-            }
-        }
 
-        nbytes = len > sectorsize ? sectorsize : len;
-        if (qcrypto_cipher_encrypt(cipher, buf, buf,
-                                   nbytes, errp) < 0) {
-            goto cleanup;
-        }
-
-        startsector++;
-        buf += nbytes;
-        len -= nbytes;
-    }
-
-    ret = 0;
- cleanup:
-    g_free(iv);
-    return ret;
+int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
+                                 size_t niv,
+                                 QCryptoIVGen *ivgen,
+                                 int sectorsize,
+                                 uint64_t offset,
+                                 uint8_t *buf,
+                                 size_t len,
+                                 Error **errp)
+{
+    return do_qcrypto_block_encdec(cipher, niv, ivgen, sectorsize, offset,
+                                   buf, len, qcrypto_cipher_encrypt, errp);
 }
-- 
2.18.0
