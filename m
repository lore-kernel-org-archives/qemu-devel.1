Received: from eggs.gnu.org ([2001:4830:134:3::10]:40155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhR-0006cj-JF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPhQ-0002sm-Ov
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPhQ-0002sF-HW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:25:52 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 18 Jul 2017 11:25:10 +0100
Message-Id: <20170718102519.15392-10-berrange@redhat.com>
In-Reply-To: <20170718102519.15392-1-berrange@redhat.com>
References: <20170718102519.15392-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 09/18] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for nettle-backend
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

Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
nettle-backend impls.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/hmac-nettle.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 4a9e6b2c7d..000dfd9d37 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -97,11 +97,11 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
+static QCryptoHmacNettle *
+qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                     const uint8_t *key, size_t nkey,
+                     Error **errp)
 {
-    QCryptoHmac *hmac;
     QCryptoHmacNettle *ctx;
 
     if (!qcrypto_hmac_supports(alg)) {
@@ -110,16 +110,11 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
         return NULL;
     }
 
-    hmac = g_new0(QCryptoHmac, 1);
-    hmac->alg = alg;
-
     ctx = g_new0(QCryptoHmacNettle, 1);
 
     qcrypto_hmac_alg_map[alg].setkey(&ctx->u, nkey, key);
 
-    hmac->opaque = ctx;
-
-    return hmac;
+    return ctx;
 }
 
 void qcrypto_hmac_free(QCryptoHmac *hmac)
@@ -173,3 +168,22 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 
     return 0;
 }
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    QCryptoHmac *hmac;
+    QCryptoHmacNettle *ctx;
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
