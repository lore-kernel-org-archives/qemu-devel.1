Received: from eggs.gnu.org ([2001:4830:134:3::10]:37718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfz-0006gc-Dt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfv-00042e-ED
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:15 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:18 +0200
Message-Id: <1504286483-23327-16-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 15/20] hw/arm/sysbus-fdt: Pass the
 VirtMachineState to the node creation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

The VirtMachineState contains some dt phandles that will be used
in some node creation functions. For instance we plan to use the
PCI host controller phandle in the smmu node creation function. So
let's pass the VirtMachineState handle down to the node creation
functions by enhancing the involved datatypes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/sysbus-fdt.c         | 3 +++
 hw/arm/virt.c               | 1 +
 include/hw/arm/sysbus-fdt.h | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d68e3dc..d92a983 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "hw/arm/virt.h"
 #include "hw/arm/fdt.h"
 
 /*
@@ -47,6 +48,7 @@ typedef struct PlatformBusFDTData {
     int irq_start; /* index of the first IRQ usable by platform bus devices */
     const char *pbus_node_name; /* name of the platform bus node */
     PlatformBusDevice *pbus;
+    VirtMachineState *vms;
 } PlatformBusFDTData;
 
 /*
@@ -514,6 +516,7 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
         .irq_start = irq_start,
         .pbus_node_name = node,
         .pbus = pbus,
+        .vms = fdt_params->vms,
     };
 
     /* Loop through all dynamic sysbus devices and create their node */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 39886c1..d7c28b0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1125,6 +1125,7 @@ static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
     fdt_params->system_params = &platform_bus_params;
     fdt_params->binfo = &vms->bootinfo;
     fdt_params->intc = "/intc";
+    fdt_params->vms = vms;
     /*
      * register a machine init done notifier that creates the device tree
      * nodes of the platform bus and its children dynamic sysbus devices
diff --git a/include/hw/arm/sysbus-fdt.h b/include/hw/arm/sysbus-fdt.h
index e15bb81..f5feabc 100644
--- a/include/hw/arm/sysbus-fdt.h
+++ b/include/hw/arm/sysbus-fdt.h
@@ -25,6 +25,7 @@
 #define HW_ARM_SYSBUS_FDT_H
 
 #include "hw/arm/arm.h"
+#include "hw/arm/virt.h"
 #include "qemu-common.h"
 #include "hw/sysbus.h"
 
@@ -48,6 +49,7 @@ typedef struct {
     const ARMPlatformBusSystemParams *system_params;
     struct arm_boot_info *binfo;
     const char *intc; /* parent interrupt controller name */
+    VirtMachineState *vms;
 } ARMPlatformBusFDTParams;
 
 /**
-- 
2.5.5
