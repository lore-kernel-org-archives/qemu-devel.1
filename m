Received: from eggs.gnu.org ([2001:4830:134:3::10]:45804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NY-0005tu-Pd
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NV-0006W9-Kz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:52 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55980)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NV-0006VU-CZ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:49 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:48 +0300
Message-ID: <152819518838.30857.7489579122481731984.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 6/7] plugin: add instruction execution
 logger
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

This patch adds a plugin for logging addresses of all executed instructions,
making a complete instruction-level trace.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 plugins/exec-log/Makefile   |   19 +++++++++++++++++++
 plugins/exec-log/exec-log.c |   18 ++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 plugins/exec-log/Makefile
 create mode 100644 plugins/exec-log/exec-log.c

diff --git a/plugins/exec-log/Makefile b/plugins/exec-log/Makefile
new file mode 100644
index 0000000..86374f4
--- /dev/null
+++ b/plugins/exec-log/Makefile
@@ -0,0 +1,19 @@
+CFLAGS += -I../include -fno-PIE -fPIC -O3
+LDFLAGS += -shared
+# TODO: Windows
+DSOSUF := .so
+
+NAME:= exec-log
+BIN := $(NAME)$(DSOSUF)
+
+FILES := exec-log.o
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
diff --git a/plugins/exec-log/exec-log.c b/plugins/exec-log/exec-log.c
new file mode 100644
index 0000000..7fc7975
--- /dev/null
+++ b/plugins/exec-log/exec-log.c
@@ -0,0 +1,18 @@
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
+    return true;
+}
+
+void plugin_before_insn(uint64_t pc, void *cpu)
+{
+    qemulib_log("executing instruction at %lx\n", pc);
+}
