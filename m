Received: from eggs.gnu.org ([209.51.188.92]:44576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAm-0008S0-0K
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAk-0001I3-Bl
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:43 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAj-00010o-T5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:31 -0500
Message-Id: <20190304181813.8075-32-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 31/73] cpu: convert to cpu_halted
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

This finishes the conversion to cpu_halted.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 cpus.c               | 8 ++++----
 qom/cpu.c            | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 78dca325ba..8af0b5de07 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -435,7 +435,7 @@ static inline bool cpu_handle_halt_locked(CPUState *cpu)
             && replay_interrupt()) {
             X86CPU *x86_cpu = X86_CPU(cpu);
 
-            /* prevent deadlock; cpu_mutex must be acquired _after_ the BQL */
+            /* locking order: cpu_mutex must be acquired _after_ the BQL */
             cpu_mutex_unlock(cpu);
             qemu_mutex_lock_iothread();
             cpu_mutex_lock(cpu);
diff --git a/cpus.c b/cpus.c
index 4b967e4674..c6806184ee 100644
--- a/cpus.c
+++ b/cpus.c
@@ -204,7 +204,7 @@ static bool cpu_thread_is_idle(CPUState *cpu)
     if (cpu_is_stopped(cpu)) {
         return true;
     }
-    if (!cpu->halted || cpu_has_work(cpu) ||
+    if (!cpu_halted(cpu) || cpu_has_work(cpu) ||
         kvm_halt_in_kernel()) {
         return false;
     }
@@ -1687,7 +1687,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
@@ -1846,7 +1846,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  *
                  * cpu->halted should ensure we sleep in wait_io_event
                  */
-                g_assert(cpu->halted);
+                g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
@@ -2343,7 +2343,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         info->value = g_malloc0(sizeof(*info->value));
         info->value->CPU = cpu->cpu_index;
         info->value->current = (cpu == first_cpu);
-        info->value->halted = cpu->halted;
+        info->value->halted = cpu_halted(cpu);
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
 #if defined(TARGET_I386)
diff --git a/qom/cpu.c b/qom/cpu.c
index 2c05aa1bca..c5106d5af8 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -261,7 +261,7 @@ static void cpu_common_reset(CPUState *cpu)
     }
 
     cpu->interrupt_request = 0;
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->mem_io_vaddr = 0;
     cpu->icount_extra = 0;
-- 
2.17.1
