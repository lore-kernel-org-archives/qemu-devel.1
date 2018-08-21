Received: from eggs.gnu.org ([2001:4830:134:3::10]:33732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0002IR-2h
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006n2-Mw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:13 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4U-0006Xl-SJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id z96-v6so7812716wrb.8
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:14 +0200
Message-Id: <1534870966-9287-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 42/74] test-rcu-list: abstract the list
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
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

So that we can test other implementations.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-8-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-rcu-list.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index dc58091..9bd1136 100644
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
1.8.3.1
