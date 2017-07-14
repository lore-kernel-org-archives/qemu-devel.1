Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvr-0000uN-So
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1dVyvn-0007i6-Th
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:51 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1dVyvn-0007gb-OR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:38:47 -0400
Received: by mail-pf0-x243.google.com with SMTP id q85so10728147pfq.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:38:46 -0700 (PDT)
From: longpeng.mike@gmail.com
Date: Fri, 14 Jul 2017 07:38:23 -0400
Message-Id: <1500032321-13951-2-git-send-email-longpeng.mike@gmail.com>
In-Reply-To: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
References: <1500032321-13951-1-git-send-email-longpeng.mike@gmail.com>
Subject: [Qemu-devel] [PATCH v5 01/18] crypto: cipher: introduce context
 free function
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

Refactors the qcrypto_cipher_free(), splits it into two parts. One
is gcrypt/nettle__cipher_free_ctx() to free the special context.

This makes code more clear, what's more, it would be used by the
later patch.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-gcrypt.c | 31 ++++++++++++++++++-------------
 crypto/cipher-nettle.c | 18 ++++++++++++++----
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 6487eca..0ecffa2 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -64,6 +64,22 @@ struct QCryptoCipherGcrypt {
     uint8_t *iv;
 };
 
+static void gcrypt_cipher_free_ctx(QCryptoCipherGcrypt *ctx,
+                                   QCryptoCipherMode mode)
+{
+    if (!ctx) {
+        return;
+    }
+
+    gcry_cipher_close(ctx->handle);
+    if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+        gcry_cipher_close(ctx->tweakhandle);
+    }
+    g_free(ctx->iv);
+    g_free(ctx);
+}
+
+
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   QCryptoCipherMode mode,
                                   const uint8_t *key, size_t nkey,
@@ -228,11 +244,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
     return cipher;
 
  error:
-    gcry_cipher_close(ctx->handle);
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
-        gcry_cipher_close(ctx->tweakhandle);
-    }
-    g_free(ctx);
+    gcrypt_cipher_free_ctx(ctx, mode);
     g_free(cipher);
     return NULL;
 }
@@ -240,17 +252,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
 
 void qcrypto_cipher_free(QCryptoCipher *cipher)
 {
-    QCryptoCipherGcrypt *ctx;
     if (!cipher) {
         return;
     }
-    ctx = cipher->opaque;
-    gcry_cipher_close(ctx->handle);
-    if (cipher->mode == QCRYPTO_CIPHER_MODE_XTS) {
-        gcry_cipher_close(ctx->tweakhandle);
-    }
-    g_free(ctx->iv);
-    g_free(ctx);
+    gcrypt_cipher_free_ctx(cipher->opaque, cipher->mode);
     g_free(cipher);
 }
 
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index dfc9030..e04e3a1 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -249,6 +249,19 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 }
 
 
+static void nettle_cipher_free_ctx(QCryptoCipherNettle *ctx)
+{
+    if (!ctx) {
+        return;
+    }
+
+    g_free(ctx->iv);
+    g_free(ctx->ctx);
+    g_free(ctx->ctx_tweak);
+    g_free(ctx);
+}
+
+
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
                                   QCryptoCipherMode mode,
                                   const uint8_t *key, size_t nkey,
@@ -440,10 +453,7 @@ void qcrypto_cipher_free(QCryptoCipher *cipher)
     }
 
     ctx = cipher->opaque;
-    g_free(ctx->iv);
-    g_free(ctx->ctx);
-    g_free(ctx->ctx_tweak);
-    g_free(ctx);
+    nettle_cipher_free_ctx(ctx);
     g_free(cipher);
 }
 
-- 
1.8.3.1
