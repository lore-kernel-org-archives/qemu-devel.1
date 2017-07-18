Received: from eggs.gnu.org ([2001:4830:134:3::10]:40057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhI-0006Vn-DY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhH-0002nB-3h
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPhG-0002mO-Lh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:42 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:25:05 +0100
Message-Id: <20170718102519.15392-5-berrange@redhat.com>
In-Reply-To: <20170718102519.15392-1-berrange@redhat.com>
References: <20170718102519.15392-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 04/18] crypto: cipher: introduce
 qcrypto_cipher_ctx_new for builtin-backend
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
builtin-backend impls.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/cipher-builtin.c | 101 ++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index b4bc2b9ca6..4ecd15eb9e 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -235,23 +235,24 @@ static int qcrypto_cipher_setiv_aes(QCryptoCipher *cipher,
 
 
 
-static int qcrypto_cipher_init_aes(QCryptoCipher *cipher,
-                                   const uint8_t *key, size_t nkey,
-                                   Error **errp)
+static QCryptoCipherBuiltin *
+qcrypto_cipher_init_aes(QCryptoCipherMode mode,
+                        const uint8_t *key, size_t nkey,
+                        Error **errp)
 {
     QCryptoCipherBuiltin *ctxt;
 
-    if (cipher->mode != QCRYPTO_CIPHER_MODE_CBC &&
-        cipher->mode != QCRYPTO_CIPHER_MODE_ECB &&
-        cipher->mode != QCRYPTO_CIPHER_MODE_XTS) {
+    if (mode != QCRYPTO_CIPHER_MODE_CBC &&
+        mode != QCRYPTO_CIPHER_MODE_ECB &&
+        mode != QCRYPTO_CIPHER_MODE_XTS) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[cipher->mode]);
-        return -1;
+                   QCryptoCipherMode_lookup[mode]);
+        return NULL;
     }
 
     ctxt = g_new0(QCryptoCipherBuiltin, 1);
 
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
+    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
         if (AES_set_encrypt_key(key, nkey * 4, &ctxt->state.aes.key.enc) != 0) {
             error_setg(errp, "Failed to set encryption key");
             goto error;
@@ -291,13 +292,11 @@ static int qcrypto_cipher_init_aes(QCryptoCipher *cipher,
     ctxt->encrypt = qcrypto_cipher_encrypt_aes;
     ctxt->decrypt = qcrypto_cipher_decrypt_aes;
 
-    cipher->opaque = ctxt;
-
-    return 0;
+    return ctxt;
 
  error:
     g_free(ctxt);
-    return -1;
+    return NULL;
 }
 
 
@@ -370,16 +369,17 @@ static int qcrypto_cipher_setiv_des_rfb(QCryptoCipher *cipher,
 }
 
 
-static int qcrypto_cipher_init_des_rfb(QCryptoCipher *cipher,
-                                       const uint8_t *key, size_t nkey,
-                                       Error **errp)
+static QCryptoCipherBuiltin *
+qcrypto_cipher_init_des_rfb(QCryptoCipherMode mode,
+                            const uint8_t *key, size_t nkey,
+                            Error **errp)
 {
     QCryptoCipherBuiltin *ctxt;
 
-    if (cipher->mode != QCRYPTO_CIPHER_MODE_ECB) {
+    if (mode != QCRYPTO_CIPHER_MODE_ECB) {
         error_setg(errp, "Unsupported cipher mode %s",
-                   QCryptoCipherMode_lookup[cipher->mode]);
-        return -1;
+                   QCryptoCipherMode_lookup[mode]);
+        return NULL;
     }
 
     ctxt = g_new0(QCryptoCipherBuiltin, 1);
@@ -394,9 +394,7 @@ static int qcrypto_cipher_init_des_rfb(QCryptoCipher *cipher,
     ctxt->encrypt = qcrypto_cipher_encrypt_des_rfb;
     ctxt->decrypt = qcrypto_cipher_decrypt_des_rfb;
 
-    cipher->opaque = ctxt;
-
-    return 0;
+    return ctxt;
 }
 
 
@@ -426,12 +424,13 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 }
 
 
-QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-                                  QCryptoCipherMode mode,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp)
+static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                                    QCryptoCipherMode mode,
+                                                    const uint8_t *key,
+                                                    size_t nkey,
+                                                    Error **errp)
 {
-    QCryptoCipher *cipher;
+    QCryptoCipherBuiltin *ctxt;
 
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
@@ -444,39 +443,27 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         return NULL;
     }
 
-    cipher = g_new0(QCryptoCipher, 1);
-    cipher->alg = alg;
-    cipher->mode = mode;
-
     if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
-        goto error;
+        return NULL;
     }
 
-    switch (cipher->alg) {
+    switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
-        if (qcrypto_cipher_init_des_rfb(cipher, key, nkey, errp) < 0) {
-            goto error;
-        }
+        ctxt = qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
         break;
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
-        if (qcrypto_cipher_init_aes(cipher, key, nkey, errp) < 0) {
-            goto error;
-        }
+        ctxt = qcrypto_cipher_init_aes(mode, key, nkey, errp);
         break;
     default:
         error_setg(errp,
                    "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgorithm_lookup[cipher->alg]);
-        goto error;
+                   QCryptoCipherAlgorithm_lookup[alg]);
+        return NULL;
     }
 
-    return cipher;
-
- error:
-    g_free(cipher);
-    return NULL;
+    return ctxt;
 }
 
 void qcrypto_cipher_free(QCryptoCipher *cipher)
@@ -537,3 +524,25 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 
     return ctxt->setiv(cipher, iv, niv, errp);
 }
+
+
+QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
+                                  QCryptoCipherMode mode,
+                                  const uint8_t *key, size_t nkey,
+                                  Error **errp)
+{
+    QCryptoCipher *cipher;
+    QCryptoCipherBuiltin *ctxt;
+
+    ctxt = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
+    if (!ctxt) {
+        return NULL;
+    }
+
+    cipher = g_new0(QCryptoCipher, 1);
+    cipher->alg = alg;
+    cipher->mode = mode;
+    cipher->opaque = ctxt;
+
+    return cipher;
+}
-- 
2.13.0
