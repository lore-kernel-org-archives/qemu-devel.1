Received: from eggs.gnu.org ([2001:4830:134:3::10]:40632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZy-000270-8Z
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZw-0008Fw-01
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:14 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:50651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cKfZv-0008FA-B0
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 01:13:11 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 24 Dec 2016 14:12:25 +0800
Message-ID: <1482559948-22772-2-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
References: <1482559948-22772-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/4] cryptodev: fix the check of aes algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Longpeng(Mike)" <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

As the key length of xts(aes) is different with other mode of aes,
so we should check specially in cryptodev_builtin_get_aes_algo, if
it is xts mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 backends/cryptodev-builtin.c | 47 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index eda954b..57980cb 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -111,23 +111,42 @@ cryptodev_builtin_get_unused_session_index(
     return -1;
 }
 
+#define AES_KEYSIZE_128 16
+#define AES_KEYSIZE_192 24
+#define AES_KEYSIZE_256 32
+#define AES_KEYSIZE_128_XTS AES_KEYSIZE_256
+#define AES_KEYSIZE_256_XTS 64
+
 static int
-cryptodev_builtin_get_aes_algo(uint32_t key_len, Error **errp)
+cryptodev_builtin_get_aes_algo(uint32_t key_len, int mode, Error **errp)
 {
     int algo;
 
-    if (key_len == 128 / 8) {
+    if (key_len == AES_KEYSIZE_128) {
         algo = QCRYPTO_CIPHER_ALG_AES_128;
-    } else if (key_len == 192 / 8) {
+    } else if (key_len == AES_KEYSIZE_192) {
         algo = QCRYPTO_CIPHER_ALG_AES_192;
-    } else if (key_len == 256 / 8) {
-        algo = QCRYPTO_CIPHER_ALG_AES_256;
+    } else if (key_len == AES_KEYSIZE_256) { /* equals AES_KEYSIZE_128_XTS */
+        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+            algo = QCRYPTO_CIPHER_ALG_AES_128;
+        } else {
+            algo = QCRYPTO_CIPHER_ALG_AES_256;
+        }
+    } else if (key_len == AES_KEYSIZE_256_XTS) {
+        if (mode == QCRYPTO_CIPHER_MODE_XTS) {
+            algo = QCRYPTO_CIPHER_ALG_AES_256;
+        } else {
+            goto err;
+        }
     } else {
-        error_setg(errp, "Unsupported key length :%u", key_len);
-        return -1;
+        goto err;
     }
 
     return algo;
+
+err:
+   error_setg(errp, "Unsupported key length :%u", key_len);
+   return -1;
 }
 
 static int cryptodev_builtin_create_cipher_session(
@@ -155,32 +174,32 @@ static int cryptodev_builtin_create_cipher_session(
 
     switch (sess_info->cipher_alg) {
     case VIRTIO_CRYPTO_CIPHER_AES_ECB:
+        mode = QCRYPTO_CIPHER_MODE_ECB;
         algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                          errp);
+                                                    mode, errp);
         if (algo < 0)  {
             return -1;
         }
-        mode = QCRYPTO_CIPHER_MODE_ECB;
         break;
     case VIRTIO_CRYPTO_CIPHER_AES_CBC:
+        mode = QCRYPTO_CIPHER_MODE_CBC;
         algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                          errp);
+                                                    mode, errp);
         if (algo < 0)  {
             return -1;
         }
-        mode = QCRYPTO_CIPHER_MODE_CBC;
         break;
     case VIRTIO_CRYPTO_CIPHER_AES_CTR:
+        mode = QCRYPTO_CIPHER_MODE_CTR;
         algo = cryptodev_builtin_get_aes_algo(sess_info->key_len,
-                                                          errp);
+                                                    mode, errp);
         if (algo < 0)  {
             return -1;
         }
-        mode = QCRYPTO_CIPHER_MODE_CTR;
         break;
     case VIRTIO_CRYPTO_CIPHER_DES_ECB:
-        algo = QCRYPTO_CIPHER_ALG_DES_RFB;
         mode = QCRYPTO_CIPHER_MODE_ECB;
+        algo = QCRYPTO_CIPHER_ALG_DES_RFB;
         break;
     default:
         error_setg(errp, "Unsupported cipher alg :%u",
-- 
1.7.12.4
