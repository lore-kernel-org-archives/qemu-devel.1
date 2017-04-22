Received: from eggs.gnu.org ([2001:4830:134:3::10]:48218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pMA-0003f8-ES
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM7-0003pb-LQ
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3460
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1d1pM6-0003oO-Q5
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 03:21:19 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Sat, 22 Apr 2017 15:20:24 +0800
Message-ID: <1492845627-4384-16-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 15/18] crypto: hmac: add af_alg hmac support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds afalg-backend hmac support: introduces some private APIs
firstly, and then intergrates them into qcrypto_hmac_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hash-afalg.c   | 108 +++++++++++++++++++++++++++++++++++++++++++-------
 crypto/hmac.c         |  27 ++++++++++++-
 crypto/hmacpriv.h     |   9 +++++
 include/crypto/hmac.h |   8 ++++
 4 files changed, 136 insertions(+), 16 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index f577c83..0670481 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -1,5 +1,5 @@
 /*
- * QEMU Crypto af_alg-backend hash support
+ * QEMU Crypto af_alg-backend hash/hmac support
  *
  * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
  *
@@ -16,10 +16,13 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "crypto/hash.h"
+#include "crypto/hmac.h"
 #include "hashpriv.h"
+#include "hmacpriv.h"
 
 static char *
 qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
+                               bool is_hmac,
                                Error **errp)
 {
     char *name;
@@ -55,10 +58,14 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
     }
 
     name = g_new0(char, SALG_NAME_LEN_MAX);
-    ret = snprintf(name, SALG_NAME_LEN_MAX, "%s", alg_name);
+    if (is_hmac) {
+        ret = snprintf(name, SALG_NAME_LEN_MAX, "hmac(%s)", alg_name);
+    } else { /* hash */
+        ret = snprintf(name, SALG_NAME_LEN_MAX, "%s", alg_name);
+    }
     if (ret < 0 || ret >= SALG_NAME_LEN_MAX) {
-        error_setg(errp, "Build hash name(name='%s') failed",
-                   alg_name);
+        error_setg(errp, "Build %s name(name='%s') failed",
+                   is_hmac ? "hmac" : "hash", alg_name);
         g_free(name);
         return NULL;
     }
@@ -67,12 +74,14 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
 }
 
 static QCryptoAFAlg *
-qcrypto_afalg_hash_ctx_new(QCryptoHashAlgorithm alg, Error **errp)
+qcrypto_afalg_hash_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                                const uint8_t *key, size_t nkey,
+                                bool is_hmac, Error **errp)
 {
     QCryptoAFAlg *afalg;
     char *name;
 
-    name = qcrypto_afalg_hash_format_name(alg, errp);
+    name = qcrypto_afalg_hash_format_name(alg, is_hmac, errp);
     if (!name) {
         return NULL;
     }
@@ -84,22 +93,49 @@ qcrypto_afalg_hash_ctx_new(QCryptoHashAlgorithm alg, Error **errp)
     }
     afalg->name = name;
 
+    /* HMAC needs setkey */
+    if (is_hmac) {
+        if (qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY,
+                            key, nkey) != 0) {
+            error_setg_errno(errp, errno, "Set hmac key failed");
+            qcrypto_afalg_comm_free(afalg);
+            return NULL;
+        }
+    }
+
     /* prepare msg header */
     afalg->msg = g_new0(struct msghdr, 1);
 
     return afalg;
 }
 
+static QCryptoAFAlg *
+qcrypto_afalg_hash_ctx_new(QCryptoHashAlgorithm alg,
+                           Error **errp)
+{
+    return qcrypto_afalg_hash_hmac_ctx_new(alg, NULL, 0, false, errp);
+}
+
+QCryptoAFAlg *
+qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp)
+{
+    return qcrypto_afalg_hash_hmac_ctx_new(alg, key, nkey, true, errp);
+}
+
 static int
-qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
-                          const struct iovec *iov,
-                          size_t niov, uint8_t **result,
-                          size_t *resultlen,
-                          Error **errp)
+qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlg *hmac,
+                               QCryptoHashAlgorithm alg,
+                               const struct iovec *iov,
+                               size_t niov, uint8_t **result,
+                               size_t *resultlen,
+                               Error **errp)
 {
     QCryptoAFAlg *afalg;
     struct iovec outv;
     int ret = 0;
+    bool is_hmac = (hmac != NULL) ? true : false;
     const int except_len = qcrypto_hash_digest_len(alg);
 
     if (*resultlen == 0) {
@@ -112,9 +148,13 @@ qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
         return -1;
     }
 
-    afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
-    if (afalg == NULL) {
-        return -1;
+    if (is_hmac) {
+        afalg = hmac;
+    } else {
+        afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
+        if (afalg == NULL) {
+            return -1;
+        }
     }
 
     /* send data to kernel's crypto core */
@@ -138,10 +178,48 @@ qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
     }
 
 out:
-    qcrypto_afalg_comm_free(afalg);
+    if (!is_hmac) {
+        qcrypto_afalg_comm_free(afalg);
+    }
     return ret;
 }
 
