Received: from eggs.gnu.org ([2001:4830:134:3::10]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyw2-0001Co-2f
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvy-0007q0-H0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:39:02 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyvy-0007pV-8V
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:58 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so10743801pfh.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:38:58 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:33 -0400
Message-Id: <1500032321-13951-12-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v5 11/18] crypto: hmac: add hmac driver
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
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

1) makes the public APIs in hmac-nettle/gcrypt/glib static,
   and rename them with "nettle/gcrypt/glib" prefix.

2) introduces hmac framework, including QCryptoHmacDriver
   and new public APIs.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hmac-gcrypt.c  | 51 ++++++++++++-----------------------
 crypto/hmac-glib.c    | 75 +++++++++++++++++++++------------------------------
 crypto/hmac-nettle.c  | 52 ++++++++++++-----------------------
 crypto/hmac.c         | 44 ++++++++++++++++++++++++++++++
 crypto/hmacpriv.h     | 36 +++++++++++++++++++++++++
 include/crypto/hmac.h |  1 +
 6 files changed, 145 insertions(+), 114 deletions(-)
 create mode 100644 crypto/hmacpriv.h

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 372ad7f..76ca61b 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include "hmacpriv.h"
 #include <gcrypt.h>
 
 static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALG__MAX] = {
@@ -42,10 +43,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
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
@@ -81,27 +81,24 @@ error:
     return NULL;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void
+qcrypto_gcrypt_hmac_ctx_free(QCryptoHmac *hmac)
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
+static int
+qcrypto_gcrypt_hmac_bytesv(QCryptoHmac *hmac,
+                           const struct iovec *iov,
+                           size_t niov,
+                           uint8_t **result,
+                           size_t *resultlen,
+                           Error **errp)
 {
     QCryptoHmacGcrypt *ctx;
     gcry_error_t err;
@@ -147,21 +144,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
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
-    if (!ctx) {
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
+    .hmac_bytesv = qcrypto_gcrypt_hmac_bytesv,
+    .hmac_free = qcrypto_gcrypt_hmac_ctx_free,
+};
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index f0ccfd6..8cf6b22 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include "hmacpriv.h"
 
 /* Support for HMAC Algos has been added in GLib 2.30 */
 #if GLIB_CHECK_VERSION(2, 30, 0)
@@ -49,10 +50,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
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
 
@@ -78,27 +78,24 @@ error:
     return NULL;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void
+qcrypto_glib_hmac_ctx_free(QCryptoHmac *hmac)
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
+static int
+qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
+                         const struct iovec *iov,
+                         size_t niov,
+                         uint8_t **result,
+                         size_t *resultlen,
+                         Error **errp)
 {
     QCryptoHmacGlib *ctx;
     int i, ret;
@@ -129,25 +126,6 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
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
-    if (!ctx) {
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
@@ -155,26 +133,33 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
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
+static void
+qcrypto_glib_hmac_ctx_free(QCryptoHmac *hmac)
 {
     return;
 }
 
-int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int
+qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
+                         const struct iovec *iov,
+                         size_t niov,
+                         uint8_t **result,
+                         size_t *resultlen,
+                         Error **errp)
 {
     return -1;
 }
 
 #endif
+
+QCryptoHmacDriver qcrypto_hmac_lib_driver = {
+    .hmac_bytesv = qcrypto_glib_hmac_bytesv,
+    .hmac_free = qcrypto_glib_hmac_ctx_free,
+};
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 000dfd9..1d5a915 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include "hmacpriv.h"
 #include <nettle/hmac.h>
 
 typedef void (*qcrypto_nettle_hmac_setkey)(void *ctx,
@@ -97,10 +98,9 @@ bool qcrypto_hmac_supports(QCryptoHashAlgorithm alg)
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
 
@@ -117,26 +117,22 @@ qcrypto_hmac_ctx_new(QCryptoHashAlgorithm alg,
     return ctx;
 }
 
-void qcrypto_hmac_free(QCryptoHmac *hmac)
+static void
+qcrypto_nettle_hmac_ctx_free(QCryptoHmac *hmac)
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
+static int
+qcrypto_nettle_hmac_bytesv(QCryptoHmac *hmac,
+                           const struct iovec *iov,
+                           size_t niov,
+                           uint8_t **result,
+                           size_t *resultlen,
+                           Error **errp)
 {
     QCryptoHmacNettle *ctx;
     int i;
@@ -169,21 +165,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
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
-    if (!ctx) {
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
+    .hmac_bytesv = qcrypto_nettle_hmac_bytesv,
+    .hmac_free = qcrypto_nettle_hmac_ctx_free,
+};
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 5750405..a4690e3 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -12,9 +12,22 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hmac.h"
+#include "hmacpriv.h"
 
 static const char hex[] = "0123456789abcdef";
 
+int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    QCryptoHmacDriver *drv = hmac->driver;
+
+    return drv->hmac_bytesv(hmac, iov, niov, result, resultlen, errp);
+}
+
 int qcrypto_hmac_bytes(QCryptoHmac *hmac,
                        const char *buf,
                        size_t len,
@@ -70,3 +83,34 @@ int qcrypto_hmac_digest(QCryptoHmac *hmac,
 
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
+    if (!ctx) {
+        return NULL;
+    }
+
+    hmac = g_new0(QCryptoHmac, 1);
+    hmac->alg = alg;
+    hmac->opaque = ctx;
+    hmac->driver = (void *)&qcrypto_hmac_lib_driver;
+
+    return hmac;
+}
+
+void qcrypto_hmac_free(QCryptoHmac *hmac)
+{
+    QCryptoHmacDriver *drv;
+
+    if (hmac) {
+        drv = hmac->driver;
+        drv->hmac_free(hmac);
+        g_free(hmac);
+    }
+}
diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
new file mode 100644
index 0000000..2be389a
--- /dev/null
+++ b/crypto/hmacpriv.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU Crypto hmac driver supports
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
+#ifndef QCRYPTO_HMACPRIV_H
+#define QCRYPTO_HMACPRIV_H
+
+typedef struct QCryptoHmacDriver QCryptoHmacDriver;
+
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
+#endif
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index 0d3acd7..5e88905 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -18,6 +18,7 @@ typedef struct QCryptoHmac QCryptoHmac;
 struct QCryptoHmac {
     QCryptoHashAlgorithm alg;
     void *opaque;
+    void *driver;
 };
 
 /**
-- 
1.8.3.1
