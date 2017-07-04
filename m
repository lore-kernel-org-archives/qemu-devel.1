Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJef-0005DO-5e
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJec-0005fI-G4
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJeb-0005cN-Iv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:54 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 4 Jul 2017 16:56:57 +0800
Message-ID: <1499158630-75260-6-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 05/18] crypto: cipher: add cipher driver
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
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com, "Longpeng(Mike)" <longpeng2@huawei.com>

1) makes the public APIs in cipher-nettle/gcrypt/builtin static,
   and rename them with "nettle/gcrypt/builtin" prefix.

2) introduces cipher framework, including QCryptoCipherDriver
   and new public APIs.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-builtin.c | 64 +++++++++++++++++--------------------------
 crypto/cipher-gcrypt.c  | 72 +++++++++++++++++++++----------------------------
 crypto/cipher-nettle.c  | 71 ++++++++++++++++++++----------------------------
 crypto/cipher.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
 crypto/cipherpriv.h     | 40 +++++++++++++++++++++++++++
 include/crypto/cipher.h |  1 +
 6 files changed, 190 insertions(+), 123 deletions(-)
 create mode 100644 crypto/cipherpriv.h

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 4ecd15e..16a36d4 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -22,6 +22,7 @@
 #include "crypto/aes.h"
 #include "crypto/desrfb.h"
 #include "crypto/xts.h"
+#include "cipherpriv.h"
 
 typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
 struct QCryptoCipherBuiltinAESContext {
@@ -466,25 +467,22 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     return ctxt;
 }
 
-void qcrypto_cipher_free(QCryptoCipher *cipher)
+static void
+qcrypto_builtin_cipher_ctx_free(QCryptoCipher *cipher)
 {
     QCryptoCipherBuiltin *ctxt;
 
-    if (!cipher) {
-        return;
-    }
-
     ctxt = cipher->opaque;
     ctxt->free(cipher);
-    g_free(cipher);
 }
 
 
-int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int
+qcrypto_builtin_cipher_encrypt(QCryptoCipher *cipher,
+                               const void *in,
+                               void *out,
+                               size_t len,
+                               Error **errp)
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
@@ -498,11 +496,12 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int
+qcrypto_builtin_cipher_decrypt(QCryptoCipher *cipher,
+                               const void *in,
+                               void *out,
+                               size_t len,
+                               Error **errp)
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
@@ -516,9 +515,10 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_setiv(QCryptoCipher *cipher,
-                         const uint8_t *iv, size_t niv,
-                         Error **errp)
+static int
+qcrypto_builtin_cipher_setiv(QCryptoCipher *cipher,
+                             const uint8_t *iv, size_t niv,
+                             Error **errp)
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
@@ -526,23 +526,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-                                  QCryptoCipherMode mode,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp)
-{
-    QCryptoCipher *cipher;
-    QCryptoCipherBuiltin *ctxt;
-
-    ctxt = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
-    if (!ctxt) {
-        return NULL;
-    }
-
-    cipher = g_new0(QCryptoCipher, 1);
-    cipher->alg = alg;
-    cipher->mode = mode;
-    cipher->opaque = ctxt;
-
-    return cipher;
-}
+static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+    .cipher_encrypt = qcrypto_builtin_cipher_encrypt,
+    .cipher_decrypt = qcrypto_builtin_cipher_decrypt,
+    .cipher_setiv = qcrypto_builtin_cipher_setiv,
+    .cipher_free = qcrypto_builtin_cipher_ctx_free,
+};
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 4939386..0489147 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "crypto/xts.h"
+#include "cipherpriv.h"
 
 #include <gcrypt.h>
 
@@ -64,8 +65,9 @@ struct QCryptoCipherGcrypt {
     uint8_t *iv;
 };
 
