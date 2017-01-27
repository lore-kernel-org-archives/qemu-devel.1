Received: from eggs.gnu.org ([2001:4830:134:3::10]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r2-000596-7C
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qz-00043W-2k
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:16 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:28 +0100
Message-Id: <1485524749-118532-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/41] block/iscsi: statically link
 qemu_iscsi_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

From: Peter Lieven <pl@kamp.de>

commit f57b4b5f moved qemu_iscsi_opts into vl.c. This
made them invisible for qemu-img, qemu-nbd etc.

Fixes: f57b4b5fb127b60e1aade2684a8b16bc4f630b29
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1485262161-18543-1-git-send-email-pl@kamp.de>
[Drop useless #ifdef. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS         |  1 +
 block/Makefile.objs |  1 +
 block/iscsi-opts.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                | 40 -------------------------------
 4 files changed, 71 insertions(+), 40 deletions(-)
 create mode 100644 block/iscsi-opts.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ad10004..dc779e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1626,6 +1626,7 @@ M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/iscsi.c
+F: block/iscsi-opts.c
 
 NFS
 M: Jeff Cody <jcody@redhat.com>
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 0b8fd06..c6bd14e 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -14,6 +14,7 @@ block-obj-y += throttle-groups.o
 
 block-obj-y += nbd.o nbd-client.o sheepdog.o
 block-obj-$(CONFIG_LIBISCSI) += iscsi.o
+block-obj-$(if $(CONFIG_LIBISCSI),y,n) += iscsi-opts.o
 block-obj-$(CONFIG_LIBNFS) += nfs.o
 block-obj-$(CONFIG_CURL) += curl.o
 block-obj-$(CONFIG_RBD) += rbd.o
diff --git a/block/iscsi-opts.c b/block/iscsi-opts.c
new file mode 100644
index 0000000..5335539
--- /dev/null
+++ b/block/iscsi-opts.c
@@ -0,0 +1,69 @@
+/*
+ * QEMU Block driver for iSCSI images (static options)
+ *
+ * Copyright (c) 2017 Peter Lieven <pl@kamp.de>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/config-file.h"
+
+static QemuOptsList qemu_iscsi_opts = {
+    .name = "iscsi",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_iscsi_opts.head),
+    .desc = {
+        {
+            .name = "user",
+            .type = QEMU_OPT_STRING,
+            .help = "username for CHAP authentication to target",
+        },{
+            .name = "password",
+            .type = QEMU_OPT_STRING,
+            .help = "password for CHAP authentication to target",
+        },{
+            .name = "password-secret",
+            .type = QEMU_OPT_STRING,
+            .help = "ID of the secret providing password for CHAP "
+                    "authentication to target",
+        },{
+            .name = "header-digest",
+            .type = QEMU_OPT_STRING,
+            .help = "HeaderDigest setting. "
+                    "{CRC32C|CRC32C-NONE|NONE-CRC32C|NONE}",
+        },{
+            .name = "initiator-name",
+            .type = QEMU_OPT_STRING,
+            .help = "Initiator iqn name to use when connecting",
+        },{
+            .name = "timeout",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Request timeout in seconds (default 0 = no timeout)",
+        },
+        { /* end of list */ }
+    },
+};
+
+static void iscsi_block_opts_init(void)
+{
+    qemu_add_opts(&qemu_iscsi_opts);
+}
+
+block_init(iscsi_block_opts_init);
diff --git a/vl.c b/vl.c
index 1f39cc0..bc8e837 100644
--- a/vl.c
+++ b/vl.c
@@ -514,43 +514,6 @@ static QemuOptsList qemu_fw_cfg_opts = {
     },
 };
 
-#ifdef CONFIG_LIBISCSI
-static QemuOptsList qemu_iscsi_opts = {
-    .name = "iscsi",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_iscsi_opts.head),
-    .desc = {
-        {
-            .name = "user",
-            .type = QEMU_OPT_STRING,
-            .help = "username for CHAP authentication to target",
-        },{
-            .name = "password",
-            .type = QEMU_OPT_STRING,
-            .help = "password for CHAP authentication to target",
-        },{
-            .name = "password-secret",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of the secret providing password for CHAP "
-                    "authentication to target",
-        },{
-            .name = "header-digest",
-            .type = QEMU_OPT_STRING,
-            .help = "HeaderDigest setting. "
-                    "{CRC32C|CRC32C-NONE|NONE-CRC32C|NONE}",
-        },{
-            .name = "initiator-name",
-            .type = QEMU_OPT_STRING,
-            .help = "Initiator iqn name to use when connecting",
-        },{
-            .name = "timeout",
-            .type = QEMU_OPT_NUMBER,
-            .help = "Request timeout in seconds (default 0 = no timeout)",
-        },
-        { /* end of list */ }
-    },
-};
-#endif
-
 /**
  * Get machine options
  *
@@ -3032,9 +2995,6 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
-#ifdef CONFIG_LIBISCSI
-    qemu_add_opts(&qemu_iscsi_opts);
-#endif
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
-- 
1.8.3.1
