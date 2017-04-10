Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBJ-0007t4-Qr
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBF-0001om-3y
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3418
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVBE-0001mf-1v
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:00:13 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 16:59:53 +0800
Message-ID: <1491814793-56832-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 06/19] crypto: hash: add hash driver
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
Cc: xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

1) makes the public APIs in hash-nettle/gcrypt/glib static,
   and rename them with "nettle/gcrypt/glib" prefix.

2) introduces hash framework, including QCryptoHashDriver
   and new public APIs.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/hash-gcrypt.c  | 17 +++++++++++------
 crypto/hash-glib.c    | 17 +++++++++++------
 crypto/hash-nettle.c  | 17 +++++++++++------
 crypto/hash.c         | 12 ++++++++++++
 include/crypto/hash.h | 12 ++++++++++++
 5 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 7690690..21c990f 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -44,12 +44,12 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
+                              const struct iovec *iov,
+                              size_t niov,
+                              uint8_t **result,
+                              size_t *resultlen,
+                              Error **errp)
 {
     int i, ret;
     gcry_md_hd_t md;
@@ -107,3 +107,8 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
     gcry_md_close(md);
     return -1;
 }
+
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_bytesv = gcrypt_hash_bytesv,
+};
diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index ec99ac9..72be47e 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -47,12 +47,12 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int glib_hash_bytesv(QCryptoHashAlgorithm alg,
+                            const struct iovec *iov,
+                            size_t niov,
+                            uint8_t **result,
+                            size_t *resultlen,
+                            Error **errp)
 {
     int i, ret;
     GChecksum *cs;
@@ -95,3 +95,8 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
     g_checksum_free(cs);
     return -1;
 }
+
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_bytesv = glib_hash_bytesv,
+};
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 6a206dc..9233e10 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -103,12 +103,12 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
-                        const struct iovec *iov,
-                        size_t niov,
-                        uint8_t **result,
-                        size_t *resultlen,
-                        Error **errp)
+static int nettle_hash_bytesv(QCryptoHashAlgorithm alg,
+                              const struct iovec *iov,
+                              size_t niov,
+                              uint8_t **result,
+                              size_t *resultlen,
+                              Error **errp)
 {
     int i;
     union qcrypto_hash_ctx ctx;
@@ -152,3 +152,8 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
 
     return 0;
 }
+
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_bytesv = nettle_hash_bytesv,
+};
diff --git a/crypto/hash.c b/crypto/hash.c
index 0f1ceac..0b0d479 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -38,6 +38,18 @@ size_t qcrypto_hash_digest_len(QCryptoHashAlgorithm alg)
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
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index ca3267f..00b764e 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -25,6 +25,18 @@
 
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
+typedef struct QCryptoHashDriver QCryptoHashDriver;
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
 /**
  * qcrypto_hash_supports:
  * @alg: the hash algorithm
-- 
1.8.3.1
