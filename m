Received: from eggs.gnu.org ([2001:4830:134:3::10]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCk-0000dU-Gs
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCf-0002UL-Nb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3358
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCe-0002T0-Ja
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:41 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:01:20 +0800
Message-ID: <1491814880-55900-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 18/19] crypto: hmac: add af_alg hmac
 support
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

Adds afalg-backend hmac support: introduces some private APIs
firstly, and then intergrates them into qcrypto_hmac_afalg_driver.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hash-afalg.c         | 108 ++++++++++++++++++++++++++++++++++++++------
 crypto/hmac.c               |  28 +++++++++++-
 include/crypto/afalg-comm.h |   1 +
 include/crypto/hmac.h       |  13 ++++++
 4 files changed, 136 insertions(+), 14 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index d96d7568..f2c27b1 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -1,5 +1,5 @@
 /*
- * QEMU Crypto af_alg-backend hash support
+ * QEMU Crypto af_alg-backend hash/hmac support
  *
  * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
  *
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "crypto/hash.h"
+#include "crypto/hmac.h"
 #include "crypto/afalg-comm.h"
 #include <linux/if_alg.h>
 
@@ -57,7 +58,10 @@ static int afalg_hash_format_name(QCryptoHashAlgorithm alg,
     return 0;
 }
 
-static QCryptoAfalg *afalg_hash_ctx_new(QCryptoHashAlgorithm alg)
+static QCryptoAfalg *
+afalg_hash_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                        const uint8_t *key, size_t nkey,
+                        bool is_hash)
 {
     SocketAddress *saddr = NULL;
     QCryptoAfalg *afalg = NULL;
@@ -70,13 +74,27 @@ static QCryptoAfalg *afalg_hash_ctx_new(QCryptoHashAlgorithm alg)
     if (ret != 0) {
         goto error;
     }
-    afalg_comm_format_type(saddr->u.afalg.data, ALG_TYPE_HASH);
+
+    if (is_hash) {
+        afalg_comm_format_type(saddr->u.afalg.data, ALG_TYPE_HASH);
+    } else {
+        afalg_comm_format_type(saddr->u.afalg.data, ALG_TYPE_HMAC);
+    }
 
     afalg = afalg_comm_alloc(saddr);
     if (!afalg) {
         goto error;
     }
 
+    /* HMAC needs setkey */
+    if (!is_hash) {
+        ret = qemu_setsockopt(afalg->tfmfd, SOL_ALG, ALG_SET_KEY,
+                              key, nkey);
+        if (ret != 0) {
+            goto error;
+        }
+    }
+
     /* prepare msg header */
     afalg->msg = g_new0(struct msghdr, 1);
 
@@ -93,15 +111,38 @@ error:
     goto cleanup;
 }
 
