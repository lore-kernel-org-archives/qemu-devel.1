Received: from eggs.gnu.org ([209.51.188.92]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBK-0000d6-UF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sBK-0002Ql-3K
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:18 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sBJ-0001ye-RC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:19:18 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:18:12 -0500
Message-Id: <20190304181813.8075-73-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 72/73] cpu: add async_run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Some async jobs do not need the BQL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 14 ++++++++++++++
 cpus-common.c     | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 44e6e83ecd..f75f5e74ca 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -898,9 +898,23 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
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
index 1241024b2c..5832a8bf37 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -109,6 +109,7 @@ struct qemu_work_item {
     run_on_cpu_func func;
     run_on_cpu_data data;
     bool free, exclusive, done;
+    bool bql;
 };
 
 /* Called with the CPU's lock held */
@@ -155,6 +156,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi.done = false;
     wi.free = false;
     wi.exclusive = false;
+    wi.bql = true;
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
@@ -179,6 +181,21 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
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
@@ -323,6 +340,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     wi->data = data;
     wi->free = true;
     wi->exclusive = true;
+    /* wi->bql initialized to false */
 
     queue_work_on_cpu(cpu, wi);
 }
@@ -347,6 +365,7 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
              * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
              * neither CPU can proceed.
              */
+            g_assert(!wi->bql);
             if (has_bql) {
                 qemu_mutex_unlock_iothread();
             }
@@ -357,12 +376,22 @@ static void process_queued_cpu_work_locked(CPUState *cpu)
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
