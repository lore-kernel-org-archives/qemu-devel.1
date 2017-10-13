Received: from eggs.gnu.org ([2001:4830:134:3::10]:43921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sU-0000UE-0u
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sS-0002CR-Pi
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:02 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:50728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sS-0002Bh-H8
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:00 -0400
Received: by mail-wm0-x232.google.com with SMTP id u138so22538024wmu.5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:34 +0100
Message-Id: <20171013162438.32458-27-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 26/30] tests/test-softfloat: add a simple
 test framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a simple pattern based framework for testing our softfloat
implementation. It is easier to use while debugging softfloat itself
than indirectly with a tool like risu.

As the softfloat library is built against given targets we need a
version per target architecture we build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include |  8 ++++++-
 tests/test-softfloat.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 tests/test-softfloat.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4ca15e6817..8bf1dfd19a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -156,6 +156,10 @@ check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
+check-unit-y += tests/test-softfloat$(EXESUF)
+gcov-files-test-softfloat-y = fpu/softfloat.c
+check-unit-y += tests/test-softfloat-aarch64$(EXESUF)
+gcov-files-test-softfloat-aarch64-y = fpu/softfloat.c
 
 check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
@@ -555,7 +559,7 @@ test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
 	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
-	tests/atomic_add-bench.o
+	tests/atomic_add-bench.o tests/test-softfloat.o
 
 $(test-obj-y): QEMU_INCLUDES += -Itests
 QEMU_CFLAGS += -I$(SRC_PATH)/tests
@@ -604,6 +608,8 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
 tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+tests/test-softfloat$(EXESUF): tests/test-softfloat.o $(BUILD_DIR)/aarch64-softmmu/fpu/softfloat.o
+tests/test-softfloat-aarch64$(EXESUF): tests/test-softfloat.o $(BUILD_DIR)/aarch64-softmmu/fpu/softfloat.o
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
diff --git a/tests/test-softfloat.c b/tests/test-softfloat.c
new file mode 100644
index 0000000000..d7b740e1cb
--- /dev/null
+++ b/tests/test-softfloat.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2017, Linaro
+ * Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+
+typedef struct {
+    float_status initial_status;
+    float16 in;
+    float16 out;
+    uint8_t final_exception_flags;
+} f16_test_data;
+
+static void test_f16_round_to_int(void)
+{
+    int i;
+    float16 out;
+    float_status flags, *fp = &flags;
+    f16_test_data test_data[] = {
+        { { /* defaults */ }, 0x87FF, 0x8000 },
+        { { /* defaults */ }, 0xE850, 0xE850 },
+        { { /* defaults */ }, 0x0000, 0x0000 },
+        { { /* defaults */ }, 0x857F, 0x8000 },
+        { { /* defaults */ }, 0x74FB, 0x74FB },
+        /* from risu 3b4:       4ef98945        frintp  v5.8h, v10.8h */
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0x06b1, 0x3c00, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0x6966, 0x6966, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0x83c0, 0x8000, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0xa619, 0x8000, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0x9cf4, 0x8000, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0xee11, 0xee11, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0xee5c, 0xee5c, 0 },
+        { { .float_detect_tininess = 1, .float_rounding_mode = 2}, 0x8004, 0x8000, 0 }
+    };
+
+    for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+        flags = test_data[i].initial_status;
+        out = float16_round_to_int(test_data[i].in, fp);
+
+        if (!(test_data[i].out == out)) {
+            fprintf(stderr, "%s[%d]: expected %#04x got %#04x\n",
+                    __func__, i, test_data[i].out, out);
+            g_test_fail();
+        }
+    }
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/softfloat/f16/round_to_int", test_f16_round_to_int);
+    return g_test_run();
+}
-- 
2.14.1
