Received: from eggs.gnu.org ([2001:4830:134:3::10]:47951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfF-0006Go-UE
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfC-00074k-FP
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:49 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:53476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGLfB-00072w-Rr
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 03:08:46 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 12 Dec 2016 16:08:11 +0800
Message-ID: <1481530092-20240-7-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
References: <1481530092-20240-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v2 6/7] crypto: support HMAC algorithms
 based on nettle
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

This patch add nettle-backed HMAC algorithms support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-nettle.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 7a9cd2e..a082bc0 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -15,9 +15,66 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include <nettle/hmac.h>
+
+typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
+        size_t key_length, const uint8_t *key);
+
+typedef void (*qcrypto_nettle_hmac_update)(void *ctx,
+        size_t length, const uint8_t *data);
+
+typedef void (*qcrypto_nettle_hmac_digest)(void *ctx,
+        size_t length, uint8_t *digest);
+
+typedef struct QCryptoHmacNettle QCryptoHmacNettle;
+struct QCryptoHmacNettle {
+    union qcrypto_nettle_hmac_ctx {
+        struct hmac_md5_ctx md5_ctx;
+        struct hmac_sha1_ctx sha1_ctx;
+        struct hmac_sha256_ctx sha256_ctx;
+        struct hmac_sha512_ctx sha512_ctx;
+    } u;
+};
+
+struct qcrypto_nettle_hmac_alg {
+    qcrypto_nettle_hmac_setkey setkey;
+    qcrypto_nettle_hmac_update update;
+    qcrypto_nettle_hmac_digest digest;
+    size_t len;
+} qcrypto_hmac_alg_map[QCRYPTO_HMAC_ALG__MAX] = {
+    [QCRYPTO_HMAC_ALG_MD5] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_md5_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_md5_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_md5_digest,
+        .len = MD5_DIGEST_SIZE,
+    },
+    [QCRYPTO_HMAC_ALG_SHA1] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha1_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha1_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha1_digest,
+        .len = SHA1_DIGEST_SIZE,
+    },
+    [QCRYPTO_HMAC_ALG_SHA256] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha256_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha256_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha256_digest,
+        .len = SHA256_DIGEST_SIZE,
+    },
+    [QCRYPTO_HMAC_ALG_SHA512] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sha512_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sha512_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sha512_digest,
+        .len = SHA512_DIGEST_SIZE,
+    },
+};
 
 bool qcrypto_hmac_supports(QCryptoHmacAlgorithm alg)
 {
+    if (alg < G_N_ELEMENTS(qcrypto_hmac_alg_map) &&
+        qcrypto_hmac_alg_map[alg].setkey != NULL) {
+        return true;
+    }
+
     return false;
 }
 
@@ -25,12 +82,39 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHmacAlgorithm alg,
                                   const uint8_t *key, size_t nkey,
                                   Error **errp)
 {
-    return NULL;
+    QCryptoHmac *hmac;
+    QCryptoHmacNettle *ctx;
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
@@ -40,5 +124,33 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
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
1.8.3.1
