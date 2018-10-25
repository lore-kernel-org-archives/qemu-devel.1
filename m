Received: from eggs.gnu.org ([2001:4830:134:3::10]:40556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006mD-Q3
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKk-0000Sr-00
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKj-0000Fa-Oz
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:57 -0400
Message-Id: <20181025172057.20414-49-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 48/48] plugin: add a couple of very simple
 examples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 plugin-examples/bbcount_avgsize_racy.c | 50 ++++++++++++++++++++++
 plugin-examples/mem_count_racy_both.c  | 58 ++++++++++++++++++++++++++
 plugin-examples/Makefile               | 31 ++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 plugin-examples/bbcount_avgsize_racy.c
 create mode 100644 plugin-examples/mem_count_racy_both.c
 create mode 100644 plugin-examples/Makefile

diff --git a/plugin-examples/bbcount_avgsize_racy.c b/plugin-examples/bbcount_avgsize_racy.c
new file mode 100644
index 0000000000..ccdf96c1fa
--- /dev/null
+++ b/plugin-examples/bbcount_avgsize_racy.c
@@ -0,0 +1,50 @@
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t bb_count;
+static uint64_t insn_count;
+const char *filename;
+static int stdout_fd;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "insns: %" PRIu64", bb: %" PRIu64 ", "
+            "avg insns/bb: %.2f\n",
+            insn_count, bb_count, (double)insn_count / bb_count);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    unsigned long n_insns = (unsigned long)udata;
+
+    insn_count += n_insns;
+    bb_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
+{
+    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
+
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         (void *)n_insns);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    /* plugin_exit might write to stdout after stdout has been closed */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/plugin-examples/mem_count_racy_both.c b/plugin-examples/mem_count_racy_both.c
new file mode 100644
index 0000000000..a47f2025bf
--- /dev/null
+++ b/plugin-examples/mem_count_racy_both.c
@@ -0,0 +1,58 @@
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t mem_count;
+static int stdout_fd;
+static bool do_inline;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "accesses: %" PRIu64 "\n", mem_count);
+}
+
+static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                     uint64_t vaddr, void *udata)
+{
+    mem_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        if (do_inline) {
+            qemu_plugin_register_vcpu_mem_inline(insn,
+                                                 QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &mem_count, 1);
+        } else {
+            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
+                                             QEMU_PLUGIN_CB_NO_REGS, NULL);
+        }
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    if (argc && strcmp(argv[0], "inline") == 0) {
+        do_inline = true;
+    }
+    /* plugin_exit might write to stdout after stdout has been closed */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/plugin-examples/Makefile b/plugin-examples/Makefile
new file mode 100644
index 0000000000..71bbcda7a8
--- /dev/null
+++ b/plugin-examples/Makefile
@@ -0,0 +1,31 @@
+NAMES :=
+NAMES += bbcount_avgsize_racy
+NAMES += mem_count_racy_both
+
+SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
+
+# QEMU installed path, set by --prefix during configure
+QEMU_PATH ?= /data/src/qemu-inst/plugin-test
+
+CC := gcc
+CFLAGS :=
+CFLAGS += -O2 -Werror -Wall
+CFLAGS += -Wundef -Wwrite-strings -Wmissing-prototypes
+CFLAGS += -Wstrict-prototypes -Wredundant-decls
+CFLAGS += -fno-strict-aliasing -fno-common -fwrapv
+CFLAGS += -I$(QEMU_PATH)/include
+LDLIBS := -lc
+
+all: $(SONAMES)
+
+%.o: %.c
+	$(CC) $(CFLAGS) -fPIC -c $< -o $@
+
+lib%.so: %.o
+	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+
+clean:
+	$(RM) -f *.o *.so
+	$(RM) -Rf .libs
+
+.PHONY: all clean
-- 
2.17.1
