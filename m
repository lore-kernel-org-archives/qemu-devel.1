Received: from eggs.gnu.org ([2001:4830:134:3::10]:35652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyw2-0001Cn-2A
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvx-0007p5-5u
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:02 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyvx-0007oV-01
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:57 -0400
Received: by mail-pg0-x243.google.com with SMTP id j186so10399622pge.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:38:56 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:32 -0400
Message-Id: <1500032321-13951-11-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v5 10/18] crypto: hmac: introduce
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
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
glib-backend impls.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-glib.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 08a1fdd..f0ccfd6 100644
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
+
 #else
 
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
-- 
1.8.3.1
