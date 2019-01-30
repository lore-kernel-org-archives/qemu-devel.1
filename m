Received: from eggs.gnu.org ([209.51.188.92]:35025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe35-0007sp-NY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe34-0000dA-FZ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe34-0000cq-8r
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:01 -0500
Message-Id: <20190130004811.27372-4-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 03/73] cpu: introduce cpu_mutex_lock/unlock
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

The few direct users of &cpu->lock will be converted soon.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h   | 33 +++++++++++++++++++++++++++++++
 cpus.c              | 48 +++++++++++++++++++++++++++++++++++++++++++--
 stubs/cpu-lock.c    | 28 ++++++++++++++++++++++++++
 stubs/Makefile.objs |  1 +
 4 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 stubs/cpu-lock.c

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 6224b83ada..403c48695b 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -454,6 +454,39 @@ extern CPUTailQ cpus;
 
 extern __thread CPUState *current_cpu;
 
+/**
+ * cpu_mutex_lock - lock a CPU's mutex
+ * @cpu: the CPU whose mutex is to be locked
+ *
+ * To avoid deadlock, a CPU's mutex must be acquired after the BQL.
+ */
+#define cpu_mutex_lock(cpu)                             \
+    cpu_mutex_lock_impl(cpu, __FILE__, __LINE__)
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line);
+
+/**
+ * cpu_mutex_unlock - unlock a CPU's mutex
+ * @cpu: the CPU whose mutex is to be unlocked
+ */
+#define cpu_mutex_unlock(cpu)                           \
+    cpu_mutex_unlock_impl(cpu, __FILE__, __LINE__)
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line);
+
+/**
+ * cpu_mutex_locked - check whether a CPU's mutex is locked
+ * @cpu: the CPU of interest
+ *
+ * Returns true if the calling thread is currently holding the CPU's mutex.
+ */
+bool cpu_mutex_locked(const CPUState *cpu);
+
+/**
+ * no_cpu_mutex_locked - check whether any CPU mutex is held
+ *
+ * Returns true if the calling thread is not holding any CPU mutex.
+ */
+bool no_cpu_mutex_locked(void);
+
 static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
 {
     unsigned int i;
diff --git a/cpus.c b/cpus.c
index 9a3a1d8a6a..187aed2533 100644
--- a/cpus.c
+++ b/cpus.c
@@ -83,6 +83,47 @@ static unsigned int throttle_percentage;
 #define CPU_THROTTLE_PCT_MAX 99
 #define CPU_THROTTLE_TIMESLICE_NS 10000000
 
+/* XXX: is this really the max number of CPUs? */
+#define CPU_LOCK_BITMAP_SIZE 2048
+
+/*
+ * Note: we index the bitmap with cpu->cpu_index + 1 so that the logic
+ * also works during early CPU initialization, when cpu->cpu_index is set to
+ * UNASSIGNED_CPU_INDEX == -1.
+ */
+static __thread DECLARE_BITMAP(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
+
+bool no_cpu_mutex_locked(void)
+{
+    return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
+}
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
+/* coverity gets confused by the indirect function call */
+#ifdef __COVERITY__
+    qemu_mutex_lock_impl(&cpu->lock, file, line);
+#else
+    QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
+
+    g_assert(!cpu_mutex_locked(cpu));
+    set_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+    f(&cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
+{
+    g_assert(cpu_mutex_locked(cpu));
+    qemu_mutex_unlock_impl(&cpu->lock, file, line);
+    clear_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+}
+
+bool cpu_mutex_locked(const CPUState *cpu)
+{
+    return test_bit(cpu->cpu_index + 1, cpu_lock_bitmap);
+}
+
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -92,9 +133,9 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
-    qemu_mutex_lock(&cpu->lock);
+    cpu_mutex_lock(cpu);
     ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    qemu_mutex_unlock(&cpu->lock);
+    cpu_mutex_unlock(cpu);
     return ret;
 }
 
@@ -1855,6 +1896,9 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line)
 {
     QemuMutexLockFunc bql_lock = atomic_read(&qemu_bql_mutex_lock_func);
 
+    /* prevent deadlock with CPU mutex */
+    g_assert(no_cpu_mutex_locked());
+
     g_assert(!qemu_mutex_iothread_locked());
     bql_lock(&qemu_global_mutex, file, line);
     iothread_locked = true;
diff --git a/stubs/cpu-lock.c b/stubs/cpu-lock.c
new file mode 100644
index 0000000000..3f07d3a28b
--- /dev/null
+++ b/stubs/cpu-lock.c
@@ -0,0 +1,28 @@
+#include "qemu/osdep.h"
+#include "qom/cpu.h"
+
+void cpu_mutex_lock_impl(CPUState *cpu, const char *file, int line)
+{
+/* coverity gets confused by the indirect function call */
+#ifdef __COVERITY__
+    qemu_mutex_lock_impl(&cpu->lock, file, line);
+#else
+    QemuMutexLockFunc f = atomic_read(&qemu_mutex_lock_func);
+    f(&cpu->lock, file, line);
+#endif
+}
+
+void cpu_mutex_unlock_impl(CPUState *cpu, const char *file, int line)
+{
+    qemu_mutex_unlock_impl(&cpu->lock, file, line);
+}
+
+bool cpu_mutex_locked(const CPUState *cpu)
+{
+    return true;
+}
+
+bool no_cpu_mutex_locked(void)
+{
+    return true;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aeeec6..49f83cf7ff 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -8,6 +8,7 @@ stub-obj-y += blockdev-close-all-bdrv-states.o
 stub-obj-y += clock-warp.o
 stub-obj-y += cpu-get-clock.o
 stub-obj-y += cpu-get-icount.o
+stub-obj-y += cpu-lock.o
 stub-obj-y += dump.o
 stub-obj-y += error-printf.o
 stub-obj-y += fdset.o
-- 
2.17.1
