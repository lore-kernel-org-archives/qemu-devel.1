Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4b-000258-Ee
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006nL-QQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:56162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4V-0006Wg-04
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:59 -0400
Received: by mail-wm0-x244.google.com with SMTP id f21-v6so3618819wmc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:13 +0200
Message-Id: <1534870966-9287-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/74] test-rcu-list: access counters with
 atomics
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-7-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-rcu-list.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index b4ed130..dc58091 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -93,7 +93,7 @@ static void reclaim_list_el(struct rcu_head *prcu)
     struct list_element *el = container_of(prcu, struct list_element, rcu);
     g_free(el);
     /* Accessed only from call_rcu thread.  */
-    n_reclaims++;
+    atomic_set(&n_reclaims, n_reclaims + 1);
 }
 
 static QLIST_HEAD(q_list_head, list_element) Q_list_head;
@@ -182,7 +182,7 @@ static void *rcu_q_updater(void *arg)
     qemu_mutex_lock(&counts_mutex);
     n_nodes += n_nodes_local;
     n_updates += n_updates_local;
-    n_nodes_removed += n_removed_local;
+    atomic_set(&n_nodes_removed, n_nodes_removed + n_removed_local);
     qemu_mutex_unlock(&counts_mutex);
     return NULL;
 }
@@ -239,16 +239,18 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
     n_nodes_removed += n_removed_local;
     qemu_mutex_unlock(&counts_mutex);
     synchronize_rcu();
-    while (n_nodes_removed > n_reclaims) {
+    while (atomic_read(&n_nodes_removed) > atomic_read(&n_reclaims)) {
         g_usleep(100);
         synchronize_rcu();
     }
     if (g_test_in_charge) {
-        g_assert_cmpint(n_nodes_removed, ==, n_reclaims);
+        g_assert_cmpint(atomic_read(&n_nodes_removed), ==,
+                        atomic_read(&n_reclaims));
     } else {
         printf("%s: %d readers; 1 updater; nodes read: "  \
                "%lld, nodes removed: %lld; nodes reclaimed: %lld\n",
-               test, nthreadsrunning - 1, n_reads, n_nodes_removed, n_reclaims);
+               test, nthreadsrunning - 1, n_reads,
+               atomic_read(&n_nodes_removed), atomic_read(&n_reclaims));
         exit(0);
     }
 }
-- 
1.8.3.1
