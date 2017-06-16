Received: from eggs.gnu.org ([2001:4830:134:3::10]:53986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLsjA-0002fZ-5B
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLsj8-0008Hh-Qc
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLsj8-0008HT-Kw
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:59:58 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Jun 2017 16:59:13 +0200
Message-Id: <1497625153-19812-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1497625153-19812-1-git-send-email-thuth@redhat.com>
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] Makefile: Move bootdevice.o to common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

There does not seem to be any target specific code in this file, so
we can put it into "common-obj" instead of "obj" to compile it only
once for all targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile.objs   | 2 +-
 Makefile.target | 2 +-
 bootdevice.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 0575802..e5bdae9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -40,7 +40,7 @@ io-obj-y = io/
 
 ifeq ($(CONFIG_SOFTMMU),y)
 common-obj-y = blockdev.o blockdev-nbd.o block/
-common-obj-y += iothread.o
+common-obj-y += bootdevice.o iothread.o
 common-obj-y += net/
 common-obj-y += qdev-monitor.o device-hotplug.o
 common-obj-$(CONFIG_WIN32) += os-win32.o
diff --git a/Makefile.target b/Makefile.target
index ce8dfe4..0759176 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -140,7 +140,7 @@ endif #CONFIG_BSD_USER
 # System emulator target
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
-obj-y += qtest.o bootdevice.o
+obj-y += qtest.o
 obj-y += hw/
 obj-$(CONFIG_KVM) += kvm-all.o
 obj-y += memory.o cputlb.o
diff --git a/bootdevice.c b/bootdevice.c
index 33e3029..1141009 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -27,7 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
+#include "sysemu/reset.h"
 #include "hw/qdev-core.h"
 
 typedef struct FWBootEntry FWBootEntry;
-- 
1.8.3.1
