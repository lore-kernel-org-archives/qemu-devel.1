Received: from eggs.gnu.org ([2001:4830:134:3::10]:40809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXgJ-0005S8-1j
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXgF-0001ho-Rk
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:34:27 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:56789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEXgE-0001eF-VO
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:34:23 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Wed, 7 Dec 2016 16:33:41 +0800
Message-ID: <1481099622-188132-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
References: <1481099622-188132-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 1/2] crypto: add 3des-ede support when
 using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, wu.wubin@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
support when using libgcrypt or nettle.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 crypto/cipher-gcrypt.c     |  6 ++++++
 crypto/cipher-nettle.c     | 37 +++++++++++++++++++++++++++++++++++++
 crypto/cipher.c            |  7 +++++--
 qapi/crypto.json           |  3 ++-
 tests/test-crypto-cipher.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index c550db9..5dd0db1 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -29,6 +29,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 {
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+    case QCRYPTO_CIPHER_ALG_3DES_EDE:
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
@@ -99,6 +100,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         gcryalg = GCRY_CIPHER_DES;
         break;
 
+    case QCRYPTO_CIPHER_ALG_3DES_EDE:
+        gcryalg = GCRY_CIPHER_3DES;
+        break;
+
     case QCRYPTO_CIPHER_ALG_AES_128:
         gcryalg = GCRY_CIPHER_AES128;
         break;
@@ -200,6 +205,7 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         case QCRYPTO_CIPHER_ALG_TWOFISH_256:
             ctx->blocksize = 16;
             break;
+        case QCRYPTO_CIPHER_ALG_3DES_EDE:
         case QCRYPTO_CIPHER_ALG_CAST5_128:
             ctx->blocksize = 8;
             break;
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index cd094cd..0353b4d 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -78,6 +78,18 @@ static void des_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
     des_decrypt(ctx, length, dst, src);
 }
 
