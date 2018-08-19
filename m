Received: from eggs.gnu.org ([2001:4830:134:3::10]:57183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002NC-9b
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmP-0000dg-NV
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:30 -0400
Message-Id: <20180819091335.22863-7-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 06/11] test-rcu-list: access counters with
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-rcu-list.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index b4ed130081..dc58091996 100644
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
2.17.1
