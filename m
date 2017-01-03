Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3c-0002wW-2d
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3a-0001LT-Rm
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:28 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:8703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3Z-0001KJ-VV
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:26 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 3 Jan 2017 08:33:09 +0800
Message-ID: <1483403591-2564-5-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1483403591-2564-1-git-send-email-longpeng2@huawei.com>
References: <1483403591-2564-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/6] crypto: implement gcrypt-backed AEAD
 algorithms
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

This patch add gcrypt-backed AEAD algorithms support

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/aead-gcrypt.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 167 insertions(+), 6 deletions(-)

diff --git a/crypto/aead-gcrypt.c b/crypto/aead-gcrypt.c
index 9465518..9892e3b 100644
--- a/crypto/aead-gcrypt.c
+++ b/crypto/aead-gcrypt.c
@@ -17,17 +17,100 @@
 #include "crypto/aead.h"
 #include <gcrypt.h>
 
+typedef struct QCryptoAeadGcrypt QCryptoAeadGcrypt;
+struct QCryptoAeadGcrypt {
+    gcry_cipher_hd_t handle;
+};
+
 QCryptoAead *qcrypto_aead_new(QCryptoCipherAlgorithm alg,
                               QCryptoCipherMode mode,
                               const uint8_t *key, size_t nkey,
                               Error **errp)
 {
+    QCryptoAead *aead;
+    QCryptoAeadGcrypt *ctx;
+    gcry_error_t err;
+    int gcryalg, gcrymode;
+
+    switch (mode) {
+    case QCRYPTO_CIPHER_MODE_CCM:
+        gcrymode = GCRY_CIPHER_MODE_CCM;
+        break;
+    case QCRYPTO_CIPHER_MODE_GCM:
+        gcrymode = GCRY_CIPHER_MODE_GCM;
+        break;
+    default:
+        error_setg(errp, "Unsupported AEAD mode %s",
+                   QCryptoCipherMode_lookup[mode]);
+        return NULL;
+    }
+
+    if (nkey != qcrypto_aead_get_key_len(alg)) {
+        error_setg(errp, "Cipher key length %zu is invalid",
+                   nkey);
+        return NULL;
+    }
+
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALG_AES_128:
+        gcryalg = GCRY_CIPHER_AES128;
+        break;
+    case QCRYPTO_CIPHER_ALG_AES_192:
+        gcryalg = GCRY_CIPHER_AES192;
+        break;
+    case QCRYPTO_CIPHER_ALG_AES_256:
+        gcryalg = GCRY_CIPHER_AES256;
+        break;
+    default:
+        error_setg(errp, "Unsupported AEAD algorithm %s",
+                   QCryptoCipherAlgorithm_lookup[alg]);
+        return NULL;
+    }
+
+    aead = g_new0(QCryptoAead, 1);
+    aead->alg = alg;
+    aead->mode = mode;
+
+    ctx = g_new0(QCryptoAeadGcrypt, 1);
+
+    err = gcry_cipher_open(&ctx->handle, gcryalg, gcrymode, 0);
+    if (err) {
+        error_setg(errp, "Cannot initialize aead: %s",
+                   gcry_strerror(err));
+        goto error;
+    }
+
+    err = gcry_cipher_setkey(ctx->handle, key, nkey);
+    if (err) {
+        error_setg(errp, "Cannot set key: %s",
+                   gcry_strerror(err));
+        goto error;
+    }
+
+    aead->opaque = ctx;
+
+    return aead;
+
+error:
+    gcry_cipher_close(ctx->handle);
+    g_free(ctx);
+    g_free(aead);
     return NULL;
 }
 
 void qcrypto_aead_free(QCryptoAead *aead)
 {
-    return;
+    QCryptoAeadGcrypt *ctx;
+
+    if (!aead) {
+        return;
+    }
+
+    ctx = aead->opaque;
+
+    gcry_cipher_close(ctx->handle);
+    g_free(ctx);
+    g_free(aead);
 }
 
 int qcrypto_aead_set_nonce(QCryptoAead *aead,
@@ -36,14 +119,54 @@ int qcrypto_aead_set_nonce(QCryptoAead *aead,
                            size_t tag_len,
                            Error **errp)
 {
-    return -1;
+    QCryptoAeadGcrypt *ctx;
+    gcry_error_t err;
+
+    ctx = aead->opaque;
+
+    err = gcry_cipher_setiv(ctx->handle, nonce, nonce_len);
+    if (err) {
+        error_setg(errp, "Cannot set iv/nonce: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    if (aead->mode == QCRYPTO_CIPHER_MODE_CCM) {
+        size_t ctl_para[3];
+
+        ctl_para[0] = in_len;
+        ctl_para[1] = aad_len;
+        ctl_para[2] = tag_len;
+
+        err = gcry_cipher_ctl(ctx->handle, GCRYCTL_SET_CCM_LENGTHS,
+                              ctl_para, sizeof(ctl_para));
+        if (err) {
+            error_setg(errp, "Cannot set lengths: %s",
+                       gcry_strerror(err));
+            return -1;
+        }
+    }
+
+    return 0;
 }
 
 int qcrypto_aead_authenticate(QCryptoAead *aead,
                               const uint8_t *aad, size_t aad_len,
                               Error **errp)
 {
-    return -1;
+    QCryptoAeadGcrypt *ctx;
+    gcry_error_t err;
+
+    ctx = aead->opaque;
+
+    err = gcry_cipher_authenticate(ctx->handle, aad, aad_len);
+    if (err) {
+        error_setg(errp, "Cannot set associated data: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
 }
 
 int qcrypto_aead_encrypt(QCryptoAead *aead,
@@ -51,7 +174,20 @@ int qcrypto_aead_encrypt(QCryptoAead *aead,
                          uint8_t *out, size_t out_len,
                          Error **errp)
 {
-    return -1;
+    QCryptoAeadGcrypt *ctx;
+    gcry_error_t err;
+
+    ctx = aead->opaque;
+
+    err = gcry_cipher_encrypt(ctx->handle, out, out_len,
+                              in, in_len);
+    if (err) {
+        error_setg(errp, "Cannot encrypt data: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
 }
 
 int qcrypto_aead_decrypt(QCryptoAead *aead,
@@ -59,12 +195,37 @@ int qcrypto_aead_decrypt(QCryptoAead *aead,
                          uint8_t *out, size_t out_len,
                          Error **errp)
 {
-    return -1;
+    QCryptoAeadGcrypt *ctx;
+    gcry_error_t err;
+
+    ctx = aead->opaque;
+
+    err = gcry_cipher_decrypt(ctx->handle, out, out_len,
+                              in, in_len);
+    if (err) {
+        error_setg(errp, "Cannot decrypt data: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
 }
 
 int qcrypto_aead_get_tag(QCryptoAead *aead,
                          uint8_t *tag, size_t tag_len,
                          Error **errp)
 {
-    return -1;
+    QCryptoAeadGcrypt *ctx;
+    gcry_error_t err;
+
+    ctx = aead->opaque;
+
+    err = gcry_cipher_gettag(ctx->handle, tag, tag_len);
+    if (err) {
+        error_setg(errp, "Cannot get tag: %s",
+                   gcry_strerror(err));
+        return -1;
+    }
+
+    return 0;
 }
-- 
2.9.3
