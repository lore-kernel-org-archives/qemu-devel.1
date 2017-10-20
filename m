Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt5-0002CC-Rh
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vt5-0002wz-11
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:40 +0200
Message-Id: <20171020115418.2050-9-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/46] s390x/tcg: STOPPED cpus can never wake up
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

Interrupts can't wake such CPUs up. SIGP from other CPUs has to be used
to toggle the state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-7-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b0517475fa..a21d5519c1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -57,6 +57,12 @@ static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
+    /* STOPPED cpus can never wake up */
+    if (s390_cpu_get_state(cpu) != CPU_STATE_LOAD &&
+        s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
+        return false;
+    }
+
     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
         return false;
     }
-- 
2.13.6
