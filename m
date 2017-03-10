Received: from eggs.gnu.org ([2001:4830:134:3::10]:60502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1cmEnt-0006W3-01
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1cmEnp-0004Fz-S7
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:17:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:12805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1cmEnp-0004FW-HX
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:17:29 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 10 Mar 2017 23:14:56 +0800
Message-Id: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 1/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, chao.p.peng@intel.com, Yang Zhong <yang.zhong@intel.com>

There are a lot of memory allocation during the qemu bootup, which are
freed later by RCU thread,which means the heap size becomes biger and
biger when allocation happens, but the heap may not be shrinked even
after release happens,because some memory blocks in top of heap are still
being used.Decreasing the sleep and removing qemu_mutex_unlock_iothread()
lock, which make call_rcu_thread()thread response the free memory in time.
This patch will reduce heap Rss around 10M.

This patch is from Anthony xu <anthony.xu@intel.com>.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 util/rcu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index 9adc5e4..c5c373c 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -167,7 +167,7 @@ void synchronize_rcu(void)
 }
 
 
-#define RCU_CALL_MIN_SIZE        30
+#define RCU_CALL_MIN_SIZE        5
 
 /* Multi-producer, single-consumer queue based on urcu/static/wfqueue.h
  * from liburcu.  Note that head is only used by the consumer.
@@ -241,7 +241,7 @@ static void *call_rcu_thread(void *opaque)
          * added before synchronize_rcu() starts.
          */
         while (n == 0 || (n < RCU_CALL_MIN_SIZE && ++tries <= 5)) {
-            g_usleep(10000);
+            g_usleep(100);
             if (n == 0) {
                 qemu_event_reset(&rcu_call_ready_event);
                 n = atomic_read(&rcu_call_count);
@@ -254,24 +254,20 @@ static void *call_rcu_thread(void *opaque)
 
         atomic_sub(&rcu_call_count, n);
         synchronize_rcu();
-        qemu_mutex_lock_iothread();
         while (n > 0) {
             node = try_dequeue();
             while (!node) {
-                qemu_mutex_unlock_iothread();
                 qemu_event_reset(&rcu_call_ready_event);
                 node = try_dequeue();
                 if (!node) {
                     qemu_event_wait(&rcu_call_ready_event);
                     node = try_dequeue();
                 }
-                qemu_mutex_lock_iothread();
             }
 
             n--;
             node->func(node);
         }
-        qemu_mutex_unlock_iothread();
     }
     abort();
 }
-- 
1.9.1
