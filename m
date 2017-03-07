Received: from eggs.gnu.org ([2001:4830:134:3::10]:59148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clDR2-0006Wq-4n
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clDQz-0000Od-1u
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:37:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clDQy-0000O9-Ow
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:37:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  7 Mar 2017 12:37:36 +0100
Message-Id: <20170307113736.13864-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target-i386: defer VMEXIT to do_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alexander.boettcher@genode-labs.com, alex.bennee@linaro.org

Paths through the softmmu code during code generation now need to be audited
to check for double locking of tb_lock.  In particular, VMEXIT can take tb_lock
through cpu_vmexit -> cpu_x86_update_cr4 -> tlb_flush.

To avoid this, split VMEXIT delivery in two parts, similar to what is done with
exceptions.  cpu_vmexit only records the VMEXIT exit code and information, and
cc->do_interrupt can then deliver it when it is safe to take the lock.

Reported-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Suggested-by: Richard Henderson <rth@twiddle.net>
Tested-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h        |  2 ++
 target/i386/seg_helper.c | 20 +++++++++++---------
 target/i386/svm_helper.c | 22 +++++++++++++---------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ac2ad6d..40a6ff7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -694,6 +694,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define EXCP_SYSCALL    0x100 /* only happens in user only emulation
                                  for syscall instruction */
+#define EXCP_VMEXIT     0x100
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
@@ -1629,6 +1630,7 @@ void cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
                                    uint64_t param, uintptr_t retaddr);
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr);
+void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1);
 
 /* seg_helper.c */
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw);
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 5c845dc..0374031 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1297,15 +1297,17 @@ void x86_cpu_do_interrupt(CPUState *cs)
     /* successfully delivered */
     env->old_exception = -1;
 #else
-    /* simulate a real cpu exception. On i386, it can
-       trigger new exceptions, but we do not handle
-       double or triple faults yet. */
-    do_interrupt_all(cpu, cs->exception_index,
-                     env->exception_is_int,
-                     env->error_code,
-                     env->exception_next_eip, 0);
-    /* successfully delivered */
-    env->old_exception = -1;
+    if (cs->exception_index >= EXCP_VMEXIT) {
+        assert(env->old_exception == -1);
+        do_vmexit(env, cs->exception_index - EXCP_VMEXIT, env->error_code);
+    } else {
+        do_interrupt_all(cpu, cs->exception_index,
+                         env->exception_is_int,
+                         env->error_code,
+                         env->exception_next_eip, 0);
+        /* successfully delivered */
+        env->old_exception = -1;
+    }
 #endif
 }
 
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 78d8df4..59e8b50 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -580,12 +580,10 @@ void helper_svm_check_io(CPUX86State *env, uint32_t port, uint32_t param,
     }
 }
 
-/* Note: currently only 32 bits of exit_code are used */
 void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
-    uint32_t int_ctl;
 
     if (retaddr) {
         cpu_restore_state(cs, retaddr);
@@ -598,6 +596,19 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
                                                    control.exit_info_2)),
                   env->eip);
 
+    cs->exception_index = EXCP_VMEXIT + exit_code;
+    env->error_code = exit_info_1;
+
+    /* remove any pending exception */
+    env->old_exception = -1;
+    cpu_loop_exit(cs);
+}
+
+void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1)
+{
+    CPUState *cs = CPU(x86_env_get_cpu(env));
+    uint32_t int_ctl;
+
     if (env->hflags & HF_INHIBIT_IRQ_MASK) {
         x86_stl_phys(cs,
                  env->vm_vmcb + offsetof(struct vmcb, control.int_state),
@@ -759,13 +770,6 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
     /* If the host's rIP reloaded by #VMEXIT is outside the limit of the
        host's code segment or non-canonical (in the case of long mode), a
        #GP fault is delivered inside the host. */
-
-    /* remove any pending exception */
-    cs->exception_index = -1;
-    env->error_code = 0;
-    env->old_exception = -1;
-
-    cpu_loop_exit(cs);
 }
 
 #endif
-- 
2.9.3
