Received: from eggs.gnu.org ([2001:4830:134:3::10]:36625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0uk-0004m7-4c
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cK0ug-0006BP-Ra
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cK0ug-0006Aw-Ib
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:47:54 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 22 Dec 2016 10:47:36 +0000
Message-Id: <20161222104740.19606-5-berrange@redhat.com>
In-Reply-To: <20161222104740.19606-1-berrange@redhat.com>
References: <20161222104740.19606-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 4/8] crypto: add HMAC algorithms framework
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

This patch introduce HMAC algorithms framework.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/Makefile.objs |   4 ++
 crypto/hmac-gcrypt.c |  45 ++++++++++++++
 crypto/hmac-glib.c   |  44 ++++++++++++++
 crypto/hmac-nettle.c |  45 ++++++++++++++
 crypto/hmac.c        |  72 ++++++++++++++++++++++
 crypto/hmac.h        | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 376 insertions(+)
 create mode 100644 crypto/hmac-gcrypt.c
 create mode 100644 crypto/hmac-glib.c
 create mode 100644 crypto/hmac-nettle.c
 create mode 100644 crypto/hmac.c
 create mode 100644 crypto/hmac.h

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index a36d2d9..1f749f2 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -3,6 +3,10 @@ crypto-obj-y += hash.o
 crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
+crypto-obj-y += hmac.o
+crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
+crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
+crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
 crypto-obj-y += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
new file mode 100644
index 0000000..6e07415
--- /dev/null
+++ b/crypto/hmac-gcrypt.c
@@ -0,0 +1,45 @@
+/*
+ * QEMU Crypto hmac algorithms (based on libgcrypt)
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Longpeng(Mike) <longpeng2@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "crypto/hmac.h"
+#include <gcrypt.h>
+
+bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
+{
+    return false;
+}
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    return NULL;
+}
+
+void qcrypto_hmac_free(QCryptoHmac *hmac)
+{
+    return;
+}
+
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    return -1;
+}
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
new file mode 100644
index 0000000..3e2a933
--- /dev/null
+++ b/crypto/hmac-glib.c
@@ -0,0 +1,44 @@
+/*
+ * QEMU Crypto hmac algorithms (based on glib)
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Longpeng(Mike) <longpeng2@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "crypto/hmac.h"
+
+bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
+{
+    return false;
+}
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    return NULL;
+}
+
+void qcrypto_hmac_free(QCryptoHmac *hmac)
+{
+    return;
+}
+
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    return -1;
+}
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
new file mode 100644
index 0000000..95f3dcc
--- /dev/null
+++ b/crypto/hmac-nettle.c
@@ -0,0 +1,45 @@
+/*
+ * QEMU Crypto hmac algorithms (based on nettle)
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Longpeng(Mike) <longpeng2@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "crypto/hmac.h"
+#include <nettle/hmac.h>
+
+bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
+{
+    return false;
+}
+
+QCryptoHmac *qcrypto_hmac_new(QCryptoHashAlgorithm alg,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    return NULL;
+}
+
+void qcrypto_hmac_free(QCryptoHmac *hmac)
+{
+    return;
+}
+
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    return -1;
+}
diff --git a/crypto/hmac.c b/crypto/hmac.c
new file mode 100644
index 0000000..5750405
--- /dev/null
+++ b/crypto/hmac.c
@@ -0,0 +1,72 @@
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "crypto/hmac.h"
+
+static const char hex[] = "0123456789abcdef";
+
+int qcrypto_hmac_bytes(QCryptoHmac *hmac,
+                       const char *buf,
+                       size_t len,
+                       uint8_t **result,
+                       size_t *resultlen,
+                       Error **errp)
+{
+    struct iovec iov = {
+            .iov_base = (char *)buf,
+            .iov_len = len
+    };
+
+    return qcrypto_hmac_bytesv(hmac, &iov, 1, result, resultlen, errp);
+}
+
+int qcrypto_hmac_digestv(QCryptoHmac *hmac,
+                         const struct iovec *iov,
+                         size_t niov,
+                         char **digest,
+                         Error **errp)
+{
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+    size_t i;
+
+    if (qcrypto_hmac_bytesv(hmac, iov, niov, &result, &resultlen, errp) < 0) {
+        return -1;
+    }
+
+    *digest = g_new0(char, (resultlen * 2) + 1);
+
+    for (i = 0 ; i < resultlen ; i++) {
+        (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
+        (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+    }
+
+    (*digest)[resultlen * 2] = '\0';
+
+    g_free(result);
+    return 0;
+}
+
+int qcrypto_hmac_digest(QCryptoHmac *hmac,
+                        const char *buf,
+                        size_t len,
+                        char **digest,
+                        Error **errp)
+{
+    struct iovec iov = {
+            .iov_base = (char *)buf,
+            .iov_len = len
+    };
+
+    return qcrypto_hmac_digestv(hmac, &iov, 1, digest, errp);
+}
diff --git a/crypto/hmac.h b/crypto/hmac.h
new file mode 100644
index 0000000..0d3acd7
--- /dev/null
+++ b/crypto/hmac.h
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
2.9.3
