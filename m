Received: from eggs.gnu.org ([2001:4830:134:3::10]:58075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGkYf-0002YV-OD
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGkYe-0002ED-IG
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:43:41 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:2825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGkYd-0002Cd-U9
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:43:40 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 13 Dec 2016 18:42:57 +0800
Message-ID: <1481625780-39164-4-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481625780-39164-1-git-send-email-longpeng2@huawei.com>
References: <1481625780-39164-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v4 3/6] crypto: support HMAC algorithms
 based on libgcrypt
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

This patch add HMAC algorithms based on libgcrypt support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-gcrypt.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 6e07415..21189e6 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -17,8 +17,28 @@
 #include "crypto/hmac.h"
 #include <gcrypt.h>
 
+static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
+    [QCRYPTO_HASH_ALG_MD5] = GCRY_MAC_HMAC_MD5,
+    [QCRYPTO_HASH_ALG_SHA1] = GCRY_MAC_HMAC_SHA1,
+    [QCRYPTO_HASH_ALG_SHA224] = GCRY_MAC_HMAC_SHA224,
+    [QCRYPTO_HASH_ALG_SHA256] = GCRY_MAC_HMAC_SHA256,
+    [QCRYPTO_HASH_ALG_SHA384] = GCRY_MAC_HMAC_SHA384,
+    [QCRYPTO_HASH_ALG_SHA512] = GCRY_MAC_HMAC_SHA512,
+    [QCRYPTO_HASH_ALG_RIPEMD160] = GCRY_MAC_HMAC_RMD160,
+};
+
+typedef struct QCryptoHmacGcrypt QCryptoHmacGcrypt;
+struct QCryptoHmacGcrypt {
+    gcry_mac_hd_t handle;
+};
+
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
 {
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg] != GCRY_MAC_NONE) {
+        return true;
+    }
+
     return false;
 }
 
@@ -26,12 +46,58 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
                               const uint8_t *key, size_t nkey,
                               Error **errp)
 {
+    QCryptoHmac *hmac;
+    QCryptoHmacGcrypt *ctx;
+    gcry_error_t err;
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
+    ctx = g_new0(QCryptoHmacGcrypt, 1);
+
+    err = gcry_mac_open(&ctx->handle, qcrypto_hmac_alg_map[alg],
+                        GCRY_MAC_FLAG_SECURE, NULL);
+    if (err != 0) {
+        error_setg(errp, "Cannot initialize hmac: %s",
+                   gcry_strerror(err));
+        goto error;
+    }
+
+    err = gcry_mac_setkey(ctx->handle, (const void *)key, nkey);
+    if (err != 0) {
+        error_setg(errp, "Cannot set key: %s",
+                   gcry_strerror(err));
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
 }
 
 int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
@@ -41,5 +107,46 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
                         size_t *resultlen,
                         Error **errp)
 {
-    return -1;
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
+                   gcry_strerror(ret));
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
+    err = gcry_mac_read(ctx->handle, *result, resultlen);
+    if (err != 0) {
+        error_setg(errp, "Cannot get result: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    err = gcry_mac_reset(ctx->handle);
+    if (err != 0) {
+        error_setg(errp, "Cannot reset hmac context: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
 }
-- 
1.8.3.1
