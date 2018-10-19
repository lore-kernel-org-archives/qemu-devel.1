Received: from eggs.gnu.org ([2001:4830:134:3::10]:58953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFc-0004fM-PF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFa-00036a-0r
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFZ-0002mh-7t
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:51 -0400
Message-Id: <20181019010625.25294-23-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 22/56] cpu-exec: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 870027d435..f37c9b1e94 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -422,14 +422,20 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     return tb;
 }
 
-static inline bool cpu_handle_halt(CPUState *cpu)
+static inline bool cpu_handle_halt_locked(CPUState *cpu)
 {
-    if (cpu->halted) {
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu_halted(cpu)) {
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
         if ((cpu->interrupt_request & CPU_INTERRUPT_POLL)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
+
+            cpu_mutex_unlock(cpu);
             qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
+
             apic_poll_irq(x86_cpu->apic_state);
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
             qemu_mutex_unlock_iothread();
@@ -439,12 +445,22 @@ static inline bool cpu_handle_halt(CPUState *cpu)
             return true;
         }
 
-        cpu->halted = 0;
+        cpu_halted_set(cpu, 0);
     }
 
     return false;
 }
 
+static inline bool cpu_handle_halt(CPUState *cpu)
+{
+    bool ret;
+
+    cpu_mutex_lock(cpu);
+    ret = cpu_handle_halt_locked(cpu);
+    cpu_mutex_unlock(cpu);
+    return ret;
+}
+
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -543,7 +559,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
             replay_interrupt();
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
-            cpu->halted = 1;
+            cpu_halted_set(cpu, 1);
             cpu->exception_index = EXCP_HLT;
             qemu_mutex_unlock_iothread();
             return true;
-- 
2.17.1
