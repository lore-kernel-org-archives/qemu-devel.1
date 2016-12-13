Received: from eggs.gnu.org ([2001:4830:134:3::10]:36150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh8v-0008Ln-8n
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh8q-0006n5-P2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:04:53 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:48076)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGh8p-0006mV-Ig
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:04:48 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 13 Dec 2016 15:01:53 +0800
Message-ID: <1481612513-28556-7-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
References: <1481612513-28556-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 v3 6/6] crypto: add HMAC algorithms
 testcases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: wu.wubin@huawei.com, jianjay.zhou@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

This patch add HMAC algorithms testcases

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 tests/Makefile.include   |   2 +
 tests/test-crypto-hmac.c | 266 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 tests/test-crypto-hmac.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e98d3b6..4841d58 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -91,6 +91,7 @@ gcov-files-test-qemu-opts-y = qom/test-qemu-opts.c
 check-unit-y += tests/test-write-threshold$(EXESUF)
 gcov-files-test-write-threshold-y = block/write-threshold.c
 check-unit-y += tests/test-crypto-hash$(EXESUF)
+check-unit-y += tests/test-crypto-hmac$(EXESUF)
 check-unit-y += tests/test-crypto-cipher$(EXESUF)
 check-unit-y += tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
@@ -571,6 +572,7 @@ tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
+tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
 tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
 tests/test-crypto-xts$(EXESUF): tests/test-crypto-xts.o $(test-crypto-obj-y)
