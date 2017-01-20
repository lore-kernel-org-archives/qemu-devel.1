Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIG-0003qw-57
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIE-00064f-Iu
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIE-00062e-AL
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 832C74E341
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:31:50 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-138.ams2.redhat.com
	[10.36.117.138])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0KDVeVH014401
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 08:31:49 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:13 +0100
Message-Id: <20170120133139.31080-10-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/35] hw: move reset handlers from vl.c to
 hw/core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

They are small, it is not worth stubbing them.  Just include them
in user-mode emulators and unit tests as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/Makefile.objs   |  2 +-
 hw/core/reset.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/hw.h         |  6 +----
 include/sysemu/reset.h  | 10 +++++++
 include/sysemu/sysemu.h |  1 -
 stubs/Makefile.objs     |  1 -
 stubs/reset.c           | 14 ----------
 tests/Makefile.include  |  1 +
 vl.c                    | 42 -----------------------------
 9 files changed, 85 insertions(+), 64 deletions(-)
 create mode 100644 hw/core/reset.c
 create mode 100644 include/sysemu/reset.h
 delete mode 100644 stubs/reset.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a4c94e5..833fd46 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,6 +1,6 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o
+common-obj-y += bus.o reset.o
 common-obj-y += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
diff --git a/hw/core/reset.c b/hw/core/reset.c
new file mode 100644
index 0000000..84c8869
--- /dev/null
+++ b/hw/core/reset.c
@@ -0,0 +1,72 @@
+/*
+ *  Reset handlers.
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2016 Red Hat, Inc.
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
+#include "qemu/queue.h"
+#include "sysemu/reset.h"
+
+/* reset/shutdown handler */
+
+typedef struct QEMUResetEntry {
+    QTAILQ_ENTRY(QEMUResetEntry) entry;
+    QEMUResetHandler *func;
+    void *opaque;
+} QEMUResetEntry;
+
+static QTAILQ_HEAD(reset_handlers, QEMUResetEntry) reset_handlers =
+    QTAILQ_HEAD_INITIALIZER(reset_handlers);
+
+void qemu_register_reset(QEMUResetHandler *func, void *opaque)
+{
+    QEMUResetEntry *re = g_malloc0(sizeof(QEMUResetEntry));
+
+    re->func = func;
+    re->opaque = opaque;
+    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
+}
+
+void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
+{
+    QEMUResetEntry *re;
+
+    QTAILQ_FOREACH(re, &reset_handlers, entry) {
+        if (re->func == func && re->opaque == opaque) {
+            QTAILQ_REMOVE(&reset_handlers, re, entry);
+            g_free(re);
+            return;
+        }
+    }
+}
+
+void qemu_devices_reset(void)
+{
+    QEMUResetEntry *re, *nre;
+
+    /* reset all devices */
+    QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
+        re->func(re->opaque);
+    }
+}
+
diff --git a/include/hw/hw.h b/include/hw/hw.h
index 3669ebd..e22d4ce 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -12,11 +12,7 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-
-typedef void QEMUResetHandler(void *opaque);
-
-void qemu_register_reset(QEMUResetHandler *func, void *opaque);
-void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
+#include "sysemu/reset.h"
 
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
new file mode 100644
index 0000000..0b0d6d7
--- /dev/null
+++ b/include/sysemu/reset.h
@@ -0,0 +1,10 @@
+#ifndef QEMU_SYSEMU_RESET_H
+#define QEMU_SYSEMU_RESET_H
+
+typedef void QEMUResetHandler(void *opaque);
+
+void qemu_register_reset(QEMUResetHandler *func, void *opaque);
+void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
+void qemu_devices_reset(void);
+
+#endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index cccde56..ff8ffb5 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -63,7 +63,6 @@ void qemu_system_vmstop_request_prepare(void);
 int qemu_shutdown_requested_get(void);
 int qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
-void qemu_devices_reset(void);
 void qemu_system_reset(bool report);
 void qemu_system_guest_panicked(void);
 size_t qemu_target_page_bits(void);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5b3e7c6..c89a9da 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -26,7 +26,6 @@ stub-obj-y += notify-event.o
 stub-obj-y += qtest.o
 stub-obj-y += replay.o
 stub-obj-y += replay-user.o
-stub-obj-y += reset.o
 stub-obj-y += runstate-check.o
 stub-obj-y += set-fd-handler.o
 stub-obj-y += slirp.o
diff --git a/stubs/reset.c b/stubs/reset.c
deleted file mode 100644
index 5d47711..0000000
--- a/stubs/reset.c
+++ /dev/null
@@ -1,14 +0,0 @@
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-
-/* Stub functions for binaries that never call qemu_devices_reset(),
- * and don't need to keep track of the reset handler list.
- */
-
-void qemu_register_reset(QEMUResetHandler *func, void *opaque)
-{
-}
-
-void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
-{
-}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2029013..c5c25a8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -517,6 +517,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/bus.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
+	hw/core/reset.o \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/qemu-file.o \
diff --git a/vl.c b/vl.c
index 63355e5..a2aff23 100644
--- a/vl.c
+++ b/vl.c
@@ -1630,16 +1630,6 @@ void vm_state_notify(int running, RunState state)
     }
 }
 
-/* reset/shutdown handler */
-
-typedef struct QEMUResetEntry {
-    QTAILQ_ENTRY(QEMUResetEntry) entry;
-    QEMUResetHandler *func;
-    void *opaque;
-} QEMUResetEntry;
-
-static QTAILQ_HEAD(reset_handlers, QEMUResetEntry) reset_handlers =
-    QTAILQ_HEAD_INITIALIZER(reset_handlers);
 static int reset_requested;
 static int shutdown_requested, shutdown_signal = -1;
 static pid_t shutdown_pid;
@@ -1729,38 +1719,6 @@ static int qemu_debug_requested(void)
     return r;
 }
 
-void qemu_register_reset(QEMUResetHandler *func, void *opaque)
-{
-    QEMUResetEntry *re = g_malloc0(sizeof(QEMUResetEntry));
-
-    re->func = func;
-    re->opaque = opaque;
-    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
-}
-
-void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
-{
-    QEMUResetEntry *re;
-
-    QTAILQ_FOREACH(re, &reset_handlers, entry) {
-        if (re->func == func && re->opaque == opaque) {
-            QTAILQ_REMOVE(&reset_handlers, re, entry);
-            g_free(re);
-            return;
-        }
-    }
-}
-
-void qemu_devices_reset(void)
-{
-    QEMUResetEntry *re, *nre;
-
-    /* reset all devices */
-    QTAILQ_FOREACH_SAFE(re, &reset_handlers, entry, nre) {
-        re->func(re->opaque);
-    }
-}
-
 void qemu_system_reset(bool report)
 {
     MachineClass *mc;
-- 
2.9.3
