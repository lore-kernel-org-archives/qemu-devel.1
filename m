Received: from eggs.gnu.org ([2001:4830:134:3::10]:33937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGTZU-0006vs-TR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGTZU-0004NI-0I
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGTZT-0004N1-QY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:07:39 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 19:07:33 +0200
Message-Id: <20170601170733.13080-3-pbonzini@redhat.com>
In-Reply-To: <20170601170733.13080-1-pbonzini@redhat.com>
References: <20170601170733.13080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/34] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, Malcolm Crossley <malcolm@nutanix.com>

From: Felipe Franciosi <felipe@nutanix.com>

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
Message-Id: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
Acked-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 516e5cbac1..f42eebda91 100644
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
2.13.0
