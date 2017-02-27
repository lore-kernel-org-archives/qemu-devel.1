Received: from eggs.gnu.org ([2001:4830:134:3::10]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKge-0004aU-R8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgd-0000SB-K1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgd-0000Rw-8z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:45:55 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:36 +0100
Message-Id: <20170227124551.8673-3-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/17] replay: check icount in cpu exec loop
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
---
 cpu-exec.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 6fd3f47..2a0dfb0 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -554,8 +554,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         qemu_mutex_unlock_iothread();
     }
 
-
-    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
+    /* Finally, check if we need to exit to the main loop.  */
+    if (unlikely(atomic_read(&cpu->exit_request)
+        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
         return true;
@@ -565,8 +566,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
-                                    TranslationBlock **last_tb, int *tb_exit,
-                                    SyncClocks *sc)
+                                    TranslationBlock **last_tb, int *tb_exit)
 {
     uintptr_t ret;
     int32_t insns_left;
@@ -615,10 +615,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
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
@@ -677,7 +674,7 @@ int cpu_exec(CPUState *cpu)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
             align_clocks(&sc, cpu);
-- 
2.9.3
