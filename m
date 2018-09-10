Received: from eggs.gnu.org ([2001:4830:134:3::10]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjt-0003bp-7o
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbR-0005Io-W5
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbR-0005HY-MO
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:43 -0400
Message-Id: <20180910232752.31565-4-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 03/12] tests: add atomic64-bench
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

- With CONFIG_ATOMIC64:
$ tests/atomic64-bench  -n 1
 Throughput:         310.40 Mops/s

- Without:
$ tests/atomic64-bench  -n 1
 Throughput:         149.08 Mops/s

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/atomic64-bench.c | 171 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   3 +-
 2 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 tests/atomic64-bench.c

diff --git a/tests/atomic64-bench.c b/tests/atomic64-bench.c
new file mode 100644
index 0000000000..71692560ed
--- /dev/null
+++ b/tests/atomic64-bench.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+#include "qemu/host-utils.h"
+#include "qemu/processor.h"
+
+struct thread_info {
+    uint64_t r;
+    uint64_t accesses;
+} QEMU_ALIGNED(64);
+
+struct count {
+    int64_t i64;
+} QEMU_ALIGNED(64);
+
+static QemuThread *threads;
+static struct thread_info *th_info;
+static unsigned int n_threads = 1;
+static unsigned int n_ready_threads;
+static struct count *counts;
+static unsigned int duration = 1;
+static unsigned int range = 1024;
+static bool test_start;
+static bool test_stop;
+
+static const char commands_string[] =
+    " -d = duration in seconds\n"
+    " -n = number of threads\n"
+    " -r = range (will be rounded up to pow2)";
+
+static void usage_complete(char *argv[])
+{
+    fprintf(stderr, "Usage: %s [options]\n", argv[0]);
+    fprintf(stderr, "options:\n%s\n", commands_string);
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
+static void *thread_func(void *arg)
+{
+    struct thread_info *info = arg;
+
+    atomic_inc(&n_ready_threads);
+    while (!atomic_read(&test_start)) {
+        cpu_relax();
+    }
+
+    while (!atomic_read(&test_stop)) {
+        unsigned int index;
+
+        info->r = xorshift64star(info->r);
+        index = info->r & (range - 1);
+        atomic_read_i64(&counts[index].i64);
+        info->accesses++;
+    }
+    return NULL;
+}
+
+static void run_test(void)
+{
+    unsigned int remaining;
+    unsigned int i;
+
+    while (atomic_read(&n_ready_threads) != n_threads) {
+        cpu_relax();
+    }
+    atomic_set(&test_start, true);
+    do {
+        remaining = sleep(duration);
+    } while (remaining);
+    atomic_set(&test_stop, true);
+
+    for (i = 0; i < n_threads; i++) {
+        qemu_thread_join(&threads[i]);
+    }
+}
+
+static void create_threads(void)
+{
+    unsigned int i;
+
+    threads = g_new(QemuThread, n_threads);
+    th_info = g_new(struct thread_info, n_threads);
+    counts = g_malloc0_n(range, sizeof(*counts));
+
+    for (i = 0; i < n_threads; i++) {
+        struct thread_info *info = &th_info[i];
+
+        info->r = (i + 1) ^ time(NULL);
+        info->accesses = 0;
+        qemu_thread_create(&threads[i], NULL, thread_func, info,
+                           QEMU_THREAD_JOINABLE);
+    }
+}
+
+static void pr_params(void)
+{
+    printf("Parameters:\n");
+    printf(" # of threads:      %u\n", n_threads);
+    printf(" duration:          %u\n", duration);
+    printf(" ops' range:        %u\n", range);
+}
+
+static void pr_stats(void)
+{
+    unsigned long long val = 0;
+    double tx;
+    int i;
+
+    for (i = 0; i < n_threads; i++) {
+        val += th_info[i].accesses;
+    }
+    tx = val / duration / 1e6;
+
+    printf("Results:\n");
+    printf("Duration:            %u s\n", duration);
+    printf(" Throughput:         %.2f Mops/s\n", tx);
+    printf(" Throughput/thread:  %.2f Mops/s/thread\n", tx / n_threads);
+}
+
+static void parse_args(int argc, char *argv[])
+{
+    int c;
+
+    for (;;) {
+        c = getopt(argc, argv, "hd:n:r:");
+        if (c < 0) {
+            break;
+        }
+        switch (c) {
+        case 'h':
+            usage_complete(argv);
+            exit(0);
+        case 'd':
+            duration = atoi(optarg);
+            break;
+        case 'n':
+            n_threads = atoi(optarg);
+            break;
+        case 'r':
+            range = pow2ceil(atoi(optarg));
+            break;
+        }
+    }
+}
+
+int main(int argc, char *argv[])
+{
+    parse_args(argc, argv);
+    pr_params();
+    create_threads();
+    run_test();
+    pr_stats();
+    return 0;
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 87c81d1dcc..b12b6a867a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -601,7 +601,7 @@ test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
 	tests/test-rcu-tailq.o \
 	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
-	tests/atomic_add-bench.o
+	tests/atomic_add-bench.o tests/atomic64-bench.o
 
 $(test-obj-y): QEMU_INCLUDES += -Itests
 QEMU_CFLAGS += -I$(SRC_PATH)/tests
@@ -656,6 +656,7 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
 tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
 tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
+tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-- 
2.17.1
