Received: from eggs.gnu.org ([2001:4830:134:3::10]:40807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046k-S6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003MI-9N
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQi-0003L0-0v
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:51 -0400
Message-Id: <1528768140-17894-6-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 05/14] tests/fp: add fp-bench,
 a collection of simple floating point microbenchmarks
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

This will allow us to measure the performance impact of FP emulation
optimizations. Note that we can measure both directly the impact
on the softfloat functions (with "-t soft"), or the impact on an
emulated workload (call with "-t host" and run under qemu user-mode).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp/fp-bench.c | 526 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/fp/.gitignore |   1 +
 tests/fp/Makefile   |   4 +-
 3 files changed, 530 insertions(+), 1 deletion(-)
 create mode 100644 tests/fp/fp-bench.c

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
new file mode 100644
index 0000000..e4c6885
--- /dev/null
+++ b/tests/fp/fp-bench.c
@@ -0,0 +1,526 @@
+/*
+ * fp-bench.c - A collection of simple floating point microbenchmarks.
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#ifndef HW_POISON_H
+#error Must define HW_POISON_H to work around TARGET_* poisoning
+#endif
+
+#include "qemu/osdep.h"
+#include <math.h>
+#include "qemu/timer.h"
+#include "fpu/softfloat.h"
+
+/* amortize the computation of random inputs */
+#define OPS_PER_ITER     50000
+
+#define MAX_OPERANDS 3
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
+    OP_CMP,
+    OP_MAX_NR,
+};
+
+static const char * const op_names[] = {
+    [OP_ADD] = "add",
+    [OP_SUB] = "sub",
+    [OP_MUL] = "mul",
+    [OP_DIV] = "div",
+    [OP_FMA] = "fma",
+    [OP_SQRT] = "sqrt",
+    [OP_CMP] = "cmp",
+    [OP_MAX_NR] = NULL,
+};
+
+enum precision {
+    PREC_SINGLE,
+    PREC_DOUBLE,
+    PREC_FLOAT32,
+    PREC_FLOAT64,
+    PREC_MAX_NR,
+};
+
+enum tester {
+    TESTER_SOFT,
+    TESTER_HOST,
+    TESTER_MAX_NR,
+};
+
+static const char * const tester_names[] = {
+    [TESTER_SOFT] = "soft",
+    [TESTER_HOST] = "host",
+    [TESTER_MAX_NR] = NULL,
+};
+
+union fp {
+    float f;
+    double d;
+    float32 f32;
+    float64 f64;
+    uint64_t u64;
+};
+
+struct op_state;
+
+typedef float (*float_func_t)(const struct op_state *s);
+typedef double (*double_func_t)(const struct op_state *s);
+
+union fp_func {
+    float_func_t float_func;
+    double_func_t double_func;
+};
+
+typedef void (*bench_func_t)(void);
+
+struct op_desc {
+    const char * const name;
+};
+
+#define DEFAULT_DURATION_SECS 1
+
+static uint64_t random_ops[MAX_OPERANDS] = {
+    SEED_A, SEED_B, SEED_C,
+};
+static float_status soft_status;
+static enum precision precision;
+static enum op operation;
+static enum tester tester;
+static uint64_t n_completed_ops;
+static unsigned int duration = DEFAULT_DURATION_SECS;
+static int64_t ns_elapsed;
+/* disable optimizations with volatile */
+static volatile union fp res;
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
+static void update_random_ops(int n_ops, enum precision prec)
+{
+    int i;
+
+    for (i = 0; i < n_ops; i++) {
+        uint64_t r = random_ops[i];
+
+        if (prec == PREC_SINGLE || PREC_FLOAT32) {
+            do {
+                r = xorshift64star(r);
+            } while (!float32_is_normal(r));
+        } else if (prec == PREC_DOUBLE || PREC_FLOAT64) {
+            do {
+                r = xorshift64star(r);
+            } while (!float64_is_normal(r));
+        } else {
+            g_assert_not_reached();
+        }
+        random_ops[i] = r;
+    }
+}
+
+static void fill_random(union fp *ops, int n_ops, enum precision prec,
+                        bool no_neg)
+{
+    int i;
+
+    for (i = 0; i < n_ops; i++) {
+        switch (prec) {
+        case PREC_SINGLE:
+        case PREC_FLOAT32:
+            ops[i].f32 = make_float32(random_ops[i]);
+            if (no_neg && float32_is_neg(ops[i].f32)) {
+                ops[i].f32 = float32_chs(ops[i].f32);
+            }
+            /* raise the exponent to limit the frequency of denormal results */
+            ops[i].f32 |= 0x40000000;
+            break;
+        case PREC_DOUBLE:
+        case PREC_FLOAT64:
+            ops[i].f64 = make_float64(random_ops[i]);
+            if (no_neg && float64_is_neg(ops[i].f64)) {
+                ops[i].f64 = float64_chs(ops[i].f64);
+            }
+            /* raise the exponent to limit the frequency of denormal results */
+            ops[i].f64 |= LIT64(0x4000000000000000);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+/*
+ * The main benchmark function. Instead of (ab)using macros, we rely
+ * on the compiler to unfold this at compile-time.
+ */
+static void bench(enum precision prec, enum op op, int n_ops, bool no_neg)
+{
+    int64_t tf = get_clock_realtime() + duration * 1000000000LL;
+
+    while (get_clock_realtime() < tf) {
+        union fp ops[MAX_OPERANDS];
+        int64_t t0;
+        int i;
+
+        update_random_ops(n_ops, prec);
+        switch (prec) {
+        case PREC_SINGLE:
+            fill_random(ops, n_ops, prec, no_neg);
+            t0 = get_clock_realtime();
+            for (i = 0; i < OPS_PER_ITER; i++) {
+                float a = ops[0].f;
+                float b = ops[1].f;
+                float c = ops[2].f;
+
+                switch (op) {
+                case OP_ADD:
+                    res.f = a + b;
+                    break;
+                case OP_SUB:
+                    res.f = a - b;
+                    break;
+                case OP_MUL:
+                    res.f = a * b;
+                    break;
+                case OP_DIV:
+                    res.f = a / b;
+                    break;
+                case OP_FMA:
+                    res.f = fmaf(a, b, c);
+                    break;
+                case OP_SQRT:
+                    res.f = sqrtf(a);
+                    break;
+                case OP_CMP:
+                    res.u64 = isgreater(a, b);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
+        case PREC_DOUBLE:
+            fill_random(ops, n_ops, prec, no_neg);
+            t0 = get_clock_realtime();
+            for (i = 0; i < OPS_PER_ITER; i++) {
+                double a = ops[0].d;
+                double b = ops[1].d;
+                double c = ops[2].d;
+
+                switch (op) {
+                case OP_ADD:
+                    res.d = a + b;
+                    break;
+                case OP_SUB:
+                    res.d = a - b;
+                    break;
+                case OP_MUL:
+                    res.d = a * b;
+                    break;
+                case OP_DIV:
+                    res.d = a / b;
+                    break;
+                case OP_FMA:
+                    res.d = fma(a, b, c);
+                    break;
+                case OP_SQRT:
+                    res.d = sqrt(a);
+                    break;
+                case OP_CMP:
+                    res.u64 = isgreater(a, b);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
+        case PREC_FLOAT32:
+            fill_random(ops, n_ops, prec, no_neg);
+            t0 = get_clock_realtime();
+            for (i = 0; i < OPS_PER_ITER; i++) {
+                float32 a = ops[0].f32;
+                float32 b = ops[1].f32;
+                float32 c = ops[2].f32;
+
+                switch (op) {
+                case OP_ADD:
+                    res.f32 = float32_add(a, b, &soft_status);
+                    break;
+                case OP_SUB:
+                    res.f32 = float32_sub(a, b, &soft_status);
+                    break;
+                case OP_MUL:
+                    res.f = float32_mul(a, b, &soft_status);
+                    break;
+                case OP_DIV:
+                    res.f32 = float32_div(a, b, &soft_status);
+                    break;
+                case OP_FMA:
+                    res.f32 = float32_muladd(a, b, c, 0, &soft_status);
+                    break;
+                case OP_SQRT:
+                    res.f32 = float32_sqrt(a, &soft_status);
+                    break;
+                case OP_CMP:
+                    res.u64 = float32_compare_quiet(a, b, &soft_status);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
+        case PREC_FLOAT64:
+            fill_random(ops, n_ops, prec, no_neg);
+            t0 = get_clock_realtime();
+            for (i = 0; i < OPS_PER_ITER; i++) {
+                float64 a = ops[0].f64;
+                float64 b = ops[1].f64;
+                float64 c = ops[2].f64;
+
+                switch (op) {
+                case OP_ADD:
+                    res.f64 = float64_add(a, b, &soft_status);
+                    break;
+                case OP_SUB:
+                    res.f64 = float64_sub(a, b, &soft_status);
+                    break;
+                case OP_MUL:
+                    res.f = float64_mul(a, b, &soft_status);
+                    break;
+                case OP_DIV:
+                    res.f64 = float64_div(a, b, &soft_status);
+                    break;
+                case OP_FMA:
+                    res.f64 = float64_muladd(a, b, c, 0, &soft_status);
+                    break;
+                case OP_SQRT:
+                    res.f64 = float64_sqrt(a, &soft_status);
+                    break;
+                case OP_CMP:
+                    res.u64 = float64_compare_quiet(a, b, &soft_status);
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        ns_elapsed += get_clock_realtime() - t0;
+        n_completed_ops += OPS_PER_ITER;
+    }
+}
+
+#define GEN_BENCH(name, type, prec, op, n_ops)          \
+    static void __attribute__((flatten)) name(void)     \
+    {                                                   \
+        bench(prec, op, n_ops, false);                  \
+    }
+
+#define GEN_BENCH_NO_NEG(name, type, prec, op, n_ops)   \
+    static void __attribute__((flatten)) name(void)     \
+    {                                                   \
+        bench(prec, op, n_ops, true);                   \
+    }
+
+#define GEN_BENCH_ALL_TYPES(opname, op, n_ops)                          \
+    GEN_BENCH(bench_ ## opname ## _float, float, PREC_SINGLE, op, n_ops) \
+    GEN_BENCH(bench_ ## opname ## _double, double, PREC_DOUBLE, op, n_ops) \
+    GEN_BENCH(bench_ ## opname ## _float32, float32, PREC_FLOAT32, op, n_ops) \
+    GEN_BENCH(bench_ ## opname ## _float64, float64, PREC_FLOAT64, op, n_ops)
+
+GEN_BENCH_ALL_TYPES(add, OP_ADD, 2)
+GEN_BENCH_ALL_TYPES(sub, OP_SUB, 2)
+GEN_BENCH_ALL_TYPES(mul, OP_MUL, 2)
+GEN_BENCH_ALL_TYPES(div, OP_DIV, 2)
+GEN_BENCH_ALL_TYPES(fma, OP_FMA, 3)
+GEN_BENCH_ALL_TYPES(cmp, OP_CMP, 2)
+#undef GEN_BENCH_ALL_TYPES
+
+#define GEN_BENCH_ALL_TYPES_NO_NEG(name, op, n)                         \
+    GEN_BENCH_NO_NEG(bench_ ## name ## _float, float, PREC_SINGLE, op, n) \
+    GEN_BENCH_NO_NEG(bench_ ## name ## _double, double, PREC_DOUBLE, op, n) \
+    GEN_BENCH_NO_NEG(bench_ ## name ## _float32, float32, PREC_FLOAT32, op, n) \
+    GEN_BENCH_NO_NEG(bench_ ## name ## _float64, float64, PREC_FLOAT64, op, n)
+
+GEN_BENCH_ALL_TYPES_NO_NEG(sqrt, OP_SQRT, 1)
+#undef GEN_BENCH_ALL_TYPES_NO_NEG
+
+#undef GEN_BENCH_NO_NEG
+#undef GEN_BENCH
+
+#define GEN_BENCH_FUNCS(opname, op)                             \
+    [op] = {                                                    \
+        [PREC_SINGLE]    = bench_ ## opname ## _float,          \
+        [PREC_DOUBLE]    = bench_ ## opname ## _double,         \
+        [PREC_FLOAT32]   = bench_ ## opname ## _float32,        \
+        [PREC_FLOAT64]   = bench_ ## opname ## _float64,        \
+    }
+
+static const bench_func_t bench_funcs[OP_MAX_NR][PREC_MAX_NR] = {
+    GEN_BENCH_FUNCS(add, OP_ADD),
+    GEN_BENCH_FUNCS(sub, OP_SUB),
+    GEN_BENCH_FUNCS(mul, OP_MUL),
+    GEN_BENCH_FUNCS(div, OP_DIV),
+    GEN_BENCH_FUNCS(fma, OP_FMA),
+    GEN_BENCH_FUNCS(sqrt, OP_SQRT),
+    GEN_BENCH_FUNCS(cmp, OP_CMP),
+};
+
+#undef GEN_BENCH_FUNCS
+
+static void run_bench(void)
+{
+    bench_func_t f;
+
+    f = bench_funcs[operation][precision];
+    g_assert(f);
+    f();
+}
+
+/* @arr must be NULL-terminated */
+static int find_name(const char * const *arr, const char *name)
+{
+    int i;
+
+    for (i = 0; arr[i] != NULL; i++) {
+        if (strcmp(name, arr[i]) == 0) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static void usage_complete(int argc, char *argv[])
+{
+    gchar *op_list = g_strjoinv(", ", (gchar **)op_names);
+    gchar *tester_list = g_strjoinv(", ", (gchar **)tester_names);
+
+    fprintf(stderr, "Usage: %s [options]\n", argv[0]);
+    fprintf(stderr, "options:\n");
+    fprintf(stderr, "  -d = duration, in seconds. Default: %d\n",
+            DEFAULT_DURATION_SECS);
+    fprintf(stderr, "  -h = show this help message.\n");
+    fprintf(stderr, "  -o = floating point operation (%s). Default: %s\n",
+            op_list, op_names[0]);
+    fprintf(stderr, "  -p = floating point precision (single, double). "
+            "Default: single\n");
+    fprintf(stderr, "  -t = tester (%s). Default: %s\n",
+            tester_list, tester_names[0]);
+    fprintf(stderr, "  -z = flush inputs to zero (soft tester only). "
+            "Default: disabled\n");
+    fprintf(stderr, "  -Z = flush output to zero (soft tester only). "
+            "Default: disabled\n");
+
+    g_free(tester_list);
+    g_free(op_list);
+}
+
+static void parse_args(int argc, char *argv[])
+{
+    int c;
+    int val;
+
+    for (;;) {
+        c = getopt(argc, argv, "d:ho:p:t:zZ");
+        if (c < 0) {
+            break;
+        }
+        switch (c) {
+        case 'd':
+            duration = atoi(optarg);
+            break;
+        case 'h':
+            usage_complete(argc, argv);
+            exit(EXIT_SUCCESS);
+        case 'o':
+            val = find_name(op_names, optarg);
+            if (val < 0) {
+                fprintf(stderr, "Unsupported op '%s'\n", optarg);
+                exit(EXIT_FAILURE);
+            }
+            operation = val;
+            break;
+        case 'p':
+            if (!strcmp(optarg, "single")) {
+                precision = PREC_SINGLE;
+            } else if (!strcmp(optarg, "double")) {
+                precision = PREC_DOUBLE;
+            } else {
+                fprintf(stderr, "Unsupported precision '%s'\n", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 't':
+            val = find_name(tester_names, optarg);
+            if (val < 0) {
+                fprintf(stderr, "Unsupported tester '%s'\n", optarg);
+                exit(EXIT_FAILURE);
+            }
+            tester = val;
+            break;
+        case 'z':
+            soft_status.flush_inputs_to_zero = 1;
+            break;
+        case 'Z':
+            soft_status.flush_to_zero = 1;
+            break;
+        }
+    }
+
+    /* set precision based on the tester */
+    switch (tester) {
+    case TESTER_HOST:
+        break;
+    case TESTER_SOFT:
+        switch (precision) {
+        case PREC_SINGLE:
+            precision = PREC_FLOAT32;
+            break;
+        case PREC_DOUBLE:
+            precision = PREC_FLOAT64;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void pr_stats(void)
+{
+    printf("%.2f MFlops\n", (double)n_completed_ops / ns_elapsed * 1e3);
+}
+
+int main(int argc, char *argv[])
+{
+    parse_args(argc, argv);
+    run_bench();
+    pr_stats();
+    return 0;
+}
diff --git a/tests/fp/.gitignore b/tests/fp/.gitignore
index 0a9fef4..a4e59d7 100644
--- a/tests/fp/.gitignore
+++ b/tests/fp/.gitignore
@@ -1,3 +1,4 @@
 ibm
 *.txt
 fp-test
+fp-bench
diff --git a/tests/fp/Makefile b/tests/fp/Makefile
index a208f4c..7c88ab0 100644
--- a/tests/fp/Makefile
+++ b/tests/fp/Makefile
@@ -12,7 +12,7 @@ QEMU_CFLAGS += -DHW_POISON_H
 
 IBMFP := ibm-fptests.zip
 
-OBJS := fp-test$(EXESUF)
+OBJS := fp-test$(EXESUF) fp-bench$(EXESUF)
 
 WHITELIST_FILES := whitelist.txt whitelist-tininess-after.txt
 
@@ -30,5 +30,7 @@ $(WHITELIST_FILES):
 
 fp-test$(EXESUF): fp-test.o softfloat.o
 
+fp-bench$(EXESUF): fp-bench.o softfloat.o
+
 clean:
 	rm -f *.o *.d $(OBJS)
-- 
2.7.4
