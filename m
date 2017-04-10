Received: from eggs.gnu.org ([2001:4830:134:3::10]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVB9-0007jX-Km
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVB4-0001gv-EJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:07 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3354
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVB3-0001fM-2v
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:02 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 16:59:46 +0800
Message-ID: <1491814786-60036-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 05/19] crypto: cipher: add cipher
 driver framework
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

1) makes the public APIs in cipher-nettle/gcrypt/builtin static,
   and rename them with "nettle/gcrypt/builtin" prefix.

2) introduces cipher framework, including QCryptoCipherDriver
   and new public APIs.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-builtin.c | 59 +++++++++++++++++--------------------------------
 crypto/cipher-gcrypt.c  | 58 +++++++++++++++++-------------------------------
 crypto/cipher-nettle.c  | 59 +++++++++++++++++--------------------------------
 crypto/cipher.c         | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/crypto/cipher.h | 22 ++++++++++++++++++
 5 files changed, 141 insertions(+), 116 deletions(-)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index 8cf47d1..a35f461 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -466,25 +466,20 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     return ctxt;
 }
 
-void qcrypto_cipher_free(QCryptoCipher *cipher)
+static void builtin_cipher_ctx_free(QCryptoCipher *cipher)
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
+static int builtin_cipher_encrypt(QCryptoCipher *cipher,
+                                  const void *in,
+                                  void *out,
+                                  size_t len,
+                                  Error **errp)
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
@@ -498,11 +493,11 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int builtin_cipher_decrypt(QCryptoCipher *cipher,
+                                  const void *in,
+                                  void *out,
+                                  size_t len,
+                                  Error **errp)
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
@@ -516,9 +511,9 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_setiv(QCryptoCipher *cipher,
-                         const uint8_t *iv, size_t niv,
-                         Error **errp)
+static int builtin_cipher_setiv(QCryptoCipher *cipher,
+                                const uint8_t *iv, size_t niv,
+                                Error **errp)
 {
     QCryptoCipherBuiltin *ctxt = cipher->opaque;
 
@@ -526,23 +521,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
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
-    if (ctxt == NULL) {
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
+    .cipher_encrypt = builtin_cipher_encrypt,
+    .cipher_decrypt = builtin_cipher_decrypt,
+    .cipher_setiv = builtin_cipher_setiv,
+    .cipher_free = builtin_cipher_ctx_free,
+};
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 871730b..36a0626 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -244,13 +244,9 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 }
 
 
-void qcrypto_cipher_free(QCryptoCipher *cipher)
+static void gcrypt_cipher_ctx_free(QCryptoCipher *cipher)
 {
-    if (!cipher) {
-        return;
-    }
     gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
-    g_free(cipher);
 }
 
 
@@ -274,11 +270,11 @@ static void qcrypto_gcrypt_xts_decrypt(const void *ctx,
     g_assert(err == 0);
 }
 
