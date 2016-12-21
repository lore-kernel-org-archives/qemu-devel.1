Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJhzy-0004nd-Da
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJhzx-0006lI-AB
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cJhzx-0006i9-2R
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:36:05 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 21 Dec 2016 14:35:40 +0000
Message-Id: <20161221143541.9260-7-berrange@redhat.com>
In-Reply-To: <20161221143541.9260-1-berrange@redhat.com>
References: <20161221143541.9260-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 6/7] crypto: support HMAC algorithms based on
 nettle
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

This patch add nettle-backed HMAC algorithms support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/hmac-nettle.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 133 insertions(+), 3 deletions(-)

diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 95f3dcc..4a9e6b2 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -17,8 +17,83 @@
 #include "crypto/hmac.h"
 #include <nettle/hmac.h>
 
+typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
+              size_t key_length, const uint8_t *key);
+
+typedef void (*qcrypto_nettle_hmac_update)(void *ctx,
+              size_t length, const uint8_t *data);
+
+typedef void (*qcrypto_nettle_hmac_digest)(void *ctx,
+              size_t length, uint8_t *digest);
+
+typedef struct QCryptoHmacNettle QCryptoHmacNettle;
+struct QCryptoHmacNettle {
+    union qcrypto_nettle_hmac_ctx {
+        struct hmac_md5_ctx md5_ctx;
+        struct hmac_sha1_ctx sha1_ctx;
+        struct hmac_sha256_ctx sha256_ctx; /* equals hmac_sha224_ctx */
+        struct hmac_sha512_ctx sha512_ctx; /* equals hmac_sha384_ctx */
+        struct hmac_ripemd160_ctx ripemd160_ctx;
+    } u;
+};
+
+struct qcrypto_nettle_hmac_alg {
+    qcrypto_nettle_hmac_setkey setkey;
+    qcrypto_nettle_hmac_update update;
+    qcrypto_nettle_hmac_digest digest;
+    size_t len;
+} qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
+    [QCRYPTO_HASH_ALG_MD5] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_md5_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_md5_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_md5_digest,
+        .len = MD5_DIGEST_SIZE,
+    },
+    [QCRYPTO_HASH_ALG_SHA1] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha1_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha1_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha1_digest,
+        .len = SHA1_DIGEST_SIZE,
+    },
+    [QCRYPTO_HASH_ALG_SHA224] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha224_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha224_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha224_digest,
+        .len = SHA224_DIGEST_SIZE,
+    },
+    [QCRYPTO_HASH_ALG_SHA256] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha256_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha256_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha256_digest,
+        .len = SHA256_DIGEST_SIZE,
+    },
+    [QCRYPTO_HASH_ALG_SHA384] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha384_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha384_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha384_digest,
+        .len = SHA384_DIGEST_SIZE,
+    },
+    [QCRYPTO_HASH_ALG_SHA512] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha512_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha512_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha512_digest,
+        .len = SHA512_DIGEST_SIZE,
+    },
+    [QCRYPTO_HASH_ALG_RIPEMD160] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_ripemd160_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_ripemd160_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_ripemd160_digest,
+        .len = RIPEMD160_DIGEST_SIZE,
+    },
+};
+
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
 {
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg].setkey != NULL) {
+        return true;
+    }
+
     return false;
 }
 
@@ -26,12 +101,39 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
                               const uint8_t *key, size_t nkey,
                               Error **errp)
 {
-    return NULL;
+    QCryptoHmac *hmac;
+    QCryptoHmacNettle *ctx;
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
+    ctx = g_new0(QCryptoHmacNettle, 1);
+
+    qcrypto_hmac_alg_map[alg].setkey(&ctx->u, nkey, key);
+
+    hmac->opaque = ctx;
+
+    return hmac;
 }
 
 void qcrypto_hmac_free(QCryptoHmac *hmac)
 {
-    return;
+    QCryptoHmacNettle *ctx;
+
+    if (!hmac) {
+        return;
+    }
+
+    ctx = hmac->opaque;
+
+    g_free(ctx);
+    g_free(hmac);
 }
 
 int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
@@ -41,5 +143,33 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
                         size_t *resultlen,
                         Error **errp)
 {
-    return -1;
+    QCryptoHmacNettle *ctx;
+    int i;
+
+    ctx = (QCryptoHmacNettle *)hmac->opaque;
+
+    for (i = 0; i < niov; ++i) {
+        size_t len = iov[i].iov_len;
+        uint8_t *base = iov[i].iov_base;
+        while (len) {
+            size_t shortlen = MIN(len, UINT_MAX);
+            qcrypto_hmac_alg_map[hmac->alg].update(&ctx->u, len, base);
+            len -= shortlen;
+            base += len;
+        }
+    }
+
+    if (*resultlen == 0) {
+        *resultlen = qcrypto_hmac_alg_map[hmac->alg].len;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != qcrypto_hmac_alg_map[hmac->alg].len) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %zu",
+                   *resultlen, qcrypto_hmac_alg_map[hmac->alg].len);
+        return -1;
+    }
+
+    qcrypto_hmac_alg_map[hmac->alg].digest(&ctx->u, *resultlen, *result);
+
+    return 0;
 }
-- 
2.9.3
