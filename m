Received: from eggs.gnu.org ([2001:4830:134:3::10]:37343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWV-0002Sz-U4
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWT-00048Q-Vb
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:00 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWT-00043I-N3
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:57 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWN-0001QG-Cr
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:51 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:36 +0000
Message-Id: <1483962824-29185-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/21] hw/arm/virt: remove
 include/hw/arm/virt-acpi-build.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

include/hw/arm/virt-acpi-build.h is only used for VirtGuestInfo,
which doesn't even necessarily have to be ACPI specific. Move
VirtGuestInfo to include/hw/arm/virt.h, allowing us to remove
include/hw/arm/virt-acpi-build.h, and to prepare for even more
code motion.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-9-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt-acpi-build.h | 39 ---------------------------------------
 include/hw/arm/virt.h            | 14 +++++++++++++-
 hw/arm/virt-acpi-build.c         |  2 +-
 hw/arm/virt.c                    |  1 -
 MAINTAINERS                      |  2 --
 5 files changed, 14 insertions(+), 44 deletions(-)
 delete mode 100644 include/hw/arm/virt-acpi-build.h

diff --git a/include/hw/arm/virt-acpi-build.h b/include/hw/arm/virt-acpi-build.h
deleted file mode 100644
index 925c434..0000000
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
index 9650193..69f7847 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -32,6 +32,7 @@
 
 #include "qemu-common.h"
 #include "exec/hwaddr.h"
+#include "qemu/notify.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -74,5 +75,16 @@ typedef struct MemMapEntry {
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
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ef0efb8..4fd52da 100644
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
index 9b55ef0..1b88b50 100644
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 585cd5a..ed884b2 100644
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
-- 
2.7.4
