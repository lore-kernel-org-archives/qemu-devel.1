Received: from eggs.gnu.org ([2001:4830:134:3::10]:40612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjo-0003al-CO
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbU-0005Kq-Ba
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbU-0005IS-2A
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:45 -0400
Message-Id: <20180910232752.31565-6-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 05/12] test-rcu-list: access n_reclaims and
 n_nodes_removed with atomic64
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

To avoid undefined behaviour.

Note that these "atomics" are atomic in the "access once" sense.
The variables are updated by a single thread at a time, so no
"full" atomics are necessary.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-rcu-list.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 192bfbf02e..2e6f70bd59 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -33,8 +33,8 @@
 static QemuMutex counts_mutex;
 static long long n_reads = 0LL;
 static long long n_updates = 0LL;
-static long long n_reclaims = 0LL;
-static long long n_nodes_removed = 0LL;
+static int64_t n_reclaims;
+static int64_t n_nodes_removed;
 static long long n_nodes = 0LL;
 static int g_test_in_charge = 0;
 
@@ -104,7 +104,7 @@ static void reclaim_list_el(struct rcu_head *prcu)
     struct list_element *el = container_of(prcu, struct list_element, rcu);
     g_free(el);
     /* Accessed only from call_rcu thread.  */
-    n_reclaims++;
+    atomic_set_i64(&n_reclaims, n_reclaims + 1);
 }
 
 #if TEST_LIST_TYPE == 1
@@ -232,7 +232,7 @@ static void *rcu_q_updater(void *arg)
     qemu_mutex_lock(&counts_mutex);
     n_nodes += n_nodes_local;
     n_updates += n_updates_local;
-    n_nodes_removed += n_removed_local;
+    atomic_set_i64(&n_nodes_removed, n_nodes_removed + n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     return NULL;
 }
@@ -286,19 +286,21 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
         n_removed_local++;
     }
     qemu_mutex_lock(&counts_mutex);
-    n_nodes_removed += n_removed_local;
+    atomic_set_i64(&n_nodes_removed, n_nodes_removed + n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     synchronize_rcu();
-    while (n_nodes_removed > n_reclaims) {
+    while (atomic_read_i64(&n_nodes_removed) > atomic_read_i64(&n_reclaims)) {
         g_usleep(100);
         synchronize_rcu();
     }
     if (g_test_in_charge) {
-        g_assert_cmpint(n_nodes_removed, ==, n_reclaims);
+        g_assert_cmpint(atomic_read_i64(&n_nodes_removed), ==,
+                        atomic_read_i64(&n_reclaims));
     } else {
         printf("%s: %d readers; 1 updater; nodes read: "  \
-               "%lld, nodes removed: %lld; nodes reclaimed: %lld\n",
-               test, nthreadsrunning - 1, n_reads, n_nodes_removed, n_reclaims);
+               "%lld, nodes removed: %"PRIi64"; nodes reclaimed: %"PRIi64"\n",
+               test, nthreadsrunning - 1, n_reads,
+               atomic_read_i64(&n_nodes_removed), atomic_read_i64(&n_reclaims));
         exit(0);
     }
 }
-- 
2.17.1
