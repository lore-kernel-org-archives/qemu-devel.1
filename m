Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3c-0002wY-4Y
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3Z-0001L8-IK
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:28 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:6872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cOD3Y-0001Jc-7p
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 19:34:25 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 3 Jan 2017 08:33:07 +0800
Message-ID: <1483403591-2564-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1483403591-2564-1-git-send-email-longpeng2@huawei.com>
References: <1483403591-2564-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/6] crypto: add AEAD algorithms framework
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

This patch introduce AEAD algorithms framework.

We currently plan to support six basic AEAD algorithms,
ccm(aes128/192/256) and gcm(aes128/192/256), so we need
to add ccm/gcm mode in qapi/crypto.json simultaneously.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/Makefile.objs |   3 +
 crypto/aead-gcrypt.c |  70 ++++++++++++++++++++
 crypto/aead-nettle.c |  72 +++++++++++++++++++++
 crypto/aead.c        |  84 ++++++++++++++++++++++++
 crypto/aead.h        | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/crypto.json     |   4 +-
 6 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 crypto/aead-gcrypt.c
 create mode 100644 crypto/aead-nettle.c
 create mode 100644 crypto/aead.c
 create mode 100644 crypto/aead.h

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 1f749f2..2c5243d 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -3,6 +3,9 @@ crypto-obj-y += hash.o
 crypto-obj-$(CONFIG_NETTLE) += hash-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(CONFIG_GCRYPT)) += hash-gcrypt.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT),n,y)) += hash-glib.o
+crypto-obj-y += aead.o
+crypto-obj-$(CONFIG_NETTLE_AEAD) += aead-nettle.o
+crypto-obj-$(if $(CONFIG_NETTLE_AEAD),n,$(CONFIG_GCRYPT_AEAD)) += aead-gcrypt.o
 crypto-obj-y += hmac.o
 crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
 crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
