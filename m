Received: from eggs.gnu.org ([2001:4830:134:3::10]:47403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNQ-0007JT-N2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBcNO-000386-8c
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:61751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBcNN-00037L-WE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:31:06 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 15:30:22 +0800
Message-Id: <1495179026-27872-3-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
References: <1495179026-27872-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 2/6] move tcg relative files into tcg
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

move translate-all.c file into tcg directory and update
trace-events file

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.objs                          | 1 +
 Makefile.target                        | 3 ++-
 tcg/trace-events                       | 6 ++++++
 translate-all.c => tcg/translate-all.c | 2 +-
 trace-events                           | 3 ---
 5 files changed, 10 insertions(+), 5 deletions(-)
 create mode 100644 tcg/trace-events
 rename translate-all.c => tcg/translate-all.c (99%)

diff --git a/Makefile.objs b/Makefile.objs
index 2100845..1de6462 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -163,6 +163,7 @@ trace-events-subdirs += target/ppc
 trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
+trace-events-subdirs += tcg
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/Makefile.target b/Makefile.target
index c388fd6..c96ebd2 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,7 +88,8 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o cpu-exec.o
+obj-y = exec.o cpu-exec.o
+obj-y += tcg/translate-all.o
 obj-y += translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
diff --git a/tcg/trace-events b/tcg/trace-events
new file mode 100644
index 0000000..989a06e
--- /dev/null
+++ b/tcg/trace-events
@@ -0,0 +1,6 @@
+# Trace events for debugging and performance instrumentation
+#
+# TCG related tracing (mostly disabled by default)
+# translate-all.c
+translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
+
diff --git a/translate-all.c b/tcg/translate-all.c
similarity index 99%
rename from translate-all.c
rename to tcg/translate-all.c
index b3ee876..7b25a16 100644
--- a/translate-all.c
+++ b/tcg/translate-all.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/trace-events b/trace-events
index e582d63..d89380e 100644
--- a/trace-events
+++ b/trace-events
@@ -78,9 +78,6 @@ disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
 
-# translate-all.c
-translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-- 
1.9.1
