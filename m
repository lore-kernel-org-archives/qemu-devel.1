Received: from eggs.gnu.org ([2001:4830:134:3::10]:46885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJec-0005B5-1m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJeY-0005bv-QF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJeY-0005ah-FD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:50 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 4 Jul 2017 16:57:01 +0800
Message-ID: <1499158630-75260-10-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 09/18] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for nettle-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
nettle-backend impls.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-nettle.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 4a9e6b2..000dfd9 100644
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
1.8.3.1
