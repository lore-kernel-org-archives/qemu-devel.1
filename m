Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIJ-0003uW-IM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZIF-000661-KO
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZIF-000654-C0
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 909C080468
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:31:51 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-138.ams2.redhat.com
	[10.36.117.138])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0KDVeVI014401
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 08:31:50 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:14 +0100
Message-Id: <20170120133139.31080-11-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/35] stubs: group stubs for user-mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Some stubs are used for user-mode emulation only; they are not
needed by tools.  Move them out of stubs/.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS         |  1 +
 Makefile.target     |  4 ++--
 stubs/Makefile.objs |  2 --
 stubs/cpus.c        | 11 -----------
 stubs/replay-user.c | 33 ---------------------------------
 user-exec-stub.c    | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 37 insertions(+), 48 deletions(-)
 delete mode 100644 stubs/cpus.c
 delete mode 100644 stubs/replay-user.c
 create mode 100644 user-exec-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1444b26..39e8230 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1494,6 +1494,7 @@ M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
 F: thunk.c
 F: user-exec.c
+F: user-exec-stub.c
 
 BSD user
 S: Orphan
diff --git a/Makefile.target b/Makefile.target
index 8ae82cb..9e8edd9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -115,7 +115,7 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
              -I$(SRC_PATH)/linux-user
 
 obj-y += linux-user/
-obj-y += gdbstub.o thunk.o user-exec.o
+obj-y += gdbstub.o thunk.o user-exec.o user-exec-stub.o
 
 endif #CONFIG_LINUX_USER
 
@@ -128,7 +128,7 @@ QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
 			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
 
 obj-y += bsd-user/
-obj-y += gdbstub.o user-exec.o
+obj-y += gdbstub.o user-exec.o user-exec-stub.o
 
 endif #CONFIG_BSD_USER
 
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c89a9da..1eec1fb 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -25,7 +25,6 @@ stub-obj-y += monitor.o
 stub-obj-y += notify-event.o
 stub-obj-y += qtest.o
 stub-obj-y += replay.o
-stub-obj-y += replay-user.o
 stub-obj-y += runstate-check.o
 stub-obj-y += set-fd-handler.o
 stub-obj-y += slirp.o
@@ -35,7 +34,6 @@ stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
-stub-obj-y += cpus.o
 stub-obj-y += kvm.o
 stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
diff --git a/stubs/cpus.c b/stubs/cpus.c
deleted file mode 100644
index e192722..0000000
--- a/stubs/cpus.c
+++ /dev/null
@@ -1,11 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qom/cpu.h"
-
-void cpu_resume(CPUState *cpu)
-{
-}
-
-void qemu_init_vcpu(CPUState *cpu)
-{
-}
diff --git a/stubs/replay-user.c b/stubs/replay-user.c
deleted file mode 100644
index b29e7eb..0000000
--- a/stubs/replay-user.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * replay.c
- *
- * Copyright (c) 2010-2015 Institute for System Programming
- *                         of the Russian Academy of Sciences.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "sysemu/replay.h"
-
-bool replay_exception(void)
-{
-    return true;
-}
-
-bool replay_has_exception(void)
-{
-    return false;
-}
-
-bool replay_interrupt(void)
-{
-    return true;
-}
-
-bool replay_has_interrupt(void)
-{
-    return false;
-}
diff --git a/user-exec-stub.c b/user-exec-stub.c
new file mode 100644
index 0000000..dbcf1ad
--- /dev/null
+++ b/user-exec-stub.c
@@ -0,0 +1,34 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qom/cpu.h"
+#include "sysemu/replay.h"
+
+void cpu_resume(CPUState *cpu)
+{
+}
+
+void qemu_init_vcpu(CPUState *cpu)
+{
+}
+
+/* User mode emulation does not support record/replay yet.  */
+
+bool replay_exception(void)
+{
+    return true;
+}
+
+bool replay_has_exception(void)
+{
+    return false;
+}
+
+bool replay_interrupt(void)
+{
+    return true;
+}
+
+bool replay_has_interrupt(void)
+{
+    return false;
+}
-- 
2.9.3
