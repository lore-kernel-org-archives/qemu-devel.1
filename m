Received: from eggs.gnu.org ([2001:4830:134:3::10]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOOR6-000484-Sp
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOOR2-0006uB-9v
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:00 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:28 +0100
Message-Id: <20171211134740.8235-4-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 03/15] s390x/tcg: deliver multiple
 interrupts in a row
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We have to consider all deliverable interrupts.

We now have to take care of the special scenario, where we first
inject an interrupt with a WAIT PSW, followed by a !WAIT PSW. (very
unlikely but possible)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f4697a884d..d024ac5fef 100644
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
2.14.3
