Received: from eggs.gnu.org ([2001:4830:134:3::10]:45126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkN-000818-8O
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkL-0004FD-K1
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:43 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkL-0004DB-DS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id v6so20216851wrr.12
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:41 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s139sm2412468wmd.3.2018.11.26.11.40.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Nov 2018 11:40:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:22 +0100
Message-Id: <1543261235-2834-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/15] cpus: run work items for all vCPUs if
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

This avoids the following I/O thread deadlock:

1) the I/O thread calls run_on_cpu for CPU 3 from a timer.  single_tcg_halt_cond
is signaled

2) CPU 1 is running and exits.  It finds no work item and enters CPU 2

3) because the I/O thread is stuck in run_on_cpu, the round-robin kick
timer never triggers, and CPU 3 never runs the work item

4) run_on_cpu never completes

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index a2b33cc..0ddeeef 100644
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
1.8.3.1
