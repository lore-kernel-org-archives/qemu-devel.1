Received: from eggs.gnu.org ([2001:4830:134:3::10]:33345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cJ16h-00070T-8H
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cJ16e-00040J-3q
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cJ16d-00040E-UX
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:48:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJGiQ4U025622
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:48:07 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ejp62ysr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 11:48:07 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 19 Dec 2016 14:48:05 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 14:47:39 -0200
In-Reply-To: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/6] target-ppc: Implement unsigned quadword
 left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

This commit implements functions to right and left shifts and the
unittest for them. Such functions is needed due to instructions
that requires them.

Today, there is already a right shift implementation in int128.h
but it's designed for signed numbers.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 include/qemu/host-utils.h |  3 ++
 tests/Makefile.include    |  5 ++-
 tests/test-shift128.c     | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs        |  2 +-
 util/host-utils.c         | 44 +++++++++++++++++++++
 5 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 tests/test-shift128.c

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 46187bb..e87de19 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -516,4 +516,7 @@ static inline uint64_t pow2ceil(uint64_t value)
     return 1ULL << (64 - nlz);
 }
 
+void urshift(uint64_t *plow, uint64_t *phigh, uint32_t shift);
+void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t shift, bool *overflow);
+
 #endif
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b574964..8ccaa3e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -65,6 +65,8 @@ check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
 endif
 check-unit-y += tests/test-cutils$(EXESUF)
 gcov-files-test-cutils-y += util/cutils.c
+check-unit-y += tests/test-shift128$(EXESUF)
+gcov-files-test-shift128-y = util/host-utils.c
 check-unit-y += tests/test-mul64$(EXESUF)
 gcov-files-test-mul64-y = util/host-utils.c
 check-unit-y += tests/test-int128$(EXESUF)
@@ -464,7 +466,7 @@ test-obj-y = tests/check-qint.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
 	tests/test-opts-visitor.o tests/test-qmp-event.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
-	tests/test-qdist.o \
+	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
 	tests/atomic_add-bench.o
 
