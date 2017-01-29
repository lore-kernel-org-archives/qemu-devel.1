Received: from eggs.gnu.org ([2001:4830:134:3::10]:46950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwiw-00082X-D5
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwir-0002D6-Nn
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:22 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwir-0002Cp-KM
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:17 -0500
Received: by mail-qt0-x244.google.com with SMTP id n13so53482243qtc.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:10 +0100
Message-Id: <20170129210910.6333-8-pbonzini@redhat.com>
In-Reply-To: <20170129210910.6333-1-pbonzini@redhat.com>
References: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] cpu-exec: centralize exiting to the main
 loop
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

The cpu->exit_request check in cpu_loop_exec_tb is unnecessary,
because cpu->tcg_exit_req is always set after cpu->exit_request.
So let the TB exit and we will pick up the exit request later
in cpu_handle_interrupt.

Likewise, use cpu->exit_request to set EXCP_INTERRUPT when the
instruction counter expires.  Because cpu_loop_exec_tb is
followed immediately by align_clocks, this lets us remove the
SyncClocks *sc argument to cpu_loop_exec_tb.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 903a834..3838eb8 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -517,6 +517,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             *last_tb = NULL;
         }
     }
+
+    /* Finally, check if we need to exit to the main loop.  */
     if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
@@ -527,16 +529,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
-                                    TranslationBlock **last_tb, int *tb_exit,
-                                    SyncClocks *sc)
+                                    TranslationBlock **last_tb, int *tb_exit)
 {
     uintptr_t ret;
     int32_t insns_left;
 
-    if (unlikely(atomic_read(&cpu->exit_request))) {
-        return;
-    }
-
     trace_exec_tb(tb, tb->pc);
     ret = cpu_tb_exec(cpu, tb);
     tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
@@ -578,10 +575,8 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
          */
         if (insns_left > 0) {
             cpu_exec_nocache(cpu, insns_left, tb, false);
-            align_clocks(sc, cpu);
         }
-        cpu->exception_index = EXCP_INTERRUPT;
-        cpu_loop_exit(cpu);
+        atomic_set(&cpu->exit_request, 1);
     }
 }
 
@@ -641,7 +636,7 @@ int cpu_exec(CPUState *cpu)
 
         while (!cpu_handle_interrupt(cpu, &last_tb)) {
             TranslationBlock *tb = tb_find(cpu, last_tb, tb_exit);
-            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
+            cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit);
             /* Try to align the host and virtual clocks
                if the guest is in advance */
             align_clocks(&sc, cpu);
-- 
2.9.3
