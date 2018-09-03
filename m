Received: from eggs.gnu.org ([2001:4830:134:3::10]:34244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUp-00059O-GI
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUm-00076o-HP
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fwsUm-00075i-B9
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  3 Sep 2018 13:18:27 -0400
Message-Id: <20180903171831.15446-3-cota@braap.org>
In-Reply-To: <20180903171831.15446-1-cota@braap.org>
References: <20180903171831.15446-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/6] test-rcu-list: avoid torn accesses to
 n_reclaims and n_nodes_removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-rcu-list.c | 67 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 192bfbf02e..2606b7c19d 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -25,6 +25,23 @@
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
 #include "qemu/rcu_queue.h"
+#include "qemu/seqlock.h"
+
+/*
+ * Abstraction to avoid torn accesses when there is a single thread updating
+ * the count.
+ *
+ * If CONFIG_ATOMIC64 is defined, we simply use atomic accesses. Otherwise, we
+ * use a seqlock without a lock, since only one thread can update the count.
+ */
+struct Count {
+    long long val;
+#ifndef CONFIG_ATOMIC64
+    QemuSeqLock sequence;
+#endif
+};
+
+typedef struct Count Count;
 
 /*
  * Test variables.
@@ -33,8 +50,8 @@
 static QemuMutex counts_mutex;
 static long long n_reads = 0LL;
 static long long n_updates = 0LL;
-static long long n_reclaims = 0LL;
-static long long n_nodes_removed = 0LL;
+static Count n_reclaims;
+static Count n_nodes_removed;
 static long long n_nodes = 0LL;
 static int g_test_in_charge = 0;
 
@@ -60,6 +77,38 @@ static int select_random_el(int max)
     return (rand() % max);
 }
 
+static inline long long count_read(Count *c)
+{
+#ifdef CONFIG_ATOMIC64
+    /* use __nocheck because sizeof(void *) might be < sizeof(long long) */
+    return atomic_read__nocheck(&c->val);
+#else
+    unsigned int version;
+    long long val;
+
+    do {
+        version = seqlock_read_begin(&c->sequence);
+        val = c->val;
+    } while (seqlock_read_retry(&c->sequence, version));
+    return val;
+#endif
+}
+
+static inline void count_add(Count *c, long long val)
+{
+#ifdef CONFIG_ATOMIC64
+    atomic_set__nocheck(&c->val, c->val + val);
+#else
+    seqlock_write_begin(&c->sequence);
+    c->val += val;
+    seqlock_write_end(&c->sequence);
+#endif
+}
+
+static inline void count_inc(Count *c)
+{
+    count_add(c, 1);
+}
 
 static void create_thread(void *(*func)(void *))
 {
@@ -104,7 +153,7 @@ static void reclaim_list_el(struct rcu_head *prcu)
     struct list_element *el = container_of(prcu, struct list_element, rcu);
     g_free(el);
     /* Accessed only from call_rcu thread.  */
-    n_reclaims++;
+    count_inc(&n_reclaims);
 }
 
 #if TEST_LIST_TYPE == 1
@@ -232,7 +281,7 @@ static void *rcu_q_updater(void *arg)
     qemu_mutex_lock(&counts_mutex);
     n_nodes += n_nodes_local;
     n_updates += n_updates_local;
-    n_nodes_removed += n_removed_local;
+    count_add(&n_nodes_removed, n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     return NULL;
 }
@@ -286,19 +335,21 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
         n_removed_local++;
     }
     qemu_mutex_lock(&counts_mutex);
-    n_nodes_removed += n_removed_local;
+    count_add(&n_nodes_removed, n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     synchronize_rcu();
-    while (n_nodes_removed > n_reclaims) {
+    while (count_read(&n_nodes_removed) > count_read(&n_reclaims)) {
         g_usleep(100);
         synchronize_rcu();
     }
     if (g_test_in_charge) {
-        g_assert_cmpint(n_nodes_removed, ==, n_reclaims);
+        g_assert_cmpint(count_read(&n_nodes_removed), ==,
+                        count_read(&n_reclaims));
     } else {
         printf("%s: %d readers; 1 updater; nodes read: "  \
                "%lld, nodes removed: %lld; nodes reclaimed: %lld\n",
-               test, nthreadsrunning - 1, n_reads, n_nodes_removed, n_reclaims);
+               test, nthreadsrunning - 1, n_reads,
+               count_read(&n_nodes_removed), count_read(&n_reclaims));
         exit(0);
     }
 }
-- 
2.17.1
