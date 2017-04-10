Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVAr-0007Ve-4P
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVAo-0001cB-E7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:59:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3417
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVAn-0001b5-M9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 04:59:46 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 16:59:33 +0800
Message-ID: <1491814773-60036-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 03/19] crypto: cipher: introduce
 qcrypto_cipher_ctx_new for nettle-backend
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

Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
nettle-backend impls.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-nettle.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index e04e3a1..e6d6e6c 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -262,12 +262,12 @@ static void nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
 }
 
 
-QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-                                  QCryptoCipherMode mode,
-                                  const uint8_t *key, size_t nkey,
-                                  Error **errp)
+static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
+                                                   QCryptoCipherMode mode,
+                                                   const uint8_t *key,
+                                                   size_t nkey,
+                                                   Error **errp)
 {
-    QCryptoCipher *cipher;
     QCryptoCipherNettle *ctx;
     uint8_t *rfbkey;
 
@@ -287,12 +287,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         return NULL;
     }
 
-    cipher = g_new0(QCryptoCipher, 1);
-    cipher->alg = alg;
-    cipher->mode = mode;
-
     ctx = g_new0(QCryptoCipherNettle, 1);
-    cipher->opaque = ctx;
 
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
@@ -436,10 +431,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
 
     ctx->iv = g_new0(uint8_t, ctx->blocksize);
 
-    return cipher;
+    return ctx;
 
  error:
-    qcrypto_cipher_free(cipher);
+    nettle_cipher_free_ctx(ctx);
     return NULL;
 }
 
@@ -561,3 +556,25 @@ int qcrypto_cipher_setiv(QCryptoCipher *cipher,
     memcpy(ctx->iv, iv, niv);
     return 0;
 }
+
+
+QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
+                                  QCryptoCipherMode mode,
+                                  const uint8_t *key, size_t nkey,
+                                  Error **errp)
+{
+    QCryptoCipher *cipher;
+    QCryptoCipherNettle *ctx;
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
+
+    return cipher;
+}
-- 
1.8.3.1
