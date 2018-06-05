Received: from eggs.gnu.org ([2001:4830:134:3::10]:45653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NG-0005cA-CQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NF-0006Gz-EU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55928)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NF-0006Gc-5u
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:33 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:32 +0300
Message-ID: <152819517217.30857.1806942753626059939.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 3/7] plugins: provide helper functions
 for plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch adds interface functions that may be called from the loaded plugins.
Such functions are needed to inspect the VM state and to pass data
to the QEMU (e.g., QEMU-side logging).

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 Makefile.target           |    2 +-
 plugins/include/plugins.h |    6 ++++++
 plugins/qemulib.c         |   31 +++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 plugins/qemulib.c

diff --git a/Makefile.target b/Makefile.target
index 4cffd96..5648c9c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -93,7 +93,7 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y += exec.o
 obj-y += accel/
-obj-$(CONFIG_PLUGINS) += plugins/plugins.o
+obj-$(CONFIG_PLUGINS) += plugins/plugins.o plugins/qemulib.o
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
diff --git a/plugins/include/plugins.h b/plugins/include/plugins.h
index 100a786..fa624ea 100644
--- a/plugins/include/plugins.h
+++ b/plugins/include/plugins.h
@@ -9,4 +9,10 @@ bool plugin_init(const char *args);
 bool plugin_needs_before_insn(uint64_t pc, void *cpu);
 void plugin_before_insn(uint64_t pc, void *cpu);
 
+/* QEMU interface */
+
+void qemulib_log(const char *fmt, ...) /*GCC_FMT_ATTR(1, 2)*/;
+int qemulib_read_memory(void *cpu, uint64_t addr, uint8_t *buf, int len);
+int qemulib_read_register(void *cpu, uint8_t *mem_buf, int reg);
+
 #endif /* PLUGINS_INTERFACE_H */
diff --git a/plugins/qemulib.c b/plugins/qemulib.c
new file mode 100644
index 0000000..eb812c1
--- /dev/null
+++ b/plugins/qemulib.c
@@ -0,0 +1,31 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "qemu/error-report.h"
+#include "qemu/plugins.h"
+#include "qemu/log.h"
+#include "include/plugins.h"
+
+void qemulib_log(const char *fmt, ...)
+{
+    va_list args;
+    va_start(args, fmt);
+    qemu_log_vprintf(fmt, args);
+    va_end(args);
+}
+
+int qemulib_read_memory(void *cpu, uint64_t addr, uint8_t *buf, int len)
+{
+    return cpu_memory_rw_debug(cpu, addr, buf, len, false);
+}
+
+int qemulib_read_register(void *cpu, uint8_t *mem_buf, int reg)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (reg < cc->gdb_num_core_regs) {
+        return cc->gdb_read_register(cpu, mem_buf, reg);
+    }
+
+    return 0;
+}
