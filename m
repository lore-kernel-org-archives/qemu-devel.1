Received: from eggs.gnu.org ([2001:4830:134:3::10]:33724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IP-Vb
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4X-0006r5-Qo
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4W-0006Uw-RB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id 20-v6so10507592wrb.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:12 +0200
Message-Id: <1534870966-9287-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/74] test-rcu-list: access goflag with atomics
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

Instead of declaring it volatile.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-6-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-rcu-list.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 1514d7e..b4ed130 100644
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
1.8.3.1
