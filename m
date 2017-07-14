Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvv-0000xF-G4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvu-0007n9-OU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:55 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyvu-0007mm-JW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:54 -0400
Received: by mail-pf0-x243.google.com with SMTP id z6so10753935pfk.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:38:54 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:30 -0400
Message-Id: <1500032321-13951-9-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v5 08/18] crypto: hmac: introduce
 qcrypto_hmac_ctx_new for gcrypt-backend
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

1) Fix a handle-leak problem in qcrypto_hmac_new(), didn't free
   ctx->handle if gcry_mac_setkey fails.

2) Extracts qcrypto_hmac_ctx_new() from qcrypto_hmac_new() for
   gcrypt-backend impls.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-gcrypt.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 21189e6..372ad7f 100644
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
1.8.3.1
