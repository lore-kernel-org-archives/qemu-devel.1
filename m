Received: from eggs.gnu.org ([2001:4830:134:3::10]:56831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dBpru-0001NU-HA
	for qemu-devel@nongnu.org; Fri, 19 May 2017 17:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dBprp-00022L-Qr
	for qemu-devel@nongnu.org; Fri, 19 May 2017 17:55:30 -0400
Received: from [62.254.189.133] (port=54277 helo=centos.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dBprp-0001qw-5U
	for qemu-devel@nongnu.org; Fri, 19 May 2017 17:55:25 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 19 May 2017 22:29:50 +0100
Message-Id: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
Subject: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled after
 sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Malcolm Crossley <malcolm@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>

Currently, the throttle_thread_scheduled flag is reset back to 0 before
sleeping (as part of the throttling logic). Given that throttle_timer
(well, any timer) may tick with a slight delay, it so happens that under
heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
schedule a further cpu_throttle_thread() work item after the flag reset,
but before the previous sleep completed. This results on the vCPU thread
sleeping continuously for potentially several seconds in a row.

The chances of that happening can be drastically minimised by resetting
the flag after the sleep.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 516e5cb..f42eebd 100644
--- a/cpus.c
+++ b/cpus.c
@@ -677,9 +677,9 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
     sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
 
     qemu_mutex_unlock_iothread();
-    atomic_set(&cpu->throttle_thread_scheduled, 0);
     g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
     qemu_mutex_lock_iothread();
+    atomic_set(&cpu->throttle_thread_scheduled, 0);
 }
 
 static void cpu_throttle_timer_tick(void *opaque)
-- 
1.9.5
