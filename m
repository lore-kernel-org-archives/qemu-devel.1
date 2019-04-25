Received: from eggs.gnu.org ([209.51.188.92]:39551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYS-0005kx-D6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYP-0007F5-5K
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYM-0006HD-Ti
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 17:00:50 -0300
Message-Id: <20190425200051.19906-4-ehabkost@redhat.com>
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
References: <20190425200051.19906-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qdev: Don't compile hotplug code in
 user-mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>

Move qdev-hotplug.o and hotplug.o to CONFIG_SOFTMMU because the
code is not necessary for *-user.

Provide a few stubs in qdev-hotplug-stubs.c to replace
initialization functions that are called from qdev.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-hotplug-stubs.c | 44 ++++++++++++++++++++++++++++++++++++
 hw/core/Makefile.objs        |  6 +++--
 tests/Makefile.include       |  3 ++-
 3 files changed, 50 insertions(+), 3 deletions(-)
 create mode 100644 hw/core/qdev-hotplug-stubs.c

diff --git a/hw/core/qdev-hotplug-stubs.c b/hw/core/qdev-hotplug-stubs.c
new file mode 100644
index 0000000000..c710f23388
--- /dev/null
+++ b/hw/core/qdev-hotplug-stubs.c
@@ -0,0 +1,44 @@
+/*
+ * qdev hotplug handler stubs (for user-mode emulation and unit tests)
+ *
+ *  Copyright (c) 2019 Red Hat Inc
+ *
+ * Authors:
+ *  Eduardo Habkost <ehabkost@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "hw/hotplug.h"
+
+HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
+{
+    return NULL;
+}
+
+void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
+                              DeviceState *plugged_dev,
+                              Error **errp)
+{
+    assert(plug_handler == NULL);
+}
+
+void hotplug_handler_plug(HotplugHandler *plug_handler,
+                          DeviceState *plugged_dev,
+                          Error **errp)
+{
+    assert(plug_handler == NULL);
+}
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 9c4f953716..284fc306c5 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,11 +1,10 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o reset.o qdev-hotplug.o
+common-obj-y += bus.o reset.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
-common-obj-y += hotplug.o
 common-obj-$(CONFIG_SOFTMMU) += nmi.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
@@ -13,6 +12,7 @@ common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
+common-obj-$(CONFIG_SOFTMMU) += hotplug.o qdev-hotplug.o
 common-obj-$(CONFIG_SOFTMMU) += gpio.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_FITLOADER) += loader-fit.o
@@ -23,3 +23,5 @@ common-obj-$(CONFIG_SOFTMMU) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) += null-machine.o
+
+common-obj-$(CONFIG_USER_ONLY) += qdev-hotplug-stubs.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e2432d5e77..fd5e7e0c77 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -568,7 +568,8 @@ tests/fp/%:
 	$(MAKE) -C $(dir $@) $(notdir $@)
 
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
-	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
+	hw/core/qdev.o hw/core/qdev-properties.o \
+	hw/core/qdev-hotplug-stubs.o \
 	hw/core/bus.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
-- 
2.18.0.rc1.1.g3f1ff2140
