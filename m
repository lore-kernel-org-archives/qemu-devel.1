Received: from eggs.gnu.org ([2001:4830:134:3::10]:57181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002NB-9M
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmO-0000cS-Rx
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:29 -0400
Message-Id: <20180819091335.22863-6-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 05/11] test-rcu-list: access goflag with
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

Instead of declaring it volatile.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-rcu-list.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 1514d7ec97..b4ed130081 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -44,7 +44,7 @@ static int nthreadsrunning;
 #define GOFLAG_RUN  1
 #define GOFLAG_STOP 2
 
-static volatile int goflag = GOFLAG_INIT;
+static int goflag = GOFLAG_INIT;
 
 #define RCU_READ_RUN 1000
 #define RCU_UPDATE_RUN 10
@@ -107,15 +107,15 @@ static void *rcu_q_reader(void *arg)
 
     *(struct rcu_reader_data **)arg = &rcu_reader;
     atomic_inc(&nthreadsrunning);
-    while (goflag == GOFLAG_INIT) {
+    while (atomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
 
-    while (goflag == GOFLAG_RUN) {
+    while (atomic_read(&goflag) == GOFLAG_RUN) {
         rcu_read_lock();
         QLIST_FOREACH_RCU(el, &Q_list_head, entry) {
             n_reads_local++;
-            if (goflag == GOFLAG_STOP) {
+            if (atomic_read(&goflag) == GOFLAG_STOP) {
                 break;
             }
         }
@@ -142,11 +142,11 @@ static void *rcu_q_updater(void *arg)
 
     *(struct rcu_reader_data **)arg = &rcu_reader;
     atomic_inc(&nthreadsrunning);
-    while (goflag == GOFLAG_INIT) {
+    while (atomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
 
-    while (goflag == GOFLAG_RUN) {
+    while (atomic_read(&goflag) == GOFLAG_RUN) {
         target_el = select_random_el(RCU_Q_LEN);
         j = 0;
         /* FOREACH_RCU could work here but let's use both macros */
@@ -160,7 +160,7 @@ static void *rcu_q_updater(void *arg)
                 break;
             }
         }
-        if (goflag == GOFLAG_STOP) {
+        if (atomic_read(&goflag) == GOFLAG_STOP) {
             break;
         }
         target_el = select_random_el(RCU_Q_LEN);
@@ -209,9 +209,9 @@ static void rcu_qtest_run(int duration, int nreaders)
         g_usleep(1000);
     }
 
-    goflag = GOFLAG_RUN;
+    atomic_set(&goflag, GOFLAG_RUN);
     sleep(duration);
-    goflag = GOFLAG_STOP;
+    atomic_set(&goflag, GOFLAG_STOP);
     wait_all_threads();
 }
 
-- 
2.17.1
