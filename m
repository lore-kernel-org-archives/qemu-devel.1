Received: from eggs.gnu.org ([209.51.188.92]:35645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3w-00005W-MP
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3s-0001G8-PO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:06 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3s-0000yS-I8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:04 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:29 -0500
Message-Id: <20190130004811.27372-32-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 31/73] cpu: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This finishes the conversion to cpu_halted.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c    | 8 ++++----
 qom/cpu.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cpus.c b/cpus.c
index c4fa3cc876..aee129c0b3 100644
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
@@ -1686,7 +1686,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
@@ -1845,7 +1845,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                  *
                  * cpu->halted should ensure we sleep in wait_io_event
                  */
-                g_assert(cpu->halted);
+                g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
@@ -2342,7 +2342,7 @@ CpuInfoList *qmp_query_cpus(Error **errp)
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
