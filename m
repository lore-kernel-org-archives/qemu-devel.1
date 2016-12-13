Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh7R-0007B3-Qu
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh7Q-0006M5-Kw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:03:21 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:46936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh7M-0006AJ-WC
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:03:20 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 13 Dec 2016 15:01:51 +0800
Message-ID: <1481612513-28556-5-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
References: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v3 4/6] crypto: support HMAC algorithms
 based on glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add glibc-backed HMAC algorithms support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-glib.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index 3e2a933..f07c841 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -16,8 +16,40 @@
 #include "qapi/error.h"
 #include "crypto/hmac.h"
 
+static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
+/* Support for HMAC Algos has been added in GLib 2.30 */
+#if GLIB_CHECK_VERSION(2, 30, 0)
+    [QCRYPTO_HASH_ALG_MD5] = G_CHECKSUM_MD5,
+    [QCRYPTO_HASH_ALG_SHA1] = G_CHECKSUM_SHA1,
+    [QCRYPTO_HASH_ALG_SHA256] = G_CHECKSUM_SHA256,
+#else
+    [QCRYPTO_HASH_ALG_MD5] = -1,
+    [QCRYPTO_HASH_ALG_SHA1] = -1,
+    [QCRYPTO_HASH_ALG_SHA256] = -1,
+#endif
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
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
 {
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg] != -1) {
+        return true;
+    }
+
     return false;
 }
 
@@ -25,12 +57,49 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
                               const uint8_t *key, size_t nkey,
                               Error **errp)
 {
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
     return NULL;
 }
 
 void qcrypto_hmac_free(QCryptoHmac *hmac)
 {
-    return;
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
 }
 
 int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
@@ -40,5 +109,31 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
                         size_t *resultlen,
                         Error **errp)
 {
-    return -1;
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
 }
-- 
1.8.3.1
