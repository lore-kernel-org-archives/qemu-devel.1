Received: from eggs.gnu.org ([2001:4830:134:3::10]:46922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwit-00080i-Oa
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwio-0002Bb-R4
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:19 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwio-0002BU-MO
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:14 -0500
Received: by mail-qt0-x243.google.com with SMTP id w20so20059454qtb.1
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:06 +0100
Message-Id: <20170129210910.6333-4-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] cpu-exec: avoid cpu_loop_exit in
 cpu_handle_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru

The siglongjmp goes straight back to the beginning of cpu_exec's
outermost loop.  We do not need a non-local jump; we can simply
leave the inner TB execution loop whose structure now becomes
clearer, too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 4065e0e..e62abed 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -461,7 +461,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
-static inline void cpu_handle_interrupt(CPUState *cpu,
+static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -475,7 +475,7 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
         if (interrupt_request & CPU_INTERRUPT_DEBUG) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
             cpu->exception_index = EXCP_DEBUG;
-            cpu_loop_exit(cpu);
+            return true;
         }
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
             /* Do nothing */
@@ -484,7 +484,7 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
             cpu->halted = 1;
             cpu->exception_index = EXCP_HLT;
-            cpu_loop_exit(cpu);
+            return true;
         }
 #if defined(TARGET_I386)
         else if (interrupt_request & CPU_INTERRUPT_INIT) {
@@ -494,13 +494,13 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
             cpu_svm_check_intercept_param(env, SVM_EXIT_INIT, 0);
             do_cpu_init(x86_cpu);
             cpu->exception_index = EXCP_HALTED;
-            cpu_loop_exit(cpu);
+            return true;
         }
 #else
         else if (interrupt_request & CPU_INTERRUPT_RESET) {
             replay_interrupt();
             cpu_reset(cpu);
-            cpu_loop_exit(cpu);
+            return true;
         }
 #endif
         /* The target hook has 3 exit conditions:
@@ -526,8 +526,10 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
-        cpu_loop_exit(cpu);
+        return true;
     }
+
+    return false;
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
@@ -625,7 +627,7 @@ int cpu_exec(CPUState *cpu)
     for(;;) {
         /* prepare setjmp context for exception handling */
         if (sigsetjmp(cpu->jmp_env, 0) == 0) {
-            TranslationBlock *tb, *last_tb = NULL;
+            TranslationBlock *last_tb = NULL;
             int tb_exit = 0;
 
             /* if an exception is pending, we execute it here */
@@ -633,14 +635,13 @@ int cpu_exec(CPUState *cpu)
                 break;
             }
 
-            for(;;) {
-                cpu_handle_interrupt(cpu, &last_tb);
-                tb = tb_find(cpu, last_tb, tb_exit);
+            while (!cpu_handle_interrupt(cpu, &last_tb)) {
+                TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
                 cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
                 /* Try to align the host and virtual clocks
                    if the guest is in advance */
                 align_clocks(&sc, cpu);
-            } /* for(;;) */
+            }
         } else {
 #if defined(__clang__) || !QEMU_GNUC_PREREQ(4, 6)
             /* Some compilers wrongly smash all local variables after
-- 
2.9.3