-int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int gcrypt_cipher_encrypt(QCryptoCipher *cipher,
+                                 const void *in,
+                                 void *out,
+                                 size_t len,
+                                 Error **errp)
 {
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
@@ -309,11 +305,11 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int gcrypt_cipher_decrypt(QCryptoCipher *cipher,
+                                 const void *in,
+                                 void *out,
+                                 size_t len,
+                                 Error **errp)
 {
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
@@ -343,9 +339,9 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
     return 0;
 }
 
-int qcrypto_cipher_setiv(QCryptoCipher *cipher,
-                         const uint8_t *iv, size_t niv,
-                         Error **errp)
+static int gcrypt_cipher_setiv(QCryptoCipher *cipher,
+                               const uint8_t *iv, size_t niv,
+                               Error **errp)
 {
     QCryptoCipherGcrypt *ctx = cipher->opaque;
     gcry_error_t err;
@@ -381,23 +377,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
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
-    if (ctx == NULL) {
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
+    .cipher_encrypt = gcrypt_cipher_encrypt,
+    .cipher_decrypt = gcrypt_cipher_decrypt,
+    .cipher_setiv = gcrypt_cipher_setiv,
+    .cipher_free = gcrypt_cipher_ctx_free,
+};
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index e6d6e6c..6373f3f 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -439,25 +439,20 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 }
 
 
-void qcrypto_cipher_free(QCryptoCipher *cipher)
+static void nettle_cipher_ctx_free(QCryptoCipher *cipher)
 {
     QCryptoCipherNettle *ctx;
 
-    if (!cipher) {
-        return;
-    }
-
     ctx = cipher->opaque;
     nettle_cipher_free_ctx(ctx);
-    g_free(cipher);
 }
 
 
-int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int nettle_cipher_encrypt(QCryptoCipher *cipher,
+                                 const void *in,
+                                 void *out,
+                                 size_t len,
+                                 Error **errp)
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
@@ -499,11 +494,11 @@ int qcrypto_cipher_encrypt(QCryptoCipher *cipher,
 }
 
 
-int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
-                           const void *in,
-                           void *out,
-                           size_t len,
-                           Error **errp)
+static int nettle_cipher_decrypt(QCryptoCipher *cipher,
+                                 const void *in,
+                                 void *out,
+                                 size_t len,
+                                 Error **errp)
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
 
@@ -543,9 +538,9 @@ int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
     return 0;
 }
 
-int qcrypto_cipher_setiv(QCryptoCipher *cipher,
-                         const uint8_t *iv, size_t niv,
-                         Error **errp)
+static int nettle_cipher_setiv(QCryptoCipher *cipher,
+                               const uint8_t *iv, size_t niv,
+                               Error **errp)
 {
     QCryptoCipherNettle *ctx = cipher->opaque;
     if (niv != ctx->blocksize) {
@@ -558,23 +553,9 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
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
+    .cipher_encrypt = nettle_cipher_encrypt,
+    .cipher_decrypt = nettle_cipher_decrypt,
+    .cipher_setiv = nettle_cipher_setiv,
+    .cipher_free = nettle_cipher_ctx_free,
+};
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 5a96489..fa31f2f 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -155,3 +155,62 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
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
+    if (ctx == NULL) {
+        return NULL;
+    }
+
+    cipher = g_new0(QCryptoCipher, 1);
+    cipher->alg = alg;
+    cipher->mode = mode;
+    cipher->opaque = ctx;
+    cipher->driver = &qcrypto_cipher_lib_driver;
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
+    return cipher->driver->cipher_encrypt(cipher, in, out, len, errp);
+}
+
+
+int qcrypto_cipher_decrypt(QCryptoCipher *cipher,
+                           const void *in,
+                           void *out,
+                           size_t len,
+                           Error **errp)
+{
+    return cipher->driver->cipher_decrypt(cipher, in, out, len, errp);
+}
+
+
+int qcrypto_cipher_setiv(QCryptoCipher *cipher,
+                         const uint8_t *iv, size_t niv,
+                         Error **errp)
+{
+    return cipher->driver->cipher_setiv(cipher, iv, niv, errp);
+}
+
+
+void qcrypto_cipher_free(QCryptoCipher *cipher)
+{
+    if (cipher) {
+        cipher->driver->cipher_free(cipher);
+        g_free(cipher);
+    }
+}
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index bec9f41..32b6065 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -23,6 +23,7 @@
 
 #include "qapi-types.h"
 
+typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 typedef struct QCryptoCipher QCryptoCipher;
 
 /* See also "QCryptoCipherAlgorithm" and "QCryptoCipherMode"
@@ -76,7 +77,28 @@ typedef struct QCryptoCipher QCryptoCipher;
  *
  */
 
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
 struct QCryptoCipher {
+    QCryptoCipherDriver *driver;
     QCryptoCipherAlgorithm alg;
     QCryptoCipherMode mode;
     void *opaque;
-- 
1.8.3.1
