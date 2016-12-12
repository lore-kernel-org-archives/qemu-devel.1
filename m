Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGL1f-0007Gh-J3
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGL1c-0006Aq-MH
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:27:55 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:30128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGL1c-00064z-2L
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 02:27:52 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 12 Dec 2016 15:27:16 +0800
Message-ID: <1481527639-17520-5-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481527639-17520-1-git-send-email-longpeng2@huawei.com>
References: <1481527639-17520-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v1 4/7] crypto: support HMAC algorithms
 based on libgcrypt
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

This patch add HMAC algorithms based on libgcrypt support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-gcrypt.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 26f42bc..6cf3046 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -15,6 +15,142 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include <gcrypt.h>
+
+#ifdef CONFIG_GCRYPT_SUPPORT_HMAC
+
+static int qcrypto_hmac_alg_map[QCRYPTO_HMAC_ALG__MAX] = {
+    [QCRYPTO_HMAC_ALG_MD5] = GCRY_MAC_HMAC_MD5,
+    [QCRYPTO_HMAC_ALG_SHA1] = GCRY_MAC_HMAC_SHA1,
+    [QCRYPTO_HMAC_ALG_SHA256] = GCRY_MAC_HMAC_SHA256,
+    [QCRYPTO_HMAC_ALG_SHA512] = GCRY_MAC_HMAC_SHA512,
+};
+
+typedef struct QCryptoHmacGcrypt QCryptoHmacGcrypt;
+struct QCryptoHmacGcrypt {
+    gcry_mac_hd_t handle;
+};
+
+bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
+{
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg] != GCRY_MAC_NONE) {
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
+    QCryptoHmacGcrypt *ctx;
+    gcry_error_t err;
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
+    ctx = g_new0(QCryptoHmacGcrypt, 1);
+
+    err = gcry_mac_open(&ctx->handle, qcrypto_hmac_alg_map[alg],
+                    GCRY_MAC_FLAG_SECURE, NULL);
+    if (err != 0) {
+        error_setg(errp, "Cannot initialize hmac: %s",
+                    gcry_strerror(err));
+        goto error;
+    }
+
+    err = gcry_mac_setkey(ctx->handle, (const void *)key, nkey);
+    if (err != 0) {
+        error_setg(errp, "Cannot set key: %s",
+                    gcry_strerror(err));
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
+    QCryptoHmacGcrypt *ctx;
+
+    if (!hmac) {
+        return;
+    }
+
+    ctx = hmac->opaque;
+    gcry_mac_close(ctx->handle);
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
+    QCryptoHmacGcrypt *ctx;
+    gcry_error_t err;
+    uint32_t ret;
+    int i;
+
+    ctx = hmac->opaque;
+
+    for (i = 0; i < niov; i++) {
+        gcry_mac_write(ctx->handle, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    ret = gcry_mac_get_algo_maclen(qcrypto_hmac_alg_map[hmac->alg]);
+    if (ret <= 0) {
+        error_setg(errp, "Unable to get hmac length: %s",
+                    gcry_strerror(ret));
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
+    err = gcry_mac_read(ctx->handle, *result, resultlen);
+    if (err != 0) {
+        error_setg(errp, "Cannot get result: %s",
+                    gcry_strerror(err));
+        return -1;
+    }
+
+    err = gcry_mac_reset(ctx->handle);
+    if (err != 0) {
+        error_setg(errp, "Cannot reset hmac context: %s",
+                    gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+#else
 
 bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
 {
@@ -42,3 +178,5 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 {
     return -1;
 }
+
+#endif
-- 
1.8.3.1
