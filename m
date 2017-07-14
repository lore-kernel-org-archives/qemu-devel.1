Received: from eggs.gnu.org ([2001:4830:134:3::10]:55127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dW4wu-0005C8-VI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dW4wt-00035c-Pq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:20 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dW4wt-00034t-Jo
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:04:19 -0400
Received: by mail-pg0-x244.google.com with SMTP id y129so11394210pgy.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:04:19 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 14:03:56 -0400
Message-Id: <1500055451-14041-4-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500055451-14041-1-git-send-email-longpeng.mike@gmail.com>
References: <1500055451-14041-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v6 03/18] crypto: cipher: introduce
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
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, weidong.huang@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

Extracts qcrypto_cipher_ctx_new() from qcrypto_cipher_new() for
nettle-backend impls.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
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
