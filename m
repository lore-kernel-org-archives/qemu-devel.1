Received: from eggs.gnu.org ([2001:4830:134:3::10]:46965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJef-0005Dg-HS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJee-0005gB-DP
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJed-0005eF-Lp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:56 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 4 Jul 2017 16:57:07 +0800
Message-ID: <1499158630-75260-16-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 15/18] crypto: hmac: add af_alg hmac support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Adds afalg-backend hmac support: introduces some private APIs
firstly, and then intergrates them into qcrypto_hmac_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hash-afalg.c | 104 +++++++++++++++++++++++++++++++++++++++++++++-------
 crypto/hmac.c       |  22 +++++++++--
 crypto/hmacpriv.h   |  12 ++++++
 3 files changed, 121 insertions(+), 17 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index a19847e..1ccb49e 100644
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
@@ -53,18 +56,24 @@ qcrypto_afalg_hash_format_name(QCryptoHashAlgorithm alg,
         return NULL;
     }
 
-    name = g_strdup_printf("%s", alg_name);
+    if (is_hmac) {
+        name = g_strdup_printf("hmac(%s)", alg_name);
+    } else {
+        name = g_strdup_printf("%s", alg_name);
+    }
 
     return name;
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
@@ -76,22 +85,49 @@ qcrypto_afalg_hash_ctx_new(QCryptoHashAlgorithm alg, Error **errp)
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
     const int expect_len = qcrypto_hash_digest_len(alg);
 
     if (*resultlen == 0) {
@@ -104,9 +140,13 @@ qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
         return -1;
     }
 
-    afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
-    if (!afalg) {
-        return -1;
+    if (is_hmac) {
+        afalg = hmac;
+    } else {
+        afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
+        if (!afalg) {
+            return -1;
+        }
     }
 
     /* send data to kernel's crypto core */
@@ -130,10 +170,48 @@ qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
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
index a4690e3..37e2af2 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -89,17 +89,31 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
                               Error **errp)
 {
     QCryptoHmac *hmac;
-    void *ctx;
+    void *ctx = NULL;
+    Error *err2 = NULL;
+    QCryptoHmacDriver *drv;
+
+#ifdef CONFIG_AF_ALG
+    ctx = qcrypto_afalg_hmac_ctx_new(alg, key, nkey, &err2);
+    if (ctx) {
+        drv = &qcrypto_hmac_afalg_driver;
+    }
+#endif
 
-    ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
     if (!ctx) {
-        return NULL;
+        ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
+        if (!ctx) {
+            return NULL;
+        }
+
+        drv = &qcrypto_hmac_lib_driver;
+        error_free(err2);
     }
 
     hmac = g_new0(QCryptoHmac, 1);
     hmac->alg = alg;
     hmac->opaque = ctx;
-    hmac->driver = (void *)&qcrypto_hmac_lib_driver;
+    hmac->driver = (void *)drv;
 
     return hmac;
 }
diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
index 2be389a..4387ca2 100644
--- a/crypto/hmacpriv.h
+++ b/crypto/hmacpriv.h
@@ -33,4 +33,16 @@ extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
                                   Error **errp);
 extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
 
+#ifdef CONFIG_AF_ALG
+
+#include "afalgpriv.h"
+
+extern QCryptoAFAlg *
+qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                           const uint8_t *key, size_t nkey,
+                           Error **errp);
+extern QCryptoHmacDriver qcrypto_hmac_afalg_driver;
+
+#endif
+
 #endif
-- 
1.8.3.1
