Received: from eggs.gnu.org ([2001:4830:134:3::10]:52010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eC27E-0003Wn-P5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eC27B-00063G-HG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:32:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eC27A-00060x-SX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:32:21 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 7 Nov 2017 19:32:06 +0800
Message-ID: <1510054326-31036-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, pbonzini@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, Longpeng <longpeng2@huawei.com>

From: Longpeng <longpeng2@huawei.com>

Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
errp=NULL, this will cause a NULL pointer deference if afalg_driver
doesn't support requested algos:

    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
                                                result, resultlen,
                                                errp);
    if (ret == 0) {
        return ret;
    }

    error_free(*errp);  // <--- here

Because the error message is threw away immediately, so we should
just pass NULL to hash_bytesv(). There is also the same problem in
afalg-backend cipher & hmac, let's fix them together.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Longpeng <longpeng2@huawei.com>
---
v2->v1:
 - fix typo [Eric]
 - just pass NULL to hash_bytesv() [Eric, Daniel]
 - remove useless Error object in afalg-backend
   cipher & hmac [Longpeng]

---
 crypto/cipher.c | 5 +----
 crypto/hash.c   | 8 +-------
 crypto/hmac.c   | 4 +---
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 0aad9d6..bcbfb3d 100644
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
index ac59c63..aeeec97 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -51,16 +51,10 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
 
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
index 82b0055..f6c2d8d 100644
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
1.8.3.1
