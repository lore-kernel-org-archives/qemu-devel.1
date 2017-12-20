Received: from eggs.gnu.org ([2001:4830:134:3::10]:56241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy8-0004RC-U7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy7-00077b-Vg
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:48 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy7-00077D-Oj
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:47 -0500
Received: by mail-wr0-x244.google.com with SMTP id w68so10468667wrc.10
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:24 +0100
Message-Id: <1513790098-9815-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/46] cpus: make pause_all_cpus() play with SMP
 on single threaded TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

pause_all_cpus() is sometimes called from a VCPU thread (e.g. s390x
during special reset). It cannot deal with multiple VCPUs per Thread
(single threaded TCG) yet.

Booting an s390x guest with -smp 2 and single threaded TCG from disk
currently fails. The DIAG 308 will issue a pause_all_cpus() and wait
forever for the CPUs to actually stop. But it is waiting for itself.

So let's stop all VCPUs belonging to the current thread. Factor out
stopping of a VCPU.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171129191215.11323-1-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/cpus.c b/cpus.c
index 114c29b..3740c4d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1057,13 +1057,22 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
 }
 
+static void qemu_cpu_stop(CPUState *cpu, bool exit)
+{
+    g_assert(qemu_cpu_is_self(cpu));
+    cpu->stop = false;
+    cpu->stopped = true;
+    if (exit) {
+        cpu_exit(cpu);
+    }
+    qemu_cond_broadcast(&qemu_pause_cond);
+}
+
 static void qemu_wait_io_event_common(CPUState *cpu)
 {
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        cpu->stop = false;
-        cpu->stopped = true;
-        qemu_cond_broadcast(&qemu_pause_cond);
+        qemu_cpu_stop(cpu, false);
     }
     process_queued_cpu_work(cpu);
 }
@@ -1610,12 +1619,12 @@ void pause_all_vcpus(void)
 
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
-        cpu->stop = true;
-        qemu_cpu_kick(cpu);
-    }
-
-    if (qemu_in_vcpu_thread()) {
-        cpu_stop_current();
+        if (qemu_cpu_is_self(cpu)) {
+            qemu_cpu_stop(cpu, true);
+        } else {
+            cpu->stop = true;
+            qemu_cpu_kick(cpu);
+        }
     }
 
     while (!all_vcpus_paused()) {
@@ -1799,10 +1808,7 @@ void qemu_init_vcpu(CPUState *cpu)
 void cpu_stop_current(void)
 {
     if (current_cpu) {
-        current_cpu->stop = false;
-        current_cpu->stopped = true;
-        cpu_exit(current_cpu);
-        qemu_cond_broadcast(&qemu_pause_cond);
+        qemu_cpu_stop(current_cpu, true);
     }
 }
 
-- 
1.8.3.1
