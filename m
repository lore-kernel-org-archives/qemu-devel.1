Received: from eggs.gnu.org ([2001:4830:134:3::10]:45034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckv0s-00014C-JI
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckv0p-0001hz-HL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:57:30 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ckv0p-0001he-7J
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:57:27 -0500
Received: by mail-wr0-x235.google.com with SMTP id l37so119907346wrc.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:57:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  6 Mar 2017 15:57:22 +0000
Message-Id: <20170306155722.31315-1-alex.bennee@linaro.org>
In-Reply-To: <d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
References: <d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/i386: move nested exception check to
 x86_cpu_exec_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alexander.boettcher@genode-labs.com
Cc: rth@twiddle.net, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

(DUMB CODE MOTION COMMIT WITHOUT FULL UNDERSTANDING OF X86 NEEDS REVIEW)

During code generation cpu_svm_check_intercept_param can through a
sequence of events generated a tlb_fill which fails due to a double
tb_lock(). Moving the checking to x86_cpu_exec_interrupt where it can
take the lock at will.

Reported-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: Richard Henderson <rth@twiddle.net>
---
 target/i386/cpu.h         |  1 +
 target/i386/excp_helper.c | 54 +------------------------------------------
 target/i386/seg_helper.c  | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fb09aee7f8..07c591672c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1105,6 +1105,7 @@ typedef struct CPUX86State {
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
+    uintptr_t exception_retaddr;
     target_ulong exception_next_eip;
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
     union {
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index ee596c6082..0a1a02cdd4 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -35,51 +35,6 @@ void helper_raise_exception(CPUX86State *env, int exception_index)
 }
 
 /*
- * Check nested exceptions and change to double or triple fault if
- * needed. It should only be called, if this is not an interrupt.
- * Returns the new exception number.
- */
-static int check_exception(CPUX86State *env, int intno, int *error_code,
-                           uintptr_t retaddr)
-{
-    int first_contributory = env->old_exception == 0 ||
-                              (env->old_exception >= 10 &&
-                               env->old_exception <= 13);
-    int second_contributory = intno == 0 ||
-                               (intno >= 10 && intno <= 13);
-
-    qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x new 0x%x\n",
-                env->old_exception, intno);
-
-#if !defined(CONFIG_USER_ONLY)
-    if (env->old_exception == EXCP08_DBLE) {
-        if (env->hflags & HF_SVMI_MASK) {
-            cpu_vmexit(env, SVM_EXIT_SHUTDOWN, 0, retaddr); /* does not return */
-        }
-
-        qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
-
-        qemu_system_reset_request();
-        return EXCP_HLT;
-    }
-#endif
-
-    if ((first_contributory && second_contributory)
-        || (env->old_exception == EXCP0E_PAGE &&
-            (second_contributory || (intno == EXCP0E_PAGE)))) {
-        intno = EXCP08_DBLE;
-        *error_code = 0;
-    }
-
-    if (second_contributory || (intno == EXCP0E_PAGE) ||
-        (intno == EXCP08_DBLE)) {
-        env->old_exception = intno;
-    }
-
-    return intno;
-}
-
-/*
  * Signal an interruption. It is executed in the main CPU loop.
  * is_int is TRUE if coming from the int instruction. next_eip is the
  * env->eip value AFTER the interrupt instruction. It is only relevant if
@@ -92,18 +47,11 @@ static void QEMU_NORETURN raise_interrupt2(CPUX86State *env, int intno,
 {
     CPUState *cs = CPU(x86_env_get_cpu(env));
 
-    if (!is_int) {
-        cpu_svm_check_intercept_param(env, SVM_EXIT_EXCP_BASE + intno,
-                                      error_code, retaddr);
-        intno = check_exception(env, intno, &error_code, retaddr);
-    } else {
-        cpu_svm_check_intercept_param(env, SVM_EXIT_SWINT, 0, retaddr);
-    }
-
     cs->exception_index = intno;
     env->error_code = error_code;
     env->exception_is_int = is_int;
     env->exception_next_eip = env->eip + next_eip_addend;
+    env->exception_retaddr = retaddr;
     cpu_loop_exit_restore(cs, retaddr);
 }
 
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 5c845dc25c..055b6d4025 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
+#include "sysemu/sysemu.h"
 
 //#define DEBUG_PCALL
 
@@ -1314,12 +1315,70 @@ void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
     do_interrupt_all(x86_env_get_cpu(env), intno, 0, 0, 0, is_hw);
 }
 
+/*
+ * Check nested exceptions and change to double or triple fault if
+ * needed. It should only be called, if this is not an interrupt.
+ * Returns the new exception number.
+ */
+static int check_exception(CPUX86State *env, int intno, int *error_code,
+                           uintptr_t retaddr)
+{
+    int first_contributory = env->old_exception == 0 ||
+                              (env->old_exception >= 10 &&
+                               env->old_exception <= 13);
+    int second_contributory = intno == 0 ||
+                               (intno >= 10 && intno <= 13);
+
+    qemu_log_mask(CPU_LOG_INT, "check_exception old: 0x%x new 0x%x\n",
+                env->old_exception, intno);
+
+#if !defined(CONFIG_USER_ONLY)
+    if (env->old_exception == EXCP08_DBLE) {
+        if (env->hflags & HF_SVMI_MASK) {
+            cpu_vmexit(env, SVM_EXIT_SHUTDOWN, 0, retaddr); /* does not return */
+        }
+
+        qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
+
+        qemu_system_reset_request();
+        return EXCP_HLT;
+    }
+#endif
+
+    if ((first_contributory && second_contributory)
+        || (env->old_exception == EXCP0E_PAGE &&
+            (second_contributory || (intno == EXCP0E_PAGE)))) {
+        intno = EXCP08_DBLE;
+        *error_code = 0;
+    }
+
+    if (second_contributory || (intno == EXCP0E_PAGE) ||
+        (intno == EXCP08_DBLE)) {
+        env->old_exception = intno;
+    }
+
+    return intno;
+}
+
 bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     bool ret = false;
 
+    if (!env->exception_is_int) {
+        cpu_svm_check_intercept_param(env,
+                                      SVM_EXIT_EXCP_BASE + cs->exception_index,
+                                      env->error_code,
+                                      env->exception_retaddr);
+        cs->exception_index = check_exception(env, cs->exception_index,
+                                              &env->error_code,
+                                              env->exception_retaddr);
+    } else {
+        cpu_svm_check_intercept_param(env, SVM_EXIT_SWINT, 0,
+                                      env->exception_retaddr);
+    }
+
 #if !defined(CONFIG_USER_ONLY)
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
-- 
2.11.0
