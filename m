Received: from eggs.gnu.org ([2001:4830:134:3::10]:44544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdL7P-0008Lm-7v
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdL7M-00035s-2H
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:12:55 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Feb 2017 19:12:41 +0100
Message-Id: <20170213181244.16297-4-pbonzini@redhat.com>
In-Reply-To: <20170213181244.16297-1-pbonzini@redhat.com>
References: <20170213181244.16297-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] test-aio-multithread: add performance
 comparison with thread-based mutexes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Add two implementations of the same benchmark as the previous patch,
but using pthreads.  One uses a normal QemuMutex, the other is Linux
only and implements a fair mutex based on MCS locks and futexes.
This shows that the slower performance of the 5-thread case is due to
the fairness of CoMutex, rather than to coroutines.  If fairness does
not matter, as is the case with two threads, CoMutex can actually be
faster than pthreads.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-aio-multithread.c | 164 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index ada8c48..e7256a9 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -278,6 +278,162 @@ static void test_multi_co_mutex_2_30(void)
     test_multi_co_mutex(2, 30);
 }
 
+/* Same test with fair mutexes, for performance comparison.  */
+
+#ifdef CONFIG_LINUX
+#include "qemu/futex.h"
+
+/* The nodes for the mutex reside in this structure (on which we try to avoid
+ * false sharing).  The head of the mutex is in the "mutex_head" variable.
+ */
+static struct {
+    int next, locked;
+    int padding[14];
+} nodes[NUM_CONTEXTS] __attribute__((__aligned__(64)));
+
+static int mutex_head = -1;
+
+static void mcs_mutex_lock(void)
+{
+    int prev;
+
+    nodes[id].next = -1;
+    nodes[id].locked = 1;
+    prev = atomic_xchg(&mutex_head, id);
+    if (prev != -1) {
+        atomic_set(&nodes[prev].next, id);
+        qemu_futex_wait(&nodes[id].locked, 1);
+    }
+}
+
+static void mcs_mutex_unlock(void)
+{
+    int next;
+    if (nodes[id].next == -1) {
+        if (atomic_read(&mutex_head) == id &&
+            atomic_cmpxchg(&mutex_head, id, -1) == id) {
+            /* Last item in the list, exit.  */
+            return;
+        }
+        while (atomic_read(&nodes[id].next) == -1) {
+            /* mcs_mutex_lock did the xchg, but has not updated
+             * nodes[prev].next yet.
+             */
+        }
+    }
+
+    /* Wake up the next in line.  */
+    next = nodes[id].next;
+    nodes[next].locked = 0;
+    qemu_futex_wake(&nodes[next].locked, 1);
+}
+
+static void test_multi_fair_mutex_entry(void *opaque)
+{
+    while (!atomic_mb_read(&now_stopping)) {
+        mcs_mutex_lock();
+        counter++;
+        mcs_mutex_unlock();
+        atomic_inc(&atomic_counter);
+    }
+    atomic_dec(&running);
+}
+
+static void test_multi_fair_mutex(int threads, int seconds)
+{
+    int i;
+
+    assert(mutex_head == -1);
+    counter = 0;
+    atomic_counter = 0;
+    now_stopping = false;
+
+    create_aio_contexts();
+    assert(threads <= NUM_CONTEXTS);
+    running = threads;
+    for (i = 0; i < threads; i++) {
+        Coroutine *co1 = qemu_coroutine_create(test_multi_fair_mutex_entry, NULL);
+        aio_co_schedule(ctx[i], co1);
+    }
+
+    g_usleep(seconds * 1000000);
+
+    atomic_mb_set(&now_stopping, true);
+    while (running > 0) {
+        g_usleep(100000);
+    }
+
+    join_aio_contexts();
+    g_test_message("%d iterations/second\n", counter / seconds);
+    g_assert_cmpint(counter, ==, atomic_counter);
+}
+
+static void test_multi_fair_mutex_1(void)
+{
+    test_multi_fair_mutex(NUM_CONTEXTS, 1);
+}
+
+static void test_multi_fair_mutex_10(void)
+{
+    test_multi_fair_mutex(NUM_CONTEXTS, 10);
+}
+#endif
+
+/* Same test with pthread mutexes, for performance comparison and
+ * portability.  */
+
+static QemuMutex mutex;
+
+static void test_multi_mutex_entry(void *opaque)
+{
+    while (!atomic_mb_read(&now_stopping)) {
+        qemu_mutex_lock(&mutex);
+        counter++;
+        qemu_mutex_unlock(&mutex);
+        atomic_inc(&atomic_counter);
+    }
+    atomic_dec(&running);
+}
+
+static void test_multi_mutex(int threads, int seconds)
+{
+    int i;
+
+    qemu_mutex_init(&mutex);
+    counter = 0;
+    atomic_counter = 0;
+    now_stopping = false;
+
+    create_aio_contexts();
+    assert(threads <= NUM_CONTEXTS);
+    running = threads;
+    for (i = 0; i < threads; i++) {
+        Coroutine *co1 = qemu_coroutine_create(test_multi_mutex_entry, NULL);
+        aio_co_schedule(ctx[i], co1);
+    }
+
+    g_usleep(seconds * 1000000);
+
+    atomic_mb_set(&now_stopping, true);
+    while (running > 0) {
+        g_usleep(100000);
+    }
+
+    join_aio_contexts();
+    g_test_message("%d iterations/second\n", counter / seconds);
+    g_assert_cmpint(counter, ==, atomic_counter);
+}
+
+static void test_multi_mutex_1(void)
+{
+    test_multi_mutex(NUM_CONTEXTS, 1);
+}
+
+static void test_multi_mutex_10(void)
+{
+    test_multi_mutex(NUM_CONTEXTS, 10);
+}
+
 /* End of tests.  */
 
 int main(int argc, char **argv)
@@ -290,10 +446,18 @@ int main(int argc, char **argv)
         g_test_add_func("/aio/multi/schedule", test_multi_co_schedule_1);
         g_test_add_func("/aio/multi/mutex/contended", test_multi_co_mutex_1);
         g_test_add_func("/aio/multi/mutex/handoff", test_multi_co_mutex_2_3);
+#ifdef CONFIG_LINUX
+        g_test_add_func("/aio/multi/mutex/mcs", test_multi_fair_mutex_1);
+#endif
+        g_test_add_func("/aio/multi/mutex/pthread", test_multi_mutex_1);
     } else {
         g_test_add_func("/aio/multi/schedule", test_multi_co_schedule_10);
         g_test_add_func("/aio/multi/mutex/contended", test_multi_co_mutex_10);
         g_test_add_func("/aio/multi/mutex/handoff", test_multi_co_mutex_2_30);
+#ifdef CONFIG_LINUX
+        g_test_add_func("/aio/multi/mutex/mcs", test_multi_fair_mutex_10);
+#endif
+        g_test_add_func("/aio/multi/mutex/pthread", test_multi_mutex_10);
     }
     return g_test_run();
 }
-- 
2.9.3
