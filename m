Received: from eggs.gnu.org ([2001:4830:134:3::10]:38525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3nNc-00049T-T6
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1d3nNb-0005FT-Tj
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 13:39:00 -0400
From: Wei Huang <wei@redhat.com>
Date: Thu, 27 Apr 2017 12:38:47 -0500
Message-Id: <1493314727-6951-3-git-send-email-wei@redhat.com>
In-Reply-To: <1493314727-6951-1-git-send-email-wei@redhat.com>
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] armv7m: Use stub functions if
 CONFIG_ARM_V7M is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

M-profile CPUs relies on NVIC controller which won't be compiled if
CONFIG_ARM_V7M is not defined. To solve the problem, this patch
defines four NVIC stub functions. These functions are called when
CONFIG_ARM_V7M is not defined.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 target/arm/Makefile.objs |  1 +
 target/arm/armv7m-stub.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 target/arm/armv7m-stub.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 847fb52..328367d 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -4,6 +4,7 @@ obj-$(CONFIG_KVM) += kvm.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-$(call lnot,$(CONFIG_ARM_V7M)) += armv7m-stub.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += neon_helper.o iwmmxt_helper.o
 obj-y += gdbstub.o
diff --git a/target/arm/armv7m-stub.c b/target/arm/armv7m-stub.c
new file mode 100644
index 0000000..1be3874
--- /dev/null
+++ b/target/arm/armv7m-stub.c
@@ -0,0 +1,43 @@
+/*
+ * ARMv7M stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/arm/armv7m.h"
+
+void armv7m_nvic_acknowledge_irq(void *opaque)
+{
+    NVICState *s = (NVICState *)opaque;
+
+    cpu_abort(CPU(s->cpu), "No NVIC avaialable to acknowledge IRQ\n");
+}
+
+void armv7m_nvic_set_pending(void *opaque, int irq)
+{
+    NVICState *s = (NVICState *)opaque;
+
+    cpu_abort(CPU(s->cpu), "No NVIC avaialable to set IRQ pending\n");
+}
+
+int armv7m_nvic_complete_irq(void *opaque, int irq)
+{
+    NVICState *s = (NVICState *)opaque;
+
+    cpu_abort(CPU(s->cpu), "No NVIC avaialable to complete IRQ\n");
+
+    return 0;
+}
+
+bool armv7m_nvic_can_take_pending_exception(void *opaque)
+{
+    NVICState *s = (NVICState *)opaque;
+
+    cpu_abort(CPU(s->cpu), "No NVIC avaialable to check pending exception\n");
+
+    return false;
+}
-- 
1.8.3.1