+static void des3_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    des3_encrypt(ctx, length, dst, src);
+}
+
+static void des3_decrypt_native(cipher_ctx_t ctx, cipher_length_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    des3_decrypt(ctx, length, dst, src);
+}
+
 static void cast128_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                    uint8_t *dst, const uint8_t *src)
 {
@@ -140,6 +152,18 @@ static void des_decrypt_wrapper(const void *ctx, size_t length,
     des_decrypt(ctx, length, dst, src);
 }
 
+static void des3_encrypt_wrapper(const void *ctx, size_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    des3_encrypt(ctx, length, dst, src);
+}
+
+static void des3_decrypt_wrapper(const void *ctx, size_t length,
+                                uint8_t *dst, const uint8_t *src)
+{
+    des3_decrypt(ctx, length, dst, src);
+}
+
 static void cast128_encrypt_wrapper(const void *ctx, size_t length,
                                     uint8_t *dst, const uint8_t *src)
 {
@@ -197,6 +221,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 {
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+    case QCRYPTO_CIPHER_ALG_3DES_EDE:
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
@@ -270,6 +295,18 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         ctx->blocksize = DES_BLOCK_SIZE;
         break;
 
+    case QCRYPTO_CIPHER_ALG_3DES_EDE:
+        ctx->ctx = g_new0(struct des3_ctx, 1);
+        des3_set_key(ctx->ctx, key);
+
+        ctx->alg_encrypt_native = des3_encrypt_native;
+        ctx->alg_decrypt_native = des3_decrypt_native;
+        ctx->alg_encrypt_wrapper = des3_encrypt_wrapper;
+        ctx->alg_decrypt_wrapper = des3_decrypt_wrapper;
+
+        ctx->blocksize = DES3_BLOCK_SIZE;
+        break;
+
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
diff --git a/crypto/cipher.c b/crypto/cipher.c
index a9bca41..97147b1 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -28,6 +28,7 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_192] = 24,
     [QCRYPTO_CIPHER_ALG_AES_256] = 32,
     [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
+    [QCRYPTO_CIPHER_ALG_3DES_EDE] = 24,
     [QCRYPTO_CIPHER_ALG_CAST5_128] = 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_192] = 24,
@@ -42,6 +43,7 @@ static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_192] = 16,
     [QCRYPTO_CIPHER_ALG_AES_256] = 16,
     [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
+    [QCRYPTO_CIPHER_ALG_3DES_EDE] = 8,
     [QCRYPTO_CIPHER_ALG_CAST5_128] = 8,
     [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_192] = 16,
@@ -107,8 +109,9 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgorithm alg,
     }
 
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
-            error_setg(errp, "XTS mode not compatible with DES-RFB");
+        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB
+                || alg == QCRYPTO_CIPHER_ALG_3DES_EDE) {
+            error_setg(errp, "XTS mode not compatible with DES-RFB/3DES-EDE");
             return false;
         }
         if (nkey % 2) {
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 5c9d7d4..848b6cd 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -63,6 +63,7 @@
 # @aes-192: AES with 192 bit / 24 byte keys
 # @aes-256: AES with 256 bit / 32 byte keys
 # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
+# @3des-ede: 3DES-EDE with 192 bit / 24 byte keys
 # @cast5-128: Cast5 with 128 bit / 16 byte keys
 # @serpent-128: Serpent with 128 bit / 16 byte keys
 # @serpent-192: Serpent with 192 bit / 24 byte keys
@@ -75,7 +76,7 @@
 { 'enum': 'QCryptoCipherAlgorithm',
   'prefix': 'QCRYPTO_CIPHER_ALG',
   'data': ['aes-128', 'aes-192', 'aes-256',
-           'des-rfb',
+           'des-rfb', '3des-ede',
            'cast5-128',
            'serpent-128', 'serpent-192', 'serpent-256',
            'twofish-128', 'twofish-192', 'twofish-256']}
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index 5d9e535..8874b61 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -165,6 +165,50 @@ static QCryptoCipherTestData test_data[] = {
             "ffd29f1bb5596ad94ea2d8e6196b7f09"
             "30d8ed0bf2773af36dd82a6280c20926",
     },
+#if defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)
+    {
+        /* Borrowed from linux-kernel crypto/testmgr.h */
+        .path = "/crypto/cipher/3des-ede-cbc",
+        .alg = QCRYPTO_CIPHER_ALG_3DES_EDE,
+        .mode = QCRYPTO_CIPHER_MODE_CBC,
+        .key =
+            "e9c0ff2e760b6424444d995a12d640c0"
+            "eac284e81495dbe8",
+        .iv =
+            "7d3388930f93b242",
+        .plaintext =
+            "6f54206f614d796e5320636565727374"
+            "54206f6f4d206e612079655372637465"
+            "20736f54206f614d796e532063656572"
+            "737454206f6f4d206e61207965537263"
+            "746520736f54206f614d796e53206365"
+            "6572737454206f6f4d206e6120796553"
+            "7263746520736f54206f614d796e5320"
+            "63656572737454206f6f4d206e610a79",
+        .ciphertext =
+            "0e2db6973c5633f4671721c76e8ad549"
+            "74b34905c51cd0ed12565c5396b6007d"
+            "9048fcf58d2939cc8ad5351836234ed7"
+            "76d1da0c9467bb048bf2036ca8cfb6ea"
+            "226447aa8f7513bf9fc2c3f0c956c57a"
+            "71632e897b1e12cae25fafd8a4f8c97a"
+            "d6f92131624445a6d6bc5ad32d5443cc"
+            "9ddea570e942458a6bfab19113b0d919",
+    },
+    {
+        /* Borrowed from linux-kernel crypto/testmgr.h */
+        .path = "/crypto/cipher/3des-ede-ecb",
+        .alg = QCRYPTO_CIPHER_ALG_3DES_EDE,
+        .mode = QCRYPTO_CIPHER_MODE_ECB,
+        .key =
+            "0123456789abcdef5555555555555555"
+            "fedcba9876543210",
+        .plaintext =
+            "736f6d6564617461",
+        .ciphertext =
+            "18d748e563620572",
+    },
+#endif
     {
         /* RFC 2144, Appendix B.1 */
         .path = "/crypto/cipher/cast5-128",
-- 
1.8.3.1
