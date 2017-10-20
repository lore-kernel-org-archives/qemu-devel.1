Received: from eggs.gnu.org ([2001:4830:134:3::10]:58573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtF-0002L3-84
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtB-00030l-Bg
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:01 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:42 +0200
Message-Id: <20171020115418.2050-11-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/46] target/s390x: factor out handling of WAIT
 PSW into s390_handle_wait()
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

This will now also detect crashes under TCG. We can directly use
cpu->env.psw.addr instead of kvm_run, as we do a cpu_synchronize_state().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-9-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c   | 27 +++++++++++++++++++++------
 target/s390x/internal.h |  1 +
 target/s390x/kvm.c      | 14 +-------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index e22b93258b..2d7df83c59 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -26,6 +26,7 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "hw/s390x/ioinst.h"
+#include "sysemu/hw_accel.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #endif
@@ -113,6 +114,25 @@ hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr vaddr)
     return phys_addr;
 }
 
+static inline bool is_special_wait_psw(uint64_t psw_addr)
+{
+    /* signal quiesce */
+    return psw_addr == 0xfffUL;
+}
+
+void s390_handle_wait(S390CPU *cpu)
+{
+    if (s390_cpu_halt(cpu) == 0) {
+#ifndef CONFIG_USER_ONLY
+        if (is_special_wait_psw(cpu->env.psw.addr)) {
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        } else {
+            qemu_system_guest_panicked(NULL);
+        }
+#endif
+    }
+}
+
 void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
 {
     uint64_t old_mask = env->psw.mask;
@@ -128,12 +148,7 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
     }
 
     if (mask & PSW_MASK_WAIT) {
-        S390CPU *cpu = s390_env_get_cpu(env);
-        if (s390_cpu_halt(cpu) == 0) {
-#ifndef CONFIG_USER_ONLY
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-#endif
-        }
+        s390_handle_wait(s390_env_get_cpu(env));
     }
 }
 
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index e41fb2e38e..6e500d6bb7 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -352,6 +352,7 @@ void s390_cpu_recompute_watchpoints(CPUState *cs);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 void do_restart_interrupt(CPUS390XState *env);
+void s390_handle_wait(S390CPU *cpu);
 #ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(LowCore *lowcore);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d3700fc2c2..3f656cfd07 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1997,12 +1997,6 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
     return r;
 }
 
-static bool is_special_wait_psw(CPUState *cs)
-{
-    /* signal quiesce */
-    return cs->kvm_run->psw_addr == 0xfffUL;
-}
-
 static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
 {
     CPUState *cs = CPU(cpu);
@@ -2074,13 +2068,7 @@ static int handle_intercept(S390CPU *cpu)
         case ICPT_WAITPSW:
             /* disabled wait, since enabled wait is handled in kernel */
             cpu_synchronize_state(cs);
-            if (s390_cpu_halt(cpu) == 0) {
-                if (is_special_wait_psw(cs)) {
-                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-                } else {
-                    qemu_system_guest_panicked(NULL);
-                }
-            }
+            s390_handle_wait(cpu);
             r = EXCP_HALTED;
             break;
         case ICPT_CPU_STOP:
-- 
2.13.6
