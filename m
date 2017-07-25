Received: from eggs.gnu.org ([2001:4830:134:3::10]:44307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwL3-0002Bl-1y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwL1-0003pn-Gq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:41:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwL1-0003pO-7t
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:41:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:23 +0200
Message-Id: <20170725094026.5376-12-cohuck@redhat.com>
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 11/14] target/s390x: Rework
 program_interrupt() and related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

misc_helper.c won't be compiled with --disable-tcg anymore, but we
still need the program_interrupt() function in that case. Move it
to interrupt.c instead, and refactor it to re-use the code from
trigger_pgm_exception() (for TCG) and enter_pgmcheck() (for KVM,
which now got renamed to kvm_s390_program_interrupt() for
clarity).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1500886370-14572-4-git-send-email-thuth@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         |  9 +++++----
 target/s390x/helper.c      | 10 ----------
 target/s390x/interrupt.c   | 39 +++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm.c         | 16 ++++++++--------
 target/s390x/misc_helper.c | 26 --------------------------
 5 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7732d01784..4041bfc4bc 100644
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
@@ -1146,10 +1142,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
+void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
 void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
                                      uintptr_t retaddr);
 
 #ifdef CONFIG_KVM
+void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 void kvm_s390_io_interrupt(uint16_t subchannel_id,
                            uint16_t subchannel_nr, uint32_t io_int_parm,
                            uint32_t io_int_word);
@@ -1170,6 +1168,9 @@ int kvm_s390_get_ri(void);
 int kvm_s390_get_gs(void);
 void kvm_s390_crypto_reset(void);
 #else
+static inline void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
+{
+}
 static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
                                         uint16_t subchannel_nr,
                                         uint32_t io_int_parm,
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 30ac2a77b3..e2040d65a6 100644
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
index 9edef96795..fde3da793a 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -8,10 +8,49 @@
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
+static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
+                                       int ilen)
+{
+#ifdef CONFIG_TCG
+    trigger_pgm_exception(env, code, ilen);
+    cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+#else
+    g_assert_not_reached();
+#endif
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
+        kvm_s390_program_interrupt(cpu, code);
+    } else if (tcg_enabled()) {
+        tcg_s390_program_interrupt(env, code, ilen);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
                     uint64_t param64)
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 84416c0a64..c4c5791d27 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1032,7 +1032,7 @@ void kvm_s390_service_interrupt(uint32_t parm)
     kvm_s390_floating_interrupt(&irq);
 }
 
-static void enter_pgmcheck(S390CPU *cpu, uint16_t code)
+void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code)
 {
     struct kvm_s390_irq irq = {
         .type = KVM_S390_PROGRAM_INT,
@@ -1068,7 +1068,7 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
 
     r = sclp_service_call(env, sccb, code);
     if (r < 0) {
-        enter_pgmcheck(cpu, -r);
+        kvm_s390_program_interrupt(cpu, -r);
     } else {
         setcc(cpu, r);
     }
@@ -1236,7 +1236,7 @@ static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
     isc = (env->regs[r3] >> 27) & 0x7;
     r = css_do_sic(env, isc, mode);
     if (r) {
-        enter_pgmcheck(cpu, -r);
+        kvm_s390_program_interrupt(cpu, -r);
     }
 
     return 0;
@@ -1357,7 +1357,7 @@ static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
     cpu_synchronize_state(CPU(cpu));
     ret = s390_virtio_hypercall(env);
     if (ret == -EINVAL) {
-        enter_pgmcheck(cpu, PGM_SPECIFICATION);
+        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
         return 0;
     }
 
@@ -1374,7 +1374,7 @@ static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
     r3 = run->s390_sieic.ipa & 0x000f;
     rc = handle_diag_288(&cpu->env, r1, r3);
     if (rc) {
-        enter_pgmcheck(cpu, PGM_SPECIFICATION);
+        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
     }
 }
 
@@ -1431,7 +1431,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
         break;
     default:
         DPRINTF("KVM: unknown DIAG: 0x%x\n", func_code);
-        enter_pgmcheck(cpu, PGM_SPECIFICATION);
+        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
         break;
     }
 
@@ -1899,7 +1899,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
 
     if (r < 0) {
         r = 0;
-        enter_pgmcheck(cpu, 0x0001);
+        kvm_s390_program_interrupt(cpu, PGM_OPERATION);
     }
 
     return r;
@@ -2009,7 +2009,7 @@ static int handle_intercept(S390CPU *cpu)
                 /* Then check for potential pgm check loops */
                 r = handle_oper_loop(cpu, run);
                 if (r == 0) {
-                    enter_pgmcheck(cpu, PGM_OPERATION);
+                    kvm_s390_program_interrupt(cpu, PGM_OPERATION);
                 }
             }
             break;
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 6a90ad55cc..44c5c401fb 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -68,32 +68,6 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
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
2.13.3
