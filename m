Received: from eggs.gnu.org ([2001:4830:134:3::10]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002N7-8E
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmP-0000dL-Gq
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:35 -0400
Message-Id: <20180819091335.22863-12-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 11/11] qom: convert the CPU list to RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

Iterating over the list without using atomics is undefined behaviour,
since the list can be modified concurrently by other threads (e.g.
every time a new thread is created in user-mode).

Fix it by implementing the CPU list as an RCU QTAILQ. This requires
a little bit of extra work to traverse list in reverse order (see
previous patch), but other than that the conversion is trivial.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h         | 11 +++++------
 cpus-common.c             |  4 ++--
 cpus.c                    |  2 +-
 linux-user/main.c         |  2 +-
 linux-user/syscall.c      |  2 +-
 target/s390x/cpu_models.c |  2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ecf6ed556a..dc130cd307 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 
@@ -442,13 +443,11 @@ struct CPUState {
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
 extern struct CPUTailQ cpus;
-#define CPU_NEXT(cpu) QTAILQ_NEXT(cpu, node)
-#define CPU_FOREACH(cpu) QTAILQ_FOREACH(cpu, &cpus, node)
+#define first_cpu        QTAILQ_FIRST_RCU(&cpus)
+#define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
+#define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus, node)
 #define CPU_FOREACH_SAFE(cpu, next_cpu) \
-    QTAILQ_FOREACH_SAFE(cpu, &cpus, node, next_cpu)
-#define CPU_FOREACH_REVERSE(cpu) \
-    QTAILQ_FOREACH_REVERSE(cpu, &cpus, CPUTailQ, node)
-#define first_cpu QTAILQ_FIRST(&cpus)
+    QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus, node, next_cpu)
 
 extern __thread CPUState *current_cpu;
 
diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..98dd8c6ff1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -84,7 +84,7 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
-    QTAILQ_INSERT_TAIL(&cpus, cpu, node);
+    QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 
     finish_safe_work(cpu);
@@ -101,7 +101,7 @@ void cpu_list_remove(CPUState *cpu)
 
     assert(!(cpu_index_auto_assigned && cpu != QTAILQ_LAST(&cpus, CPUTailQ)));
 
-    QTAILQ_REMOVE(&cpus, cpu, node);
+    QTAILQ_REMOVE_RCU(&cpus, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
diff --git a/cpus.c b/cpus.c
index b5844b7103..d60f8603fd 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1491,7 +1491,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        qemu_tcg_rr_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
+        qemu_tcg_rr_wait_io_event(cpu ? cpu : first_cpu);
         deal_with_unplugged_cpus();
     }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index ea00dd9057..923cbb753a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -126,7 +126,7 @@ void fork_end(int child)
            Discard information about the parent threads.  */
         CPU_FOREACH_SAFE(cpu, next_cpu) {
             if (cpu != thread_cpu) {
-                QTAILQ_REMOVE(&cpus, cpu, node);
+                QTAILQ_REMOVE_RCU(&cpus, cpu, node);
             }
         }
         qemu_init_cpu_list();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bb42a225eb..95ac0102bf 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8051,7 +8051,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             TaskState *ts;
 
             /* Remove the CPU from the list.  */
-            QTAILQ_REMOVE(&cpus, cpu, node);
+            QTAILQ_REMOVE_RCU(&cpus, cpu, node);
 
             cpu_list_unlock();
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 604898a882..d1a45bd8c0 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1110,7 +1110,7 @@ void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
     const S390CPUDef *def = s390_find_cpu_def(type, gen, ec_ga, NULL);
 
     g_assert(def);
-    g_assert(QTAILQ_EMPTY(&cpus));
+    g_assert(QTAILQ_EMPTY_RCU(&cpus));
 
     /* TCG emulates some features that can usually not be enabled with
      * the emulated machine generation. Make sure they can be enabled
-- 
2.17.1