+static int
+qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
+                          const struct iovec *iov,
+                          size_t niov, uint8_t **result,
+                          size_t *resultlen,
+                          Error **errp)
+{
+    return qcrypto_afalg_hash_hmac_bytesv(NULL, alg, iov, niov, result,
+                                          resultlen, errp);
+}
+
+static int
+qcrypto_afalg_hmac_bytesv(QCryptoHmac *hmac,
+                          const struct iovec *iov,
+                          size_t niov, uint8_t **result,
+                          size_t *resultlen,
+                          Error **errp)
+{
+    return qcrypto_afalg_hash_hmac_bytesv(hmac->opaque, hmac->alg,
+                                          iov, niov, result, resultlen,
+                                          errp);
+}
+
+static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
+{
+    QCryptoAFAlg *afalg;
+
+    afalg = hmac->opaque;
+    qcrypto_afalg_comm_free(afalg);
+}
+
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
     .hash_bytesv = qcrypto_afalg_hash_bytesv,
 };
+
+QCryptoHmacDriver qcrypto_hmac_afalg_driver = {
+    .hmac_bytesv = qcrypto_afalg_hmac_bytesv,
+    .hmac_free = qcrypto_afalg_hmac_ctx_free,
+};
diff --git a/crypto/hmac.c b/crypto/hmac.c
index d040fbb..0a1a6e7 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -90,16 +90,32 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
 {
     QCryptoHmac *hmac;
     void *ctx;
+    Error *err2 = NULL;
+    QCryptoHmacDriver *drv;
+
+#ifdef CONFIG_AF_ALG
+    ctx = qcrypto_afalg_hmac_ctx_new(alg, key, nkey, &err2);
+    if (ctx) {
+        drv = &qcrypto_hmac_afalg_driver;
+        goto set_hmac;
+    }
+#endif
 
     ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
     if (ctx == NULL) {
         return NULL;
     }
 
+    drv = &qcrypto_hmac_lib_driver;
+    error_free(err2);
+
+#ifdef CONFIG_AF_ALG
+set_hmac:
+#endif
     hmac = g_new0(QCryptoHmac, 1);
     hmac->alg = alg;
     hmac->opaque = ctx;
-    hmac->driver = (void *)&qcrypto_hmac_lib_driver;
+    hmac->driver = (void *)drv;
 
     return hmac;
 }
@@ -114,3 +130,12 @@ void qcrypto_hmac_free(QCryptoHmac *hmac)
         g_free(hmac);
     }
 }
+
+bool qcrypto_hmac_using_afalg_drv(QCryptoHmac *hmac)
+{
+#ifdef CONFIG_AF_ALG
+    return hmac->driver == &qcrypto_hmac_afalg_driver;
+#else
+    return false;
+#endif
+}
diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
index 2be389a..2d1900f 100644
--- a/crypto/hmacpriv.h
+++ b/crypto/hmacpriv.h
@@ -15,6 +15,8 @@
 #ifndef QCRYPTO_HMACPRIV_H
 #define QCRYPTO_HMACPRIV_H
 
+#include "afalgpriv.h"
+
 typedef struct QCryptoHmacDriver QCryptoHmacDriver;
 
 struct QCryptoHmacDriver {
@@ -33,4 +35,11 @@ extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
                                   Error **errp);
 extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
 
+
+extern QCryptoAFAlg *
+qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp);
+extern QCryptoHmacDriver qcrypto_hmac_afalg_driver;
+
 #endif
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index 5e88905..450cdee 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -164,4 +164,12 @@ int qcrypto_hmac_digest(QCryptoHmac *hmac,
                         char **digest,
                         Error **errp);
 
+/**
+ * qcrypto_cipher_using_afalg_drv:
+ * @hmac: the hmac object
+ *
+ * Returns: True if @hmac using afalg driver, otherwise false.
+ */
+bool qcrypto_hmac_using_afalg_drv(QCryptoHmac *hmac);
+
 #endif
-- 
1.8.3.1
