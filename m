Received: from eggs.gnu.org ([209.51.188.92]:46010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoG-0004mj-Cl
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoE-0001b5-ME
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:28 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoE-0001Zk-D1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id p4so1062139wrt.7
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:43 +0000
Message-Id: <20190107163117.16269-4-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/37] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

This commit adds the cpu-cluster type. It aims at gathering CPUs from
the same cluster in a machine.

For now it only has a `cluster-id` property.

Documentation in cluster.h written with the help of Peter Maydell.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181207090135.7651-2-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/Makefile.objs     |  2 +-
 include/hw/cpu/cluster.h | 58 ++++++++++++++++++++++++++++++++++++++++
 hw/cpu/cluster.c         | 50 ++++++++++++++++++++++++++++++++++
 MAINTAINERS              |  2 ++
 4 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/cpu/cluster.h
 create mode 100644 hw/cpu/cluster.c

diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
index cd52d20b652..8db9e8a7b3c 100644
--- a/hw/cpu/Makefile.objs
+++ b/hw/cpu/Makefile.objs
@@ -2,4 +2,4 @@ obj-$(CONFIG_ARM11MPCORE) += arm11mpcore.o
 obj-$(CONFIG_REALVIEW) += realview_mpcore.o
 obj-$(CONFIG_A9MPCORE) += a9mpcore.o
 obj-$(CONFIG_A15MPCORE) += a15mpcore.o
-common-obj-y += core.o
+common-obj-y += core.o cluster.o
diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
new file mode 100644
index 00000000000..73818232437
--- /dev/null
+++ b/include/hw/cpu/cluster.h
@@ -0,0 +1,58 @@
+/*
+ * QEMU CPU cluster
+ *
+ * Copyright (c) 2018 GreenSocs SAS
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ */
+#ifndef HW_CPU_CLUSTER_H
+#define HW_CPU_CLUSTER_H
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+
+/*
+ * CPU Cluster type
+ *
+ * A cluster is a group of CPUs which are all identical and have the same view
+ * of the rest of the system. It is mainly an internal QEMU representation and
+ * does not necessarily match with the notion of clusters on the real hardware.
+ *
+ * If CPUs are not identical (for example, Cortex-A53 and Cortex-A57 CPUs in an
+ * Arm big.LITTLE system) they should be in different clusters. If the CPUs do
+ * not have the same view of memory (for example the main CPU and a management
+ * controller processor) they should be in different clusters.
+ */
+
+#define TYPE_CPU_CLUSTER "cpu-cluster"
+#define CPU_CLUSTER(obj) \
+    OBJECT_CHECK(CPUClusterState, (obj), TYPE_CPU_CLUSTER)
+
+/**
+ * CPUClusterState:
+ * @cluster_id: The cluster ID. This value is for internal use only and should
+ *   not be exposed directly to the user or to the guest.
+ *
+ * State of a CPU cluster.
+ */
+typedef struct CPUClusterState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    uint32_t cluster_id;
+} CPUClusterState;
+
+#endif
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
new file mode 100644
index 00000000000..9d50a235d5c
--- /dev/null
+++ b/hw/cpu/cluster.c
@@ -0,0 +1,50 @@
+/*
+ * QEMU CPU cluster
+ *
+ * Copyright (c) 2018 GreenSocs SAS
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cpu/cluster.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+
+static Property cpu_cluster_properties[] = {
+    DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void cpu_cluster_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = cpu_cluster_properties;
+}
+
+static const TypeInfo cpu_cluster_type_info = {
+    .name = TYPE_CPU_CLUSTER,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(CPUClusterState),
+    .class_init = cpu_cluster_class_init,
+};
+
+static void cpu_cluster_register_types(void)
+{
+    type_register_static(&cpu_cluster_type_info);
+}
+
+type_init(cpu_cluster_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 19792cfb2da..471161742de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1195,7 +1195,9 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
+F: hw/cpu/cluster.c
 F: include/hw/boards.h
+F: include/hw/cpu/cluster.h
 T: git https://github.com/ehabkost/qemu.git machine-next
 
 Xtensa Machines
-- 
2.19.2
