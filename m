Received: from eggs.gnu.org ([2001:4830:134:3::10]:55710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmB7E-0003hZ-DE
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dmB7C-0003wK-Gp
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:53:32 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dmB7C-0003vz-Av
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:53:30 -0400
Received: by mail-yw0-x241.google.com with SMTP id h127so2734778ywf.1
	for <qemu-devel@nongnu.org>; Sun, 27 Aug 2017 20:53:30 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sun, 27 Aug 2017 23:53:25 -0400
Message-Id: <20170828035327.17146-2-bobby.prani@gmail.com>
In-Reply-To: <20170828035327.17146-1-bobby.prani@gmail.com>
References: <20170828035327.17146-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 2/3] cpus-common: Cache allocated work items
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

This reduces the number of allocations by 25% (200000 -> 150000 for
ARM64 boot+shutdown test).

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 cpus-common.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..a1c4c7d1a3 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -24,6 +24,7 @@
 #include "sysemu/cpus.h"
 
 static QemuMutex qemu_cpu_list_lock;
+static QemuMutex qemu_wi_pool_lock;
 static QemuCond exclusive_cond;
 static QemuCond exclusive_resume;
 static QemuCond qemu_work_cond;
@@ -33,6 +34,58 @@ static QemuCond qemu_work_cond;
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
+    qemu_work_item *first, *last;
+} qemu_wi_pool;
+
+qemu_wi_pool *wi_free_pool;
+
+static void qemu_init_workitem_pool(void)
+{
+    wi_free_pool = g_malloc0(sizeof(qemu_wi_pool));
+    wi_free_pool->first = NULL;
+    wi_free_pool->last  = NULL;
+}
+
+static void qemu_wi_pool_insert(qemu_work_item *item)
+{
+    qemu_mutex_lock(&qemu_wi_pool_lock);
+    if (wi_free_pool->last == NULL) {
+        wi_free_pool->first = item;
+        wi_free_pool->last = item;
+    } else {
+        wi_free_pool->last->next = item;
+        wi_free_pool->last = item;
+    }
+    qemu_mutex_unlock(&qemu_wi_pool_lock);
+}
+
+static qemu_work_item* qemu_wi_pool_remove(void)
+{
+    qemu_mutex_lock(&qemu_wi_pool_lock);
+    qemu_work_item *ret = wi_free_pool->first;
+
+    if (ret == NULL)
+        goto out;
+
+    wi_free_pool->first = ret->next;
+    if (wi_free_pool->last == ret) {
+        wi_free_pool->last = NULL;
+    }
+    ret->next = NULL;
+
+ out:
+    qemu_mutex_unlock(&qemu_wi_pool_lock);
+    return ret;
+}
+
 void qemu_init_cpu_list(void)
 {
     /* This is needed because qemu_init_cpu_list is also called by the
@@ -43,6 +96,9 @@ void qemu_init_cpu_list(void)
     qemu_cond_init(&exclusive_cond);
     qemu_cond_init(&exclusive_resume);
     qemu_cond_init(&qemu_work_cond);
+
+    qemu_init_workitem_pool();
+    qemu_mutex_init(&qemu_wi_pool_lock);
 }
 
 void cpu_list_lock(void)
@@ -106,14 +162,7 @@ void cpu_list_remove(CPUState *cpu)
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
@@ -132,7 +181,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
 void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
                    QemuMutex *mutex)
 {
-    struct qemu_work_item wi;
+    qemu_work_item wi;
 
     if (qemu_cpu_is_self(cpu)) {
         func(cpu, data);
@@ -145,6 +194,7 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
     wi.free = false;
     wi.exclusive = false;
 
+
     queue_work_on_cpu(cpu, &wi);
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
@@ -156,9 +206,11 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
 
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
@@ -299,9 +351,11 @@ void cpu_exec_end(CPUState *cpu)
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
@@ -312,7 +366,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 
 void process_queued_cpu_work(CPUState *cpu)
 {
-    struct qemu_work_item *wi;
+    qemu_work_item *wi;
 
     if (cpu->queued_work_first == NULL) {
         return;
@@ -343,7 +397,8 @@ void process_queued_cpu_work(CPUState *cpu)
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
