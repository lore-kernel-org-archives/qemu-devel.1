Received: from eggs.gnu.org ([2001:4830:134:3::10]:58591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtG-0002MJ-CI
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtF-00032e-Hm
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:43 +0200
Message-Id: <20171020115418.2050-12-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/46] s390x/tcg: handle WAIT PSWs during
 interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

If we encounter a WAIT PSW, we have to halt immediately. Using
cpu_loop_exit() at this point feels wrong. Simply leaving
cs->exception_index set doesn't result in an immediate stop.

This is also necessary to properly handle SIGP STOP interrupts later.

The CPU_INTERRUPT_HALT will be processed immediately and properly set
the CPU to halted (also resetting cs->exception_index to EXCP_HLT)

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-10-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 63058a6b7a..56331ae4fb 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -468,6 +468,12 @@ void s390_cpu_do_interrupt(CPUState *cs)
         do_mchk_interrupt(env);
         break;
     }
+
+    /* WAIT PSW during interrupt injection */
+    if (cs->exception_index == EXCP_HLT) {
+        /* don't trigger a cpu_loop_exit(), use an interrupt instead */
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
+    }
     cs->exception_index = -1;
 
     /* we might still have pending interrupts, but not deliverable */
-- 
2.13.6
