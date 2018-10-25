Received: from eggs.gnu.org ([2001:4830:134:3::10]:59897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5L-0003jm-0V
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgvK-0008IY-FX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgvK-00088u-4F
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:32 -0400
Message-Id: <20181025144644.15464-59-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 59/71] cpu: introduce
 cpu_has_work_with_iothread_lock
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

It will gain some users soon.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 9826cdfa4c..b5c3b2c734 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
@@ -86,6 +87,8 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do. Called with the
  * CPU lock held.
+ * @has_work_with_iothread_lock: Callback for checking if there is work to do.
+ * Called with both the BQL and the CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unassigned_access: Callback for unassigned access handling.
  * (this is deprecated: new targets should use do_transaction_failed instead)
@@ -157,6 +160,7 @@ typedef struct CPUClass {
     void (*reset)(CPUState *cpu);
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
+    bool (*has_work_with_iothread_lock)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
     CPUUnassignedAccess do_unassigned_access;
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
@@ -794,14 +798,40 @@ const char *parse_cpu_model(const char *cpu_model);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
+    bool (*func)(CPUState *cpu);
     bool ret;
 
+    if (cc->has_work_with_iothread_lock) {
+        if (qemu_mutex_iothread_locked()) {
+            func = cc->has_work_with_iothread_lock;
+            goto call_func;
+        }
+
+        if (has_cpu_lock) {
+            /* avoid deadlock by acquiring the locks in order */
+            cpu_mutex_unlock(cpu);
+        }
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
+
+        ret = cc->has_work_with_iothread_lock(cpu);
+
+        qemu_mutex_unlock_iothread();
+        if (!has_cpu_lock) {
+            cpu_mutex_unlock(cpu);
+        }
+        return ret;
+    }
+
     g_assert(cc->has_work);
-    if (cpu_mutex_locked(cpu)) {
-        return cc->has_work(cpu);
+    func = cc->has_work;
+ call_func:
+    if (has_cpu_lock) {
+        return func(cpu);
     }
     cpu_mutex_lock(cpu);
-    ret = cc->has_work(cpu);
+    ret = func(cpu);
     cpu_mutex_unlock(cpu);
     return ret;
 }
-- 
2.17.1
