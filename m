Received: from eggs.gnu.org ([2001:4830:134:3::10]:43231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4w9-0001rP-Lu
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4w4-0005ra-Kl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:24:57 +0100
Message-Id: <20180209092524.31348-3-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/29] s390x/tcg: deliver multiple interrupts in
 a row
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We have to consider all deliverable interrupts.

We now have to take care of the special scenario, where we first
inject an interrupt with a WAIT PSW, followed by a !WAIT PSW. (very
unlikely but possible)

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index e8f7a40c2b..97caa7f418 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -433,10 +433,12 @@ void s390_cpu_do_interrupt(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
+    bool stopped = false;
 
     qemu_log_mask(CPU_LOG_INT, "%s: %d at pc=%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.addr);
 
+try_deliver:
     /* handle machine checks */
     if (cs->exception_index == -1 && s390_cpu_has_mcck_int(cpu)) {
         cs->exception_index = EXCP_MCHK;
@@ -479,13 +481,14 @@ void s390_cpu_do_interrupt(CPUState *cs)
         break;
     case EXCP_STOP:
         do_stop_interrupt(env);
+        stopped = true;
         break;
     }
 
-    /* WAIT PSW during interrupt injection or STOP interrupt */
-    if (cs->exception_index == EXCP_HLT) {
-        /* don't trigger a cpu_loop_exit(), use an interrupt instead */
-        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
+    if (cs->exception_index != -1 && !stopped) {
+        /* check if there are more pending interrupts to deliver */
+        cs->exception_index = -1;
+        goto try_deliver;
     }
     cs->exception_index = -1;
 
@@ -493,6 +496,15 @@ void s390_cpu_do_interrupt(CPUState *cs)
     if (!env->pending_int) {
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
     }
+
+    /* WAIT PSW during interrupt injection or STOP interrupt */
+    if ((env->psw.mask & PSW_MASK_WAIT) || stopped) {
+        /* don't trigger a cpu_loop_exit(), use an interrupt instead */
+        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
+    } else if (cs->halted) {
+        /* unhalt if we had a WAIT PSW somehwere in our injection chain */
+        s390_cpu_unhalt(cpu);
+    }
 }
 
 bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.13.6
