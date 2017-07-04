Received: from eggs.gnu.org ([2001:4830:134:3::10]:46904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJec-0005BV-JC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJea-0005cV-6c
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJeZ-0005aw-B3
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:52 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 4 Jul 2017 16:56:59 +0800
Message-ID: <1499158630-75260-8-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/18] crypto: hmac: move crypto/hmac.h into
 include/crypto/
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

Moves crypto/hmac.h into include/crypto/, likes cipher.h and hash.h

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac.h         | 166 --------------------------------------------------
 include/crypto/hmac.h | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+), 166 deletions(-)
 delete mode 100644 crypto/hmac.h
 create mode 100644 include/crypto/hmac.h

diff --git a/crypto/hmac.h b/crypto/hmac.h
deleted file mode 100644
index 0d3acd7..0000000
--- a/crypto/hmac.h
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * QEMU Crypto hmac algorithms
- *
- * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * (at your option) any later version.  See the COPYING file in the
- * top-level directory.
- *
- */
-
-#ifndef QCRYPTO_HMAC_H
-#define QCRYPTO_HMAC_H
-
-#include "qapi-types.h"
-
-typedef struct QCryptoHmac QCryptoHmac;
-struct QCryptoHmac {
-    QCryptoHashAlgorithm alg;
-    void *opaque;
-};
-
-/**
- * qcrypto_hmac_supports:
- * @alg: the hmac algorithm
- *
- * Determine if @alg hmac algorithm is supported by
- * the current configured build
- *
- * Returns:
- *  true if the algorithm is supported, false otherwise
- */
-bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg);
-
-/**
- * qcrypto_hmac_new:
- * @alg: the hmac algorithm
- * @key: the key bytes
- * @nkey: the length of @key
- * @errp: pointer to a NULL-initialized error object
- *
- * Creates a new hmac object with the algorithm @alg
- *
- * The @key parameter provides the bytes representing
- * the secret key to use. The @nkey parameter specifies
- * the length of @key in bytes
- *
- * Note: must use qcrypto_hmac_free() to release the
- * returned hmac object when no longer required
- *
- * Returns:
- *  a new hmac object, or NULL on error
- */
-QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
-                              const uint8_t *key, size_t nkey,
-                              Error **errp);
-
-/**
- * qcrypto_hmac_free:
- * @hmac: the hmac object
- *
- * Release the memory associated with @hmac that was
- * previously allocated by qcrypto_hmac_new()
- */
-void qcrypto_hmac_free(QCryptoHmac *hmac);
-
-/**
- * qcrypto_hmac_bytesv:
- * @hmac: the hmac object
- * @iov: the array of memory regions to hmac
- * @niov: the length of @iov
- * @result: pointer to hold output hmac
- * @resultlen: pointer to hold length of @result
- * @errp: pointer to a NULL-initialized error object
- *
- * Computes the hmac across all the memory regions
- * present in @iov. The @result pointer will be
- * filled with raw bytes representing the computed
- * hmac, which will have length @resultlen. The
- * memory pointer in @result must be released
- * with a call to g_free() when no longer required.
- *
- * Returns:
- *  0 on success, -1 on error
- */
-int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp);
-
-/**
- * qcrypto_hmac_bytes:
- * @hmac: the hmac object
- * @buf: the memory region to hmac
- * @len: the length of @buf
- * @result: pointer to hold output hmac
- * @resultlen: pointer to hold length of @result
- * @errp: pointer to a NULL-initialized error object
- *
- * Computes the hmac across all the memory region
- * @buf of length @len. The @result pointer will be
- * filled with raw bytes representing the computed
- * hmac, which will have length @resultlen. The
- * memory pointer in @result must be released
- * with a call to g_free() when no longer required.
- *
- * Returns:
- *  0 on success, -1 on error
- */
-int qcrypto_hmac_bytes(QCryptoHmac *hmac,
-                       const char *buf,
-                       size_t len,
-                       uint8_t **result,
-                       size_t *resultlen,
-                       Error **errp);
-
-/**
- * qcrypto_hmac_digestv:
- * @hmac: the hmac object
- * @iov: the array of memory regions to hmac
- * @niov: the length of @iov
- * @digest: pointer to hold output hmac
- * @errp: pointer to a NULL-initialized error object
- *
- * Computes the hmac across all the memory regions
- * present in @iov. The @digest pointer will be
- * filled with the printable hex digest of the computed
- * hmac, which will be terminated by '\0'. The
- * memory pointer in @digest must be released
- * with a call to g_free() when no longer required.
- *
- * Returns:
- *  0 on success, -1 on error
- */
-int qcrypto_hmac_digestv(QCryptoHmac *hmac,
-                         const struct iovec *iov,
-                         size_t niov,
-                         char **digest,
-                         Error **errp);
-
-/**
- * qcrypto_hmac_digest:
- * @hmac: the hmac object
- * @buf: the memory region to hmac
- * @len: the length of @buf
- * @digest: pointer to hold output hmac
- * @errp: pointer to a NULL-initialized error object
- *
- * Computes the hmac across all the memory region
- * @buf of length @len. The @digest pointer will be
- * filled with the printable hex digest of the computed
- * hmac, which will be terminated by '\0'. The
- * memory pointer in @digest must be released
- * with a call to g_free() when no longer required.
- *
- * Returns: 0 on success, -1 on error
- */
-int qcrypto_hmac_digest(QCryptoHmac *hmac,
-                        const char *buf,
-                        size_t len,
-                        char **digest,
-                        Error **errp);
-
-#endif
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
new file mode 100644
index 0000000..0d3acd7
--- /dev/null
+++ b/include/crypto/hmac.h
@@ -0,0 +1,166 @@
+/*
+ * QEMU Crypto hmac algorithms
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ */
+
+#ifndef QCRYPTO_HMAC_H
+#define QCRYPTO_HMAC_H
+
+#include "qapi-types.h"
+
+typedef struct QCryptoHmac QCryptoHmac;
+struct QCryptoHmac {
+    QCryptoHashAlgorithm alg;
+    void *opaque;
+};
+
+/**
+ * qcrypto_hmac_supports:
+ * @alg: the hmac algorithm
+ *
+ * Determine if @alg hmac algorithm is supported by
+ * the current configured build
+ *
+ * Returns:
+ *  true if the algorithm is supported, false otherwise
+ */
+bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg);
+
+/**
+ * qcrypto_hmac_new:
+ * @alg: the hmac algorithm
+ * @key: the key bytes
+ * @nkey: the length of @key
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Creates a new hmac object with the algorithm @alg
+ *
+ * The @key parameter provides the bytes representing
+ * the secret key to use. The @nkey parameter specifies
+ * the length of @key in bytes
+ *
+ * Note: must use qcrypto_hmac_free() to release the
+ * returned hmac object when no longer required
+ *
+ * Returns:
+ *  a new hmac object, or NULL on error
+ */
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp);
+
+/**
+ * qcrypto_hmac_free:
+ * @hmac: the hmac object
+ *
+ * Release the memory associated with @hmac that was
+ * previously allocated by qcrypto_hmac_new()
+ */
+void qcrypto_hmac_free(QCryptoHmac *hmac);
+
+/**
+ * qcrypto_hmac_bytesv:
+ * @hmac: the hmac object
+ * @iov: the array of memory regions to hmac
+ * @niov: the length of @iov
+ * @result: pointer to hold output hmac
+ * @resultlen: pointer to hold length of @result
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hmac across all the memory regions
+ * present in @iov. The @result pointer will be
+ * filled with raw bytes representing the computed
+ * hmac, which will have length @resultlen. The
+ * memory pointer in @result must be released
+ * with a call to g_free() when no longer required.
+ *
+ * Returns:
+ *  0 on success, -1 on error
+ */
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp);
+
+/**
+ * qcrypto_hmac_bytes:
+ * @hmac: the hmac object
+ * @buf: the memory region to hmac
+ * @len: the length of @buf
+ * @result: pointer to hold output hmac
+ * @resultlen: pointer to hold length of @result
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hmac across all the memory region
+ * @buf of length @len. The @result pointer will be
+ * filled with raw bytes representing the computed
+ * hmac, which will have length @resultlen. The
+ * memory pointer in @result must be released
+ * with a call to g_free() when no longer required.
+ *
+ * Returns:
+ *  0 on success, -1 on error
+ */
+int qcrypto_hmac_bytes(QCryptoHmac *hmac,
+                       const char *buf,
+                       size_t len,
+                       uint8_t **result,
+                       size_t *resultlen,
+                       Error **errp);
+
+/**
+ * qcrypto_hmac_digestv:
+ * @hmac: the hmac object
+ * @iov: the array of memory regions to hmac
+ * @niov: the length of @iov
+ * @digest: pointer to hold output hmac
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hmac across all the memory regions
+ * present in @iov. The @digest pointer will be
+ * filled with the printable hex digest of the computed
+ * hmac, which will be terminated by '\0'. The
+ * memory pointer in @digest must be released
+ * with a call to g_free() when no longer required.
+ *
+ * Returns:
+ *  0 on success, -1 on error
+ */
+int qcrypto_hmac_digestv(QCryptoHmac *hmac,
+                         const struct iovec *iov,
+                         size_t niov,
+                         char **digest,
+                         Error **errp);
+
+/**
+ * qcrypto_hmac_digest:
+ * @hmac: the hmac object
+ * @buf: the memory region to hmac
+ * @len: the length of @buf
+ * @digest: pointer to hold output hmac
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hmac across all the memory region
+ * @buf of length @len. The @digest pointer will be
+ * filled with the printable hex digest of the computed
+ * hmac, which will be terminated by '\0'. The
+ * memory pointer in @digest must be released
+ * with a call to g_free() when no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hmac_digest(QCryptoHmac *hmac,
+                        const char *buf,
+                        size_t len,
+                        char **digest,
+                        Error **errp);
+
+#endif
-- 
1.8.3.1
