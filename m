Received: from eggs.gnu.org ([2001:4830:134:3::10]:38874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9D6-000846-Eu
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Cu-0001td-SR
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:30 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37620)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Cu-0001s3-GI
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:24 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:07:21 +0300
Message-ID: <151127324158.6888.17818677336117525693.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 01/45] windbg: added empty windbgstub files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 Makefile.target                 |    7 +++++++
 include/exec/windbgstub-utils.h |   18 ++++++++++++++++++
 include/exec/windbgstub.h       |   17 +++++++++++++++++
 stubs/Makefile.objs             |    1 +
 stubs/windbgstub.c              |   18 ++++++++++++++++++
 target/i386/Makefile.objs       |    2 +-
 target/i386/windbgstub.c        |   12 ++++++++++++
 windbgstub-utils.c              |   12 ++++++++++++
 windbgstub.c                    |   19 +++++++++++++++++++
 9 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100755 include/exec/windbgstub-utils.h
 create mode 100755 include/exec/windbgstub.h
 create mode 100755 stubs/windbgstub.c
 create mode 100755 target/i386/windbgstub.c
 create mode 100755 windbgstub-utils.c
 create mode 100755 windbgstub.c

diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..6df0836509 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,6 +148,13 @@ obj-y += dump.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
+# WinDbg support
+ifeq ($(TARGET_NAME), i386)
+ifneq ($(TARGET_NAME), x86_64)
+obj-y += windbgstub.o windbgstub-utils.o
+endif
+endif
+
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
new file mode 100755
index 0000000000..67d190bf6c
--- /dev/null
+++ b/include/exec/windbgstub-utils.h
@@ -0,0 +1,18 @@
+/*
+ * windbgstub-utils.h
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef WINDBGSTUB_UTILS_H
+#define WINDBGSTUB_UTILS_H
+
+#include "qemu/osdep.h"
+#include "exec/windbgstub.h"
+
+#endif
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
new file mode 100755
index 0000000000..1a6e1cc6e5
--- /dev/null
+++ b/include/exec/windbgstub.h
@@ -0,0 +1,17 @@
+/*
+ * windbgstub.h
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef WINDBGSTUB_H
+#define WINDBGSTUB_H
+
+int windbg_server_start(const char *device);
+
+#endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e69c217aff..5c25a53c15 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -12,6 +12,7 @@ stub-obj-y += dump.o
 stub-obj-y += error-printf.o
 stub-obj-y += fdset.o
 stub-obj-y += gdbstub.o
+stub-obj-y += windbgstub.o
 stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
diff --git a/stubs/windbgstub.c b/stubs/windbgstub.c
new file mode 100755
index 0000000000..4951f59203
--- /dev/null
+++ b/stubs/windbgstub.c
@@ -0,0 +1,18 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "exec/windbgstub.h"
+
+int windbg_server_start(const char *device)
+{
+    return 0;
+}
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 6a26e9d9f0..730ee04e27 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += helper.o cpu.o gdbstub.o xsave_helper.o
+obj-y += helper.o cpu.o gdbstub.o windbgstub.o xsave_helper.o
 obj-$(CONFIG_TCG) += translate.o
 obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
new file mode 100755
index 0000000000..df89e1edd8
--- /dev/null
+++ b/target/i386/windbgstub.c
@@ -0,0 +1,12 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
new file mode 100755
index 0000000000..dc5e505c63
--- /dev/null
+++ b/windbgstub-utils.c
@@ -0,0 +1,12 @@
+/*
+ * windbgstub-utils.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "exec/windbgstub-utils.h"
diff --git a/windbgstub.c b/windbgstub.c
new file mode 100755
index 0000000000..3830446988
--- /dev/null
+++ b/windbgstub.c
@@ -0,0 +1,19 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "exec/windbgstub.h"
+#include "exec/windbgstub-utils.h"
+
+int windbg_server_start(const char *device)
+{
+    return 0;
+}
