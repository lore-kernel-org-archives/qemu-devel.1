Received: from eggs.gnu.org ([2001:4830:134:3::10]:57174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002N8-8Y
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmP-0000dG-Fa
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:31 -0400
Message-Id: <20180819091335.22863-8-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 07/11] test-rcu-list: abstract the list
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

So that we can test other implementations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-rcu-list.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index dc58091996..9bd11367a0 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -82,9 +82,16 @@ static void wait_all_threads(void)
     n_threads = 0;
 }
 
+#ifndef TEST_LIST_TYPE
+#define TEST_LIST_TYPE 1
+#endif
 
 struct list_element {
+#if TEST_LIST_TYPE == 1
     QLIST_ENTRY(list_element) entry;
+#else
+#error Invalid TEST_LIST_TYPE
+#endif
     struct rcu_head rcu;
 };
 
@@ -96,8 +103,19 @@ static void reclaim_list_el(struct rcu_head *prcu)
     atomic_set(&n_reclaims, n_reclaims + 1);
 }
 
+#if TEST_LIST_TYPE == 1
 static QLIST_HEAD(q_list_head, list_element) Q_list_head;
 
+#define TEST_NAME "qlist"
+#define TEST_LIST_REMOVE_RCU        QLIST_REMOVE_RCU
+#define TEST_LIST_INSERT_AFTER_RCU  QLIST_INSERT_AFTER_RCU
+#define TEST_LIST_INSERT_HEAD_RCU   QLIST_INSERT_HEAD_RCU
+#define TEST_LIST_FOREACH_RCU       QLIST_FOREACH_RCU
+#define TEST_LIST_FOREACH_SAFE_RCU  QLIST_FOREACH_SAFE_RCU
+#else
+#error Invalid TEST_LIST_TYPE
+#endif
+
 static void *rcu_q_reader(void *arg)
 {
     long long n_reads_local = 0;
@@ -113,7 +131,7 @@ static void *rcu_q_reader(void *arg)
 
     while (atomic_read(&goflag) == GOFLAG_RUN) {
         rcu_read_lock();
-        QLIST_FOREACH_RCU(el, &Q_list_head, entry) {
+        TEST_LIST_FOREACH_RCU(el, &Q_list_head, entry) {
             n_reads_local++;
             if (atomic_read(&goflag) == GOFLAG_STOP) {
                 break;
@@ -150,10 +168,10 @@ static void *rcu_q_updater(void *arg)
         target_el = select_random_el(RCU_Q_LEN);
         j = 0;
         /* FOREACH_RCU could work here but let's use both macros */
-        QLIST_FOREACH_SAFE_RCU(prev_el, &Q_list_head, entry, el) {
+        TEST_LIST_FOREACH_SAFE_RCU(prev_el, &Q_list_head, entry, el) {
             j++;
             if (target_el == j) {
-                QLIST_REMOVE_RCU(prev_el, entry);
+                TEST_LIST_REMOVE_RCU(prev_el, entry);
                 /* may be more than one updater in the future */
                 call_rcu1(&prev_el->rcu, reclaim_list_el);
                 n_removed_local++;
@@ -165,12 +183,12 @@ static void *rcu_q_updater(void *arg)
         }
         target_el = select_random_el(RCU_Q_LEN);
         j = 0;
-        QLIST_FOREACH_RCU(el, &Q_list_head, entry) {
+        TEST_LIST_FOREACH_RCU(el, &Q_list_head, entry) {
             j++;
             if (target_el == j) {
-                prev_el = g_new(struct list_element, 1);
+                struct list_element *new_el = g_new(struct list_element, 1);
                 n_nodes += n_nodes_local;
-                QLIST_INSERT_BEFORE_RCU(el, prev_el, entry);
+                TEST_LIST_INSERT_AFTER_RCU(el, new_el, entry);
                 break;
             }
         }
@@ -195,7 +213,7 @@ static void rcu_qtest_init(void)
     srand(time(0));
     for (i = 0; i < RCU_Q_LEN; i++) {
         new_el = g_new(struct list_element, 1);
-        QLIST_INSERT_HEAD_RCU(&Q_list_head, new_el, entry);
+        TEST_LIST_INSERT_HEAD_RCU(&Q_list_head, new_el, entry);
     }
     qemu_mutex_lock(&counts_mutex);
     n_nodes += RCU_Q_LEN;
@@ -230,8 +248,8 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
     create_thread(rcu_q_updater);
     rcu_qtest_run(duration, nreaders);
 
-    QLIST_FOREACH_SAFE_RCU(prev_el, &Q_list_head, entry, el) {
-        QLIST_REMOVE_RCU(prev_el, entry);
+    TEST_LIST_FOREACH_SAFE_RCU(prev_el, &Q_list_head, entry, el) {
+        TEST_LIST_REMOVE_RCU(prev_el, entry);
         call_rcu1(&prev_el->rcu, reclaim_list_el);
         n_removed_local++;
     }
@@ -292,9 +310,9 @@ int main(int argc, char *argv[])
             } else {
                 gtest_seconds = 20;
             }
-            g_test_add_func("/rcu/qlist/single-threaded", gtest_rcuq_one);
-            g_test_add_func("/rcu/qlist/short-few", gtest_rcuq_few);
-            g_test_add_func("/rcu/qlist/long-many", gtest_rcuq_many);
+            g_test_add_func("/rcu/"TEST_NAME"/single-threaded", gtest_rcuq_one);
+            g_test_add_func("/rcu/"TEST_NAME"/short-few", gtest_rcuq_few);
+            g_test_add_func("/rcu/"TEST_NAME"/long-many", gtest_rcuq_many);
             g_test_in_charge = 1;
             return g_test_run();
         }
-- 
2.17.1
