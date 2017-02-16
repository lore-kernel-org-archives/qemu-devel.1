Received: from eggs.gnu.org ([2001:4830:134:3::10]:52006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6q-00040k-EY
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6k-0008Fj-GK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:36 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6k-0008FF-AA
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:30 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so3431039wmi.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:30 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56])
	by smtp.gmail.com with ESMTPSA id g5sm9203365wrd.0.2017.02.16.06.32.26
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Feb 2017 06:32:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:39 +0100
Message-Id: <1487255507-106654-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/23] cpu-exec: remove outermost infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reorganize the sigsetjmp so that the restart case falls through
to cpu_handle_exception and the execution loop.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 58 +++++++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 865015c..b8ebb5c 100644
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
1.8.3.1
