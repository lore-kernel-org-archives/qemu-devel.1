Received: from eggs.gnu.org ([2001:4830:134:3::10]:59966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5Q-0003lE-6L
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgv6-00087C-Lv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgv6-0007vB-EW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:03 -0400
Message-Id: <20181025144644.15464-30-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 30/71] cpu: define cpu_interrupt_request
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Add a comment about how atomic_read works here. The comment refers to
a "BQL-less CPU loop", which will materialize toward the end
of this series.

Note that the modifications to cpu_reset_interrupt are there to
avoid deadlock during the CPU lock transition; once that is complete,
cpu_interrupt_request will be simple again.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 37 +++++++++++++++++++++++++++++++++++++
 qom/cpu.c         | 27 +++++++++++++++++++++------
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index aeed63a705..a86690c7a5 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -511,6 +511,43 @@ static inline void cpu_halted_set(CPUState *cpu, uint32_t val)
     cpu_mutex_unlock(cpu);
 }
 
+/*
+ * When sending an interrupt, setters OR the appropriate bit and kick the
+ * destination vCPU. The latter can then read interrupt_request without
+ * acquiring the CPU lock, because once the kick-induced completes, they'll read
+ * an up-to-date interrupt_request.
+ * Setters always acquire the lock, which guarantees that (1) concurrent
+ * updates from different threads won't result in data races, and (2) the
+ * BQL-less CPU loop will always see an up-to-date interrupt_request, since the
+ * loop holds the CPU lock.
+ */
+static inline uint32_t cpu_interrupt_request(CPUState *cpu)
+{
+    return atomic_read(&cpu->interrupt_request);
+}
+
+static inline void cpu_interrupt_request_or(CPUState *cpu, uint32_t mask)
+{
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request | mask);
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, cpu->interrupt_request | mask);
+    cpu_mutex_unlock(cpu);
+}
+
+static inline void cpu_interrupt_request_set(CPUState *cpu, uint32_t val)
+{
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, val);
+        return;
+    }
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, val);
+    cpu_mutex_unlock(cpu);
+}
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
diff --git a/qom/cpu.c b/qom/cpu.c
index bb031a3a6a..ecdf8e7aac 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -98,14 +98,29 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
  * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !qemu_mutex_iothread_locked();
+    bool has_bql = qemu_mutex_iothread_locked();
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
 
-    if (need_lock) {
-        qemu_mutex_lock_iothread();
+    if (has_bql) {
+        if (has_cpu_lock) {
+            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+        } else {
+            cpu_mutex_lock(cpu);
+            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+            cpu_mutex_unlock(cpu);
+        }
+        return;
+    }
+
+    if (has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
     }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        qemu_mutex_unlock_iothread();
+    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
+    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+    qemu_mutex_unlock_iothread();
+    if (!has_cpu_lock) {
+        cpu_mutex_unlock(cpu);
     }
 }
 
-- 
2.17.1
