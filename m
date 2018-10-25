Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006hv-Kh
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJk-0008Ol-OO
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJk-0008Nz-Er
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:10 -0400
Message-Id: <20181025172057.20414-2-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 01/48] cpu: introduce run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

This allows us to queue synchronous CPU work without the BQL.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 13 +++++++++++++
 cpus-common.c     | 28 ++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 204bc94056..863aa2bff1 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -877,6 +877,19 @@ bool cpu_is_stopped(CPUState *cpu);
  */
 void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
+/**
+ * run_on_cpu_no_bql
+ * @cpu: The vCPU to run on.
+ * @func: The function to be executed.
+ * @data: Data to pass to the function.
+ *
+ * Schedules the function @func for execution on the vCPU @cpu.
+ * This function is run outside the BQL.
+ * See also: run_on_cpu()
+ */
+void run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
+                       run_on_cpu_data data);
+
 /**
  * async_run_on_cpu:
  * @cpu: The vCPU to run on.
diff --git a/cpus-common.c b/cpus-common.c
index cffb2b71ac..b478fc8741 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -144,7 +144,8 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     cpu_mutex_unlock(cpu);
 }
 
-void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+static void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
+                          run_on_cpu_data data, bool bql)
 {
     struct qemu_work_item wi;
     bool has_bql = qemu_mutex_iothread_locked();
@@ -152,12 +153,16 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     g_assert(no_cpu_mutex_locked());
 
     if (qemu_cpu_is_self(cpu)) {
-        if (has_bql) {
-            func(cpu, data);
+        if (bql) {
+            if (has_bql) {
+                func(cpu, data);
+            } else {
+                qemu_mutex_lock_iothread();
+                func(cpu, data);
+                qemu_mutex_unlock_iothread();
+            }
         } else {
-            qemu_mutex_lock_iothread();
             func(cpu, data);
-            qemu_mutex_unlock_iothread();
         }
         return;
     }
@@ -172,7 +177,7 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     wi.done = false;
     wi.free = false;
     wi.exclusive = false;
-    wi.bql = true;
+    wi.bql = bql;
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
@@ -189,6 +194,17 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
     }
 }
 
+void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+{
+    do_run_on_cpu(cpu, func, data, true);
+}
+
+void
+run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
+{
+    do_run_on_cpu(cpu, func, data, false);
+}
+
 void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item *wi;
-- 
2.17.1
