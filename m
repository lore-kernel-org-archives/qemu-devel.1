Received: from eggs.gnu.org ([2001:4830:134:3::10]:33240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWex-0000Fv-PQ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWew-0004st-GH
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:49934)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWew-0004sU-1Q
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:10 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:52:07 +0300
Message-ID: <154401432740.8440.8861063892576062855.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 01/39] windbg: add empty windbgstub files
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 Makefile.target                  |    3 +++
 default-configs/i386-softmmu.mak |    1 +
 include/exec/windbgstub-utils.h  |   18 ++++++++++++++++++
 include/exec/windbgstub.h        |   17 +++++++++++++++++
 stubs/Makefile.objs              |    1 +
 stubs/windbgstub.c               |   18 ++++++++++++++++++
 target/i386/Makefile.objs        |    1 +
 target/i386/windbgstub.c         |   13 +++++++++++++
 windbgstub-utils.c               |   12 ++++++++++++
 windbgstub.c                     |   19 +++++++++++++++++++
 10 files changed, 103 insertions(+)
 create mode 100644 include/exec/windbgstub-utils.h
 create mode 100644 include/exec/windbgstub.h
 create mode 100644 stubs/windbgstub.c
 create mode 100644 target/i386/windbgstub.c
 create mode 100644 windbgstub-utils.c
 create mode 100644 windbgstub.c

diff --git a/Makefile.target b/Makefile.target
index 4d56298bbf..3bf11d3366 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -147,6 +147,9 @@ obj-$(TARGET_X86_64) += win_dump.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
+# WinDbg support
+obj-$(CONFIG_WINDBGSTUB) += windbgstub.o windbgstub-utils.o
+
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 64c998c4c8..5cb41a53ab 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -67,3 +67,4 @@ CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
+CONFIG_WINDBGSTUB=y
diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
new file mode 100644
index 0000000000..11487be465
--- /dev/null
+++ b/include/exec/windbgstub-utils.h
@@ -0,0 +1,18 @@
+/*
+ * windbgstub-utils.h
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
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
+#endif /* WINDBGSTUB_UTILS_H */
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
new file mode 100644
index 0000000000..9656c152ef
--- /dev/null
+++ b/include/exec/windbgstub.h
@@ -0,0 +1,17 @@
+/*
+ * windbgstub.h
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
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
+#endif /* WINDBGSTUB_H */
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5dd0aeeec6..2158e99516 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -33,6 +33,7 @@ stub-obj-y += trace-control.o
 stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
+stub-obj-y += windbgstub.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
 stub-obj-y += qmp_memory_device.o
 stub-obj-y += target-monitor-defs.o
diff --git a/stubs/windbgstub.c b/stubs/windbgstub.c
new file mode 100644
index 0000000000..36ad918dad
--- /dev/null
+++ b/stubs/windbgstub.c
@@ -0,0 +1,18 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
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
index 32bf966300..249b878036 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -20,3 +20,4 @@ obj-$(CONFIG_WHPX) += whpx-all.o
 endif
 obj-$(CONFIG_SEV) += sev.o
 obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
+obj-$(CONFIG_WINDBGSTUB) += windbgstub.o
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
new file mode 100644
index 0000000000..8caaa7cd38
--- /dev/null
+++ b/target/i386/windbgstub.c
@@ -0,0 +1,13 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "exec/windbgstub-utils.h"
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
new file mode 100644
index 0000000000..7f603b7f3f
--- /dev/null
+++ b/windbgstub-utils.c
@@ -0,0 +1,12 @@
+/*
+ * windbgstub-utils.c
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "exec/windbgstub-utils.h"
diff --git a/windbgstub.c b/windbgstub.c
new file mode 100644
index 0000000000..4673703b66
--- /dev/null
+++ b/windbgstub.c
@@ -0,0 +1,19 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2018 Institute for System Programming
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
