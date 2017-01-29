Received: from eggs.gnu.org ([2001:4830:134:3::10]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwiu-000818-5X
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwip-0002Br-DQ
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:20 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwip-0002Bg-9N
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:15 -0500
Received: by mail-qt0-x243.google.com with SMTP id h53so17150689qth.3
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:07 +0100
Message-Id: <20170129210910.6333-5-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] cpu-exec: avoid repeated sigsetjmp on
 interrupts
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

The sigsetjmp only needs to be prepared once for the whole execution
of cpu_exec.  This patch takes care of the "== 0" side, using a
nested loop so that cpu_handle_interrupt goes straight back to
cpu_handle_exception without doing another sigsetjmp.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index e62abed..fcf37ba 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -627,21 +627,21 @@ int cpu_exec(CPUState *cpu)
     for(;;) {
         /* prepare setjmp context for exception handling */
         if (sigsetjmp(cpu->jmp_env, 0) == 0) {
-            TranslationBlock *last_tb = NULL;
-            int tb_exit = 0;
-
             /* if an exception is pending, we execute it here */
-            if (cpu_handle_exception(cpu, &ret)) {
-                break;
+            while (!cpu_handle_exception(cpu, &ret)) {
+                TranslationBlock *last_tb = NULL;
+                int tb_exit = 0;
+
+                while (!cpu_handle_interrupt(cpu, &last_tb)) {
+                    TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
+                    cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+                    /* Try to align the host and virtual clocks
+                       if the guest is in advance */
+                    align_clocks(&sc, cpu);
+                }
             }
+            break;
 
-            while (!cpu_handle_interrupt(cpu, &last_tb)) {
-                TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-                cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
-                /* Try to align the host and virtual clocks
-                   if the guest is in advance */
-                align_clocks(&sc, cpu);
-            }
         } else {
 #if defined(__clang__) || !QEMU_GNUC_PREREQ(4, 6)
             /* Some compilers wrongly smash all local variables after
-- 
2.9.3
