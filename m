Received: from eggs.gnu.org ([2001:4830:134:3::10]:38716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXl6C-0000yB-A0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXl69-0001kR-0v
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXl68-0001jz-OG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:16:48 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 19 Jul 2017 10:16:00 +0100
Message-Id: <20170719091600.8555-19-berrange@redhat.com>
In-Reply-To: <20170719091600.8555-1-berrange@redhat.com>
References: <20170719091600.8555-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 18/18] tests: crypto: add hmac speed
 benchmark support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Longpeng(Mike)" <longpeng2@huawei.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add a hmac speed benchmark, it helps us to
measure the performance by using "make check-speed" or
using "./tests/benchmark-crypto-hmac" directly.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/.gitignore              |  1 +
 tests/Makefile.include        |  2 ++
 tests/benchmark-crypto-hmac.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 tests/benchmark-crypto-hmac.c

diff --git a/tests/.gitignore b/tests/.gitignore
index 7f88cc3771..fed0189a5a 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -1,6 +1,7 @@
 atomic_add-bench
 benchmark-crypto-cipher
 benchmark-crypto-hash
+benchmark-crypto-hmac
 check-qdict
 check-qnum
 check-qjson
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0ef796c66a..d40ea57f5c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -99,6 +99,7 @@ gcov-files-test-write-threshold-y = block/write-threshold.c
 check-unit-y += tests/test-crypto-hash$(EXESUF)
 check-speed-y += tests/benchmark-crypto-hash$(EXESUF)
 check-unit-y += tests/test-crypto-hmac$(EXESUF)
+check-speed-y += tests/benchmark-crypto-hmac$(EXESUF)
 check-unit-y += tests/test-crypto-cipher$(EXESUF)
 check-speed-y += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-y += tests/test-crypto-secret$(EXESUF)
@@ -638,6 +639,7 @@ tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
 tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test-crypto-obj-y)
 tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
+tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test-crypto-obj-y)
 tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
 tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-crypto-obj-y)
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c
new file mode 100644
index 0000000000..72408be987
--- /dev/null
+++ b/tests/benchmark-crypto-hmac.c
@@ -0,0 +1,82 @@
+/*
+ * QEMU Crypto hmac speed benchmark
+ *
+ * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Longpeng(Mike) <longpeng2@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "crypto/init.h"
+#include "crypto/hmac.h"
+
+#define KEY "monkey monkey monkey monkey"
+
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
+    in = g_new0(uint8_t, chunk_size);
+    memset(in, g_test_rand_int(), chunk_size);
+
+    iov.iov_base = (char *)in;
+    iov.iov_len = chunk_size;
+
+    g_test_timer_start();
+    do {
+        hmac = qcrypto_hmac_new(QCRYPTO_HASH_ALG_SHA256,
+                                (const uint8_t *)KEY, strlen(KEY), &err);
+        g_assert(err == NULL);
+        g_assert(hmac != NULL);
+
+        ret = qcrypto_hmac_bytesv(hmac, &iov, 1, &out, &out_len, &err);
+        g_assert(ret == 0);
+        g_assert(err == NULL);
+
+        qcrypto_hmac_free(hmac);
+
+        total += chunk_size;
+    } while (g_test_timer_elapsed() < 5.0);
+
+    total /= 1024 * 1024; /* to MB */
+
+    g_print("hmac(sha256): ");
+    g_print("Testing chunk_size %ld bytes ", chunk_size);
+    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
+    g_print("%.2f MB/sec\n", total / g_test_timer_last());
+
+    g_free(out);
+    g_free(in);
+}
+
+int main(int argc, char **argv)
+{
+    size_t i;
+    char name[64];
+
+    g_test_init(&argc, &argv, NULL);
+    g_assert(qcrypto_init(NULL) == 0);
+
+    for (i = 512; i <= (64 * 1204); i *= 2) {
+        memset(name, 0 , sizeof(name));
+        snprintf(name, sizeof(name), "/crypto/hmac/speed-%lu", i);
+        g_test_add_data_func(name, (void *)i, test_hmac_speed);
+    }
+
+    return g_test_run();
+}
-- 
2.13.0
