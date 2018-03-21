Received: from eggs.gnu.org ([2001:4830:134:3::10]:42173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5W-0002A1-0M
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5Q-0000y8-R4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5Q-0000xG-K5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:36 -0400
Message-Id: <1521663109-32262-2-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 01/14] tests: add fp-bench,
 a collection of simple floating-point microbenchmarks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This will allow us to measure the performance impact of FP
emulation optimizations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp-bench.c       | 290 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/.gitignore       |   1 +
 tests/Makefile.include |   3 +-
 3 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 tests/fp-bench.c

diff --git a/tests/fp-bench.c b/tests/fp-bench.c
new file mode 100644
index 0000000..a782093
--- /dev/null
+++ b/tests/fp-bench.c
@@ -0,0 +1,290 @@
+/*
+ * fp-bench.c - A collection of simple floating point microbenchmarks.
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/atomic.h"
+
+#include <math.h>
+
+#include <sys/time.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <time.h>
+
+/* amortize the computation of random inputs */
+#define OPS_PER_ITER     (1000ULL)
+
+#define SEED_A 0xdeadfacedeadface
+#define SEED_B 0xbadc0feebadc0fee
+#define SEED_C 0xbeefdeadbeefdead
+
+enum op {
+    OP_ADD,
+    OP_SUB,
+    OP_MUL,
+    OP_DIV,
+    OP_FMA,
+    OP_SQRT,
+};
+
+static const char * const op_names[] = {
+    [OP_ADD] = "add",
+    [OP_SUB] = "sub",
+    [OP_MUL] = "mul",
+    [OP_DIV] = "div",
+    [OP_FMA] = "fma",
+    [OP_SQRT] = "sqrt",
+};
+
+static uint64_t n_ops = 10000000;
+static enum op op;
+static const char *precision = "float";
+
+static const char commands_string[] =
+    " -n = number of floating point operations\n"
+    " -o = floating point operation (add, sub, mul, div, fma, sqrt). Default: add\n"
+    " -p = precision (float|single, double). Default: float";
+
+static void usage_complete(int argc, char *argv[])
+{
+    fprintf(stderr, "Usage: %s [options]\n", argv[0]);
+    fprintf(stderr, "options:\n%s\n", commands_string);
+    exit(-1);
+}
+
+static void set_op(const char *name)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(op_names); i++) {
+        if (strcmp(name, op_names[i]) == 0) {
+            op = i;
+            return;
+        }
+    }
+    fprintf(stderr, "Unsupported op '%s'\n", name);
+    exit(EXIT_FAILURE);
+}
+
+static inline int64_t get_clock_realtime(void)
+{
+    struct timeval tv;
+
+    gettimeofday(&tv, NULL);
+    return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
+}
+
+/*
+ * From: https://en.wikipedia.org/wiki/Xorshift
+ * This is faster than rand_r(), and gives us a wider range (RAND_MAX is only
+ * guaranteed to be >= INT_MAX).
+ */
+static uint64_t xorshift64star(uint64_t x)
+{
+    x ^= x >> 12; /* a */
+    x ^= x << 25; /* b */
+    x ^= x >> 27; /* c */
+    return x * UINT64_C(2685821657736338717);
+}
+
+static inline bool u32_is_normal(uint32_t x)
+{
+    return ((x + 0x00800000) & 0x7fffffff) >= 0x01000000;
+}
+
+static inline bool u64_is_normal(uint64_t x)
+{
+    return ((x + (1ULL << 52)) & -1ULL >> 1) >= 1ULL << 53;
+}
+
+static inline float get_random_float(uint64_t *x)
+{
+    uint64_t r = *x;
+    uint32_t r32;
+
+    do {
+        r = xorshift64star(r);
+    } while (!u32_is_normal(r));
+    *x = r;
+    r32 = r;
+    return *(float *)&r32;
+}
+
+static inline double get_random_double(uint64_t *x)
+{
+    uint64_t r = *x;
+
+    do {
+        r = xorshift64star(r);
+    } while (!u64_is_normal(r));
+    *x = r;
+    return *(double *)&r;
+}
+
+/*
+ * Disable optimizations (e.g. "a OP b" outside of the inner loop) with
+ * volatile.
+ */
+#define GEN_BENCH_1OPF(NAME, FUNC, PRECISION)                           \
+    static void NAME(volatile PRECISION *res)                           \
+    {                                                                   \
+        uint64_t ra = SEED_A;                                           \
+        uint64_t i, j;                                                  \
+                                                                        \
+        for (i = 0; i < n_ops; i += OPS_PER_ITER) {                     \
+            volatile PRECISION a = glue(get_random_, PRECISION)(&ra);   \
+                                                                        \
+            for (j = 0; j < OPS_PER_ITER; j++) {                        \
+                *res = FUNC(a);                                         \
+            }                                                           \
+        }                                                               \
+    }
+
+GEN_BENCH_1OPF(bench_float_sqrt, sqrtf, float)
+GEN_BENCH_1OPF(bench_double_sqrt, sqrt, double)
+#undef GEN_BENCH_1OPF
+
+#define GEN_BENCH_2OP(NAME, OP, PRECISION)                              \
+    static void NAME(volatile PRECISION *res)                           \
+    {                                                                   \
+        uint64_t ra = SEED_A;                                           \
+        uint64_t rb = SEED_B;                                           \
+        uint64_t i, j;                                                  \
+                                                                        \
+        for (i = 0; i < n_ops; i += OPS_PER_ITER) {                     \
+            volatile PRECISION a = glue(get_random_, PRECISION)(&ra);   \
+            volatile PRECISION b = glue(get_random_, PRECISION)(&rb);   \
+                                                                        \
+            for (j = 0; j < OPS_PER_ITER; j++) {                        \
+                *res = a OP b;                                          \
+            }                                                           \
+        }                                                               \
+    }
+
+GEN_BENCH_2OP(bench_float_add, +, float)
+GEN_BENCH_2OP(bench_float_sub, -, float)
+GEN_BENCH_2OP(bench_float_mul, *, float)
+GEN_BENCH_2OP(bench_float_div, /, float)
+
+GEN_BENCH_2OP(bench_double_add, +, double)
+GEN_BENCH_2OP(bench_double_sub, -, double)
+GEN_BENCH_2OP(bench_double_mul, *, double)
+GEN_BENCH_2OP(bench_double_div, /, double)
+
+#define GEN_BENCH_3OPF(NAME, FUNC, PRECISION)                           \
+    static void NAME(volatile PRECISION *res)                           \
+    {                                                                   \
+        uint64_t ra = SEED_A;                                           \
+        uint64_t rb = SEED_B;                                           \
+        uint64_t rc = SEED_C;                                           \
+        uint64_t i, j;                                                  \
+                                                                        \
+        for (i = 0; i < n_ops; i += OPS_PER_ITER) {                     \
+            volatile PRECISION a = glue(get_random_, PRECISION)(&ra);   \
+            volatile PRECISION b = glue(get_random_, PRECISION)(&rb);   \
+            volatile PRECISION c = glue(get_random_, PRECISION)(&rc);   \
+                                                                        \
+            for (j = 0; j < OPS_PER_ITER; j++) {                        \
+                *res = FUNC(a, b, c);                                   \
+            }                                                           \
+        }                                                               \
+    }
+
+GEN_BENCH_3OPF(bench_float_fma, fmaf, float)
+GEN_BENCH_3OPF(bench_double_fma, fma, double)
+#undef GEN_BENCH_3OPF
+
+static void parse_args(int argc, char *argv[])
+{
+    int c;
+
+    for (;;) {
+        c = getopt(argc, argv, "n:ho:p:");
+        if (c < 0) {
+            break;
+        }
+        switch (c) {
+        case 'h':
+            usage_complete(argc, argv);
+            exit(0);
+        case 'n':
+            n_ops = atoll(optarg);
+            if (n_ops < OPS_PER_ITER) {
+                n_ops = OPS_PER_ITER;
+            }
+            n_ops -= n_ops % OPS_PER_ITER;
+            break;
+        case 'o':
+            set_op(optarg);
+            break;
+        case 'p':
+            precision = optarg;
+            if (strcmp(precision, "float") &&
+                strcmp(precision, "single") &&
+                strcmp(precision, "double")) {
+                fprintf(stderr, "Unsupported precision '%s'\n", precision);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        }
+    }
+}
+
+#define CALL_BENCH(OP, PRECISION, RESP)                 \
+    do {                                                \
+        switch (OP) {                                   \
+        case OP_ADD:                                    \
+            glue(glue(bench_, PRECISION), _add)(RESP);  \
+            break;                                      \
+        case OP_SUB:                                    \
+            glue(glue(bench_, PRECISION), _sub)(RESP);  \
+            break;                                      \
+        case OP_MUL:                                    \
+            glue(glue(bench_, PRECISION), _mul)(RESP);  \
+            break;                                      \
+        case OP_DIV:                                    \
+            glue(glue(bench_, PRECISION), _div)(RESP);  \
+            break;                                      \
+        case OP_FMA:                                    \
+            glue(glue(bench_, PRECISION), _fma)(RESP);  \
+            break;                                      \
+        case OP_SQRT:                                   \
+            glue(glue(bench_, PRECISION), _sqrt)(RESP); \
+            break;                                      \
+        default:                                        \
+            g_assert_not_reached();                     \
+        }                                               \
+    } while (0)
+
+int main(int argc, char *argv[])
+{
+    int64_t t0, t1;
+    double resd;
+
+    parse_args(argc, argv);
+    if (!strcmp(precision, "float") || !strcmp(precision, "single")) {
+        float res;
+        t0 = get_clock_realtime();
+        CALL_BENCH(op, float, &res);
+        t1 = get_clock_realtime();
+        resd = res;
+    } else if (!strcmp(precision, "double")) {
+        t0 = get_clock_realtime();
+        CALL_BENCH(op, double, &resd);
+        t1 = get_clock_realtime();
+    } else {
+        g_assert_not_reached();
+    }
+    printf("%.2f MFlops\n", (double)n_ops / (t1 - t0) * 1e3);
+    if (resd) {
+        return 0;
+    }
+    return 0;
+}
diff --git a/tests/.gitignore b/tests/.gitignore
index 18e58b2..df69175 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -12,6 +12,7 @@ check-qobject
 check-qstring
 check-qom-interface
 check-qom-proplist
+fp-bench
 qht-bench
 rcutorture
 test-aio
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ef9b88c..f6121ee 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -587,7 +587,7 @@ test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
 	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
-	tests/atomic_add-bench.o
+	tests/atomic_add-bench.o tests/fp-bench.o
 
 $(test-obj-y): QEMU_INCLUDES += -Itests
 QEMU_CFLAGS += -I$(SRC_PATH)/tests
@@ -639,6 +639,7 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
 tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+tests/fp-bench$(EXESUF): tests/fp-bench.o $(test-util-obj-y)
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-- 
2.7.4
