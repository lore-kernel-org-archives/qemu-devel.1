Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGfkW-000275-Ed
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGfkR-0002aJ-GM
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:07:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:28978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dGfkR-0002Zc-6b
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:07:47 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri,  2 Jun 2017 14:06:44 +0800
Message-Id: <1496383606-18060-3-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
References: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/4] tcg: move tcg related files into
 accel/tcg/ subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, laurent.desnogues@gmail.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

move cputlb.c, cpu-exec-common.c and cpu-exec.c related tcg exec
file into accel/tcg/ subdirectory.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.objs                                    | 1 +
 Makefile.target                                  | 7 +++----
 accel/tcg/Makefile.objs                          | 2 ++
 cpu-exec-common.c => accel/tcg/cpu-exec-common.c | 0
 cpu-exec.c => accel/tcg/cpu-exec.c               | 2 +-
 cputlb.c => accel/tcg/cputlb.c                   | 0
 accel/tcg/trace-events                           | 7 +++++++
 trace-events                                     | 5 -----
 8 files changed, 14 insertions(+), 10 deletions(-)
 rename cpu-exec-common.c => accel/tcg/cpu-exec-common.c (100%)
 rename cpu-exec.c => accel/tcg/cpu-exec.c (99%)
 rename cputlb.c => accel/tcg/cputlb.c (100%)
 create mode 100644 accel/tcg/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 5fb6bef..b703d45 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -162,6 +162,7 @@ trace-events-subdirs += target/ppc
 trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
+trace-events-subdirs += accel/tcg
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/Makefile.target b/Makefile.target
index c3c08ff..18470dd 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,9 +88,9 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o cpu-exec.o
+obj-y = exec.o translate-all.o
+obj-y += accel/
 obj-y += translate-common.o
-obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
@@ -143,8 +143,7 @@ obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o bootdevice.o
 obj-y += hw/
 obj-$(CONFIG_KVM) += kvm-all.o
-obj-y += accel/
-obj-y += memory.o cputlb.o
+obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
 obj-y += migration/ram.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 6e3211a..940379b 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1 +1,3 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
+obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-y += cpu-exec.o cpu-exec-common.o
diff --git a/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
similarity index 100%
rename from cpu-exec-common.c
rename to accel/tcg/cpu-exec-common.c
diff --git a/cpu-exec.c b/accel/tcg/cpu-exec.c
similarity index 99%
rename from cpu-exec.c
rename to accel/tcg/cpu-exec.c
index 63a56d0..689837a 100644
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
diff --git a/cputlb.c b/accel/tcg/cputlb.c
similarity index 100%
rename from cputlb.c
rename to accel/tcg/cputlb.c
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
index 433865f..ffe5e66 100644
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
