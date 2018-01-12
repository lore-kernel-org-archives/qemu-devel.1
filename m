Received: from eggs.gnu.org ([2001:4830:134:3::10]:41982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZC-0007rr-2m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ7-0005pC-2W
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ6-0005o9-PE
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:05 -0500
Received: by mail-wr0-x244.google.com with SMTP id 36so5058251wrh.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:04 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-229-84.clienti.tiscali.it.
	[78.12.229.84])
	by smtp.gmail.com with ESMTPSA id l8sm2732271wmg.46.2018.01.12.03.32.02
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Jan 2018 03:32:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:02 +0100
Message-Id: <1515756676-3860-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/52] cpus: unify qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Except for round-robin TCG, every other accelerator is using more or
less the same code around qemu_wait_io_event_common.  The exception
is HAX, which also has to eat the dummy APC that is queued by
qemu_cpu_kick_thread.

We can add the SleepEx call to qemu_wait_io_event under "if
(!tcg_enabled())", since that is the condition that is used in
qemu_cpu_kick_thread, and unify the function for KVM, HAX, HVF and
multi-threaded TCG.  Single-threaded TCG code can also be simplified
since it is only used in the round-robin, sleep-if-all-CPUs-idle case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 49 +++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/cpus.c b/cpus.c
index f992537..2cb0af9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -909,7 +909,8 @@ static void kick_tcg_thread(void *opaque)
 
 static void start_tcg_kick_timer(void)
 {
-    if (!mttcg_enabled && !tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
+    assert(!mttcg_enabled);
+    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
         tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                            kick_tcg_thread, NULL);
         timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
@@ -918,6 +919,7 @@ static void start_tcg_kick_timer(void)
 
 static void stop_tcg_kick_timer(void)
 {
+    assert(!mttcg_enabled);
     if (tcg_kick_vcpu_timer) {
         timer_del(tcg_kick_vcpu_timer);
         tcg_kick_vcpu_timer = NULL;
@@ -1137,18 +1139,9 @@ static void qemu_wait_io_event_common(CPUState *cpu)
     process_queued_cpu_work(cpu);
 }
 
-static bool qemu_tcg_should_sleep(CPUState *cpu)
+static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 {
-    if (mttcg_enabled) {
-        return cpu_thread_is_idle(cpu);
-    } else {
-        return all_cpu_threads_idle();
-    }
-}
-
-static void qemu_tcg_wait_io_event(CPUState *cpu)
-{
-    while (qemu_tcg_should_sleep(cpu)) {
+    while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
@@ -1158,20 +1151,18 @@ static void qemu_tcg_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
-static void qemu_kvm_wait_io_event(CPUState *cpu)
+static void qemu_wait_io_event(CPUState *cpu)
 {
     while (cpu_thread_is_idle(cpu)) {
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
 
-    qemu_wait_io_event_common(cpu);
-}
-
-static void qemu_hvf_wait_io_event(CPUState *cpu)
-{
-    while (cpu_thread_is_idle(cpu)) {
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+#ifdef _WIN32
+    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
+    if (!tcg_enabled()) {
+        SleepEx(0, TRUE);
     }
+#endif
     qemu_wait_io_event_common(cpu);
 }
 
@@ -1207,7 +1198,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_kvm_wait_io_event(cpu);
+        qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     qemu_kvm_destroy_vcpu(cpu);
@@ -1253,7 +1244,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
             exit(1);
         }
         qemu_mutex_lock_iothread();
-        qemu_wait_io_event_common(cpu);
+        qemu_wait_io_event(cpu);
     }
 
     return NULL;
@@ -1470,7 +1461,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
+        qemu_tcg_rr_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
         deal_with_unplugged_cpus();
     }
 
@@ -1501,13 +1492,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
             }
         }
 
-        while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
-        }
-#ifdef _WIN32
-        SleepEx(0, TRUE);
-#endif
-        qemu_wait_io_event_common(cpu);
+        qemu_wait_io_event(cpu);
     }
     return NULL;
 }
@@ -1544,7 +1529,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_hvf_wait_io_event(cpu);
+        qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     hvf_vcpu_destroy(cpu);
@@ -1623,7 +1608,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
         }
 
         atomic_mb_set(&cpu->exit_request, 0);
-        qemu_tcg_wait_io_event(cpu);
+        qemu_wait_io_event(cpu);
     }
 
     return NULL;
-- 
1.8.3.1
