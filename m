Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCZ-0000Uf-GG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCY-0002SR-ES
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3423
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cxVCX-0002R3-Md
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:01:34 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 10 Apr 2017 17:01:14 +0800
Message-ID: <1491814874-63308-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 17/19] tests: crypto: add hash speed
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
to add the speed test in test-crypto-hash.

We can use "./tests/test-crypto-hash speed" to do the speed test.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 tests/test-crypto-hash.c | 56 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tests/test-crypto-hash.c b/tests/test-crypto-hash.c
index 214a9f7..71199ec 100644
--- a/tests/test-crypto-hash.c
+++ b/tests/test-crypto-hash.c
@@ -241,15 +241,61 @@ static void test_hash_base64(void)
     }
 }
 
+static void test_hash_speed(const void *opaque)
+{
+    size_t chunk_size = (size_t)opaque;
+    uint8_t *in = NULL, *out = NULL;
+    size_t out_len = 0;
+    double total = 0.0;
+    struct iovec iov;
+    int ret;
+
+    in = g_new0(uint8_t, chunk_size);
+    memset(in, g_test_rand_int(), chunk_size);
+
+    iov.iov_base = (char *)in;
+    iov.iov_len = chunk_size;
+
+    g_test_timer_start();
+    do {
+        ret = qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
+                                  &iov, 1, &out, &out_len,
+                                  NULL);
+        g_assert(ret == 0);
+
+        total += chunk_size;
+    } while (g_test_timer_elapsed() < 5.0);
+
+    total /= 1024 * 1024; /* to MB */
+    g_print("Testing sha256: ");
+    g_print("Encrypting in chunks of %ld bytes: ", chunk_size);
+    g_print("done. %.2f MB in %.2f secs: ", total, g_test_timer_last());
+    g_print("%.2f MB/sec\t", total / g_test_timer_last());
+
+    g_free(out);
+    g_free(in);
+}
+
 int main(int argc, char **argv)
 {
+    size_t i;
+
     g_assert(qcrypto_init(NULL) == 0);
 
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/crypto/hash/iov", test_hash_iov);
-    g_test_add_func("/crypto/hash/alloc", test_hash_alloc);
-    g_test_add_func("/crypto/hash/prealloc", test_hash_prealloc);
-    g_test_add_func("/crypto/hash/digest", test_hash_digest);
-    g_test_add_func("/crypto/hash/base64", test_hash_base64);
+
+    if ((argc > 1) && !strcmp(argv[1], "speed")) {
+        for (i = 512; i <= (64 * 1204); i *= 2) {
+            g_test_add_data_func("/crypto/hash/speed", (void *)i,
+                                 test_hash_speed);
+        }
+    } else {
+        g_test_add_func("/crypto/hash/iov", test_hash_iov);
+        g_test_add_func("/crypto/hash/alloc", test_hash_alloc);
+        g_test_add_func("/crypto/hash/prealloc", test_hash_prealloc);
+        g_test_add_func("/crypto/hash/digest", test_hash_digest);
+        g_test_add_func("/crypto/hash/base64", test_hash_base64);
+    }
+
     return g_test_run();
 }
-- 
1.8.3.1
