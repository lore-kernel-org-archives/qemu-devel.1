Received: from eggs.gnu.org ([2001:4830:134:3::10]:53840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutL-0002Wb-D2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGutK-0007a2-5x
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:45:43 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Tue, 13 Dec 2016 22:45:16 +0100
Message-Id: <20161213214522.25548-6-drjones@redhat.com>
In-Reply-To: <20161213214522.25548-1-drjones@redhat.com>
References: <20161213214522.25548-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH 05/11] hw/arm/virt: remove
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
Cc: peter.maydell@linaro.org, zhaoshenglong@huawei.com, mst@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

include/hw/arm/virt-acpi-build.h is only used for VirtGuestInfo,
which doesn't even necessarily have to be ACPI specific. Move
VirtGuestInfo to include/hw/arm/virt.h, allowing us to remove
include/hw/arm/virt-acpi-build.h, and to prepare for even more
code motion.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 MAINTAINERS                      |  2 --
 hw/arm/virt-acpi-build.c         |  2 +-
 hw/arm/virt.c                    |  1 -
 include/hw/arm/virt-acpi-build.h | 41 ----------------------------------------
 include/hw/arm/virt.h            | 16 +++++++++++++++-
 5 files changed, 16 insertions(+), 46 deletions(-)
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
index d4160dfa7d34..db44e2dd5f12 100644
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
index 0657f9ae8722..b137d9bbb689 100644
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
index d74d7a1af650..000000000000
--- a/include/hw/arm/virt-acpi-build.h
+++ /dev/null
@@ -1,41 +0,0 @@
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
-#define ACPI_GICC_ENABLED 1
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
index b805b7622834..c2c1f6837442 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -32,6 +32,7 @@
 
 #include "qemu-common.h"
 #include "exec/hwaddr.h"
+#include "qemu/notify.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -47,6 +48,8 @@
 
 #define PPI(irq) ((irq) + 16)
 
+#define ACPI_GICC_ENABLED 1
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
@@ -76,5 +79,16 @@ typedef struct MemMapEntry {
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
+
+void virt_acpi_setup(VirtGuestInfo *guest_info);
 
-#endif
+#endif /* QEMU_ARM_VIRT_H */
-- 
2.9.3