diff --git a/tests/test-crypto-hmac.c b/tests/test-crypto-hmac.c
new file mode 100644
index 0000000..ee55382
--- /dev/null
+++ b/tests/test-crypto-hmac.c
@@ -0,0 +1,266 @@
+/*
+ * QEMU Crypto hmac algorithms tests
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Longpeng(Mike) <longpeng2@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/init.h"
+#include "crypto/hmac.h"
+
+#define INPUT_TEXT1 "ABCDEFGHIJKLMNOPQRSTUVWXY"
+#define INPUT_TEXT2 "Zabcdefghijklmnopqrstuvwx"
+#define INPUT_TEXT3 "yz0123456789"
+#define INPUT_TEXT INPUT_TEXT1 \
+              INPUT_TEXT2 \
+              INPUT_TEXT3
+
+#define KEY "monkey monkey monkey monkey"
+
+typedef struct QCryptoHmacTestData QCryptoHmacTestData;
+struct QCryptoHmacTestData {
+    QCryptoHashAlgorithm alg;
+    const char *hex_digest;
+};
+
+static QCryptoHmacTestData test_data[] = {
+    {
+        .alg = QCRYPTO_HASH_ALG_MD5,
+        .hex_digest =
+            "ede9cb83679ba82d88fbeae865b3f8fc",
+    },
+    {
+        .alg = QCRYPTO_HASH_ALG_SHA1,
+        .hex_digest =
+            "c7b5a631e3aac975c4ededfcd346e469"
+            "dbc5f2d1",
+    },
+    {
+        .alg = QCRYPTO_HASH_ALG_SHA224,
+        .hex_digest =
+            "5f768179dbb29ca722875d0f461a2e2f"
+            "597d0210340a84df1a8e9c63",
+    },
+    {
+        .alg = QCRYPTO_HASH_ALG_SHA256,
+        .hex_digest =
+            "3798f363c57afa6edaffe39016ca7bad"
+            "efd1e670afb0e3987194307dec3197db",
+    },
+    {
+        .alg = QCRYPTO_HASH_ALG_SHA384,
+        .hex_digest =
+            "d218680a6032d33dccd9882d6a6a7164"
+            "64f26623be257a9b2919b185294f4a49"
+            "9e54b190bfd6bc5cedd2cd05c7e65e82",
+    },
+    {
+        .alg = QCRYPTO_HASH_ALG_SHA512,
+        .hex_digest =
+            "835a4f5b3750b4c1fccfa88da2f746a4"
+            "900160c9f18964309bb736c13b59491b"
+            "8e32d37b724cc5aebb0f554c6338a3b5"
+            "94c4ba26862b2dadb59b7ede1d08d53e",
+    },
+    {
+        .alg = QCRYPTO_HASH_ALG_RIPEMD160,
+        .hex_digest =
+            "94964ed4c1155b62b668c241d67279e5"
+            "8a711676",
+    },
+};
+
+static const char hex[] = "0123456789abcdef";
+
+static void test_hmac_alloc(void)
+{
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+        QCryptoHmacTestData *data = &test_data[i];
+        QCryptoHmac *hmac = NULL;
+        uint8_t *result = NULL;
+        size_t resultlen = 0;
+        Error *err = NULL;
+        const char *exp_output = NULL;
+        int ret;
+        size_t j;
+
+        if (!qcrypto_hmac_supports(data->alg)) {
+            return;
+        }
+
+        exp_output = data->hex_digest;
+
+        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                                strlen(KEY), &err);
+        g_assert(err == NULL);
+        g_assert(hmac != NULL);
+
+        ret = qcrypto_hmac_bytes(hmac, (const char *)INPUT_TEXT,
+                                 strlen(INPUT_TEXT), &result,
+                                 &resultlen, &err);
+        g_assert(err == NULL);
+        g_assert(ret == 0);
+
+        for (j = 0; j < resultlen; j++) {
+            g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
+            g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
+        }
+
+        qcrypto_hmac_free(hmac);
+
+        g_free(result);
+    }
+}
+
+static void test_hmac_prealloc(void)
+{
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+        QCryptoHmacTestData *data = &test_data[i];
+        QCryptoHmac *hmac = NULL;
+        uint8_t *result = NULL;
+        size_t resultlen = 0;
+        Error *err = NULL;
+        const char *exp_output = NULL;
+        int ret;
+        size_t j;
+
+        if (!qcrypto_hmac_supports(data->alg)) {
+            return;
+        }
+
+        exp_output = data->hex_digest;
+
+        resultlen = strlen(exp_output) / 2;
+        result = g_new0(uint8_t, resultlen);
+
+        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                                strlen(KEY), &err);
+        g_assert(err == NULL);
+        g_assert(hmac != NULL);
+
+        ret = qcrypto_hmac_bytes(hmac, (const char *)INPUT_TEXT,
+                                 strlen(INPUT_TEXT), &result,
+                                 &resultlen, &err);
+        g_assert(err == NULL);
+        g_assert(ret == 0);
+
+        exp_output = data->hex_digest;
+        for (j = 0; j < resultlen; j++) {
+            g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
+            g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
+        }
+
+        qcrypto_hmac_free(hmac);
+
+        g_free(result);
+    }
+}
+
+static void test_hmac_iov(void)
+{
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+        QCryptoHmacTestData *data = &test_data[i];
+        QCryptoHmac *hmac = NULL;
+        uint8_t *result = NULL;
+        size_t resultlen = 0;
+        Error *err = NULL;
+        const char *exp_output = NULL;
+        int ret;
+        size_t j;
+        struct iovec iov[3] = {
+            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
+            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
+            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
+        };
+
+        if (!qcrypto_hmac_supports(data->alg)) {
+            return;
+        }
+
+        exp_output = data->hex_digest;
+
+        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                                strlen(KEY), &err);
+        g_assert(err == NULL);
+        g_assert(hmac != NULL);
+
+        ret = qcrypto_hmac_bytesv(hmac, iov, 3, &result,
+                                  &resultlen, &err);
+        g_assert(err == NULL);
+        g_assert(ret == 0);
+
+        for (j = 0; j < resultlen; j++) {
+            g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
+            g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
+        }
+
+        qcrypto_hmac_free(hmac);
+
+        g_free(result);
+    }
+}
+
+static void test_hmac_digest(void)
+{
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+        QCryptoHmacTestData *data = &test_data[i];
+        QCryptoHmac *hmac = NULL;
+        uint8_t *result = NULL;
+        Error *err = NULL;
+        const char *exp_output = NULL;
+        int ret;
+
+        if (!qcrypto_hmac_supports(data->alg)) {
+            return;
+        }
+
+        exp_output = data->hex_digest;
+
+        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                                strlen(KEY), &err);
+        g_assert(err == NULL);
+        g_assert(hmac != NULL);
+
+        ret = qcrypto_hmac_digest(hmac, (const char *)INPUT_TEXT,
+                                  strlen(INPUT_TEXT), (char **)&result,
+                                  &err);
+        g_assert(err == NULL);
+        g_assert(ret == 0);
+
+        g_assert_cmpstr((const char *)result, ==, exp_output);
+
+        qcrypto_hmac_free(hmac);
+
+        g_free(result);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_assert(qcrypto_init(NULL) == 0);
+
+    g_test_add_func("/crypto/hmac/iov", test_hmac_iov);
+    g_test_add_func("/crypto/hmac/alloc", test_hmac_alloc);
+    g_test_add_func("/crypto/hmac/prealloc", test_hmac_prealloc);
+    g_test_add_func("/crypto/hmac/digest", test_hmac_digest);
+
+    return g_test_run();
+}
-- 
1.8.3.1
