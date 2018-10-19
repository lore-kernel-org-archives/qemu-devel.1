Received: from eggs.gnu.org ([2001:4830:134:3::10]:59592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGA-0005EF-OS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJG4-0003ea-1J
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:23 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFy-0003IE-VY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:24 -0400
Message-Id: <20181019010625.25294-56-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 55/56] cpu: add async_run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Some async jobs do not need the BQL.

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 14 ++++++++++++++
 cpus-common.c     | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index b351fe6164..3028447002 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -842,9 +842,23 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
  * @data: Data to pass to the function.
  *
  * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * See also: async_run_on_cpu_no_bql()
  */
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * async_run_on_cpu_no_bql:
+ * @cpu: The vCPU to run on.
+ * @func: The function to be executed.
+ * @data: Data to pass to the function.
+ *
+ * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * This function is run outside the BQL.
+ * See also: async_run_on_cpu()
+ */
+void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                             run_on_cpu_data data);
+
 /**
  * async_safe_run_on_cpu:
  * @cpu: The vCPU to run on.
diff --git a/cpus-common.c b/cpus-common.c
index d559f94ef1..9f33cc94d5 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -109,6 +109,7 @@ struct qemu_work_item {
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
+    bool bql;
 };
 
 /* Called with the CPU's lock held */
@@ -145,6 +146,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi.done = false;
     wi.free = false;
     wi.exclusive = false;
+    wi.bql = true;
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
@@ -167,6 +169,21 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi->func = func;
     wi->data = data;
     wi->free = true;
+    wi->bql = true;
+
+    queue_work_on_cpu(cpu, wi);
+}
+
+void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                             run_on_cpu_data data)
+{
+    struct qemu_work_item *wi;
+
+    wi = g_malloc0(sizeof(struct qemu_work_item));
+    wi->func = func;
+    wi->data = data;
+    wi->free = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -311,6 +328,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     wi->data = data;
     wi->free = true;
     wi->exclusive = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -335,6 +353,7 @@ void process_queued_cpu_work_locked(CPUState *cpu)
              * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
              * neither CPU can proceed.
              */
+            g_assert(!wi->bql);
             if (has_bql) {
                 qemu_mutex_unlock_iothread();
             }
@@ -345,12 +364,22 @@ void process_queued_cpu_work_locked(CPUState *cpu)
                 qemu_mutex_lock_iothread();
             }
         } else {
-            if (has_bql) {
-                wi->func(cpu, wi->data);
+            if (wi->bql) {
+                if (has_bql) {
+                    wi->func(cpu, wi->data);
+                } else {
+                    qemu_mutex_lock_iothread();
+                    wi->func(cpu, wi->data);
+                    qemu_mutex_unlock_iothread();
+                }
             } else {
-                qemu_mutex_lock_iothread();
-                wi->func(cpu, wi->data);
-                qemu_mutex_unlock_iothread();
+                if (has_bql) {
+                    qemu_mutex_unlock_iothread();
+                    wi->func(cpu, wi->data);
+                    qemu_mutex_lock_iothread();
+                } else {
+                    wi->func(cpu, wi->data);
+                }
             }
         }
         cpu_mutex_lock(cpu);
-- 
2.17.1
