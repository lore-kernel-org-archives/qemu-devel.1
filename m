Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPB-0008J2-KF
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPA-0007bR-Gl
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:37 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPA-0007bG-75
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:36 -0400
Received: by mail-wr0-x241.google.com with SMTP id z45so2763277wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:42 +0200
Message-Id: <1497523981-38449-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/41] tcg: move tcg backend files into
 accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

move tcg-runtime.c, translate-all.(ch) and translate-common.c into
accel/tcg/ subdirectory and updated related trace-events file.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <1496383606-18060-4-git-send-email-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target                                    | 6 ++----
 accel/tcg/Makefile.objs                            | 2 +-
 accel/tcg/trace-events                             | 3 +++
 translate-all.c => accel/tcg/translate-all.c       | 2 +-
 translate-all.h => accel/tcg/translate-all.h       | 0
 translate-common.c => accel/tcg/translate-common.c | 0
 configure                                          | 2 +-
 tcg-runtime.c => tcg/tcg-runtime.c                 | 0
 tci.c => tcg/tci.c                                 | 0
 trace-events                                       | 4 ----
 10 files changed, 8 insertions(+), 11 deletions(-)
 rename translate-all.c => accel/tcg/translate-all.c (99%)
 rename translate-all.h => accel/tcg/translate-all.h (100%)
 rename translate-common.c => accel/tcg/translate-common.c (100%)
 rename tcg-runtime.c => tcg/tcg-runtime.c (100%)
 rename tci.c => tcg/tci.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 18470dd..73cd9c6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,17 +88,15 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o
+obj-y = exec.o
 obj-y += accel/
-obj-y += translate-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
+obj-y += tcg/tcg-common.o tcg/tcg-runtime.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
-obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 940379b..f173cd5 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
-obj-y += cpu-exec.o cpu-exec-common.o
+obj-y += cpu-exec.o cpu-exec-common.o translate-all.o translate-common.o
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
index b147191..48d5ceb 100755
--- a/configure
+++ b/configure
@@ -407,7 +407,7 @@ QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-QEMU_INCLUDES="-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/include"
+QEMU_INCLUDES="-I. -I\$(SRC_PATH) -I\$(SRC_PATH)/accel/tcg -I\$(SRC_PATH)/include"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
     LDFLAGS="-g $LDFLAGS"
diff --git a/tcg-runtime.c b/tcg/tcg-runtime.c
similarity index 100%
rename from tcg-runtime.c
rename to tcg/tcg-runtime.c
diff --git a/tci.c b/tcg/tci.c
similarity index 100%
rename from tci.c
rename to tcg/tci.c
diff --git a/trace-events b/trace-events
index 279aede..62d8100 100644
--- a/trace-events
+++ b/trace-events
@@ -68,10 +68,6 @@ kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d vi
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
 
-# TCG related tracing (mostly disabled by default)
-# translate-all.c
-translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-- 
1.8.3.1
