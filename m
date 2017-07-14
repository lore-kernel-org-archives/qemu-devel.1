Received: from eggs.gnu.org ([2001:4830:134:3::10]:35508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvr-0000uM-Sa
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvn-0007hx-Kh
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:51 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyvn-0007hL-Cn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:47 -0400
Received: by mail-pg0-x241.google.com with SMTP id j186so10399248pge.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:38:47 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:24 -0400
Message-Id: <1500032321-13951-3-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v5 02/18] crypto: cipher: introduce
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
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
gcrypt-backend impls.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-gcrypt.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 0ecffa2..4939386 100644
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
1.8.3.1
