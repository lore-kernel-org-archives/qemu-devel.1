Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgT-00039D-7g
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgR-0003LC-9p
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:45 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgR-0003Kw-0V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:43 -0500
Received: by mail-wj0-x244.google.com with SMTP id qs7so54428078wjc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:42 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:04 +0100
Message-Id: <1484163327-111841-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/33] stubs: group stubs for user-mode emulation
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
1.8.3.1
