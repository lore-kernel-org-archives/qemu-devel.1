Received: from eggs.gnu.org ([2001:4830:134:3::10]:44761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMtaY-0001pW-8g
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMtaV-00038C-5e
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:44:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gMtaV-00037y-0z
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:44:03 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Nov 2018 12:44:00 +0100
Message-Id: <20181114114400.15577-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] cpus: run work items for all vCPUs if
 single-threaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, alex.bennee@linaro.org, cota@braap.org

This avoids the following deadlock:

1) a thread calls run_on_cpu for CPU 2 from a timer, and single_tcg_halt_cond
is signaled

2) CPU 1 is running and exits.  It finds no work item and enters CPU 2

3) because the I/O thread is stuck in run_on_cpu, the round-robin kick
timer never triggers, and CPU 2 never runs the work item

4) run_on_cpu never completes

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index a2b33ccb29..0ddeeefc14 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1220,16 +1220,20 @@ static void qemu_wait_io_event_common(CPUState *cpu)
     process_queued_cpu_work(cpu);
 }
 
-static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
+static void qemu_tcg_rr_wait_io_event(void)
 {
+    CPUState *cpu;
+
     while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
     }
 
     start_tcg_kick_timer();
 
-    qemu_wait_io_event_common(cpu);
+    CPU_FOREACH(cpu) {
+        qemu_wait_io_event_common(cpu);
+    }
 }
 
 static void qemu_wait_io_event(CPUState *cpu)
@@ -1562,7 +1566,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             qemu_notify_event();
         }
 
-        qemu_tcg_rr_wait_io_event(cpu ? cpu : first_cpu);
+        qemu_tcg_rr_wait_io_event();
         deal_with_unplugged_cpus();
     }
 
-- 
2.17.1
