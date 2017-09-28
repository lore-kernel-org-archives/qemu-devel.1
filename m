Received: from eggs.gnu.org ([2001:4830:134:3::10]:53561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa2-0004lP-1h
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfZy-0003Y9-4R
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfZx-0003Xr-Rw
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:42 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:56 +0200
Message-Id: <20170928203708.9376-19-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/30] s390x/kvm: factor out actual handling
 of STOP interrupts
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

For KVM, the KVM module decides when a STOP can be performed (when the
STOP interrupt can be processed). Factor it out so we can use it
later for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
index 1174e249ab..72008e436f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1597,13 +1597,7 @@ static int handle_intercept(S390CPU *cpu)
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
2.13.5
