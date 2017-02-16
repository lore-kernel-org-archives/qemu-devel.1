Received: from eggs.gnu.org ([2001:4830:134:3::10]:51917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6g-0003sU-IK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6f-0008D7-6l
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:26 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6f-0008CW-0N
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:25 -0500
Received: by mail-wr0-x243.google.com with SMTP id c4so2275630wrd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:24 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56])
	by smtp.gmail.com with ESMTPSA id g5sm9203365wrd.0.2017.02.16.06.32.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Feb 2017 06:32:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:37 +0100
Message-Id: <1487255507-106654-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/23] cpu-exec: avoid cpu_loop_exit in
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

The siglongjmp goes straight back to the beginning of cpu_exec's
outermost loop.  We do not need a siglongjmp, we can simply
leave the inner TB execution loop.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index d50625b..ed2fbc6 100644
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
1.8.3.1
