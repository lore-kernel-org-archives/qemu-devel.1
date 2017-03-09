Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4L-0005Fk-SX
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4K-0006Yr-2C
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:17 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clw4J-0006YP-PS
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:15 -0500
Received: by mail-wm0-x232.google.com with SMTP id n11so136796302wma.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:17:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Mar 2017 11:17:12 +0000
Message-Id: <20170309111714.20394-10-alex.bennee@linaro.org>
In-Reply-To: <20170309111714.20394-1-alex.bennee@linaro.org>
References: <20170309111714.20394-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/11] target-i386: defer VMEXIT to do_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/cpu.h        |  2 ++
 target/i386/seg_helper.c | 20 +++++++++++---------
 target/i386/svm_helper.c | 22 +++++++++++++---------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fb09aee7f8..406cb24301 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -697,6 +697,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define EXCP_SYSCALL    0x100 /* only happens in user only emulation
                                  for syscall instruction */
+#define EXCP_VMEXIT     0x100
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
@@ -1632,6 +1633,7 @@ void cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
                                    uint64_t param, uintptr_t retaddr);
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr);
+void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1);
 
 /* seg_helper.c */
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw);
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 5c845dc25c..0374031ea2 100644
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
index 78d8df4af6..59e8b5091c 100644
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
2.11.0
