Received: from eggs.gnu.org ([2001:4830:134:3::10]:50756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOzT-0006fr-3P
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOzS-00036W-5f
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csOzR-00036D-Vd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:58 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 27 Mar 2017 15:21:28 +0800
Message-Id: <1490599288-11751-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1490599288-11751-1-git-send-email-peterx@redhat.com>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] cpu: throttle: fix throttle time slice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "\\  Dr . David Alan Gilbert \\ " <dgilbert@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

IIUC the throttle idea is that: we split a CPU_THROTTLE_TIMESLICE_NS
time slice into two parts - one for vcpu, one for throttle thread (which
will suspend the thread by a sleep). However current algorithm on
calculating the working piece and sleeping piece is strange.

Assume a 99% throttle, what we want is to merely stop vcpu from running,
but the old logic will just first let the vcpu run for a very long
time (which is "CPU_THROTTLE_TIMESLICE_NS / (1-pct)" = 1 second) before
doing anything else.

Fixing it up to the simplest but imho accurate logic.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 cpus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index 167d961..7976ce4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -633,7 +633,6 @@ static const VMStateDescription vmstate_timers = {
 static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
 {
     double pct;
-    double throttle_ratio;
     long sleeptime_ns;
 
     if (!cpu_throttle_get_percentage()) {
@@ -641,8 +640,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
     }
 
     pct = (double)cpu_throttle_get_percentage()/100;
-    throttle_ratio = pct / (1 - pct);
-    sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
+    sleeptime_ns = (long)((1 - pct) * CPU_THROTTLE_TIMESLICE_NS);
 
     qemu_mutex_unlock_iothread();
     atomic_set(&cpu->throttle_thread_scheduled, 0);
@@ -668,7 +666,7 @@ static void cpu_throttle_timer_tick(void *opaque)
 
     pct = (double)cpu_throttle_get_percentage()/100;
     timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
-                                   CPU_THROTTLE_TIMESLICE_NS / (1-pct));
+                                   CPU_THROTTLE_TIMESLICE_NS * pct);
 }
 
 void cpu_throttle_set(int new_throttle_pct)
-- 
2.7.4
