Received: from eggs.gnu.org ([2001:4830:134:3::10]:53787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJhzx-0004mp-3L
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJhzw-0006ho-5o
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cJhzv-0006hQ-Ti
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:04 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 21 Dec 2016 14:35:39 +0000
Message-Id: <20161221143541.9260-6-berrange@redhat.com>
In-Reply-To: <20161221143541.9260-1-berrange@redhat.com>
References: <20161221143541.9260-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 5/7] crypto: support HMAC algorithms based on
 glib
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

This patch add glib-backed HMAC algorithms support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/hmac-glib.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 3e2a933..08a1fdd 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -16,6 +16,126 @@
 #include "qapi/error.h"
 #include "crypto/hmac.h"
 
+/* Support for HMAC Algos has been added in GLib 2.30 */
+#if GLIB_CHECK_VERSION(2, 30, 0)
+
+static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
+    [QCRYPTO_HASH_ALG_MD5] = G_CHECKSUM_MD5,
+    [QCRYPTO_HASH_ALG_SHA1] = G_CHECKSUM_SHA1,
+    [QCRYPTO_HASH_ALG_SHA256] = G_CHECKSUM_SHA256,
+/* Support for HMAC SHA-512 in GLib 2.42 */
+#if GLIB_CHECK_VERSION(2, 42, 0)
+    [QCRYPTO_HASH_ALG_SHA512] = G_CHECKSUM_SHA512,
+#else
+    [QCRYPTO_HASH_ALG_SHA512] = -1,
+#endif
+    [QCRYPTO_HASH_ALG_SHA224] = -1,
+    [QCRYPTO_HASH_ALG_SHA384] = -1,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = -1,
+};
+
+typedef struct QCryptoHmacGlib QCryptoHmacGlib;
+struct QCryptoHmacGlib {
+    GHmac *ghmac;
+};
+
+bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
+{
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg] != -1) {
+        return true;
+    }
+
+    return false;
+}
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    QCryptoHmac *hmac;
+    QCryptoHmacGlib *ctx;
+
+    if (!qcrypto_hmac_supports(alg)) {
+        error_setg(errp, "Unsupported hmac algorithm %s",
+                   QCryptoHashAlgorithm_lookup[alg]);
+        return NULL;
+    }
+
+    hmac = g_new0(QCryptoHmac, 1);
+    hmac->alg = alg;
+
+    ctx = g_new0(QCryptoHmacGlib, 1);
+
+    ctx->ghmac = g_hmac_new(qcrypto_hmac_alg_map[alg],
+                            (const uint8_t *)key, nkey);
+    if (!ctx->ghmac) {
+        error_setg(errp, "Cannot initialize hmac and set key");
+        goto error;
+    }
+
+    hmac->opaque = ctx;
+    return hmac;
+
+error:
+    g_free(ctx);
+    g_free(hmac);
+    return NULL;
+}
+
+void qcrypto_hmac_free(QCryptoHmac *hmac)
+{
+    QCryptoHmacGlib *ctx;
+
+    if (!hmac) {
+        return;
+    }
+
+    ctx = hmac->opaque;
+    g_hmac_unref(ctx->ghmac);
+
+    g_free(ctx);
+    g_free(hmac);
+}
+
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    QCryptoHmacGlib *ctx;
+    int i, ret;
+
+    ctx = hmac->opaque;
+
+    for (i = 0; i < niov; i++) {
+        g_hmac_update(ctx->ghmac, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    ret = g_checksum_type_get_length(qcrypto_hmac_alg_map[hmac->alg]);
+    if (ret < 0) {
+        error_setg(errp, "Unable to get hmac length");
+        return -1;
+    }
+
+    if (*resultlen == 0) {
+        *resultlen = ret;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != ret) {
+        error_setg(errp, "Result buffer size %zu is smaller than hmac %d",
+                   *resultlen, ret);
+        return -1;
+    }
+
+    g_hmac_get_digest(ctx->ghmac, *result, resultlen);
+
+    return 0;
+}
+
+#else
+
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
 {
     return false;
@@ -42,3 +162,5 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 {
     return -1;
 }
+
+#endif
-- 
2.9.3
