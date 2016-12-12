Received: from eggs.gnu.org ([2001:4830:134:3::10]:52949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGL1f-0007Gg-J1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGL1b-0006A4-Kc
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:27:55 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:30147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGL1b-00065p-1n
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:27:51 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 12 Dec 2016 15:27:17 +0800
Message-ID: <1481527639-17520-6-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481527639-17520-1-git-send-email-longpeng2@huawei.com>
References: <1481527639-17520-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v1 5/7] crypto: support HMAC algorithms
 based on glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, armbru@redhat.com, berrange@redhat.com, stefanha@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add glibc-backed HMAC algorithms support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-glib.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 42f63c6..6a5f722 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -16,6 +16,123 @@
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
+};
+
+typedef struct QCryptoHmacGlib QCryptoHmacGlib;
+struct QCryptoHmacGlib {
+    GHmac *ghmac;
+};
+
+bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
+{
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg] != -1) {
+        return true;
+    }
+
+    return false;
+}
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHmacAlgorithm alg,
+                                  const uint8_t *key, size_t nkey,
+                                  Error **errp)
+{
+    QCryptoHmac *hmac;
+    QCryptoHmacGlib *ctx;
+
+    if (!qcrypto_hmac_supports(alg)) {
+        error_setg(errp, "Unsupported hmac algorithm %s",
+                    QCryptoHmacAlgorithm_lookup[alg]);
+        return NULL;
+    }
+
+    hmac = g_new0(QCryptoHmac, 1);
+    hmac->alg = alg;
+
+    ctx = g_new0(QCryptoHmacGlib, 1);
+
+    ctx->ghmac = g_hmac_new(qcrypto_hmac_alg_map[alg],
+                    (const uint8_t *)key, nkey);
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
+                    *resultlen, ret);
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
 bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
 {
     return false;
@@ -42,3 +159,5 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 {
     return -1;
 }
+
+#endif
-- 
1.8.3.1
