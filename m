Received: from eggs.gnu.org ([2001:4830:134:3::10]:51759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9q9-0001ZP-25
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cg9q7-0003Ba-Ny
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cg9q7-0003BF-Hq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:46:43 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 13:46:37 +0100
Message-Id: <20170221124638.19573-3-pbonzini@redhat.com>
In-Reply-To: <20170221124638.19573-1-pbonzini@redhat.com>
References: <20170221124638.19573-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] replay: check icount in cpu exec loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pavel.dovgaluk@ispras.ru, peter.maydell@linaro.orgPavel Dovgalyuk <dovgaluk@ispras.ru>

From: Pavel Dovgalyuk <dovgaluk@ispras.ru>

This patch adds check to break cpu loop when icount expires without
setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
available translated blocks and all instructions were executed.
In icount replay mode unnecessary tb_find will be called (which may
cause an exception) and execution will be non-deterministic.

Because cpu_loop_exec_tb does not longjmp anymore after exhausting the
icount decrementer, it can use the align_clocks call in cpu_exec.  Remove
the one in cpu_loop_exec_tb, as well as the SyncClocks *sc argument.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-Id: <002801d2810f$18809c20$4981d460$@ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 18e1973..bf126dd 100644
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
@@ -578,10 +580,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
          */
         if (insns_left > 0) {
             cpu_exec_nocache(cpu, insns_left, tb, false);
-            align_clocks(sc, cpu);
         }
-        cpu->exception_index = EXCP_INTERRUPT;
-        cpu_loop_exit(cpu);
     }
 }
 
@@ -641,7 +640,7 @@ int cpu_exec(CPUState *cpu)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
             align_clocks(&sc, cpu);
-- 
2.9.3
