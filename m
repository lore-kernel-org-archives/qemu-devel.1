Received: from eggs.gnu.org ([2001:4830:134:3::10]:51938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6h-0003tv-PO
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6g-0008ES-Vt
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:27 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6g-0008Dv-Pn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:26 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so3429115wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:26 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56])
	by smtp.gmail.com with ESMTPSA id g5sm9203365wrd.0.2017.02.16.06.32.24
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Feb 2017 06:32:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:38 +0100
Message-Id: <1487255507-106654-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/23] cpu-exec: avoid repeated sigsetjmp on
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

The sigsetjmp only needs to be prepared once for the whole execution
of cpu_exec.  This patch takes care of the "== 0" side, using a
nested loop so that cpu_handle_interrupt goes straight back to
cpu_handle_exception without doing another sigsetjmp.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index ed2fbc6..865015c 100644
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
1.8.3.1
