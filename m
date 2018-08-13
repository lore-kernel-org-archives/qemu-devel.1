Received: from eggs.gnu.org ([2001:4830:134:3::10]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpFs7-0004kQ-Vf
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpFs2-00011f-W6
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:39:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 12:38:59 -0400
Message-Id: <20180813163859.17964-4-cota@braap.org>
In-Reply-To: <20180813163859.17964-1-cota@braap.org>
References: <20180813163859.17964-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/3] qom: implement CPU list with an RCU QLIST
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

Fix it by implementing the CPU list as an RCU QLIST. This requires
a little bit of extra work to insert CPUs at the tail of
the list and to iterate over the list in reverse order (see previous patch).

One might be tempted to just insert new CPUs at the head of the list.
However, I think this might lead to hard-to-debug issues, since it is
possible that callers are assuming that CPUs are inserted at the tail
(just like spapr code did in the previous patch). So instead of auditing
all callers, this patch simply keeps the old behaviour.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus-common.c        | 19 +++++++++++++++----
 cpus.c               |  2 +-
 exec.c               |  2 +-
 include/qom/cpu.h    | 15 +++++++--------
 linux-user/main.c    |  2 +-
 linux-user/syscall.c |  2 +-
 6 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 6eaedae60b..d8e8db48dd 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -77,6 +77,8 @@ static void finish_safe_work(CPUState *cpu)
 
 void cpu_list_add(CPUState *cpu)
 {
+    CPUState *cs, *cs_next;
+
     qemu_mutex_lock(&qemu_cpu_list_lock);
     if (cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
         cpu->cpu_index = cpu_get_free_index();
@@ -84,7 +86,18 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
-    QTAILQ_INSERT_TAIL(&cpus, cpu, node);
+    /* poor man's tail insert */
+    CPU_FOREACH_SAFE(cs, cs_next) {
+        if (cs_next == NULL) {
+            break;
+        }
+    }
+    if (cs == NULL) {
+        QLIST_INSERT_HEAD_RCU(&cpus, cpu, node);
+    } else {
+        g_assert(cs_next == NULL);
+        QLIST_INSERT_AFTER_RCU(cs, cpu, node);
+    }
     cpu->in_cpu_list = true;
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 
@@ -100,9 +113,7 @@ void cpu_list_remove(CPUState *cpu)
         return;
     }
 
-    assert(!(cpu_index_auto_assigned && cpu != QTAILQ_LAST(&cpus, CPUTailQ)));
-
-    QTAILQ_REMOVE(&cpus, cpu, node);
+    QLIST_REMOVE_RCU(cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
diff --git a/cpus.c b/cpus.c
index b5844b7103..82e298d825 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1491,7 +1491,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        qemu_tcg_rr_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
+        qemu_tcg_rr_wait_io_event(cpu ? cpu : QLIST_FIRST_RCU(&cpus));
         deal_with_unplugged_cpus();
     }
 
diff --git a/exec.c b/exec.c
index 4f5df07b6a..cab0da6919 100644
--- a/exec.c
+++ b/exec.c
@@ -114,7 +114,7 @@ int target_page_bits;
 bool target_page_bits_decided;
 #endif
 
-struct CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+struct CPUTailQ cpus = QLIST_HEAD_INITIALIZER(cpus);
 /* current CPU in the current thread. It is only valid inside
    cpu_exec() */
 __thread CPUState *current_cpu;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index aa555e27a7..407c57254d 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 
@@ -371,7 +372,7 @@ struct CPUState {
     struct GDBRegisterState *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
-    QTAILQ_ENTRY(CPUState) node;
+    QLIST_ENTRY(CPUState) node;
 
     /* ice debug support */
     QTAILQ_HEAD(breakpoints_head, CPUBreakpoint) breakpoints;
@@ -436,15 +437,13 @@ struct CPUState {
     GArray *iommu_notifiers;
 };
 
-QTAILQ_HEAD(CPUTailQ, CPUState);
+QLIST_HEAD(CPUTailQ, CPUState);
 extern struct CPUTailQ cpus;
-#define CPU_NEXT(cpu) QTAILQ_NEXT(cpu, node)
-#define CPU_FOREACH(cpu) QTAILQ_FOREACH(cpu, &cpus, node)
+#define CPU_NEXT(cpu) QLIST_NEXT_RCU(cpu, node)
+#define CPU_FOREACH(cpu) QLIST_FOREACH_RCU(cpu, &cpus, node)
 #define CPU_FOREACH_SAFE(cpu, next_cpu) \
-    QTAILQ_FOREACH_SAFE(cpu, &cpus, node, next_cpu)
-#define CPU_FOREACH_REVERSE(cpu) \
-    QTAILQ_FOREACH_REVERSE(cpu, &cpus, CPUTailQ, node)
-#define first_cpu QTAILQ_FIRST(&cpus)
+    QLIST_FOREACH_SAFE_RCU(cpu, &cpus, node, next_cpu)
+#define first_cpu QLIST_FIRST_RCU(&cpus)
 
 extern __thread CPUState *current_cpu;
 
diff --git a/linux-user/main.c b/linux-user/main.c
index ea00dd9057..99afb14ae5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -126,7 +126,7 @@ void fork_end(int child)
            Discard information about the parent threads.  */
         CPU_FOREACH_SAFE(cpu, next_cpu) {
             if (cpu != thread_cpu) {
-                QTAILQ_REMOVE(&cpus, cpu, node);
+                QLIST_REMOVE_RCU(cpu, node);
             }
         }
         qemu_init_cpu_list();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfc851cc35..41b592dee3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8040,7 +8040,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             TaskState *ts;
 
             /* Remove the CPU from the list.  */
-            QTAILQ_REMOVE(&cpus, cpu, node);
+            QLIST_REMOVE_RCU(cpu, node);
 
             cpu_list_unlock();
 
-- 
2.17.1
