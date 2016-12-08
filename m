Received: from eggs.gnu.org ([2001:4830:134:3::10]:43750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEoXF-0001Zz-MI
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEoXC-0006vP-EX
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:34:13 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:54692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cEoXB-0006eY-Go
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:34:10 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Thu, 8 Dec 2016 10:33:28 +0800
Message-ID: <1481164408-194252-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v2] crypto: add 3des-ede support when
 using libgcrypt/nettle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

Libgcrypt and nettle support 3des-ede, so this patch add 3des-ede
support when using libgcrypt or nettle.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
Changes since v1:
    - rename 3des-ede to 3des. [Daniel]
    - add (since 2.9) in comment. [Gonglei]
    - add ctr(3des) testcase. [Gonglei]
    - split original patchset. [Gonglei]

---
 crypto/cipher-gcrypt.c     |   6 +++
 crypto/cipher-nettle.c     |  37 ++++++++++++++
 crypto/cipher.c            |   7 ++-
 qapi/crypto.json           |   3 +-
 tests/test-crypto-cipher.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 3 deletions(-)

diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index c550db9..6487eca 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -29,6 +29,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
 {
     switch (alg) {
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+    case QCRYPTO_CIPHER_ALG_3DES:
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
@@ -99,6 +100,10 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         gcryalg = GCRY_CIPHER_DES;
         break;
 
+    case QCRYPTO_CIPHER_ALG_3DES:
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
+        case QCRYPTO_CIPHER_ALG_3DES:
         case QCRYPTO_CIPHER_ALG_CAST5_128:
             ctx->blocksize = 8;
             break;
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index cd094cd..781c11d 100644
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
+    case QCRYPTO_CIPHER_ALG_3DES:
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
@@ -270,6 +295,18 @@ QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
         ctx->blocksize = DES_BLOCK_SIZE;
         break;
 
+    case QCRYPTO_CIPHER_ALG_3DES:
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
index a9bca41..9ecaff7 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -28,6 +28,7 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_192] = 24,
     [QCRYPTO_CIPHER_ALG_AES_256] = 32,
     [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
+    [QCRYPTO_CIPHER_ALG_3DES] = 24,
     [QCRYPTO_CIPHER_ALG_CAST5_128] = 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_192] = 24,
@@ -42,6 +43,7 @@ static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_192] = 16,
     [QCRYPTO_CIPHER_ALG_AES_256] = 16,
     [QCRYPTO_CIPHER_ALG_DES_RFB] = 8,
+    [QCRYPTO_CIPHER_ALG_3DES] = 8,
     [QCRYPTO_CIPHER_ALG_CAST5_128] = 8,
     [QCRYPTO_CIPHER_ALG_SERPENT_128] = 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_192] = 16,
