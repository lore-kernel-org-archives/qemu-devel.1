Received: from eggs.gnu.org ([2001:4830:134:3::10]:58849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtg-0002pN-P9
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtf-0003OL-UW
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:51 +0200
Message-Id: <20171020115418.2050-20-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 19/46] s390x/kvm: factor out actual handling of
 STOP interrupts
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

For KVM, the KVM module decides when a STOP can be performed (when the
STOP interrupt can be processed). Factor it out so we can use it
later for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-19-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/internal.h |  1 +
 target/s390x/kvm.c      |  8 +-------
 target/s390x/sigp.c     | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index d6ab45add4..2c3fc3fce0 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -418,5 +418,6 @@ void s390x_translate_init(void);
 
 /* sigp.c */
 int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3);
+void do_stop_interrupt(CPUS390XState *env);
 
 #endif /* S390X_INTERNAL_H */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b2e36559c8..88f27d75b9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1634,13 +1634,7 @@ static int handle_intercept(S390CPU *cpu)
             r = EXCP_HALTED;
             break;
         case ICPT_CPU_STOP:
-            if (s390_cpu_set_state(CPU_STATE_STOPPED, cpu) == 0) {
-                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-            }
-            if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
-                s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
-            }
-            cpu->env.sigp_order = 0;
+            do_stop_interrupt(&cpu->env);
             r = EXCP_HALTED;
             break;
         case ICPT_OPEREXC:
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 4813123aad..9587c3d319 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -81,7 +81,7 @@ static void sigp_stop_and_store_status(CPUState *cs, run_on_cpu_data arg)
     case CPU_STATE_OPERATING:
         cpu->env.sigp_order = SIGP_STOP_STORE_STATUS;
         cpu_inject_stop(cpu);
-        /* store will be performed when handling the stop intercept */
+        /* store will be performed in do_stop_interrup() */
         break;
     case CPU_STATE_STOPPED:
         /* already stopped, just store the status */
@@ -360,6 +360,19 @@ int s390_cpu_restart(S390CPU *cpu)
     return 0;
 }
 
+void do_stop_interrupt(CPUS390XState *env)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    if (s390_cpu_set_state(CPU_STATE_STOPPED, cpu) == 0) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+    if (cpu->env.sigp_order == SIGP_STOP_STORE_STATUS) {
+        s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
+    }
+    env->sigp_order = 0;
+}
+
 void s390_init_sigp(void)
 {
     qemu_mutex_init(&qemu_sigp_mutex);
-- 
2.13.6
