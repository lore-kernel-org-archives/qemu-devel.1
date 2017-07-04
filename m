Received: from eggs.gnu.org ([2001:4830:134:3::10]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJeg-0005E7-0M
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJee-0005gS-MR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dSJee-0005eh-1U
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:57:56 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 4 Jul 2017 16:57:08 +0800
Message-ID: <1499158630-75260-17-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
References: <1499158630-75260-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 16/18] tests: crypto: add cipher speed
 benchmark support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: arei.gonglei@huawei.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org, longpeng.mike@gmail.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Now we have two qcrypto backends, libiary-backend and afalg-backend,
but which one is faster? This patch add a cipher speed benchmark, it
helps us to measure the performance by using "make check-speed" or
using "./tests/benchmark-crypto-cipher" directly.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 tests/Makefile.include          |  9 ++++-
 tests/benchmark-crypto-cipher.c | 88 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 tests/benchmark-crypto-cipher.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ae889ca..7bf7277 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -99,6 +99,7 @@ gcov-files-test-write-threshold-y = block/write-threshold.c
 check-unit-y += tests/test-crypto-hash$(EXESUF)
 check-unit-y += tests/test-crypto-hmac$(EXESUF)
 check-unit-y += tests/test-crypto-cipher$(EXESUF)
+check-speed-y += tests/benchmark-crypto-cipher$(EXESUF)
 check-unit-y += tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlssession$(EXESUF)
@@ -531,6 +532,7 @@ test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
 	$(test-qom-obj-y)
+benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
 test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
 test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
 test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
@@ -634,6 +636,7 @@ tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
 tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
 tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
+tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-crypto-obj-y)
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
 tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
 
@@ -801,6 +804,7 @@ check-help:
 	@echo " make check-qtest-TARGET   Run qtest tests for given target"
 	@echo " make check-qtest          Run qtest tests"
 	@echo " make check-unit           Run qobject tests"
+	@echo " make check-speed          Run qobject speed tests"
 	@echo " make check-qapi-schema    Run QAPI schema tests"
 	@echo " make check-block          Run block tests"
 	@echo " make check-report.html    Generates an HTML test report"
@@ -831,8 +835,8 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check-qtest-y)
 	  $(GCOV) $(GCOV_OPTIONS) $$f -o `dirname $$f`; \
 	done,)
 
-.PHONY: $(patsubst %, check-%, $(check-unit-y))
-$(patsubst %, check-%, $(check-unit-y)): check-%: %
+.PHONY: $(patsubst %, check-%, $(check-unit-y) $(check-speed-y))
+$(patsubst %, check-%, $(check-unit-y) $(check-speed-y)): check-%: %
 	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
 	$(call quiet-command, \
 		MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))} \
@@ -891,6 +895,7 @@ check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-unit: $(patsubst %,check-%, $(check-unit-y))
+check-speed: $(patsubst %,check-%, $(check-speed-y))
 check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-qapi-schema check-unit check-qtest
 check-clean:
diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
new file mode 100644
index 0000000..c6a4092
--- /dev/null
+++ b/tests/benchmark-crypto-cipher.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU Crypto cipher speed benchmark
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
+#include "crypto/cipher.h"
+
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
+    g_print("cbc(aes128): ");
+    g_print("Testing chunk_size %ld bytes ", chunk_size);
+    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
+    g_print("%.2f MB/sec\n", total / g_test_timer_last());
+
+    qcrypto_cipher_free(cipher);
+    g_free(plaintext);
+    g_free(ciphertext);
+    g_free(iv);
+    g_free(key);
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
+        snprintf(name, sizeof(name), "/crypto/cipher/speed-%lu", i);
+        g_test_add_data_func(name, (void *)i, test_cipher_speed);
+    }
+
+    return g_test_run();
+}
-- 
1.8.3.1