@@ -572,6 +574,7 @@ tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-qmp-marsh
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 
+tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
diff --git a/tests/test-shift128.c b/tests/test-shift128.c
new file mode 100644
index 0000000..52be6a2
--- /dev/null
+++ b/tests/test-shift128.c
@@ -0,0 +1,98 @@
+/*
+ * Test unsigned left and right shift
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+
+typedef struct {
+    uint64_t low;
+    uint64_t high;
+    uint64_t rlow;
+    uint64_t rhigh;
+    int32_t shift;
+    bool overflow;
+} test_data;
+
+static const test_data test_ltable[] = {
+    { 1223ULL, 0, 1223ULL,   0, 0, false },
+    { 1ULL,    0, 2ULL,   0, 1, false },
+    { 1ULL,    0, 4ULL,   0, 2, false },
+    { 1ULL,    0, 16ULL,  0, 4, false },
+    { 1ULL,    0, 256ULL, 0, 8, false },
+    { 1ULL,    0, 65536ULL, 0, 16, false },
+    { 1ULL,    0, 2147483648ULL, 0, 31, false },
+    { 1ULL,    0, 35184372088832ULL, 0, 45, false },
+    { 1ULL,    0, 1152921504606846976ULL, 0, 60, false },
+    { 1ULL,    0, 0, 1ULL, 64, false },
+    { 1ULL,    0, 0, 65536ULL, 80, false },
+    { 1ULL,    0, 0, 9223372036854775808ULL, 127, false },
+    { 0ULL,    1, 0, 0, 64, true },
+    { 0x8888888888888888ULL, 0x9999999999999999ULL,
+        0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
+    { 0x8888888888888888ULL, 0x9999999999999999ULL,
+        0, 0x8888888888888888ULL, 64, true },
+    { 0x8ULL, 0, 0, 0x8ULL, 64, false },
+    { 0x8ULL, 0, 0, 0x8000000000000000ULL, 124, false },
+    { 0x1ULL, 0, 0, 0x4000000000000000ULL, 126, false },
+    { 0x1ULL, 0, 0, 0x8000000000000000ULL, 127, false },
+    { 0x1ULL, 0, 0x1ULL, 0, 128, true },
+    { 0, 0, 0ULL, 0, 200, false },
+};
+
+static const test_data test_rtable[] = {
+    { 1223ULL, 0, 1223ULL,   0, 0, false },
+    { 9223372036854775808ULL, 9223372036854775808ULL,
+        2147483648L, 2147483648ULL, 32, false },
+    { 9223372036854775808ULL, 9223372036854775808ULL,
+        9223372036854775808ULL, 0, 64, false },
+    { 9223372036854775808ULL, 9223372036854775808ULL,
+        36028797018963968ULL, 0, 72, false },
+    { 9223372036854775808ULL, 9223372036854775808ULL,
+        1ULL, 0, 127, false },
+    { 9223372036854775808ULL, 0, 4611686018427387904ULL, 0, 1, false },
+    { 9223372036854775808ULL, 0, 2305843009213693952ULL, 0, 2, false },
+    { 9223372036854775808ULL, 0, 36028797018963968ULL, 0, 8, false },
+    { 9223372036854775808ULL, 0, 140737488355328ULL, 0, 16, false },
+    { 9223372036854775808ULL, 0, 2147483648ULL, 0, 32, false },
+    { 9223372036854775808ULL, 0, 1ULL, 0, 63, false },
+    { 9223372036854775808ULL, 0, 0ULL, 0, 64, false },
+};
+
+static void test_lshift(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(test_ltable); ++i) {
+        bool overflow = false;
+        test_data tmp = test_ltable[i];
+        ulshift(&tmp.low, &tmp.high, tmp.shift, &overflow);
+        g_assert_cmpuint(tmp.low, ==, tmp.rlow);
+        g_assert_cmpuint(tmp.high, ==, tmp.rhigh);
+        g_assert_cmpuint(tmp.overflow, ==, overflow);
+    }
+}
+
+static void test_rshift(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(test_rtable); ++i) {
+        test_data tmp = test_rtable[i];
+        urshift(&tmp.low, &tmp.high, tmp.shift);
+        g_assert_cmpuint(tmp.low, ==, tmp.rlow);
+        g_assert_cmpuint(tmp.high, ==, tmp.rhigh);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/host-utils/test_lshift", test_lshift);
+    g_test_add_func("/host-utils/test_rshift", test_rshift);
+    return g_test_run();
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index ad0f9c7..39ae26e 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -11,7 +11,7 @@ util-obj-$(CONFIG_POSIX) += memfd.o
 util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
 util-obj-y += envlist.o path.o module.o
-util-obj-$(call lnot,$(CONFIG_INT128)) += host-utils.o
+util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
 util-obj-y += acl.o
diff --git a/util/host-utils.c b/util/host-utils.c
index b166e57..1ee2433 100644
--- a/util/host-utils.c
+++ b/util/host-utils.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 
+#ifndef CONFIG_INT128
 /* Long integer helpers */
 static inline void mul64(uint64_t *plow, uint64_t *phigh,
                          uint64_t a, uint64_t b)
@@ -158,4 +159,47 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
 
     return overflow;
 }
+#endif
 
+void urshift(uint64_t *plow, uint64_t *phigh, uint32_t shift)
+{
+    shift &= 127;
+    uint64_t h = *phigh >> (shift & 63);
+    if (shift == 0) {
+        return;
+    } else if (shift >= 64) {
+        *plow = h;
+        *phigh = 0;
+    } else {
+        *plow = (*plow >> (shift & 63)) | (*phigh << (64 - (shift & 63)));
+        *phigh = h;
+    }
+}
+
+void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t shift, bool *overflow)
+{
+    uint64_t low = *plow;
+    uint64_t high = *phigh;
+
+    if (shift > 127 && (low | high)) {
+        *overflow = true;
+    }
+    shift &= 127;
+
+    if (shift == 0) {
+        return;
+    }
+
+    urshift(&low, &high, 128 - shift);
+    if (low > 0 || high > 0) {
+        *overflow = true;
+    }
+
+    if (shift >= 64) {
+        *phigh = *plow << (shift & 63);
+        *plow = 0;
+    } else {
+        *phigh = (*plow >> (64 - (shift & 63))) | (*phigh << (shift & 63));
+        *plow = *plow << shift;
+    }
+}
-- 
2.7.4
