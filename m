Received: from eggs.gnu.org ([2001:4830:134:3::10]:45849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9Nb-0005xU-TY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9Na-0006ay-VQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:55 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56000)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9Na-0006aS-Ng
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:54 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:53 +0300
Message-ID: <152819519376.30857.17032517857304957536.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 7/7] plugins: add syscall logging plugin
 sample
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

This is an example of plugin which instruments only specific instructions:
sysenter and sysexit. When executing them, it prints system call id
and return code to the QEMU log.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 plugins/syscall-log/Makefile      |   19 ++++++++++++++++
 plugins/syscall-log/syscall-log.c |   44 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 plugins/syscall-log/Makefile
 create mode 100644 plugins/syscall-log/syscall-log.c

diff --git a/plugins/syscall-log/Makefile b/plugins/syscall-log/Makefile
new file mode 100644
index 0000000..1bbdf04
--- /dev/null
+++ b/plugins/syscall-log/Makefile
@@ -0,0 +1,19 @@
+CFLAGS += -I../include -fno-PIE -fPIC -O3
+LDFLAGS += -shared
+# TODO: Windows
+DSOSUF := .so
+
+NAME:= syscall-log
+BIN := $(NAME)$(DSOSUF)
+
+FILES := syscall-log.o
+
+%.o: %.c
+	$(CC) -c -o $@ $< $(CFLAGS)
+
+all: $(FILES)
+	$(CC) $(LDFLAGS) -o $(BIN) $(FILES)
+
+clean:
+	rm $(FILES)
+	rm $(BIN)
diff --git a/plugins/syscall-log/syscall-log.c b/plugins/syscall-log/syscall-log.c
new file mode 100644
index 0000000..1f5d55f
--- /dev/null
+++ b/plugins/syscall-log/syscall-log.c
@@ -0,0 +1,44 @@
+#include <stdint.h>
+#include <stdio.h>
+#include "plugins.h"
+
+bool plugin_init(const char *args)
+{
+    return true;
+}
+
+bool plugin_needs_before_insn(uint64_t pc, void *cpu)
+{
+    uint8_t code = 0;
+    if (!qemulib_read_memory(cpu, pc, &code, 1)
+        && code == 0x0f) {
+        if (qemulib_read_memory(cpu, pc + 1, &code, 1)) {
+            return false;
+        }
+        if (code == 0x34) {
+            /* sysenter */
+            return true;
+        }
+        if (code == 0x35) {
+            /* sysexit */
+            return true;
+        }
+    }
+    return false;
+}
+
+void plugin_before_insn(uint64_t pc, void *cpu)
+{
+    uint8_t code = 0;
+    uint32_t reg;
+    qemulib_read_memory(cpu, pc + 1, &code, 1);
+    /* Read EAX. There should be a header with register ids
+       or a function for reading the register by the name */
+    qemulib_read_register(cpu, (uint8_t*)&reg, 0);
+    /* log system calls */
+    if (code == 0x34) {
+        qemulib_log("sysenter %x\n", reg);
+    } else if (code == 0x35) {
+        qemulib_log("sysexit %x\n", reg);
+    }
+}