-static void gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
-                                   QCryptoCipherMode mode)
+static void
+qcrypto_gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
+                               QCryptoCipherMode mode)
 {
     if (!ctx) {
         return;
@@ -239,18 +241,15 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     return ctx;
 
  error:
-    gcrypt_cipher_free_ctx(ctx, mode);
+    qcrypto_gcrypt_cipher_free_ctx(ctx, mode);
     return NULL;
 }
 
 
-void qcrypto_cipher_free(QCryptoCipher *cipher)
+static void
+qcrypto_gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    if (!cipher) {
-        return;
-    }
-    gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
-    g_free(cipher);
+    qcrypto_gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
 }
 
 
@@ -274,11 +273,12 @@ static void qcrypto_gcrypt_xts_decrypt(const void *ctx,
     g_assert(err == 0);
 }
 
-int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int
+qcrypto_gcrypt_cipher_encrypt(QCryptoCipher *cipher,
+                              const void *in,
+                              void *out,
+                              size_t len,
+                              Error **errp)
 {
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
@@ -309,11 +309,12 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int
+qcrypto_gcrypt_cipher_decrypt(QCryptoCipher *cipher,
+                              const void *in,
+                              void *out,
+                              size_t len,
+                              Error **errp)
 {
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
@@ -343,9 +344,10 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
     return 0;
 }
 
-int qcrypto_cipher_setiv(QCryptoCipher *cipher,
-                         const uint8_t *iv, size_t niv,
-                         Error **errp)
+static int
+qcrypto_gcrypt_cipher_setiv(QCryptoCipher *cipher,
+                            const uint8_t *iv, size_t niv,
+                            Error **errp)
 {
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
@@ -381,23 +383,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-                                  QCryptoCipherMode mode,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp)
-{
-    QCryptoCipher *cipher;
-    QCryptoCipherGcrypt *ctx;
-
-    ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
-    if (!ctx) {
-        return NULL;
-    }
-
-    cipher = g_new0(QCryptoCipher, 1);
-    cipher->alg = alg;
-    cipher->mode = mode;
-    cipher->opaque = ctx;
-
-    return cipher;
-}
+static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+    .cipher_encrypt = qcrypto_gcrypt_cipher_encrypt,
+    .cipher_decrypt = qcrypto_gcrypt_cipher_decrypt,
+    .cipher_setiv = qcrypto_gcrypt_cipher_setiv,
+    .cipher_free = qcrypto_gcrypt_cipher_ctx_free,
+};
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index e6d6e6c..c51f119 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "crypto/xts.h"
+#include "cipherpriv.h"
 
 #include <nettle/nettle-types.h>
 #include <nettle/aes.h>
@@ -249,7 +250,8 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 }
 
 
-static void nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
+static void
+qcrypto_nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
 {
     if (!ctx) {
         return;
@@ -434,30 +436,27 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     return ctx;
 
  error:
-    nettle_cipher_free_ctx(ctx);
+    qcrypto_nettle_cipher_free_ctx(ctx);
     return NULL;
 }
 
 
-void qcrypto_cipher_free(QCryptoCipher *cipher)
+static void
+qcrypto_nettle_cipher_ctx_free(QCryptoCipher *cipher)
 {
     QCryptoCipherNettle *ctx;
 
-    if (!cipher) {
-        return;
-    }
-
     ctx = cipher->opaque;
-    nettle_cipher_free_ctx(ctx);
-    g_free(cipher);
+    qcrypto_nettle_cipher_free_ctx(ctx);
 }
 
 
-int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int
+qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
+                              const void *in,
+                              void *out,
+                              size_t len,
+                              Error **errp)
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
@@ -499,11 +498,12 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int
+qcrypto_nettle_cipher_decrypt(QCryptoCipher *cipher,
+                              const void *in,
+                              void *out,
+                              size_t len,
+                              Error **errp)
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
@@ -543,9 +543,10 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
     return 0;
 }
 
-int qcrypto_cipher_setiv(QCryptoCipher *cipher,
-                         const uint8_t *iv, size_t niv,
-                         Error **errp)
+static int
+qcrypto_nettle_cipher_setiv(QCryptoCipher *cipher,
+                            const uint8_t *iv, size_t niv,
+                            Error **errp)
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
     if (niv != ctx->blocksize) {
@@ -558,23 +559,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
 }
 
 
-QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-                                  QCryptoCipherMode mode,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp)
-{
-    QCryptoCipher *cipher;
-    QCryptoCipherNettle *ctx;
-
-    ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
-    if (!ctx) {
-        return NULL;
-    }
-
-    cipher = g_new0(QCryptoCipher, 1);
-    cipher->alg = alg;
-    cipher->mode = mode;
-    cipher->opaque = ctx;
-
-    return cipher;
-}
+static struct QCryptoCipherDriver qcrypto_cipher_lib_driver = {
+    .cipher_encrypt = qcrypto_nettle_cipher_encrypt,
+    .cipher_decrypt = qcrypto_nettle_cipher_decrypt,
+    .cipher_setiv = qcrypto_nettle_cipher_setiv,
+    .cipher_free = qcrypto_nettle_cipher_ctx_free,
+};
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 5a96489..0a3d2e5 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/cipher.h"
+#include "cipherpriv.h"
 
 
 static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
@@ -155,3 +156,67 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
 #else
 #include "crypto/cipher-builtin.c"
 #endif
+
+QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
+                                  QCryptoCipherMode mode,
+                                  const uint8_t *key, size_t nkey,
+                                  Error **errp)
+{
+    QCryptoCipher *cipher;
+    void *ctx;
+
+    ctx = qcrypto_cipher_ctx_new(alg, mode, key, nkey, errp);
+    if (!ctx) {
+        return NULL;
+    }
+
+    cipher = g_new0(QCryptoCipher, 1);
+    cipher->alg = alg;
+    cipher->mode = mode;
+    cipher->opaque = ctx;
+    cipher->driver = (void *)&qcrypto_cipher_lib_driver;
+
+    return cipher;
+}
+
+
+int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
+                           const void *in,
+                           void *out,
+                           size_t len,
+                           Error **errp)
+{
+    QCryptoCipherDriver *drv = cipher->driver;
+    return drv->cipher_encrypt(cipher, in, out, len, errp);
+}
+
+
+int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
+                           const void *in,
+                           void *out,
+                           size_t len,
+                           Error **errp)
+{
+    QCryptoCipherDriver *drv = cipher->driver;
+    return drv->cipher_decrypt(cipher, in, out, len, errp);
+}
+
+
+int qcrypto_cipher_setiv(QCryptoCipher *cipher,
+                         const uint8_t *iv, size_t niv,
+                         Error **errp)
+{
+    QCryptoCipherDriver *drv = cipher->driver;
+    return drv->cipher_setiv(cipher, iv, niv, errp);
+}
+
+
+void qcrypto_cipher_free(QCryptoCipher *cipher)
+{
+    QCryptoCipherDriver *drv;
+    if (cipher) {
+        drv = cipher->driver;
+        drv->cipher_free(cipher);
+        g_free(cipher);
+    }
+}
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
new file mode 100644
index 0000000..4af5e85
--- /dev/null
+++ b/crypto/cipherpriv.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU Crypto cipher driver supports
+ *
+ * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
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
+#ifndef QCRYPTO_CIPHERPRIV_H
+#define QCRYPTO_CIPHERPRIV_H
+
+typedef struct QCryptoCipherDriver QCryptoCipherDriver;
+
+struct QCryptoCipherDriver {
+    int (*cipher_encrypt)(QCryptoCipher *cipher,
+                          const void *in,
+                          void *out,
+                          size_t len,
+                          Error **errp);
+
+    int (*cipher_decrypt)(QCryptoCipher *cipher,
+                          const void *in,
+                          void *out,
+                          size_t len,
+                          Error **errp);
+
+    int (*cipher_setiv)(QCryptoCipher *cipher,
+                        const uint8_t *iv, size_t niv,
+                        Error **errp);
+
+    void (*cipher_free)(QCryptoCipher *cipher);
+};
+
+#endif
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index bec9f41..984fb82 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -80,6 +80,7 @@ struct QCryptoCipher {
     QCryptoCipherAlgorithm alg;
     QCryptoCipherMode mode;
     void *opaque;
+    void *driver;
 };
 
 /**
-- 
1.8.3.1
