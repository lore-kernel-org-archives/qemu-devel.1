Received: from eggs.gnu.org ([2001:4830:134:3::10]:54721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCk-0000dZ-KC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCj-0002Xq-2Q
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3359
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCi-0002UF-Af
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:45 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:01:31 +0800
Message-ID: <1491814891-59688-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 19/19] tests: crypto: add hmac speed
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
to add the speed test in test-crypto-hmac.

We can use "./tests/test-crypto-hmac speed" to do the speed
test.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 tests/test-crypto-hmac.c | 66 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/tests/test-crypto-hmac.c b/tests/test-crypto-hmac.c
index ee55382..febc556 100644
--- a/tests/test-crypto-hmac.c
+++ b/tests/test-crypto-hmac.c
@@ -251,16 +251,74 @@ static void test_hmac_digest(void)
     }
 }
 
+static void test_hmac_speed(const void *opaque)
+{
+    size_t chunk_size = (size_t)opaque;
+    QCryptoHmac *hmac = NULL;
+    uint8_t *in = NULL, *out = NULL;
+    size_t out_len = 0;
+    double total = 0.0;
+    struct iovec iov;
+    Error *err = NULL;
+    int ret;
+
+    if (!qcrypto_hmac_supports(QCRYPTO_HASH_ALG_SHA256)) {
+        return;
+    }
+
+    hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALG_SHA256, (const uint8_t *)KEY,
+                            strlen(KEY), &err);
+    g_assert(err == NULL);
+    g_assert(hmac != NULL);
+
+    in = g_new0(uint8_t, chunk_size);
+    memset(in, g_test_rand_int(), chunk_size);
+
+    iov.iov_base = (char *)in;
+    iov.iov_len = chunk_size;
+
+    g_test_timer_start();
+    do {
+        ret = qcrypto_hmac_bytesv(hmac, &iov, 1, &out, &out_len, &err);
+        g_assert(ret == 0);
+        g_assert(err == NULL);
+
+        total += chunk_size;
+    } while (g_test_timer_elapsed() < 5.0);
+
+    total /= 1024 * 1024; /* to MB */
+
+    g_print("[drv:%s]", qcrypto_hmac_using_afalg_drv(hmac) ?
+            "afalg" : "libs");
+    g_print("Testing hmac(sha256): ");
+    g_print("Encrypting in chunks of %ld bytes: ", chunk_size);
+    g_print("done. %.2f MB in %.2f secs: ", total, g_test_timer_last());
+    g_print("%.2f MB/sec\t", total / g_test_timer_last());
+
+    qcrypto_hmac_free(hmac);
+    g_free(out);
+    g_free(in);
+}
+
 int main(int argc, char **argv)
 {
+    size_t i;
+
     g_test_init(&argc, &argv, NULL);
 
     g_assert(qcrypto_init(NULL) == 0);
 
-    g_test_add_func("/crypto/hmac/iov", test_hmac_iov);
-    g_test_add_func("/crypto/hmac/alloc", test_hmac_alloc);
-    g_test_add_func("/crypto/hmac/prealloc", test_hmac_prealloc);
-    g_test_add_func("/crypto/hmac/digest", test_hmac_digest);
+    if ((argc > 1) && !strcmp(argv[1], "speed")) {
+        for (i = 512; i <= (64 * 1204); i *= 2) {
+            g_test_add_data_func("/crypto/hmac/speed", (void *)i,
+                                 test_hmac_speed);
+        }
+    } else {
+        g_test_add_func("/crypto/hmac/iov", test_hmac_iov);
+        g_test_add_func("/crypto/hmac/alloc", test_hmac_alloc);
+        g_test_add_func("/crypto/hmac/prealloc", test_hmac_prealloc);
+        g_test_add_func("/crypto/hmac/digest", test_hmac_digest);
+    }
 
     return g_test_run();
 }
-- 
1.8.3.1
