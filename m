Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQX3-0006Qh-OG
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQWz-00029D-I9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCQWz-00028p-95
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:36:37 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  8 Nov 2017 13:36:12 +0000
Message-Id: <20171108133612.16471-3-berrange@redhat.com>
In-Reply-To: <20171108133612.16471-1-berrange@redhat.com>
References: <20171108133612.16471-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/2] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Longpeng <longpeng2@huawei.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Longpeng <longpeng2@huawei.com>

Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
errp=NULL, this will cause a NULL pointer dereference if afalg_driver
doesn't support requested algos:

    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
                                                result, resultlen,
                                                errp);
    if (ret == 0) {
        return ret;
    }

    error_free(*errp);  // <--- here

Because the error message is thrown away immediately, we should
just pass NULL to hash_bytesv(). There is also the same problem in
afalg-backend cipher & hmac, let's fix them together.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Longpeng <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/cipher.c |  5 +----
 crypto/hash.c   | 13 +++++--------
 crypto/hmac.c   |  4 +---
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 0aad9d6d79..bcbfb3d5b8 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -164,11 +164,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
 {
     QCryptoCipher *cipher;
     void *ctx = NULL;
-    Error *err2 = NULL;
     QCryptoCipherDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
-    ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, &err2);
+    ctx = qcrypto_afalg_cipher_ctx_new(alg, mode, key, nkey, NULL);
     if (ctx) {
         drv = &qcrypto_cipher_afalg_driver;
     }
@@ -177,12 +176,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
     if (!ctx) {
         ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
         if (!ctx) {
-            error_free(err2);
             return NULL;
         }
 
         drv = &qcrypto_cipher_lib_driver;
-        error_free(err2);
     }
 
     cipher = g_new0(QCryptoCipher, 1);
diff --git a/crypto/hash.c b/crypto/hash.c
index ac59c63d5f..8dab25d9ea 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -48,19 +48,16 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
 {
 #ifdef CONFIG_AF_ALG
     int ret;
-
+    /*
+     * TODO:
+     * Maybe we should treat some afalg errors as fatal
+     */
     ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
                                                 result, resultlen,
-                                                errp);
+                                                NULL);
     if (ret == 0) {
         return ret;
     }
-
-    /*
-     * TODO:
-     * Maybe we should treat some afalg errors as fatal
-     */
-    error_free(*errp);
 #endif
 
     return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 82b0055adf..f6c2d8db60 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -90,11 +90,10 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
 {
     QCryptoHmac *hmac;
     void *ctx = NULL;
-    Error *err2 = NULL;
     QCryptoHmacDriver *drv = NULL;
 
 #ifdef CONFIG_AF_ALG
-    ctx = qcrypto_afalg_hmac_ctx_new(alg, key, nkey, &err2);
+    ctx = qcrypto_afalg_hmac_ctx_new(alg, key, nkey, NULL);
     if (ctx) {
         drv = &qcrypto_hmac_afalg_driver;
     }
@@ -107,7 +106,6 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
         }
 
         drv = &qcrypto_hmac_lib_driver;
-        error_free(err2);
     }
 
     hmac = g_new0(QCryptoHmac, 1);
-- 
2.13.6
