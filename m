Received: from eggs.gnu.org ([2001:4830:134:3::10]:48130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM5-0003aH-Il
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM2-0003lP-BF
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3500
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM1-0003jY-OD
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:14 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Sat, 22 Apr 2017 15:20:11 +0800
Message-ID: <1492845627-4384-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 02/18] crypto: cipher: introduce
 qcrypto_cipher_ctx_new for gcrypt-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
gcrypt-backend impls.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-gcrypt.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 0ecffa2..871730b 100644
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
+    if (ctx == NULL) {
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
1.8.3.1
