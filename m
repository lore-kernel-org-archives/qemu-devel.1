Received: from eggs.gnu.org ([2001:4830:134:3::10]:52986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZM-00085g-D1
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85ZJ-0004yf-Sb
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:29:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:48 +0200
Message-Id: <20181004152857.14525-7-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] s390x: move tcg_s390_program_interrupt()
 into TCG code and mark it noreturn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Move it into TCG-only code and provide a stub. Turn it into noreturn.

As Richard noted, we currently don't log the psw.addr before restoring
the state, fix that by moving (duplicating) the qemu_log_mask in the
tcg/kvm handlers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 13 +++++++++++++
 target/s390x/interrupt.c   | 15 +--------------
 target/s390x/kvm.c         |  4 +++-
 target/s390x/tcg-stub.c    |  5 +++++
 target/s390x/tcg_s390x.h   |  2 ++
 5 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f0ce60cff2..5dab3387c3 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -26,6 +26,7 @@
 #include "exec/cpu_ldst.h"
 #include "hw/s390x/ioinst.h"
 #include "exec/address-spaces.h"
+#include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "hw/s390x/s390_flic.h"
@@ -48,6 +49,18 @@
     do { } while (0)
 #endif
 
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
+                                              int ilen, uintptr_t ra)
+{
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+
+    cpu_restore_state(cs, ra, true);
+    qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
+                  env->psw.addr);
+    trigger_pgm_exception(env, code, ilen);
+    cpu_loop_exit(cs);
+}
+
 #if defined(CONFIG_USER_ONLY)
 
 void s390_cpu_do_interrupt(CPUState *cs)
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 25cfb3eef8..a17eff5ebc 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -15,6 +15,7 @@
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
 #include "hw/s390x/ioinst.h"
+#include "tcg_s390x.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/s390x/s390_flic.h"
 #endif
@@ -29,25 +30,11 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
     env->int_pgm_ilen = ilen;
 }
 
-static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                       int ilen, uintptr_t ra)
-{
-#ifdef CONFIG_TCG
-    trigger_pgm_exception(env, code, ilen);
-    cpu_loop_exit_restore(CPU(s390_env_get_cpu(env)), ra);
-#else
-    g_assert_not_reached();
-#endif
-}
-
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
                             uintptr_t ra)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
-                  env->psw.addr);
-
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(cpu, code);
     } else if (tcg_enabled()) {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 323cb00e6a..78d39b34d0 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -36,6 +36,7 @@
 #include "qemu/timer.h"
 #include "qemu/units.h"
 #include "qemu/mmap-alloc.h"
+#include "qemu/log.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "hw/hw.h"
@@ -1115,7 +1116,8 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
         .type = KVM_S390_PROGRAM_INT,
         .u.pgm.code = code,
     };
-
+    qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
+                  cpu->env.psw.addr);
     kvm_s390_vcpu_interrupt(cpu, &irq);
 }
 
diff --git a/target/s390x/tcg-stub.c b/target/s390x/tcg-stub.c
index c93501db0b..dc444fc867 100644
--- a/target/s390x/tcg-stub.c
+++ b/target/s390x/tcg-stub.c
@@ -18,3 +18,8 @@
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque)
 {
 }
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
+                                              int ilen, uintptr_t ra)
+{
+    g_assert_not_reached();
+}
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index 4e308aa0ce..d1fe01ef7e 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -14,5 +14,7 @@
 #define TCG_S390X_H
 
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
+void QEMU_NORETURN tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
+                                              int ilen, uintptr_t ra);
 
 #endif /* TCG_S390X_H */
-- 
2.14.4
