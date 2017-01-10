Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltb-0001rU-TI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cQltY-0008RG-JA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cQltY-0008QI-9R
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 21:10:40 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A292p4000882
	for <qemu-devel@nongnu.org>; Mon, 9 Jan 2017 21:10:39 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vn3yaxty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 21:10:38 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 00:10:35 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 00:10:09 -0200
In-Reply-To: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1484014214-32533-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 2/7] host-utils: Implement unsigned quadword
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, eblake@redhat.com

Implements 128-bit left shift and right shift as well as their
testcases. By design, shift silently mods by 128, so the caller is
responsible to assert the shift range if necessary.

Left shift sets the overflow flag if any non-zero digit is shifted out.

Examples:
 ulshift(&low, &high, 250, &overflow);
 equivalent: n << 122

 urshift(&low, &high, -2);
 equivalent: n << 126

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 include/qemu/host-utils.h |  27 +++++++++
 tests/Makefile.include    |   5 +-
 tests/test-shift128.c     | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 util/host-utils.c         |  64 +++++++++++++++++++++
 4 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 tests/test-shift128.c

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 46187bb..89c3dc7 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -516,4 +516,31 @@ static inline uint64_t pow2ceil(uint64_t value)
     return 1ULL << (64 - nlz);
 }
 
+/**
+ * urshift - 128-bit Unsigned Right Shift.
+ * @plow: in/out - lower 64-bit integer.
+ * @phigh: in/out - higher 64-bit integer.
+ * @shift: in - bytes to shift, between 0 and 127.
+ *
+ * Result is zero-extended and stored in plow/phigh, which are
+ * input/output variables. Shift values outside the range will
+ * be mod to 128. In other words, the caller is responsible to
+ * verify/assert both the shift range and plow/phigh pointers.
+ */
+void urshift(uint64_t *plow, uint64_t *phigh, int32_t shift);
+
+/**
+ * ulshift - 128-bit Unsigned Left Shift.
+ * @plow: in/out - lower 64-bit integer.
+ * @phigh: in/out - higher 64-bit integer.
+ * @shift: in - bytes to shift, between 0 and 127.
+ * @overflow: out - true if any 1-bit is shifted out.
+ *
+ * Result is zero-extended and stored in plow/phigh, which are
+ * input/output variables. Shift values outside the range will
+ * be mod to 128. In other words, the caller is responsible to
+ * verify/assert both the shift range and plow/phigh pointers.
+ */
+void ulshift(uint64_t *plow, uint64_t *phigh, int32_t shift, bool *overflow);
+
 #endif
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0bb939d..1981a32 100644
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
@@ -466,7 +468,7 @@ test-obj-y = tests/check-qint.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
 	tests/test-opts-visitor.o tests/test-qmp-event.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
-	tests/test-qdist.o \
+	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
 	tests/atomic_add-bench.o
 
