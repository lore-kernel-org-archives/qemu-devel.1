Received: from eggs.gnu.org ([2001:4830:134:3::10]:46924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwit-000810-Vw
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwiq-0002CF-A1
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:19 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwiq-0002C0-5U
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:16 -0500
Received: by mail-qk0-x242.google.com with SMTP id 11so16258674qkl.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:08 +0100
Message-Id: <20170129210910.6333-6-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] cpu-exec: remove outermost infinite loop
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

Reorganize the sigsetjmp so that the restart case falls through
to cpu_handle_exception and the execution loop.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 58 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index fcf37ba..1226362 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -624,41 +624,37 @@ int cpu_exec(CPUState *cpu)
      */
     init_delay_params(&sc, cpu);
 
-    for(;;) {
-        /* prepare setjmp context for exception handling */
-        if (sigsetjmp(cpu->jmp_env, 0) == 0) {
-            /* if an exception is pending, we execute it here */
-            while (!cpu_handle_exception(cpu, &ret)) {
-                TranslationBlock *last_tb = NULL;
-                int tb_exit = 0;
-
-                while (!cpu_handle_interrupt(cpu, &last_tb)) {
-                    TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-                    cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
-                    /* Try to align the host and virtual clocks
-                       if the guest is in advance */
-                    align_clocks(&sc, cpu);
-                }
-            }
-            break;
-
-        } else {
+    /* prepare setjmp context for exception handling */
+    if (sigsetjmp(cpu->jmp_env, 0) != 0) {
 #if defined(__clang__) || !QEMU_GNUC_PREREQ(4, 6)
-            /* Some compilers wrongly smash all local variables after
-             * siglongjmp. There were bug reports for gcc 4.5.0 and clang.
-             * Reload essential local variables here for those compilers.
-             * Newer versions of gcc would complain about this code (-Wclobbered). */
-            cpu = current_cpu;
-            cc = CPU_GET_CLASS(cpu);
+        /* Some compilers wrongly smash all local variables after
+         * siglongjmp. There were bug reports for gcc 4.5.0 and clang.
+         * Reload essential local variables here for those compilers.
+         * Newer versions of gcc would complain about this code (-Wclobbered). */
+        cpu = current_cpu;
+        cc = CPU_GET_CLASS(cpu);
 #else /* buggy compiler */
-            /* Assert that the compiler does not smash local variables. */
-            g_assert(cpu == current_cpu);
-            g_assert(cc == CPU_GET_CLASS(cpu));
+        /* Assert that the compiler does not smash local variables. */
+        g_assert(cpu == current_cpu);
+        g_assert(cc == CPU_GET_CLASS(cpu));
 #endif /* buggy compiler */
-            cpu->can_do_io = 1;
-            tb_lock_reset();
+        cpu->can_do_io = 1;
+        tb_lock_reset();
+    }
+
+    /* if an exception is pending, we execute it here */
+    while (!cpu_handle_exception(cpu, &ret)) {
+        TranslationBlock *last_tb = NULL;
+        int tb_exit = 0;
+
+        while (!cpu_handle_interrupt(cpu, &last_tb)) {
+            TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
+            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+            /* Try to align the host and virtual clocks
+               if the guest is in advance */
+            align_clocks(&sc, cpu);
         }
-    } /* for(;;) */
+    }
 
     cc->cpu_exec_exit(cpu);
     rcu_read_unlock();
-- 
2.9.3
