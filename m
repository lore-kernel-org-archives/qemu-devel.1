Received: from eggs.gnu.org ([2001:4830:134:3::10]:40006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhE-0006T8-Ol
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhD-0002k6-Gv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPhC-0002jZ-T2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:25:03 +0100
Message-Id: <20170718102519.15392-3-berrange@redhat.com>
In-Reply-To: <20170718102519.15392-1-berrange@redhat.com>
References: <20170718102519.15392-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 02/18] crypto: cipher: introduce
 qcrypto_cipher_ctx_new for gcrypt-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Longpeng(Mike)" <longpeng2@huawei.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
gcrypt-backend impls.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/cipher-gcrypt.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 0ecffa2751..493938629e 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -80,12 +80,12 @@ static void gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
 }
 
 
-QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-                                  QCryptoCipherMode mode,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp)
+static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                                   QCryptoCipherMode mode,
+                                                   const uint8_t *key,
+                                                   size_t nkey,
+                                                   Error **errp)
 {
-    QCryptoCipher *cipher;
     QCryptoCipherGcrypt *ctx;
     gcry_error_t err;
     int gcryalg, gcrymode;
@@ -162,10 +162,6 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         return NULL;
     }
 
-    cipher = g_new0(QCryptoCipher, 1);
-    cipher->alg = alg;
-    cipher->mode = mode;
-
     ctx = g_new0(QCryptoCipherGcrypt, 1);
 
     err = gcry_cipher_open(&ctx->handle, gcryalg, gcrymode, 0);
@@ -174,7 +170,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                    gcry_strerror(err));
         goto error;
     }
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
+    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
         err = gcry_cipher_open(&ctx->tweakhandle, gcryalg, gcrymode, 0);
         if (err != 0) {
             error_setg(errp, "Cannot initialize cipher: %s",
@@ -183,7 +179,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         }
     }
 
-    if (cipher->alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
+    if (alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
         /* We're using standard DES cipher from gcrypt, so we need
          * to munge the key so that the results are the same as the
          * bizarre RFB variant of DES :-)
@@ -193,7 +189,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         g_free(rfbkey);
         ctx->blocksize = 8;
     } else {
-        if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
+        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
             nkey /= 2;
             err = gcry_cipher_setkey(ctx->handle, key, nkey);
             if (err != 0) {
@@ -210,7 +206,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                        gcry_strerror(err));
             goto error;
         }
-        switch (cipher->alg) {
+        switch (alg) {
         case QCRYPTO_CIPHER_ALG_AES_128:
         case QCRYPTO_CIPHER_ALG_AES_192:
         case QCRYPTO_CIPHER_ALG_AES_256:
@@ -230,7 +226,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         }
     }
 
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
+    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
         if (ctx->blocksize != XTS_BLOCK_SIZE) {
             error_setg(errp,
                        "Cipher block size %zu must equal XTS block size %d",
@@ -240,12 +236,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         ctx->iv = g_new0(uint8_t, ctx->blocksize);
     }
 
-    cipher->opaque = ctx;
-    return cipher;
+    return ctx;
 
  error:
     gcrypt_cipher_free_ctx(ctx, mode);
-    g_free(cipher);
     return NULL;
 }
 
@@ -385,3 +379,25 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 
     return 0;
 }
+
+
+QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
+                                  QCryptoCipherMode mode,
+                                  const uint8_t *key, size_t nkey,
+                                  Error **errp)
+{
+    QCryptoCipher *cipher;
+    QCryptoCipherGcrypt *ctx;
+
+    ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
+    if (!ctx) {
+        return NULL;
+    }
+
+    cipher = g_new0(QCryptoCipher, 1);
+    cipher->alg = alg;
+    cipher->mode = mode;
+    cipher->opaque = ctx;
+
+    return cipher;
+}
-- 
2.13.0