@@ -107,8 +109,9 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgorithm alg,
     }
 
     if (mode == QCRYPTO_CIPHER_MODE_XTS) {
-        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB) {
-            error_setg(errp, "XTS mode not compatible with DES-RFB");
+        if (alg == QCRYPTO_CIPHER_ALG_DES_RFB
+                || alg == QCRYPTO_CIPHER_ALG_3DES) {
+            error_setg(errp, "XTS mode not compatible with DES-RFB/3DES");
             return false;
         }
         if (nkey % 2) {
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 15d296e..f4fd93b 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -63,6 +63,7 @@
 # @aes-192: AES with 192 bit / 24 byte keys
 # @aes-256: AES with 256 bit / 32 byte keys
 # @des-rfb: RFB specific variant of single DES. Do not use except in VNC.
+# @3des: 3DES(EDE) with 192 bit / 24 byte keys (since 2.9)
 # @cast5-128: Cast5 with 128 bit / 16 byte keys
 # @serpent-128: Serpent with 128 bit / 16 byte keys
 # @serpent-192: Serpent with 192 bit / 24 byte keys
@@ -75,7 +76,7 @@
 { 'enum': 'QCryptoCipherAlgorithm',
   'prefix': 'QCRYPTO_CIPHER_ALG',
   'data': ['aes-128', 'aes-192', 'aes-256',
-           'des-rfb',
+           'des-rfb', '3des',
            'cast5-128',
            'serpent-128', 'serpent-192', 'serpent-256',
            'twofish-128', 'twofish-192', 'twofish-256']}
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index 5d9e535..07fa2fa 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -165,6 +165,125 @@ static QCryptoCipherTestData test_data[] = {
             "ffd29f1bb5596ad94ea2d8e6196b7f09"
             "30d8ed0bf2773af36dd82a6280c20926",
     },
+#if defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)
+    {
+        /* Borrowed from linux-kernel crypto/testmgr.h */
+        .path = "/crypto/cipher/3des-cbc",
+        .alg = QCRYPTO_CIPHER_ALG_3DES,
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
+        .path = "/crypto/cipher/3des-ecb",
+        .alg = QCRYPTO_CIPHER_ALG_3DES,
+        .mode = QCRYPTO_CIPHER_MODE_ECB,
+        .key =
+            "0123456789abcdef5555555555555555"
+            "fedcba9876543210",
+        .plaintext =
+            "736f6d6564617461",
+        .ciphertext =
+            "18d748e563620572",
+    },
+    {
+        /* Borrowed from linux-kernel crypto/testmgr.h */
+        .path = "/crypto/cipher/3des-ctr",
+        .alg = QCRYPTO_CIPHER_ALG_3DES,
+        .mode = QCRYPTO_CIPHER_MODE_CTR,
+        .key =
+            "9cd6f39cb95a67005a67002dceeb2dce"
+            "ebb45172b451721f",
+        .iv =
+            "ffffffffffffffff",
+        .plaintext =
+            "05ec77fb42d559208b128669f05bcf56"
+            "39ad349f66ea7dc448d3ba0db118e34a"
+            "fe41285c278e11856cf75ec2553ca00b"
+            "9265e970db4fd6b900b41fe649fd442f"
+            "533a8d149863ca5dc1a833a70e9178ec"
+            "77de42d5bc078b12e54cf05b22563980"
+            "6b9f66c950c4af36ba0d947fe34add41"
+            "28b31a8e11f843f75e21553c876e9265"
+            "cc57dba235b900eb72e649d0442fb619"
+            "8d14ff46ca5d24a8339a6d9178c377de"
+            "a108bc07ee71e54cd75b22b51c806bf2"
+            "45c9503baf369960947fc64adda40fb3"
+            "1aed74f8432a5e218813876ef158cc57"
+            "3ea2359c67eb72c549d0bb02b619e04b"
+            "ff46295d248f169a6df45fc3aa3da108"
+            "937aee71d84cd7be01b51ce74ef2452c"
+            "503b82159960cb52c6a930a40f9679ed"
+            "74df432abd048813fa4df15823573e81"
+            "689c67ce51c5ac37bb02957ce04bd246"
+            "29b01b8f16f940f45f26aa3d846f937a"
+            "cd54d8a30abe01e873e74ed1452cb71e"
+            "8215fc47cb5225a9309b629679c074df"
+            "a609bd04ef76fa4dd458238a1d8168f3"
+            "5ace5138ac379e61957cc74bd2a50cb0"
+            "1be275f9402b5f268910846ff659cd54"
+            "3fa30a9d64e873da4ed1b803b71ee148"
+            "fc472e52258c179b62f55cc0ab32a609"
+            "907bef76d94dd4bf068a1de44ff35a2d"
+            "5138836a9e61c853c7ae31a50c977ee2"
+            "75dc402bb2058910fb42f65920543f86"
+            "699d64cf56daad34b803ea7de148d347",
+        .ciphertext =
+            "07c20820721f49ef19cd6f3253052215"
+            "a2852bdb85d2d8b9dd0d1b45cb6911d4"
+            "eabeb2455d0caebea0c127ac659f537e"
+            "afc21bb5b86d360c25c0f86d0b2901da"
+            "1378dc89121243faf612ef8d87627883"
+            "e2be41204c6d351bd10c30cfe2de2b03"
+            "bf4573d4e55995d1b39b276297bdde7f"
+            "a4d23980aa5023f074883da86a18793b"
+            "c4966c8d2240926ed6ad2a1fde63c0e7"
+            "07f72df7b5f3f0cc017c2a9bc210caaa"
+            "fd2b3fc5f3f6fc9b45db53e45bf3c97b"
+            "8e52ffc802b8ac9da10039da3d2d0e01"
+            "097d8d5ebe53b9b08ee7e2966ab278ea"
+            "de238ba5fa5ce3dabf8e316a55d16ab2"
+            "b5466fa5f0eeba1f9f98b0664fd03fa9"
+            "df5f58c4f4ff755c403a097e6e1c97d4"
+            "cce7e771cf0b150871fa0797cde6ca1d"
+            "14280ccf99137af1ebfafa9207de1da1"
+            "d33669fe514d9f2e83374f1f4830ed04"
+            "4da4ef3aca76f41c418f6337782f86a6"
+            "ef417ed2af88ab675271c38ef8269372"
+            "aad60ee70b46b13ab408a9a8a0cf200c"
+            "52bc8b0556b2bc319b74b92929969a50"
+            "dc45dc1aeb0c64d4d3057e5955c3f490"
+            "c2abf89b8adacea1c3f4ad77dd44c8ac"
+            "a3f1c9d2195cb0caa234c1f76cfdac65"
+            "32dc48c4f2006b77f17d76acc031632a"
+            "a53a62c891b10365cb43d106dfc367bc"
+            "dce0cd35ce4965a0527ba70d07a91bb0"
+            "407772c2ea0e3a7846b991b6e73d5142"
+            "fd51b0c62c6313785ceefccfc4700034",
+    },
+#endif
     {
         /* RFC 2144, Appendix B.1 */
         .path = "/crypto/cipher/cast5-128",
-- 
1.8.3.1
