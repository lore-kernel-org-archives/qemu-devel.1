Received: from eggs.gnu.org ([2001:4830:134:3::10]:52434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kA-0007pY-Uh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k1-00046P-6t
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:09 +1100
Message-Id: <20170202051445.5735-72-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 071/107] host-utils: Implement unsigned quadword
 left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

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
Reviewed-by: Eric Blake <eblake@redhat.com>
[dwg: Added test-shift128 to .gitignore]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/qemu/host-utils.h |  27 +++++++++
 tests/.gitignore          |   1 +
 tests/Makefile.include    |   5 +-
 tests/test-shift128.c     | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 util/host-utils.c         |  64 +++++++++++++++++++++
 5 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 tests/test-shift128.c

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 96288d0..a38be42 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -513,4 +513,31 @@ static inline uint64_t pow2ceil(uint64_t value)
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
diff --git a/tests/.gitignore b/tests/.gitignore
index 7357d0a..dc37519 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -69,6 +69,7 @@ test-qmp-marshal.c
 test-qobject-output-visitor
 test-rcu-list
 test-replication
+test-shift128
 test-string-input-visitor
 test-string-output-visitor
 test-thread-pool
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c35fa75..1f6b732 100644
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
@@ -487,7 +489,7 @@ test-obj-y = tests/check-qint.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
 	tests/test-opts-visitor.o tests/test-qmp-event.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
-	tests/test-qdist.o \
+	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
 	tests/atomic_add-bench.o
 
@@ -596,6 +598,7 @@ tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-qmp-marsh
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serialization.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-obj-y)
 
+tests/test-shift128$(EXESUF): tests/test-shift128.o $(test-util-obj-y)
 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
 tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
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
2.9.3
