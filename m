Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUT-0007UV-0U
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUR-0008BI-Lg
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUR-0008Ay-EV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:02 +0200
Message-Id: <20170918160012.4317-18-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 17/27] s390x/kvm: factor out actual handling
 of STOP interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
index 99413beeae..2e738de6af 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -400,5 +400,6 @@ void s390x_translate_init(void);
 
 /* sigp.c */
 int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3);
+void do_stop_interrupt(CPUS390XState *env);
 
 #endif /* S390X_INTERNAL_H */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 142b63eef0..eb8b297a88 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1594,13 +1594,7 @@ static int handle_intercept(S390CPU *cpu)
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
