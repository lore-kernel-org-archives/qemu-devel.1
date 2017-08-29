Received: from eggs.gnu.org ([2001:4830:134:3::10]:38837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dma5Q-0000Oz-If
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dma5N-00041p-Fz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:20 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:38508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dma5N-00041Y-Ao
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:17 -0400
Received: by mail-yw0-x244.google.com with SMTP id e9so1482690ywh.5
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 23:33:17 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 29 Aug 2017 02:33:10 -0400
Message-Id: <20170829063313.10237-2-bobby.prani@gmail.com>
In-Reply-To: <20170829063313.10237-1-bobby.prani@gmail.com>
References: <20170829063313.10237-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC v3 PATCH 2/5] cpus-common: Cache allocated work
 items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Sergey Fedorov <serge.fdrv@gmail.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Using heaptrack, I found that quite a few of our temporary allocations
are coming from allocating work items. Instead of doing this
continously, we can cache the allocated items and reuse them instead
of freeing them.

Stats from an ARM64 guest (boot+shutdown):

heaptrack stats(before):
        allocations:            1471317
        leaked allocations:     73824
        temporary allocations:  651293

heaptrack stats(after):
        allocations:            1143130
        leaked allocations:     73693
        temporary allocations:  487342

The improvement in speedup is minor and within error margins, however I think the
patch is still worth. We can also explore atomics instead of taking a lock for
the work item pool.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpus-common.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..ccf5f50e4e 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -24,6 +24,7 @@
 #include "sysemu/cpus.h"
 
 static QemuMutex qemu_cpu_list_lock;
+static QemuMutex qemu_wi_pool_lock;
 static QemuCond exclusive_cond;
 static QemuCond exclusive_resume;
 static QemuCond qemu_work_cond;
@@ -33,6 +34,49 @@ static QemuCond qemu_work_cond;
  */
 static int pending_cpus;
 
+typedef struct qemu_work_item {
+    struct qemu_work_item *next;
+    run_on_cpu_func func;
+    run_on_cpu_data data;
+    bool free, exclusive, done;
+} qemu_work_item;
+
+typedef struct qemu_wi_pool {
+    qemu_work_item *head;
+    int num_items;
+} qemu_wi_pool;
+
+qemu_wi_pool *wi_free_pool;
+
+static void qemu_init_workitem_pool(void)
+{
+    wi_free_pool = g_malloc0(sizeof(qemu_wi_pool));
+}
+
+static void qemu_wi_pool_insert(qemu_work_item *item)
+{
+    qemu_mutex_lock(&qemu_wi_pool_lock);
+    qemu_work_item *curr = atomic_read(&wi_free_pool->head);
+    item->next = curr;
+    wi_free_pool->head = item;
+    qemu_mutex_unlock(&qemu_wi_pool_lock);
+}
+
+static qemu_work_item *qemu_wi_pool_remove(void)
+{
+    qemu_mutex_lock(&qemu_wi_pool_lock);
+    qemu_work_item *curr = atomic_read(&wi_free_pool->head);
+    if (curr == NULL) {
+        goto out;
+    }
+    wi_free_pool->head = curr->next;
+    curr->next = NULL;
+
+ out:
+    qemu_mutex_unlock(&qemu_wi_pool_lock);
+    return curr;
+}
+
 void qemu_init_cpu_list(void)
 {
     /* This is needed because qemu_init_cpu_list is also called by the
@@ -43,6 +87,9 @@ void qemu_init_cpu_list(void)
     qemu_cond_init(&exclusive_cond);
     qemu_cond_init(&exclusive_resume);
     qemu_cond_init(&qemu_work_cond);
+
+    qemu_init_workitem_pool();
+    qemu_mutex_init(&qemu_wi_pool_lock);
 }
 
 void cpu_list_lock(void)
@@ -106,14 +153,7 @@ void cpu_list_remove(CPUState *cpu)
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
-struct qemu_work_item {
-    struct qemu_work_item *next;
-    run_on_cpu_func func;
-    run_on_cpu_data data;
-    bool free, exclusive, done;
-};
-
-static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
+static void queue_work_on_cpu(CPUState *cpu, qemu_work_item *wi)
 {
     qemu_mutex_lock(&cpu->work_mutex);
     if (cpu->queued_work_first == NULL) {
@@ -132,7 +172,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
                    QemuMutex *mutex)
 {
-    struct qemu_work_item wi;
+    qemu_work_item wi;
 
     if (qemu_cpu_is_self(cpu)) {
         func(cpu, data);
@@ -156,9 +196,11 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
 
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
-    struct qemu_work_item *wi;
+    qemu_work_item *wi = qemu_wi_pool_remove();
 
-    wi = g_malloc0(sizeof(struct qemu_work_item));
+    if (!wi) {
+        wi = g_malloc0(sizeof(qemu_work_item));
+    }
     wi->func = func;
     wi->data = data;
     wi->free = true;
@@ -299,9 +341,11 @@ void cpu_exec_end(CPUState *cpu)
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
                            run_on_cpu_data data)
 {
-    struct qemu_work_item *wi;
+    qemu_work_item *wi = qemu_wi_pool_remove();
 
-    wi = g_malloc0(sizeof(struct qemu_work_item));
+    if (!wi) {
+        wi = g_malloc0(sizeof(qemu_work_item));
+    }
     wi->func = func;
     wi->data = data;
     wi->free = true;
@@ -312,7 +356,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 
 void process_queued_cpu_work(CPUState *cpu)
 {
-    struct qemu_work_item *wi;
+    qemu_work_item *wi;
 
     if (cpu->queued_work_first == NULL) {
         return;
@@ -343,7 +387,8 @@ void process_queued_cpu_work(CPUState *cpu)
         }
         qemu_mutex_lock(&cpu->work_mutex);
         if (wi->free) {
-            g_free(wi);
+            memset(wi, 0, sizeof(qemu_work_item));
+            qemu_wi_pool_insert(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
-- 
2.13.0
