Received: from eggs.gnu.org ([2001:4830:134:3::10]:58193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBJRg-0004yT-7G
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBJRe-0001yu-Ov
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:18:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:4954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBJRe-0001OQ-Bj
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:18:14 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 03:14:55 +0800
Message-Id: <1495134895-7814-4-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
References: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 4/4] move cpu-exec-common.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, Yang Zhong <yang.zhong@intel.com>

move cpu-exec-common.c to accel/tcg

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target             |  1 -
 accel/tcg/Makefile.objs     |  2 +-
 accel/tcg/cpu-exec-common.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 cpu-exec-common.c           | 82 ---------------------------------------------
 4 files changed, 83 insertions(+), 84 deletions(-)
 create mode 100644 accel/tcg/cpu-exec-common.c
 delete mode 100644 cpu-exec-common.c

diff --git a/Makefile.target b/Makefile.target
index 709d07a..b083a76 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -91,7 +91,6 @@ all: $(PROGS) stap
 obj-y = exec.o translate-all.o
 obj-y += accel/
 obj-y += translate-common.o
-obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 6b75a31..940379b 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
-obj-y += cpu-exec.o
+obj-y += cpu-exec.o cpu-exec-common.o
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
new file mode 100644
index 0000000..e81da27
--- /dev/null
+++ b/accel/tcg/cpu-exec-common.c
@@ -0,0 +1,82 @@
+/*
+ *  emulator main execution loop
+ *
+ *  Copyright (c) 2003-2005 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "sysemu/cpus.h"
+#include "exec/exec-all.h"
+#include "exec/memory-internal.h"
+
+/* exit the current TB, but without causing any exception to be raised */
+void cpu_loop_exit_noexc(CPUState *cpu)
+{
+    /* XXX: restore cpu registers saved in host registers */
+
+    cpu->exception_index = -1;
+    siglongjmp(cpu->jmp_env, 1);
+}
+
+#if defined(CONFIG_SOFTMMU)
+void cpu_reloading_memory_map(void)
+{
+    if (qemu_in_vcpu_thread() && current_cpu->running) {
+        /* The guest can in theory prolong the RCU critical section as long
+         * as it feels like. The major problem with this is that because it
+         * can do multiple reconfigurations of the memory map within the
+         * critical section, we could potentially accumulate an unbounded
+         * collection of memory data structures awaiting reclamation.
+         *
+         * Because the only thing we're currently protecting with RCU is the
+         * memory data structures, it's sufficient to break the critical section
+         * in this callback, which we know will get called every time the
+         * memory map is rearranged.
+         *
+         * (If we add anything else in the system that uses RCU to protect
+         * its data structures, we will need to implement some other mechanism
+         * to force TCG CPUs to exit the critical section, at which point this
+         * part of this callback might become unnecessary.)
+         *
+         * This pair matches cpu_exec's rcu_read_lock()/rcu_read_unlock(), which
+         * only protects cpu->as->dispatch. Since we know our caller is about
+         * to reload it, it's safe to split the critical section.
+         */
+        rcu_read_unlock();
+        rcu_read_lock();
+    }
+}
+#endif
+
+void cpu_loop_exit(CPUState *cpu)
+{
+    siglongjmp(cpu->jmp_env, 1);
+}
+
+void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
+{
+    if (pc) {
+        cpu_restore_state(cpu, pc);
+    }
+    siglongjmp(cpu->jmp_env, 1);
+}
+
+void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
+{
+    cpu->exception_index = EXCP_ATOMIC;
+    cpu_loop_exit_restore(cpu, pc);
+}
diff --git a/cpu-exec-common.c b/cpu-exec-common.c
deleted file mode 100644
index e81da27..0000000
--- a/cpu-exec-common.c
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- *  emulator main execution loop
- *
- *  Copyright (c) 2003-2005 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "sysemu/cpus.h"
-#include "exec/exec-all.h"
-#include "exec/memory-internal.h"
-
-/* exit the current TB, but without causing any exception to be raised */
-void cpu_loop_exit_noexc(CPUState *cpu)
-{
-    /* XXX: restore cpu registers saved in host registers */
-
-    cpu->exception_index = -1;
-    siglongjmp(cpu->jmp_env, 1);
-}
-
-#if defined(CONFIG_SOFTMMU)
-void cpu_reloading_memory_map(void)
-{
-    if (qemu_in_vcpu_thread() && current_cpu->running) {
-        /* The guest can in theory prolong the RCU critical section as long
-         * as it feels like. The major problem with this is that because it
-         * can do multiple reconfigurations of the memory map within the
-         * critical section, we could potentially accumulate an unbounded
-         * collection of memory data structures awaiting reclamation.
-         *
-         * Because the only thing we're currently protecting with RCU is the
-         * memory data structures, it's sufficient to break the critical section
-         * in this callback, which we know will get called every time the
-         * memory map is rearranged.
-         *
-         * (If we add anything else in the system that uses RCU to protect
-         * its data structures, we will need to implement some other mechanism
-         * to force TCG CPUs to exit the critical section, at which point this
-         * part of this callback might become unnecessary.)
-         *
-         * This pair matches cpu_exec's rcu_read_lock()/rcu_read_unlock(), which
-         * only protects cpu->as->dispatch. Since we know our caller is about
-         * to reload it, it's safe to split the critical section.
-         */
-        rcu_read_unlock();
-        rcu_read_lock();
-    }
-}
-#endif
-
-void cpu_loop_exit(CPUState *cpu)
-{
-    siglongjmp(cpu->jmp_env, 1);
-}
-
-void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
-{
-    if (pc) {
-        cpu_restore_state(cpu, pc);
-    }
-    siglongjmp(cpu->jmp_env, 1);
-}
-
-void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
-{
-    cpu->exception_index = EXCP_ATOMIC;
-    cpu_loop_exit_restore(cpu, pc);
-}
-- 
1.9.1
