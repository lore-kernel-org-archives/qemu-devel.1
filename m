Received: from eggs.gnu.org ([209.51.188.92]:35930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe44-0000Lo-6V
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe42-0001Xo-N5
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:16 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe42-0001E4-Hr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:14 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:48:00 -0500
Message-Id: <20190130004811.27372-63-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 62/73] cpu: introduce
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

It will gain some users soon.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 96a5d0cb94..27a80bc113 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -27,6 +27,7 @@
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/fprintf-fn.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
@@ -87,6 +88,8 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do. Called with the
  * CPU lock held.
+ * @has_work_with_iothread_lock: Callback for checking if there is work to do.
+ * Called with both the BQL and the CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unassigned_access: Callback for unassigned access handling.
  * (this is deprecated: new targets should use do_transaction_failed instead)
@@ -158,6 +161,7 @@ typedef struct CPUClass {
     void (*reset)(CPUState *cpu);
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
+    bool (*has_work_with_iothread_lock)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
     CPUUnassignedAccess do_unassigned_access;
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
@@ -796,14 +800,40 @@ const char *parse_cpu_model(const char *cpu_model);
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