@@ -574,6 +576,7 @@ tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-qmp-marsh
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 
+tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test-crypto-obj-y)
diff --git a/tests/test-shift128.c b/tests/test-shift128.c
new file mode 100644
index 0000000..f3ff736
--- /dev/null
+++ b/tests/test-shift128.c
@@ -0,0 +1,139 @@
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
+    { 0x4C7ULL, 0x0ULL, 0x00000000000004C7ULL,
+      0x0000000000000000ULL,   0, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000002ULL,
+      0x0000000000000000ULL,   1, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000004ULL,
+      0x0000000000000000ULL,   2, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000010ULL,
+      0x0000000000000000ULL,   4, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000100ULL,
+      0x0000000000000000ULL,   8, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000010000ULL,
+      0x0000000000000000ULL,  16, false },
+    { 0x001ULL, 0x0ULL, 0x0000000080000000ULL,
+      0x0000000000000000ULL,  31, false },
+    { 0x001ULL, 0x0ULL, 0x0000200000000000ULL,
+      0x0000000000000000ULL,  45, false },
+    { 0x001ULL, 0x0ULL, 0x1000000000000000ULL,
+      0x0000000000000000ULL,  60, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x0000000000000001ULL,  64, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x0000000000010000ULL,  80, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x8000000000000000ULL, 127, false },
+    { 0x000ULL, 0x1ULL, 0x0000000000000000ULL,
+      0x0000000000000000ULL,  64,  true },
+    { 0x008ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x0000000000000008ULL,  64, false },
+    { 0x008ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x8000000000000000ULL, 124, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x4000000000000000ULL, 126, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x8000000000000000ULL, 127, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000001ULL,
+      0x0000000000000000ULL, 128,  false },
+    { 0x000ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x0000000000000000ULL, 200, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x0000000000000100ULL, 200,  false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x8000000000000000ULL,  -1, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x8000000000000000ULL, INT32_MAX, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x4000000000000000ULL,  -2, false },
+    { 0x001ULL, 0x0ULL, 0x0000000000000000ULL,
+      0x4000000000000000ULL, INT32_MAX - 1, false },
+    { 0x8888888888888888ULL, 0x9999999999999999ULL,
+      0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
+    { 0x8888888888888888ULL, 0x9999999999999999ULL,
+      0x0000000000000000ULL, 0x8888888888888888ULL, 64, true },
+};
+
+static const test_data test_rtable[] = {
+    { 0x00000000000004C7ULL, 0x0ULL, 0x00000000000004C7ULL, 0x0ULL,  0, false },
+    { 0x0800000000000000ULL, 0x0ULL, 0x0400000000000000ULL, 0x0ULL,  1, false },
+    { 0x0800000000000000ULL, 0x0ULL, 0x0200000000000000ULL, 0x0ULL,  2, false },
+    { 0x0800000000000000ULL, 0x0ULL, 0x0008000000000000ULL, 0x0ULL,  8, false },
+    { 0x0800000000000000ULL, 0x0ULL, 0x0000080000000000ULL, 0x0ULL, 16, false },
+    { 0x0800000000000000ULL, 0x0ULL, 0x0000000008000000ULL, 0x0ULL, 32, false },
+    { 0x8000000000000000ULL, 0x0ULL, 0x0000000000000001ULL, 0x0ULL, 63, false },
+    { 0x8000000000000000ULL, 0x0ULL, 0x0000000000000000ULL, 0x0ULL, 64, false },
+    { 0x0000000000000000ULL, 0x8000000000000000ULL,
+      0x0000000000000000ULL, 0x8000000000000000ULL, 128, false },
+    { 0x0000000000000000ULL, 0x8000000000000000ULL,
+      0x0080000000000000ULL, 0x0000000000000000ULL, 200, false },
+    { 0x0000000000000000ULL, 0x0000000000000000ULL,
+      0x0000000000000000ULL, 0x0000000000000000ULL, 200, false },
+    { 0x0000000000000000ULL, 0x8000000000000000ULL,
+      0x0000000000000000ULL, 0x0000000000000080ULL, -200, false },
+    { 0x8000000000000000ULL, 0x8000000000000000ULL,
+      0x0000000080000000ULL, 0x0000000080000000ULL, 32, false },
+    { 0x0800000000000000ULL, 0x0800000000000000ULL,
+      0x0800000000000000ULL, 0x0000000000000000ULL, 64, false },
+    { 0x0800000000000000ULL, 0x0800000000000000ULL,
+      0x0008000000000000ULL, 0x0000000000000000ULL, 72, false },
+    { 0x8000000000000000ULL, 0x8000000000000000ULL,
+      0x0000000000000001ULL, 0x0000000000000000ULL, 127, false },
+    { 0x0000000000000000ULL, 0x8000000000000000ULL,
+      0x0000000000000001ULL, 0x0000000000000000ULL, -1, false },
+    { 0x0000000000000000ULL, 0x8000000000000000ULL,
+      0x0000000000000002ULL, 0x0000000000000000ULL, -2, false },
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
diff --git a/util/host-utils.c b/util/host-utils.c
index 3495262..7b93220 100644
--- a/util/host-utils.c
+++ b/util/host-utils.c
@@ -161,3 +161,67 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
 }
 #endif
 
+/**
+ * urshift - 128-bit Unsigned Right Shift.
+ * @plow: in/out - lower 64-bit integer.
+ * @phigh: in/out - higher 64-bit integer.
+ * @shift: in - bytes to shift, between 0 and 127.
+ *
+ * Result is zero-extended and stored in plow/phigh, which are
+ * input/output variables. Shift values outside the range will
+ * be mod to 128. In other words, the caller is responsible to
+ * verify/assert both the shift range and plow/phigh pointers.
+ */
+void urshift(uint64_t *plow, uint64_t *phigh, int32_t shift)
+{
+    shift &= 127;
+    if (shift == 0) {
+        return;
+    }
+
+    uint64_t h = *phigh >> (shift & 63);
+    if (shift >= 64) {
+        *plow = h;
+        *phigh = 0;
+    } else {
+        *plow = (*plow >> (shift & 63)) | (*phigh << (64 - (shift & 63)));
+        *phigh = h;
+    }
+}
+
+/**
+ * ulshift - 128-bit Unsigned Left Shift.
+ * @plow: in/out - lower 64-bit integer.
+ * @phigh: in/out - higher 64-bit integer.
+ * @shift: in - bytes to shift, between 0 and 127.
+ * @overflow: out - true if any 1-bit is shifted out.
+ *
+ * Result is zero-extended and stored in plow/phigh, which are
+ * input/output variables. Shift values outside the range will
+ * be mod to 128. In other words, the caller is responsible to
+ * verify/assert both the shift range and plow/phigh pointers.
+ */
+void ulshift(uint64_t *plow, uint64_t *phigh, int32_t shift, bool *overflow)
+{
+    uint64_t low = *plow;
+    uint64_t high = *phigh;
+
+    shift &= 127;
+    if (shift == 0) {
+        return;
+    }
+
+    /* check if any bit will be shifted out */
+    urshift(&low, &high, 128 - shift);
+    if (low | high) {
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
