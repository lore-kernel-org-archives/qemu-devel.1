Received: from eggs.gnu.org ([2001:4830:134:3::10]:54350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBt-0008MS-Q5
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBo-00025U-TO
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3028
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBn-00023w-OV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:48 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:00:33 +0800
Message-ID: <1491814833-62792-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 11/19] crypto: hmac: add hmac driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

1) makes the public APIs in hmac-nettle/gcrypt/glib static,
   and rename them with "nettle/gcrypt/glib" prefix.

2) introduces hmac framework, including QCryptoHmacDriver
   and new public APIs.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-gcrypt.c  | 48 +++++++++++------------------------
 crypto/hmac-glib.c    | 70 ++++++++++++++++++---------------------------------
 crypto/hmac-nettle.c  | 49 +++++++++++-------------------------
 crypto/hmac.c         | 39 ++++++++++++++++++++++++++++
 include/crypto/hmac.h | 20 +++++++++++++++
 5 files changed, 112 insertions(+), 114 deletions(-)

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 42489f3..4181b2e 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -42,10 +42,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-static QCryptoHmacGcrypt *
-qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
-                     const uint8_t *key, size_t nkey,
-                     Error **errp)
+void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp)
 {
     QCryptoHmacGcrypt *ctx;
     gcry_error_t err;
@@ -81,27 +80,22 @@ error:
     return NULL;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void gcrypt_hmac_ctx_free(QCryptoHmac *hmac)
 {
     QCryptoHmacGcrypt *ctx;
 
-    if (!hmac) {
-        return;
-    }
-
     ctx = hmac->opaque;
     gcry_mac_close(ctx->handle);
 
     g_free(ctx);
-    g_free(hmac);
 }
 
-int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int gcrypt_hmac_bytesv(QCryptoHmac *hmac,
+                              const struct iovec *iov,
+                              size_t niov,
+                              uint8_t **result,
+                              size_t *resultlen,
+                              Error **errp)
 {
     QCryptoHmacGcrypt *ctx;
     gcry_error_t err;
@@ -147,21 +141,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
     return 0;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
-{
-    QCryptoHmac *hmac;
-    QCryptoHmacGcrypt *ctx;
-
-    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
-    if (ctx == NULL) {
-        return NULL;
-    }
-
-    hmac = g_new0(QCryptoHmac, 1);
-    hmac->alg = alg;
-    hmac->opaque = ctx;
-
-    return hmac;
-}
+QCryptoHmacDriver qcrypto_hmac_lib_driver = {
+    .hmac_bytesv = gcrypt_hmac_bytesv,
+    .hmac_free = gcrypt_hmac_ctx_free,
+};
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index d9f88d8..b224be3 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -49,10 +49,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-static QCryptoHmacGlib *
-qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
-                     const uint8_t *key, size_t nkey,
-                     Error **errp)
+void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp)
 {
     QCryptoHmacGlib *ctx;
 
@@ -78,27 +77,22 @@ error:
     return NULL;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void glib_hmac_ctx_free(QCryptoHmac *hmac)
 {
     QCryptoHmacGlib *ctx;
 
-    if (!hmac) {
-        return;
-    }
-
     ctx = hmac->opaque;
     g_hmac_unref(ctx->ghmac);
 
     g_free(ctx);
-    g_free(hmac);
 }
 
-int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int glib_hmac_bytesv(QCryptoHmac *hmac,
+                            const struct iovec *iov,
+                            size_t niov,
+                            uint8_t **result,
+                            size_t *resultlen,
+                            Error **errp)
 {
     QCryptoHmacGlib *ctx;
     int i, ret;
@@ -129,25 +123,6 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
     return 0;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
-{
-    QCryptoHmac *hmac;
-    QCryptoHmacGlib *ctx;
-
-    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
-    if (ctx == NULL) {
-        return NULL;
-    }
-
-    hmac = g_new0(QCryptoHmac, 1);
-    hmac->alg = alg;
-    hmac->opaque = ctx;
-
-    return hmac;
-}
-
 #else
 
 bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
@@ -155,26 +130,31 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
+void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp)
 {
     return NULL;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void glib_hmac_ctx_free(QCryptoHmac *hmac)
 {
     return;
 }
 
-int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int glib_hmac_bytesv(QCryptoHmac *hmac,
+                            const struct iovec *iov,
+                            size_t niov,
+                            uint8_t **result,
+                            size_t *resultlen,
+                            Error **errp)
 {
     return -1;
 }
 
 #endif
+
+QCryptoHmacDriver qcrypto_hmac_lib_driver = {
+    .hmac_bytesv = glib_hmac_bytesv,
+    .hmac_free = glib_hmac_ctx_free,
+};
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 19fbb4f..e7357b3 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -97,10 +97,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-static QCryptoHmacNettle *
-qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
-                     const uint8_t *key, size_t nkey,
-                     Error **errp)
+void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp)
 {
     QCryptoHmacNettle *ctx;
 
@@ -117,26 +116,20 @@ qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
     return ctx;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void nettle_hmac_ctx_free(QCryptoHmac *hmac)
 {
     QCryptoHmacNettle *ctx;
 
-    if (!hmac) {
-        return;
-    }
-
     ctx = hmac->opaque;
-
     g_free(ctx);
-    g_free(hmac);
 }
 
-int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int nettle_hmac_bytesv(QCryptoHmac *hmac,
+                              const struct iovec *iov,
+                              size_t niov,
+                              uint8_t **result,
+                              size_t *resultlen,
+                              Error **errp)
 {
     QCryptoHmacNettle *ctx;
     int i;
@@ -169,21 +162,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
     return 0;
 }
 
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp)
-{
-    QCryptoHmac *hmac;
-    QCryptoHmacNettle *ctx;
-
-    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
-    if (ctx == NULL) {
-        return NULL;
-    }
-
-    hmac = g_new0(QCryptoHmac, 1);
-    hmac->alg = alg;
-    hmac->opaque = ctx;
-
-    return hmac;
-}
+QCryptoHmacDriver qcrypto_hmac_lib_driver = {
+    .hmac_bytesv = nettle_hmac_bytesv,
+    .hmac_free = nettle_hmac_ctx_free,
+};
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 5750405..2d9487a 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -15,6 +15,17 @@
 
 static const char hex[] = "0123456789abcdef";
 
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    return hmac->driver->hmac_bytesv(hmac, iov, niov,
+                                     result, resultlen, errp);
+}
+
 int qcrypto_hmac_bytes(QCryptoHmac *hmac,
                        const char *buf,
                        size_t len,
@@ -70,3 +81,31 @@ int qcrypto_hmac_digest(QCryptoHmac *hmac,
 
     return qcrypto_hmac_digestv(hmac, &iov, 1, digest, errp);
 }
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    QCryptoHmac *hmac;
+    void *ctx;
+
+    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
+    if (ctx == NULL) {
+        return NULL;
+    }
+
+    hmac = g_new0(QCryptoHmac, 1);
+    hmac->alg = alg;
+    hmac->opaque = ctx;
+    hmac->driver = &qcrypto_hmac_lib_driver;
+
+    return hmac;
+}
+
+void qcrypto_hmac_free(QCryptoHmac *hmac)
+{
+    if (hmac) {
+        hmac->driver->hmac_free(hmac);
+        g_free(hmac);
+    }
+}
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index 0d3acd7..6f63eb8 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -14,12 +14,32 @@
 
 #include "qapi-types.h"
 
+typedef struct QCryptoHmacDriver QCryptoHmacDriver;
 typedef struct QCryptoHmac QCryptoHmac;
+
 struct QCryptoHmac {
+    QCryptoHmacDriver *driver;
     QCryptoHashAlgorithm alg;
     void *opaque;
 };
 
+struct QCryptoHmacDriver {
+    int (*hmac_bytesv)(QCryptoHmac *hmac,
+                       const struct iovec *iov,
+                       size_t niov,
+                       uint8_t **result,
+                       size_t *resultlen,
+                       Error **errp);
+
+    void (*hmac_free)(QCryptoHmac *hmac);
+};
+
+extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                                  const uint8_t *key, size_t nkey,
+                                  Error **errp);
+extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
+
+
 /**
  * qcrypto_hmac_supports:
  * @alg: the hmac algorithm
-- 
1.8.3.1
