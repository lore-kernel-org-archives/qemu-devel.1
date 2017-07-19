Received: from eggs.gnu.org ([2001:4830:134:3::10]:38512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXl5p-0000et-0K
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXl5k-0001LK-8W
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXl5j-0001Ke-Ul
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:24 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 19 Jul 2017 10:15:48 +0100
Message-Id: <20170719091600.8555-7-berrange@redhat.com>
In-Reply-To: <20170719091600.8555-1-berrange@redhat.com>
References: <20170719091600.8555-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/18] crypto: hash: add hash driver framework
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

1) makes the public APIs in hash-nettle/gcrypt/glib static,
   and rename them with "nettle/gcrypt/glib" prefix.

2) introduces hash framework, including QCryptoHashDriver
   and new public APIs.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/hash-gcrypt.c | 19 +++++++++++++------
 crypto/hash-glib.c   | 19 +++++++++++++------
 crypto/hash-nettle.c | 19 +++++++++++++------
 crypto/hash.c        | 13 +++++++++++++
 crypto/hashpriv.h    | 31 +++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 18 deletions(-)
 create mode 100644 crypto/hashpriv.h

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 7690690f70..972beaa0f9 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -22,6 +22,7 @@
 #include <gcrypt.h>
 #include "qapi/error.h"
 #include "crypto/hash.h"
+#include "hashpriv.h"
 
 
 static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
@@ -44,12 +45,13 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int
+qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
+                           const struct iovec *iov,
+                           size_t niov,
+                           uint8_t **result,
+                           size_t *resultlen,
+                           Error **errp)
 {
     int i, ret;
     gcry_md_hd_t md;
@@ -107,3 +109,8 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
     gcry_md_close(md);
     return -1;
 }
+
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
+};
diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index ec99ac9df9..a5871cc72f 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hash.h"
+#include "hashpriv.h"
 
 
 static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
@@ -47,12 +48,13 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int
+qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
+                         const struct iovec *iov,
+                         size_t niov,
+                         uint8_t **result,
+                         size_t *resultlen,
+                         Error **errp)
 {
     int i, ret;
     GChecksum *cs;
@@ -95,3 +97,8 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
     g_checksum_free(cs);
     return -1;
 }
+
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_bytesv = qcrypto_glib_hash_bytesv,
+};
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 6a206dcb18..96f186f442 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hash.h"
+#include "hashpriv.h"
 #include <nettle/md5.h>
 #include <nettle/sha.h>
 #include <nettle/ripemd160.h>
@@ -103,12 +104,13 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int
+qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
+                           const struct iovec *iov,
+                           size_t niov,
+                           uint8_t **result,
+                           size_t *resultlen,
+                           Error **errp)
 {
     int i;
     union qcrypto_hash_ctx ctx;
@@ -152,3 +154,8 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
 
     return 0;
 }
+
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_bytesv = qcrypto_nettle_hash_bytesv,
+};
diff --git a/crypto/hash.c b/crypto/hash.c
index 0f1ceac66a..c43fd874fa 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/hash.h"
+#include "hashpriv.h"
 
 static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALG__MAX] = {
     [QCRYPTO_HASH_ALG_MD5] = 16,
@@ -38,6 +39,18 @@ size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)
     return qcrypto_hash_alg_size[alg];
 }
 
+int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
+                        const struct iovec *iov,
+                        size_t niov,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp)
+{
+    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
+                                               result, resultlen,
+                                               errp);
+}
+
 
 int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
                        const char *buf,
diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
new file mode 100644
index 0000000000..5e505e0492
--- /dev/null
+++ b/crypto/hashpriv.h
@@ -0,0 +1,31 @@
+/*
+ * QEMU Crypto hash driver supports
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
+#ifndef QCRYPTO_HASHPRIV_H
+#define QCRYPTO_HASHPRIV_H
+
+typedef struct QCryptoHashDriver QCryptoHashDriver;
+
+struct QCryptoHashDriver {
+    int (*hash_bytesv)(QCryptoHashAlgorithm alg,
+                       const struct iovec *iov,
+                       size_t niov,
+                       uint8_t **result,
+                       size_t *resultlen,
+                       Error **errp);
+};
+
+extern QCryptoHashDriver qcrypto_hash_lib_driver;
+
+#endif
-- 
2.13.0
