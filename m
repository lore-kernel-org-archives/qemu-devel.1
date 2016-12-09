Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFMNv-0004ka-DP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFMNp-0005TA-9A
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:42:51 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFMNo-0005SD-OA
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:42:45 -0500
Received: by mail-wm0-f53.google.com with SMTP id t79so29291331wmt.0
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 06:42:44 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-62-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-62-git-send-email-rth@twiddle.net>
Date: Fri, 09 Dec 2016 14:41:41 +0000
Message-ID: <87twadxize.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 61/64] qemu/host-utils.h: Reduce the
 operation count in the fallback ctpop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

As it looked like we were messing about with the Hackers Delight
algorithms I thought it might be worth defending any changes with some
unit tests. Feel free to include the unit test bellow:

--8<---------------cut here---------------start------------->8---
>From 66857f0be793c86ce9aaa6e02ffccc6552f6e894 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 9 Dec 2016 14:36:00 +0000
Subject: [PATCH] new: tests/test-bitcnt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add some unit tests for bit count functions (currently only ctpop). As
the routines are based on the Hackers Delight optimisations I based
the test patterns on their tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/.gitignore       |   1 +
 tests/Makefile.include |   2 +
 tests/test-bitcnt.c    | 135 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 tests/test-bitcnt.c

diff --git a/tests/.gitignore b/tests/.gitignore
index c0d7857538..96986efc1a 100644
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
index e98d3b6bb3..8b85c5399a 100644
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
@@ -570,6 +571,7 @@ tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)

 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
+tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
 tests/test-crypto-cipher$(EXESUF): tests/test-crypto-cipher.o $(test-crypto-obj-y)
 tests/test-crypto-secret$(EXESUF): tests/test-crypto-secret.o $(test-crypto-obj-y)
diff --git a/tests/test-bitcnt.c b/tests/test-bitcnt.c
new file mode 100644
index 0000000000..3969b32803
--- /dev/null
+++ b/tests/test-bitcnt.c
@@ -0,0 +1,135 @@
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
+    { { .w64 = 0x0000000000000001 }, .popct=1 },
+    { { .w64 = 0x000000000000000f }, .popct=4 },
+    { { .w64 = 0x0000000000000f0f }, .popct=8 },
+    { { .w64 = 0x0000000000001f1f }, .popct=10 },
+    { { .w64 = 0x0000000000004001 }, .popct=2 },
+    { { .w64 = 0x0000000000007000 }, .popct=3 },
+    { { .w64 = 0x0000000000007fff }, .popct=15 },
+    { { .w64 = 0x0000005500555555 }, .popct=16 },
+    { { .w64 = 0x00aa0000aaaa00aa }, .popct=16 },
+    { { .w64 = 0x000f000000f00000 }, .popct=8 },
+    { { .w64 = 0x0c0c0000c0c0c0c0 }, .popct=12 },
+    { { .w64 = 0xf00f00f0f0f0f000 }, .popct=24 },
+    { { .w64 = 0x8000000000000000 }, .popct=1 },
+    { { .w64 = 0xf0f0f0f0f0f0f0f0 }, .popct=32 },
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
2.11.0


--8<---------------cut here---------------end--------------->8---
