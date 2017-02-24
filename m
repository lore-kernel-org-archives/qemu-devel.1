Received: from eggs.gnu.org ([2001:4830:134:3::10]:36244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrE-0007rF-91
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrB-0002F2-Qd
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrB-0002Ej-KL
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:37 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so4053922wmd.3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:15 +0100
Message-Id: <1487958030-51417-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/17] replay: check icount in cpu exec loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <dovgaluk@ispras.ru>

This patch adds check to break cpu loop when icount expires without
setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
available translated blocks and all instructions were executed.
In icount replay mode unnecessary tb_find will be called (which may
cause an exception) and execution will be non-deterministic.
Because cpu_loop_exec_tb cannot longjmp anymore, we can remove
the anticipated call to align_clocks in cpu_loop_exec_tb, as
well as the SyncClocks *sc argument.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <002801d2810f$18809c20$4981d460$@ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 cpu-exec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 8f094c8..7ddf66c 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -517,7 +517,10 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             *last_tb = NULL;
         }
     }
-    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
+
+    /* Finally, check if we need to exit to the main loop.  */
+    if (unlikely(atomic_read(&cpu->exit_request)
+        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
         return true;
@@ -527,8 +530,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
-                                    TranslationBlock **last_tb, int *tb_exit,
-                                    SyncClocks *sc)
+                                    TranslationBlock **last_tb, int *tb_exit)
 {
     uintptr_t ret;
     int32_t insns_left;
@@ -579,10 +581,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
          */
         if (insns_left > 0) {
             cpu_exec_nocache(cpu, insns_left, tb, false);
-            align_clocks(sc, cpu);
         }
-        cpu->exception_index = EXCP_INTERRUPT;
-        cpu_loop_exit(cpu);
     }
 #endif
 }
@@ -593,7 +592,7 @@ int cpu_exec(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     int ret;
-    SyncClocks sc;
+    SyncClocks sc = { 0 };
 
     /* replay_interrupt may need current_cpu */
     current_cpu = cpu;
@@ -643,7 +642,7 @@ int cpu_exec(CPUState *cpu)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
             align_clocks(&sc, cpu);
-- 
1.8.3.1
