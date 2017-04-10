Received: from eggs.gnu.org ([2001:4830:134:3::10]:54325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBp-0008JL-EI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBk-00023k-C7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3357
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBj-00020e-KR
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:44 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:00:26 +0800
Message-ID: <1491814826-61448-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 10/19] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for glib-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
glib-backend impls.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-glib.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 08a1fdd..d9f88d8 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -49,11 +49,11 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
+static QCryptoHmacGlib *
+qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                     const uint8_t *key, size_t nkey,
+                     Error **errp)
 {
-    QCryptoHmac *hmac;
     QCryptoHmacGlib *ctx;
 
     if (!qcrypto_hmac_supports(alg)) {
@@ -62,9 +62,6 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
         return NULL;
     }
 
-    hmac = g_new0(QCryptoHmac, 1);
-    hmac->alg = alg;
-
     ctx = g_new0(QCryptoHmacGlib, 1);
 
     ctx->ghmac = g_hmac_new(qcrypto_hmac_alg_map[alg],
@@ -74,12 +71,10 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
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
 
@@ -134,6 +129,25 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
     return 0;
 }
 
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    QCryptoHmac *hmac;
+    QCryptoHmacGlib *ctx;
+
+    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
+    if (ctx == NULL) {
+        return NULL;
+    }
+
+    hmac = g_new0(QCryptoHmac, 1);
+    hmac->alg = alg;
+    hmac->opaque = ctx;
+
+    return hmac;
+}
+
 #else
 
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
-- 
1.8.3.1
