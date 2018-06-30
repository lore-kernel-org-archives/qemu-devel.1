Received: from eggs.gnu.org ([2001:4830:134:3::10]:33592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3X-0008DK-9Z
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fZC3W-0001oq-97
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 05:20:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 30 Jun 2018 10:13:42 +0100
Message-Id: <20180630091343.14391-3-stefanha@redhat.com>
In-Reply-To: <20180630091343.14391-1-stefanha@redhat.com>
References: <20180630091343.14391-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] hw/arm: add ARMv6M object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, joel@jms.id.au, qemu-arm@nongnu.org, jim@groklearning.com, mail@steffen-goertz.de, jusual@mail.ru, Subbaraya Sundeep <sundeep.lkml@gmail.com>, ilg@livius.net, Stefan Hajnoczi <stefanha@redhat.com>

The ARMv6M object will be used by machine types that need ARMv6-M CPUs.

There is no logic beyond what the ARMMProfile base class already
provides because ARMv6-M is a pretty small microcontroller without many
bells and whistles.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/Makefile.objs            |  1 +
 include/hw/arm/armv6m.h         | 24 ++++++++++++++++++++++++
 hw/arm/armv6m.c                 | 23 +++++++++++++++++++++++
 default-configs/arm-softmmu.mak |  1 +
 4 files changed, 49 insertions(+)
 create mode 100644 include/hw/arm/armv6m.h
 create mode 100644 hw/arm/armv6m.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2c43d34c64..e693d86cd3 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_VERSATILE) += vexpress.o versatilepb.o
 obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
 
 obj-$(CONFIG_ARM_M_PROFILE) += arm-m-profile.o
+obj-$(CONFIG_ARM_V6M) += armv6m.o
 obj-$(CONFIG_ARM_V7M) += armv7m.o
 obj-$(CONFIG_EXYNOS4) += exynos4210.o
 obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
diff --git a/include/hw/arm/armv6m.h b/include/hw/arm/armv6m.h
new file mode 100644
index 0000000000..5f80120266
--- /dev/null
+++ b/include/hw/arm/armv6m.h
@@ -0,0 +1,24 @@
+/*
+ * ARMv6M CPU object
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.
+ */
+
+#ifndef HW_ARM_ARMV6M_H
+#define HW_ARM_ARMV6M_H
+
+#include "hw/arm/arm-m-profile.h"
+
+#define TYPE_ARMV6M "armv6m"
+#define ARMV6M(obj) OBJECT_CHECK(ARMv6MState, (obj), TYPE_ARMV6M)
+
+/* ARMv6M container object.
+ */
+typedef struct ARMv6MState {
+    /*< private >*/
+    ARMMProfileState parent_obj;
+} ARMv6MState;
+
+#endif
diff --git a/hw/arm/armv6m.c b/hw/arm/armv6m.c
new file mode 100644
index 0000000000..89c4727a87
--- /dev/null
+++ b/hw/arm/armv6m.c
@@ -0,0 +1,23 @@
+/*
+ * ARMv6M CPU object
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * This code is licensed under the GPL version 2 or later.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/armv6m.h"
+
+static const TypeInfo armv6m_info = {
+    .name = TYPE_ARMV6M,
+    .parent = TYPE_ARM_M_PROFILE,
+    .instance_size = sizeof(ARMv6MState),
+};
+
+static void armv6m_register_types(void)
+{
+    type_register_static(&armv6m_info);
+}
+
+type_init(armv6m_register_types)
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index e704cb6e34..a381817126 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -49,6 +49,7 @@ CONFIG_A9MPCORE=y
 CONFIG_A15MPCORE=y
 
 CONFIG_ARM_M_PROFILE=y
+CONFIG_ARM_V6M=y
 CONFIG_ARM_V7M=y
 CONFIG_NETDUINO2=y
 
-- 
2.17.1
