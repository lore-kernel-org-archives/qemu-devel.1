Received: from eggs.gnu.org ([209.51.188.92]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAp-00005J-Qf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAl-0001Kq-VJ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAj-00010G-Vk
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:30 -0500
Message-Id: <20190304181813.8075-31-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 30/73] cpu-exec: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 45ef41ebb2..78dca325ba 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -425,14 +425,21 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
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
+            /* prevent deadlock; cpu_mutex must be acquired _after_ the BQL */
+            cpu_mutex_unlock(cpu);
             qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
+
             apic_poll_irq(x86_cpu->apic_state);
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
             qemu_mutex_unlock_iothread();
@@ -442,12 +449,22 @@ static inline bool cpu_handle_halt(CPUState *cpu)
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
@@ -546,7 +563,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
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
