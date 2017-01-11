Received: from eggs.gnu.org ([2001:4830:134:3::10]:35869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VQ-0006nt-2w
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VO-0003e4-PO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:16 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VO-0003dh-HH
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:14 -0500
Received: by mail-pf0-x242.google.com with SMTP id b22so15073890pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:14 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:17 -0800
Message-Id: <20170111021820.24416-63-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 62/65] tests: New test-bitcnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

Add some unit tests for bit count functions (currently only ctpop). As
the routines are based on the Hackers Delight optimisations I based
the test patterns on their tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tests/.gitignore       |   1 +
 tests/Makefile.include |   2 +
 tests/test-bitcnt.c    | 140 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 tests/test-bitcnt.c

diff --git a/tests/.gitignore b/tests/.gitignore
index e9b182e..7357d0a 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -13,6 +13,7 @@ rcutorture
 test-aio
 test-base64
 test-bitops
+test-bitcnt
 test-blockjob
 test-blockjob-txn
 test-bufferiszero
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f776404..2029013 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -81,6 +81,7 @@ gcov-files-test-qht-y = util/qht.c
 check-unit-y += tests/test-qht-par$(EXESUF)
 gcov-files-test-qht-par-y = util/qht.c
 check-unit-y += tests/test-bitops$(EXESUF)
+check-unit-y += tests/test-bitcnt$(EXESUF)
 check-unit-$(CONFIG_HAS_GLIB_SUBPROCESS_TESTS) += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 gcov-files-check-qom-interface-y = qom/object.c
@@ -571,6 +572,7 @@ tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 
 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
+tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
 tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test-crypto-obj-y)
 tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
diff --git a/tests/test-bitcnt.c b/tests/test-bitcnt.c
new file mode 100644
index 0000000..e153dcb
--- /dev/null
+++ b/tests/test-bitcnt.c
@@ -0,0 +1,140 @@
+/*
+ * Test bit count routines
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+
+struct bitcnt_test_data {
+    /* value to count */
+    union {
+        uint8_t  w8;
+        uint16_t w16;
+        uint32_t w32;
+        uint64_t w64;
+    } value;
+    /* expected result */
+    int popct;
+};
+
+struct bitcnt_test_data eight_bit_data[] = {
+    { { .w8 = 0x00 }, .popct=0 },
+    { { .w8 = 0x01 }, .popct=1 },
+    { { .w8 = 0x03 }, .popct=2 },
+    { { .w8 = 0x04 }, .popct=1 },
+    { { .w8 = 0x0f }, .popct=4 },
+    { { .w8 = 0x3f }, .popct=6 },
+    { { .w8 = 0x40 }, .popct=1 },
+    { { .w8 = 0xf0 }, .popct=4 },
+    { { .w8 = 0x7f }, .popct=7 },
+    { { .w8 = 0x80 }, .popct=1 },
+    { { .w8 = 0xf1 }, .popct=5 },
+    { { .w8 = 0xfe }, .popct=7 },
+    { { .w8 = 0xff }, .popct=8 },
+};
+
+static void test_ctpop8(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(eight_bit_data); i++) {
+        struct bitcnt_test_data *d = &eight_bit_data[i];
+        g_assert(ctpop8(d->value.w8)==d->popct);
+    }
+}
+
+struct bitcnt_test_data sixteen_bit_data[] = {
+    { { .w16 = 0x0000 }, .popct=0 },
+    { { .w16 = 0x0001 }, .popct=1 },
+    { { .w16 = 0x0003 }, .popct=2 },
+    { { .w16 = 0x000f }, .popct=4 },
+    { { .w16 = 0x003f }, .popct=6 },
+    { { .w16 = 0x00f0 }, .popct=4 },
+    { { .w16 = 0x0f0f }, .popct=8 },
+    { { .w16 = 0x1f1f }, .popct=10 },
+    { { .w16 = 0x4000 }, .popct=1 },
+    { { .w16 = 0x4001 }, .popct=2 },
+    { { .w16 = 0x7000 }, .popct=3 },
+    { { .w16 = 0x7fff }, .popct=15 },
+};
+
+static void test_ctpop16(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(sixteen_bit_data); i++) {
+        struct bitcnt_test_data *d = &sixteen_bit_data[i];
+        g_assert(ctpop16(d->value.w16)==d->popct);
+    }
+}
+
+struct bitcnt_test_data thirtytwo_bit_data[] = {
+    { { .w32 = 0x00000000 }, .popct=0 },
+    { { .w32 = 0x00000001 }, .popct=1 },
+    { { .w32 = 0x0000000f }, .popct=4 },
+    { { .w32 = 0x00000f0f }, .popct=8 },
+    { { .w32 = 0x00001f1f }, .popct=10 },
+    { { .w32 = 0x00004001 }, .popct=2 },
+    { { .w32 = 0x00007000 }, .popct=3 },
+    { { .w32 = 0x00007fff }, .popct=15 },
+    { { .w32 = 0x55555555 }, .popct=16 },
+    { { .w32 = 0xaaaaaaaa }, .popct=16 },
+    { { .w32 = 0xff000000 }, .popct=8 },
+    { { .w32 = 0xc0c0c0c0 }, .popct=8 },
+    { { .w32 = 0x0ffffff0 }, .popct=24 },
+    { { .w32 = 0x80000000 }, .popct=1 },
+    { { .w32 = 0xffffffff }, .popct=32 },
+};
+
+static void test_ctpop32(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(thirtytwo_bit_data); i++) {
+        struct bitcnt_test_data *d = &thirtytwo_bit_data[i];
+        g_assert(ctpop32(d->value.w32)==d->popct);
+    }
+}
+
+struct bitcnt_test_data sixtyfour_bit_data[] = {
+    { { .w64 = 0x0000000000000000ULL }, .popct=0 },
+    { { .w64 = 0x0000000000000001ULL }, .popct=1 },
+    { { .w64 = 0x000000000000000fULL }, .popct=4 },
+    { { .w64 = 0x0000000000000f0fULL }, .popct=8 },
+    { { .w64 = 0x0000000000001f1fULL }, .popct=10 },
+    { { .w64 = 0x0000000000004001ULL }, .popct=2 },
+    { { .w64 = 0x0000000000007000ULL }, .popct=3 },
+    { { .w64 = 0x0000000000007fffULL }, .popct=15 },
+    { { .w64 = 0x0000005500555555ULL }, .popct=16 },
+    { { .w64 = 0x00aa0000aaaa00aaULL }, .popct=16 },
+    { { .w64 = 0x000f000000f00000ULL }, .popct=8 },
+    { { .w64 = 0x0c0c0000c0c0c0c0ULL }, .popct=12 },
+    { { .w64 = 0xf00f00f0f0f0f000ULL }, .popct=24 },
+    { { .w64 = 0x8000000000000000ULL }, .popct=1 },
+    { { .w64 = 0xf0f0f0f0f0f0f0f0ULL }, .popct=32 },
+    { { .w64 = 0xffffffffffffffffULL }, .popct=64 },
+};
+
+static void test_ctpop64(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(sixtyfour_bit_data); i++) {
+        struct bitcnt_test_data *d = &sixtyfour_bit_data[i];
+        g_assert(ctpop64(d->value.w64)==d->popct);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/bitcnt/ctpop8", test_ctpop8);
+    g_test_add_func("/bitcnt/ctpop16", test_ctpop16);
+    g_test_add_func("/bitcnt/ctpop32", test_ctpop32);
+    g_test_add_func("/bitcnt/ctpop64", test_ctpop64);
+    return g_test_run();
+}
-- 
2.9.3
