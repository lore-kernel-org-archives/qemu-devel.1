Received: from eggs.gnu.org ([209.51.188.92]:36013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe47-0000NH-2w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe46-0001c4-6s
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe46-0001HV-1w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:48:09 -0500
Message-Id: <20190130004811.27372-72-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 71/73] cpus-common: release BQL earlier in
 run_on_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

After completing the conversion to per-CPU locks, there is no need
to release the BQL after having called cpu_kick.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 62e282bff1..1241024b2c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -145,6 +145,11 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
         return;
     }
 
+    /* We are going to sleep on the CPU lock, so release the BQL */
+    if (has_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     wi.func = func;
     wi.data = data;
     wi.done = false;
@@ -153,21 +158,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
-
-    /*
-     * We are going to sleep on the CPU lock, so release the BQL.
-     *
-     * During the transition to per-CPU locks, we release the BQL _after_
-     * having kicked the destination CPU (from queue_work_on_cpu_locked above).
-     * This makes sure that the enqueued work will be seen by the CPU
-     * after being woken up from the kick, since the CPU sleeps on the BQL.
-     * Once we complete the transition to per-CPU locks, we will release
-     * the BQL earlier in this function.
-     */
-    if (has_bql) {
-        qemu_mutex_unlock_iothread();
-    }
-
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-- 
2.17.1
