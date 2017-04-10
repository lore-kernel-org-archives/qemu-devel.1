Received: from eggs.gnu.org ([2001:4830:134:3::10]:54530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCF-0000Fe-Ic
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCD-0002KK-VK
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3030
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCD-0002IJ-6G
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:13 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:00:58 +0800
Message-ID: <1491814858-63428-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 15/19] tests: crypto: add cipher speed
 case
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

Now we have afalg-backend and libiary-backend, it's necessary
to add the speed test in test-crypto-cipher.

We can use "./tests/test-crypto-cipher speed" to do the speed
test.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 tests/test-crypto-cipher.c | 82 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index 8bb3308..ee0c2ca 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -789,6 +789,64 @@ static void test_cipher_short_plaintext(void)
     qcrypto_cipher_free(cipher);
 }
 
+static void test_cipher_speed(const void *opaque)
+{
+    QCryptoCipher *cipher;
+    Error *err = NULL;
+    double total = 0.0;
+    size_t chunk_size = (size_t)opaque;
+    uint8_t *key = NULL, *iv = NULL;
+    uint8_t *plaintext = NULL, *ciphertext = NULL;
+    size_t nkey = qcrypto_cipher_get_key_len(QCRYPTO_CIPHER_ALG_AES_128);
+    size_t niv = qcrypto_cipher_get_iv_len(QCRYPTO_CIPHER_ALG_AES_128,
+                                           QCRYPTO_CIPHER_MODE_CBC);
+
+    key = g_new0(uint8_t, nkey);
+    memset(key, g_test_rand_int(), nkey);
+
+    iv = g_new0(uint8_t, niv);
+    memset(iv, g_test_rand_int(), niv);
+
+    ciphertext = g_new0(uint8_t, chunk_size);
+
+    plaintext = g_new0(uint8_t, chunk_size);
+    memset(plaintext, g_test_rand_int(), chunk_size);
+
+    cipher = qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_128,
+                                QCRYPTO_CIPHER_MODE_CBC,
+                                key, nkey, &err);
+    g_assert(cipher != NULL);
+
+    g_assert(qcrypto_cipher_setiv(cipher,
+                                  iv, niv,
+                                  &err) == 0);
+
+    g_test_timer_start();
+    do {
+        g_assert(qcrypto_cipher_encrypt(cipher,
+                                        plaintext,
+                                        ciphertext,
+                                        chunk_size,
+                                        &err) == 0);
+        total += chunk_size;
+    } while (g_test_timer_elapsed() < 5.0);
+
+    total /= 1024 * 1024; /* to MB */
+
+    g_print("[drv:%s]", qcrypto_cipher_using_afalg_drv(cipher) ?
+            "afalg" : "libs");
+    g_print("Testing cbc(aes128): ");
+    g_print("Encrypting in chunks of %ld bytes: ", chunk_size);
+    g_print("done. %.2f MB in %.2f secs: ", total, g_test_timer_last());
+    g_print("%.2f MB/sec\t", total / g_test_timer_last());
+
+    qcrypto_cipher_free(cipher);
+    g_free(plaintext);
+    g_free(ciphertext);
+    g_free(iv);
+    g_free(key);
+}
+
 int main(int argc, char **argv)
 {
     size_t i;
@@ -797,17 +855,25 @@ int main(int argc, char **argv)
 
     g_assert(qcrypto_init(NULL) == 0);
 
-    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        if (qcrypto_cipher_supports(test_data[i].alg, test_data[i].mode)) {
-            g_test_add_data_func(test_data[i].path, &test_data[i], test_cipher);
+    if ((argc > 1) && !strcmp(argv[1], "speed")) {
+        for (i = 512; i <= (64 * 1204); i *= 2) {
+            g_test_add_data_func("/crypto/cipher/speed", (void *)i,
+                                 test_cipher_speed);
+        }
+    } else {
+        for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+            if (qcrypto_cipher_supports(test_data[i].alg, test_data[i].mode)) {
+                g_test_add_data_func(test_data[i].path, &test_data[i],
+                                     test_cipher);
+            }
         }
-    }
 
-    g_test_add_func("/crypto/cipher/null-iv",
-                    test_cipher_null_iv);
+        g_test_add_func("/crypto/cipher/null-iv",
+                        test_cipher_null_iv);
 
-    g_test_add_func("/crypto/cipher/short-plaintext",
-                    test_cipher_short_plaintext);
+        g_test_add_func("/crypto/cipher/short-plaintext",
+                        test_cipher_short_plaintext);
+    }
 
     return g_test_run();
 }
-- 
1.8.3.1
