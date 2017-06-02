Received: from eggs.gnu.org ([2001:4830:134:3::10]:54989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGfkV-000274-PV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dGfkS-0002b1-UX
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:07:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:18449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dGfkS-0002aP-Jf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 02:07:48 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri,  2 Jun 2017 14:06:45 +0800
Message-Id: <1496383606-18060-4-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
References: <1496383606-18060-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/4] tcg: move tcg backend files into
 accel/tcg/
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

move tcg-runtime.c, translate-all.(ch) and translate-common.c into
accel/tcg/ subdirectory and updated related trace-events file.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target                                    | 5 +----
 accel/tcg/Makefile.objs                            | 3 ++-
 tcg-runtime.c => accel/tcg/tcg-runtime.c           | 0
 tci.c => accel/tcg/tci.c                           | 0
 accel/tcg/trace-events                             | 3 +++
 translate-all.c => accel/tcg/translate-all.c       | 2 +-
 translate-all.h => accel/tcg/translate-all.h       | 0
 translate-common.c => accel/tcg/translate-common.c | 0
 configure                                          | 2 +-
 trace-events                                       | 4 ----
 10 files changed, 8 insertions(+), 11 deletions(-)
 rename tcg-runtime.c => accel/tcg/tcg-runtime.c (100%)
 rename tci.c => accel/tcg/tci.c (100%)
 rename translate-all.c => accel/tcg/translate-all.c (99%)
 rename translate-all.h => accel/tcg/translate-all.h (100%)
 rename translate-common.c => accel/tcg/translate-common.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 18470dd..8a270c3 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,17 +88,14 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o
+obj-y = exec.o
 obj-y += accel/
-obj-y += translate-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 940379b..a9a68ea 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
-obj-y += cpu-exec.o cpu-exec-common.o
+obj-y += cpu-exec.o cpu-exec-common.o tcg-runtime.o translate-all.o translate-common.o
+obj-$(CONFIG_TCG_INTERPRETER) += tci.o
diff --git a/tcg-runtime.c b/accel/tcg/tcg-runtime.c
similarity index 100%
rename from tcg-runtime.c
rename to accel/tcg/tcg-runtime.c
diff --git a/tci.c b/accel/tcg/tci.c
similarity index 100%
rename from tci.c
rename to accel/tcg/tci.c
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index f2db388..2de8359 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -5,3 +5,6 @@
 disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
+
+# translate-all.c
+translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
diff --git a/translate-all.c b/accel/tcg/translate-all.c
similarity index 99%
rename from translate-all.c
rename to accel/tcg/translate-all.c
index b3ee876..7b25a16 100644
--- a/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/translate-all.h b/accel/tcg/translate-all.h
similarity index 100%
rename from translate-all.h
rename to accel/tcg/translate-all.h
diff --git a/translate-common.c b/accel/tcg/translate-common.c
similarity index 100%
rename from translate-common.c
rename to accel/tcg/translate-common.c
diff --git a/configure b/configure
index 1a5ee4b..7fcd291 100755
--- a/configure
+++ b/configure
@@ -402,7 +402,7 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/include"
+QEMU_INCLUDES="-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/accel/tcg -I\$(SRC_PATH)/include"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
     LDFLAGS="-g $LDFLAGS"
diff --git a/trace-events b/trace-events
index ffe5e66..7cf8c76 100644
--- a/trace-events
+++ b/trace-events
@@ -72,10 +72,6 @@ kvm_irqchip_commit_routes(void) ""
 kvm_irqchip_add_msi_route(int virq) "Adding MSI route virq=%d"
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 
-# TCG related tracing (mostly disabled by default)
-# translate-all.c
-translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-- 
1.9.1
