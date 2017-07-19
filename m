Received: from eggs.gnu.org ([2001:4830:134:3::10]:60156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXoUg-00057H-I2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXoUb-0003mF-ML
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXoUb-0003m6-Cx
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:54:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 19 Jul 2017 14:54:06 +0200
Message-Id: <1500468850-15571-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1500468850-15571-1-git-send-email-thuth@redhat.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] target/s390x: Move program_interrupt() &
 trigger_pgm_exception() to interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

misc_helper.c won't be compiled with --disable-tcg anymore, but we
still need the program_interrupt() function in that case. Move it
to interrupt.c instead, and refactor it a little bit to re-use the
code from trigger_pgm_exception() here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu.h         |  5 +----
 target/s390x/helper.c      | 10 ----------
 target/s390x/interrupt.c   | 36 ++++++++++++++++++++++++++++++++++++
 target/s390x/misc_helper.c | 26 --------------------------
 4 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7732d01..aec9aac 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -474,10 +474,6 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
-#endif
-
 S390CPU *cpu_s390x_init(const char *cpu_model);
 S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
 S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
@@ -1146,6 +1142,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
                                      uintptr_t retaddr);
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index aef09e1..2a89029 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -165,16 +165,6 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 
 #else /* !CONFIG_USER_ONLY */
 
-/* Ensure to exit the TB after this call! */
-void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
-{
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    cs->exception_index = EXCP_PGM;
-    env->int_pgm_code = code;
-    env->int_pgm_ilen = ilen;
-}
-
 int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
                               int rw, int mmu_idx)
 {
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 9edef96..b30c95c 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -8,10 +8,46 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 #include "sysemu/kvm.h"
 #include "hw/s390x/ioinst.h"
 
+/* Ensure to exit the TB after this call! */
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
+{
+    CPUState *cs = CPU(s390_env_get_cpu(env));
+
+    cs->exception_index = EXCP_PGM;
+    env->int_pgm_code = code;
+    env->int_pgm_ilen = ilen;
+}
+
+void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
+{
+    S390CPU *cpu = s390_env_get_cpu(env);
+
+    qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
+                  env->psw.addr);
+
+    if (kvm_enabled()) {
+#ifdef CONFIG_KVM
+        struct kvm_s390_irq irq = {
+            .type = KVM_S390_PROGRAM_INT,
+            .u.pgm.code = code,
+        };
+
+        kvm_s390_vcpu_interrupt(cpu, &irq);
+#endif
+    } else {
+        trigger_pgm_exception(env, code, ilen);
+#ifdef CONFIG_TCG
+        cpu_loop_exit(CPU(cpu));
+#endif
+    }
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
                     uint64_t param64)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index b508101..3fd7070 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -75,32 +75,6 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
     cpu_loop_exit(cs);
 }
 
-void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
-{
-    S390CPU *cpu = s390_env_get_cpu(env);
-
-    qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
-                  env->psw.addr);
-
-    if (kvm_enabled()) {
-#ifdef CONFIG_KVM
-        struct kvm_s390_irq irq = {
-            .type = KVM_S390_PROGRAM_INT,
-            .u.pgm.code = code,
-        };
-
-        kvm_s390_vcpu_interrupt(cpu, &irq);
-#endif
-    } else {
-        CPUState *cs = CPU(cpu);
-
-        env->int_pgm_code = code;
-        env->int_pgm_ilen = ilen;
-        cs->exception_index = EXCP_PGM;
-        cpu_loop_exit(cs);
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 
 /* SCLP service call */
-- 
1.8.3.1
