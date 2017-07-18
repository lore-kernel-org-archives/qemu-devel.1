Received: from eggs.gnu.org ([2001:4830:134:3::10]:40131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhP-0006cM-Tf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhO-0002rr-QK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPhO-0002rd-KK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:50 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:25:09 +0100
Message-Id: <20170718102519.15392-9-berrange@redhat.com>
In-Reply-To: <20170718102519.15392-1-berrange@redhat.com>
References: <20170718102519.15392-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 08/18] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for gcrypt-backend
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

1) Fix a handle-leak problem in qcrypto_hmac_new(), didn't free
   ctx->handle if gcry_mac_setkey fails.

2) Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
   gcrypt-backend impls.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/hmac-gcrypt.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 21189e694f..372ad7fc20 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -42,11 +42,11 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
+static QCryptoHmacGcrypt *
+qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                     const uint8_t *key, size_t nkey,
+                     Error **errp)
 {
-    QCryptoHmac *hmac;
     QCryptoHmacGcrypt *ctx;
     gcry_error_t err;
 
@@ -56,9 +56,6 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
         return NULL;
     }
 
-    hmac = g_new0(QCryptoHmac, 1);
-    hmac->alg = alg;
-
     ctx = g_new0(QCryptoHmacGcrypt, 1);
 
     err = gcry_mac_open(&ctx->handle, qcrypto_hmac_alg_map[alg],
@@ -73,15 +70,14 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
     if (err != 0) {
         error_setg(errp, "Cannot set key: %s",
                    gcry_strerror(err));
+        gcry_mac_close(ctx->handle);
         goto error;
     }
 
-    hmac->opaque = ctx;
-    return hmac;
+    return ctx;
 
 error:
     g_free(ctx);
-    g_free(hmac);
     return NULL;
 }
 
@@ -150,3 +146,22 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 
     return 0;
 }
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    QCryptoHmac *hmac;
+    QCryptoHmacGcrypt *ctx;
+
+    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
+    if (!ctx) {
+        return NULL;
+    }
+
+    hmac = g_new0(QCryptoHmac, 1);
+    hmac->alg = alg;
+    hmac->opaque = ctx;
+
+    return hmac;
+}
-- 
2.13.0
