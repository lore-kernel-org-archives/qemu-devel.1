Received: from eggs.gnu.org ([2001:4830:134:3::10]:33310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oJ-0001qw-Aw
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cO8oE-0003uW-Jl
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:02:23 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Mon,  2 Jan 2017 21:01:45 +0100
Message-Id: <20170102200153.28864-9-drjones@redhat.com>
In-Reply-To: <20170102200153.28864-1-drjones@redhat.com>
References: <20170102200153.28864-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/16] hw/arm/virt: remove
 include/hw/arm/virt-acpi-build.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: imammedo@redhat.com, peter.maydell@linaro.org, zhaoshenglong@huawei.com, shannon.zhao@linaro.org, mst@redhat.com, ehabkost@redhat.com

include/hw/arm/virt-acpi-build.h is only used for VirtGuestInfo,
which doesn't even necessarily have to be ACPI specific. Move
VirtGuestInfo to include/hw/arm/virt.h, allowing us to remove
include/hw/arm/virt-acpi-build.h, and to prepare for even more
code motion.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                      |  2 --
 hw/arm/virt-acpi-build.c         |  2 +-
 hw/arm/virt.c                    |  1 -
 include/hw/arm/virt-acpi-build.h | 39 ---------------------------------------
 include/hw/arm/virt.h            | 14 +++++++++++++-
 5 files changed, 14 insertions(+), 44 deletions(-)
 delete mode 100644 include/hw/arm/virt-acpi-build.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a605791fc98..465b9f0f8440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -508,7 +508,6 @@ M: Shannon Zhao <shannon.zhao@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/virt-acpi-build.c
-F: include/hw/arm/virt-acpi-build.h
 
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
@@ -885,7 +884,6 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
-F: include/hw/arm/virt-acpi-build.h
 
 ppc4xx
 M: Alexander Graf <agraf@suse.de>
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a6c6180f4bce..dbd359063781 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -29,7 +29,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "hw/arm/virt-acpi-build.h"
 #include "qemu/bitmap.h"
 #include "trace.h"
 #include "qom/cpu.h"
@@ -43,6 +42,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
+#include "hw/arm/virt.h"
 #include "sysemu/numa.h"
 #include "kvm_arm.h"
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d242980869bc..e51c1668e16e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -48,7 +48,6 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/arm/virt-acpi-build.h"
 #include "hw/arm/sysbus-fdt.h"
 #include "hw/platform-bus.h"
 #include "hw/arm/fdt.h"
diff --git a/include/hw/arm/virt-acpi-build.h b/include/hw/arm/virt-acpi-build.h
deleted file mode 100644
index 925c4347381c..000000000000
--- a/include/hw/arm/virt-acpi-build.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *
- * Copyright (c) 2015 HUAWEI TECHNOLOGIES CO.,LTD.
- *
- * Author: Shannon Zhao <zhaoshenglong@huawei.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef QEMU_VIRT_ACPI_BUILD_H
-#define QEMU_VIRT_ACPI_BUILD_H
-
-#include "qemu-common.h"
-#include "hw/arm/virt.h"
-#include "qemu/notify.h"
-
-typedef struct VirtGuestInfo {
-    int smp_cpus;
-    FWCfgState *fw_cfg;
-    const MemMapEntry *memmap;
-    const int *irqmap;
-    bool use_highmem;
-    int gic_version;
-    bool no_its;
-} VirtGuestInfo;
-
-void virt_acpi_setup(VirtGuestInfo *guest_info);
-
-#endif
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b805b7622834..248ba6f755a3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -32,6 +32,7 @@
 
 #include "qemu-common.h"
 #include "exec/hwaddr.h"
+#include "qemu/notify.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -76,5 +77,16 @@ typedef struct MemMapEntry {
     hwaddr size;
 } MemMapEntry;
 
+typedef struct VirtGuestInfo {
+    int smp_cpus;
+    FWCfgState *fw_cfg;
+    const MemMapEntry *memmap;
+    const int *irqmap;
+    bool use_highmem;
+    int gic_version;
+    bool no_its;
+} VirtGuestInfo;
 
-#endif
+void virt_acpi_setup(VirtGuestInfo *guest_info);
+
+#endif /* QEMU_ARM_VIRT_H */
-- 
2.9.3