-static int afalg_hash_bytesv(QCryptoHashAlgorithm alg,
-                             const struct iovec *iov,
-                             size_t niov, uint8_t **result,
-                             size_t *resultlen,
-                             Error **errp)
+static QCryptoAfalg *afalg_hash_ctx_new(QCryptoHashAlgorithm alg)
+{
+    return afalg_hash_hmac_ctx_new(alg, NULL, 0, true);
+}
+
+QCryptoAfalg *afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                                 const uint8_t *key, size_t nkey,
+                                 Error **errp)
+{
+    QCryptoAfalg *afalg;
+
+    afalg = afalg_hash_hmac_ctx_new(alg, key, nkey, false);
+    if (afalg == NULL) {
+        error_setg(errp, "Afalg cannot initialize hmac and set key");
+        return NULL;
+    }
+
+    return afalg;
+}
+
+static int
+afalg_hash_hmac_bytesv(QCryptoAfalg *hmac,
+                       QCryptoHashAlgorithm alg,
+                       const struct iovec *iov,
+                       size_t niov, uint8_t **result,
+                       size_t *resultlen,
+                       Error **errp)
 {
     QCryptoAfalg *afalg = NULL;
     struct iovec outv;
     int ret = 0;
+    bool is_hmac = (hmac != NULL) ? true : false;
     const int except_len = qcrypto_hash_digest_len(alg);
 
     if (*resultlen == 0) {
@@ -114,10 +155,14 @@ static int afalg_hash_bytesv(QCryptoHashAlgorithm alg,
         return -1;
     }
 
-    afalg = afalg_hash_ctx_new(alg);
-    if (afalg == NULL) {
-        error_setg(errp, "Alloc QCryptoAfalg object failed");
-        return -1;
+    if (is_hmac) {
+        afalg = hmac;
+    } else {
+        afalg = afalg_hash_ctx_new(alg);
+        if (afalg == NULL) {
+            error_setg(errp, "Alloc QCryptoAfalg object failed");
+            return -1;
+        }
     }
 
     /* send data to kernel's crypto core */
@@ -141,10 +186,47 @@ static int afalg_hash_bytesv(QCryptoHashAlgorithm alg,
     }
 
 out:
-    afalg_comm_free(afalg);
+    if (!is_hmac) { /* hash */
+        afalg_comm_free(afalg);
+    }
     return ret;
 }
 
+static int
+afalg_hash_bytesv(QCryptoHashAlgorithm alg,
+                  const struct iovec *iov,
+                  size_t niov, uint8_t **result,
+                  size_t *resultlen,
+                  Error **errp)
+{
+    return afalg_hash_hmac_bytesv(NULL, alg, iov, niov,
+                                  result, resultlen, errp);
+}
+
+static int
+afalg_hmac_bytesv(QCryptoHmac *hmac,
+                  const struct iovec *iov,
+                  size_t niov, uint8_t **result,
+                  size_t *resultlen,
+                  Error **errp)
+{
+    return afalg_hash_hmac_bytesv(hmac->opaque, hmac->alg, iov, niov,
+                                  result, resultlen, errp);
+}
+
+static void afalg_hmac_ctx_free(QCryptoHmac *hmac)
+{
+    QCryptoAfalg *afalg;
+
+    afalg = hmac->opaque;
+    afalg_comm_free(afalg);
+}
+
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
     .hash_bytesv = afalg_hash_bytesv,
 };
+
+QCryptoHmacDriver qcrypto_hmac_afalg_driver = {
+    .hmac_bytesv = afalg_hmac_bytesv,
+    .hmac_free = afalg_hmac_ctx_free,
+};
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 2d9487a..9419abd 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include "crypto/afalg-comm.h"
 
 static const char hex[] = "0123456789abcdef";
 
@@ -88,16 +89,32 @@ QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
 {
     QCryptoHmac *hmac;
     void *ctx;
+    QCryptoHmacDriver *drv;
+#ifdef CONFIG_AF_ALG
+    Error *errp2 = NULL;
+
+    ctx = afalg_hmac_ctx_new(alg, key, nkey, &errp2);
+    if (ctx) {
+        drv = &qcrypto_hmac_afalg_driver;
+        goto set;
+    }
+
+    if (errp2) {
+        error_free(errp2);
+    }
+#endif
 
     ctx = qcrypto_hmac_ctx_new(alg, key, nkey, errp);
     if (ctx == NULL) {
         return NULL;
     }
+    drv = &qcrypto_hmac_lib_driver;
 
+set:
     hmac = g_new0(QCryptoHmac, 1);
     hmac->alg = alg;
     hmac->opaque = ctx;
-    hmac->driver = &qcrypto_hmac_lib_driver;
+    hmac->driver = drv;
 
     return hmac;
 }
@@ -109,3 +126,12 @@ void qcrypto_hmac_free(QCryptoHmac *hmac)
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
diff --git a/include/crypto/afalg-comm.h b/include/crypto/afalg-comm.h
index 3293949..3da9166 100644
--- a/include/crypto/afalg-comm.h
+++ b/include/crypto/afalg-comm.h
@@ -21,6 +21,7 @@
 
 #define ALG_TYPE_CIPHER "skcipher"
 #define ALG_TYPE_HASH   "hash"
+#define ALG_TYPE_HMAC   "hmac"
 
 #define ALG_OPTYPE_LEN 4
 #define ALG_MSGIV_LEN(len) (sizeof(struct af_alg_iv) + (len))
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index 6f63eb8..91d1d0b 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -13,6 +13,7 @@
 #define QCRYPTO_HMAC_H
 
 #include "qapi-types.h"
+#include "afalg-comm.h"
 
 typedef struct QCryptoHmacDriver QCryptoHmacDriver;
 typedef struct QCryptoHmac QCryptoHmac;
@@ -39,6 +40,10 @@ extern void *qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
                                   Error **errp);
 extern QCryptoHmacDriver qcrypto_hmac_lib_driver;
 
+extern QCryptoAfalg *afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
+                                        const uint8_t *key, size_t nkey,
+                                        Error **errp);
+extern QCryptoHmacDriver qcrypto_hmac_afalg_driver;
 
 /**
  * qcrypto_hmac_supports:
@@ -183,4 +188,12 @@ int qcrypto_hmac_digest(QCryptoHmac *hmac,
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
