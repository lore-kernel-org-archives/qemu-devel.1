Received: from eggs.gnu.org ([2001:4830:134:3::10]:37404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2ds-00039F-G2
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2dq-0004U5-Aa
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:28 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 12 Dec 2018 11:24:47 +0000
Message-Id: <20181212112450.2103-4-berrange@redhat.com>
In-Reply-To: <20181212112450.2103-1-berrange@redhat.com>
References: <20181212112450.2103-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] crypto/block: refactor
 qcrypto_block_*crypt_helper functions
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

qcrypto_block_encrypt_helper and qcrypto_block_decrypt_helper are
almost identical, let's reduce code duplication and simplify further
improvements.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 crypto/block.c | 81 +++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 50 deletions(-)

diff --git a/crypto/block.c b/crypto/block.c
index e59d1140fe..8d0e4bdbb2 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -190,14 +190,21 @@ void qcrypto_block_free(QCryptoBlock *block)
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
     int ret =3D -1;
@@ -226,8 +233,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *ciphe=
r,
         }
=20
         nbytes =3D len > sectorsize ? sectorsize : len;
-        if (qcrypto_cipher_decrypt(cipher, buf, buf,
-                                   nbytes, errp) < 0) {
+        if (func(cipher, buf, buf, nbytes, errp) < 0) {
             goto cleanup;
         }
=20
@@ -243,7 +249,7 @@ int qcrypto_block_decrypt_helper(QCryptoCipher *ciphe=
r,
 }
=20
=20
-int qcrypto_block_encrypt_helper(QCryptoCipher *cipher,
+int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
                                  size_t niv,
                                  QCryptoIVGen *ivgen,
                                  int sectorsize,
@@ -252,45 +258,20 @@ int qcrypto_block_encrypt_helper(QCryptoCipher *cip=
her,
                                  size_t len,
                                  Error **errp)
 {
-    uint8_t *iv;
-    int ret =3D -1;
-    uint64_t startsector =3D offset / sectorsize;
-
-    assert(QEMU_IS_ALIGNED(offset, sectorsize));
-    assert(QEMU_IS_ALIGNED(len, sectorsize));
-
-    iv =3D niv ? g_new0(uint8_t, niv) : NULL;
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
+    return do_qcrypto_block_encdec(cipher, niv, ivgen, sectorsize, offse=
t,
+                                   buf, len, qcrypto_cipher_decrypt, err=
p);
+}
=20
-            if (qcrypto_cipher_setiv(cipher,
-                                     iv, niv,
-                                     errp) < 0) {
-                goto cleanup;
-            }
-        }
=20
-        nbytes =3D len > sectorsize ? sectorsize : len;
-        if (qcrypto_cipher_encrypt(cipher, buf, buf,
-                                   nbytes, errp) < 0) {
-            goto cleanup;
-        }
-
-        startsector++;
-        buf +=3D nbytes;
-        len -=3D nbytes;
-    }
-
-    ret =3D 0;
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
+    return do_qcrypto_block_encdec(cipher, niv, ivgen, sectorsize, offse=
t,
+                                   buf, len, qcrypto_cipher_encrypt, err=
p);
 }
--=20
2.19.2
