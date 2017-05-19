Received: from eggs.gnu.org ([2001:4830:134:3::10]:52397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBR-00012A-4L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBP-0005iR-Lm
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:39329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBaBP-0005ha-D0
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:35 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 13:09:42 +0800
Message-Id: <1495170583-30905-4-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
References: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 3/4] move cpu-exec.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

move cpu-exec.c to ./accel/tcg/

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.objs                      | 1 +
 Makefile.target                    | 4 ++--
 accel/tcg/Makefile.objs            | 1 +
 cpu-exec.c => accel/tcg/cpu-exec.c | 5 +++--
 accel/tcg/trace-events             | 7 +++++++
 trace-events                       | 5 -----
 6 files changed, 14 insertions(+), 9 deletions(-)
 rename cpu-exec.c => accel/tcg/cpu-exec.c (99%)
 create mode 100644 accel/tcg/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 2a8de77..6a33874 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -163,6 +163,7 @@ trace-events-subdirs += target/ppc
 trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
+trace-events-subdirs += accel/tcg
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/Makefile.target b/Makefile.target
index 3e19fe9..709d07a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,7 +88,8 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o cpu-exec.o
+obj-y = exec.o translate-all.o
+obj-y += accel/
 obj-y += translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
@@ -143,7 +144,6 @@ obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o bootdevice.o
 obj-y += hw/
 obj-$(CONFIG_KVM) += kvm-all.o
-obj-y += accel/
 obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 487570f..6b75a31 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,2 +1,3 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-y += cpu-exec.o
diff --git a/cpu-exec.c b/accel/tcg/cpu-exec.c
similarity index 99%
rename from cpu-exec.c
rename to accel/tcg/cpu-exec.c
index 63a56d0..2019160 100644
--- a/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
@@ -200,8 +200,9 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 
     /* Should never happen.
        We only end up here when an existing TB is too long.  */
-    if (max_cycles > CF_COUNT_MASK)
+    if (max_cycles > CF_COUNT_MASK) {
         max_cycles = CF_COUNT_MASK;
+    }
 
     tb_lock();
     tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base, orig_tb->flags,
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
new file mode 100644
index 0000000..f2db388
--- /dev/null
+++ b/accel/tcg/trace-events
@@ -0,0 +1,7 @@
+# Trace events for debugging and performance instrumentation
+
+# TCG related tracing (mostly disabled by default)
+# cpu-exec.c
+disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
diff --git a/trace-events b/trace-events
index e582d63..153942d 100644
--- a/trace-events
+++ b/trace-events
@@ -73,11 +73,6 @@ kvm_irqchip_add_msi_route(int virq) "Adding MSI route virq=%d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 
 # TCG related tracing (mostly disabled by default)
-# cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
-
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
 
-- 
1.9.1