diff --git a/crypto/aead-gcrypt.c b/crypto/aead-gcrypt.c
new file mode 100644
index 0000000..9465518
--- /dev/null
+++ b/crypto/aead-gcrypt.c
@@ -0,0 +1,70 @@
+/*
+ * QEMU Crypto aead algorithms (based on libgcrypt)
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
+#include "crypto/aead.h"
+#include <gcrypt.h>
+
+QCryptoAead *qcrypto_aead_new(QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    return NULL;
+}
+
+void qcrypto_aead_free(QCryptoAead *aead)
+{
+    return;
+}
+
+int qcrypto_aead_set_nonce(QCryptoAead *aead,
+                           const uint8_t *nonce, size_t nonce_len,
+                           size_t aad_len, size_t in_len,
+                           size_t tag_len,
+                           Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_authenticate(QCryptoAead *aead,
+                              const uint8_t *aad, size_t aad_len,
+                              Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_encrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_decrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_get_tag(QCryptoAead *aead,
+                         uint8_t *tag, size_t tag_len,
+                         Error **errp)
+{
+    return -1;
+}
diff --git a/crypto/aead-nettle.c b/crypto/aead-nettle.c
new file mode 100644
index 0000000..cfb9d33
--- /dev/null
+++ b/crypto/aead-nettle.c
@@ -0,0 +1,72 @@
+/*
+ * QEMU Crypto aead algorithms (based on nettle)
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
+#include "crypto/aead.h"
+#include <nettle/aes.h>
+#include <nettle/ccm.h>
+#include <nettle/gcm.h>
+
+QCryptoAead *qcrypto_aead_new(QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    return NULL;
+}
+
+void qcrypto_aead_free(QCryptoAead *aead)
+{
+    return;
+}
+
+int qcrypto_aead_set_nonce(QCryptoAead *aead,
+                           const uint8_t *nonce, size_t nonce_len,
+                           size_t aad_len, size_t in_len,
+                           size_t tag_len,
+                           Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_authenticate(QCryptoAead *aead,
+                              const uint8_t *aad, size_t aad_len,
+                              Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_encrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_decrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_get_tag(QCryptoAead *aead,
+                         uint8_t *tag, size_t tag_len,
+                         Error **errp)
+{
+    return -1;
+}
diff --git a/crypto/aead.c b/crypto/aead.c
new file mode 100644
index 0000000..47639b7
--- /dev/null
+++ b/crypto/aead.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU Crypto aead algorithms
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
+#include "crypto/aead.h"
+
+bool qcrypto_aead_supports(QCryptoCipherAlgorithm alg,
+                           QCryptoCipherMode mode)
+{
+    return false;
+}
+
+size_t qcrypto_aead_get_key_len(QCryptoCipherAlgorithm alg)
+{
+    return -1;
+}
+
+#if !defined(CONFIG_NETTLE_AEAD) && !defined(CONFIG_GCRYPT_AEAD)
+
+QCryptoAead *qcrypto_aead_new(QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp)
+{
+    return NULL;
+}
+
+void qcrypto_aead_free(QCryptoAead *aead)
+{
+    return;
+}
+
+int qcrypto_aead_set_nonce(QCryptoAead *aead,
+                           const uint8_t *nonce, size_t nonce_len,
+                           size_t aad_len, size_t in_len,
+                           size_t tag_len,
+                           Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_authenticate(QCryptoAead *aead,
+                              const uint8_t *aad, size_t aad_len,
+                              Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_encrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_decrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+int qcrypto_aead_get_tag(QCryptoAead *aead,
+                         uint8_t *tag, size_t tag_len,
+                         Error **errp)
+{
+    return -1;
+}
+
+#endif
diff --git a/crypto/aead.h b/crypto/aead.h
new file mode 100644
index 0000000..a868d0a
--- /dev/null
+++ b/crypto/aead.h
@@ -0,0 +1,180 @@
+/*
+ * QEMU Crypto aead algorithms
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ */
+
+#ifndef QCRYPTO_AEAD_H
+#define QCRYPTO_AEAD_H
+
+#include "qapi-types.h"
+
+/**
+ * We currently only support six basic aead algorithms,
+ * ccm(aes128/192/256) and gcm(aes128/192/256), so for
+ * some global arrays, like qcrypto_aead_alg_map, we use
+ * AEAD_ALG__MAX/AEAD_MODE__MAX as their size instead of
+ * CIPHER_ALG__MAX/CIPHER_MODE__MAX, in order to save memory.
+ *
+ * Note: this means that we must make sure ccm,gcm,ecb at
+ * the first three places in QCryptoCipherMode, and aes128,
+ * aes192,aes256,des-rfb at the first four places in
+ * QCryptoCipherAlgorithm.
+ */
+#define QCRYPTO_AEAD_ALG__MAX QCRYPTO_CIPHER_ALG_DES_RFB
+#define QCRYPTO_AEAD_MODE__MAX QCRYPTO_CIPHER_MODE_ECB
+
+typedef struct QCryptoAead QCryptoAead;
+struct QCryptoAead {
+    QCryptoCipherAlgorithm alg;
+    QCryptoCipherMode mode;
+    void *opaque;
+};
+
+/**
+ * qcrypto_aead_supports:
+ * @alg: the cipher algorithm
+ * @mode: the cipher mode
+ *
+ * Determine if @alg hmac algorithm is supported by
+ * the current configured build
+ *
+ * Returns:
+ * true if the algorithm is supported, false otherwise
+ */
+bool qcrypto_aead_supports(QCryptoCipherAlgorithm alg,
+                           QCryptoCipherMode mode);
+
+/**
+ * qcrypto_aead_get_key_len:
+ * @alg: the cipher algorithm
+ *
+ * Get the required key size in bytes
+ *
+ * Returns: the key size in bytes
+ */
+size_t qcrypto_aead_get_key_len(QCryptoCipherAlgorithm alg);
+
+/**
+ * qcrypto_aead_new:
+ * @alg: the cipher algorithm
+ * @mode: the cipher usage mode
+ * @key: the private key bytes
+ * @nkey: the length of @key
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Creates a new aead object for encrypting/decrypting
+ * data with the algorithm @alg in the usage mode @mode.
+ *
+ * The returned aead object must be released with
+ * qcrypto_aead_free() when no longer required
+ *
+ * Returns:
+ *  a new aead object, or NULL on error
+ */
+QCryptoAead *qcrypto_aead_new(QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              Error **errp);
+
+/**
+ * qcrypto_aead_free:
+ * @aead: the aead object
+ *
+ * Release the memory associated with @aead that
+ * was previously allocated by qcrypto_aead_new()
+ */
+void qcrypto_aead_free(QCryptoAead *aead);
+
+/**
+ * qcrypto_aead_set_nonce:
+ * @aead: the aead object
+ * @nonce: the nonce/iv data
+ * @nonce_len: the length of @nonce
+ * @aad_len: the length of associated data
+ * @in_len: the length of plain data
+ * @tag_len: the length of authentication tag
+ *
+ * Set the aead object's nonce/iv
+ *
+ * Returns:
+ *  0 if success, or -1 on error
+ */
+int qcrypto_aead_set_nonce(QCryptoAead *aead,
+                           const uint8_t *nonce, size_t nonce_len,
+                           size_t aad_len, size_t in_len,
+                           size_t tag_len,
+                           Error **errp);
+
+/**
+ * qcrypto_aead_authenticate:
+ * @aead: the aead object
+ * @aad: associated data
+ * @aad_len: the length of @add
+ *
+ * Set associated data to be authenticated
+ *
+ * Returns:
+ *  0 if success, or -1 on error
+ */
+int qcrypto_aead_authenticate(QCryptoAead *aead,
+                              const uint8_t *aad, size_t aad_len,
+                              Error **errp);
+
+/**
+ * qcrypto_aead_encrypt:
+ * @aead: the aead object
+ * @in: the plain data
+ * @in_len: the length of @in
+ * @out: the cipher data buffer
+ * @out_len: the length of @out
+ *
+ * Encrypts the input data
+ *
+ * Returns:
+ *  0 if success, or -1 on error
+ */
+int qcrypto_aead_encrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp);
+
+/**
+ * qcrypto_aead_decrypt:
+ * @aead: the aead object
+ * @in: the cipher data
+ * @in_len: the length of @in
+ * @out: the plain data buffer
+ * @out_len: the length of @out
+ *
+ * Decrypts the input data
+ *
+ * Returns:
+ *  0 if success, or -1 on error
+ */
+int qcrypto_aead_decrypt(QCryptoAead *aead,
+                         const uint8_t *in, size_t in_len,
+                         uint8_t *out, size_t out_len,
+                         Error **errp);
+
+/**
+ * qcrypto_aead_get_tag:
+ * @aead: the aead object
+ * @tag: the tag buffer
+ * @tag_len: the length of @tag
+ *
+ * Extracts the authentication tag
+ *
+ * Returns:
+ *  0 if success, or -1 on error
+ */
+int qcrypto_aead_get_tag(QCryptoAead *aead,
+                         uint8_t *tag, size_t tag_len,
+                         Error **errp);
+
+#endif
diff --git a/qapi/crypto.json b/qapi/crypto.json
index f4fd93b..edb2962 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -87,6 +87,8 @@
 #
 # The supported modes for content encryption ciphers
 #
+# @ccm: Counter with CBC-MAC Mode (Since 2.9)
+# @gcm: Galois Counter Mode (Since 2.9)
 # @ecb: Electronic Code Book
 # @cbc: Cipher Block Chaining
 # @xts: XEX with tweaked code book and ciphertext stealing
@@ -95,7 +97,7 @@
 ##
 { 'enum': 'QCryptoCipherMode',
   'prefix': 'QCRYPTO_CIPHER_MODE',
-  'data': ['ecb', 'cbc', 'xts', 'ctr']}
+  'data': ['ccm', 'gcm', 'ecb', 'cbc', 'xts', 'ctr']}
 
 
 ##
-- 
2.9.3
