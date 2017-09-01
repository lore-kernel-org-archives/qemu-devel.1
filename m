Received: from eggs.gnu.org ([2001:4830:134:3::10]:36053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpde-0004dw-73
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpdc-0001r2-Gh
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:21:50 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:04 +0200
Message-Id: <1504286483-23327-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 01/20] hw/arm/smmu-common: smmu base device
 and datatypes
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

The patch introduces the smmu base device and class for the ARM
smmu. Devices for specific versions will be derived from this
base device.

We also introduce some important datatypes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

---

v3 -> v4:
- added smmu_find_as_from_bus_num
- SMMU_PCI_BUS_MAX and SMMU_PCI_DEVFN_MAX in smmu-common header
- new fields in SMMUState:
  - iommu_ops, smmu_as_by_busptr, smmu_as_by_bus_num
- add aa64[] field in SMMUTransCfg

v3:
- moved the base code in a separate patch to ease the review.
- clearer separation between base class and smmuv3 class
- translate_* only implemented as class methods
---
 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/Makefile.objs                |   1 +
 hw/arm/smmu-common.c                |  58 +++++++++++++++++++
 include/hw/arm/smmu-common.h        | 108 ++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 include/hw/arm/smmu-common.h

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 2449483..83a2932 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -7,3 +7,4 @@ CONFIG_AUX=y
 CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
+CONFIG_ARM_SMMUV3=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index a2e56ec..5b2d38d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -19,3 +19,4 @@ obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
+obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
new file mode 100644
index 0000000..56608f1
--- /dev/null
+++ b/hw/arm/smmu-common.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2014-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Author: Prem Mallappa <pmallapp@broadcom.com>
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
+#include "trace.h"
+#include "exec/target_page.h"
+#include "qom/cpu.h"
+
+#include "qemu/error-report.h"
+#include "hw/arm/smmu-common.h"
+
+static void smmu_base_instance_init(Object *obj)
+{
+}
+
+static void smmu_base_class_init(ObjectClass *klass, void *data)
+{
+}
+
+static const TypeInfo smmu_base_info = {
+    .name          = TYPE_SMMU_DEV_BASE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SMMUState),
+    .instance_init = smmu_base_instance_init,
+    .class_data    = NULL,
+    .class_size    = sizeof(SMMUBaseClass),
+    .class_init    = smmu_base_class_init,
+    .abstract      = true,
+};
+
+static void smmu_base_register_types(void)
+{
+    type_register_static(&smmu_base_info);
+}
+
+type_init(smmu_base_register_types)
+
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
new file mode 100644
index 0000000..38cd18f
--- /dev/null
+++ b/include/hw/arm/smmu-common.h
@@ -0,0 +1,108 @@
+/*
+ * ARM SMMU Support
+ *
+ * Copyright (C) 2015-2016 Broadcom Corporation
+ * Copyright (c) 2017 Red Hat, Inc.
+ * Written by Prem Mallappa, Eric Auger
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ARM_SMMU_COMMON_H
+#define HW_ARM_SMMU_COMMON_H
+
+#include <hw/sysbus.h>
+#include "hw/pci/pci.h"
+
+#define SMMU_PCI_BUS_MAX      256
+#define SMMU_PCI_DEVFN_MAX    256
+
+/*
+ * Page table walk generic errors
+ * At the moment values match SMMUv3 event numbers though
+ */
+typedef enum {
+    SMMU_TRANS_ERR_NONE          = 0x0,
+    SMMU_TRANS_ERR_WALK_EXT_ABRT = 0x1,  /* Translation walk external abort */
+    SMMU_TRANS_ERR_TRANS         = 0x10, /* Translation fault */
+    SMMU_TRANS_ERR_ADDR_SZ,              /* Address Size fault */
+    SMMU_TRANS_ERR_ACCESS,               /* Access fault */
+    SMMU_TRANS_ERR_PERM,                 /* Permission fault */
+    SMMU_TRANS_ERR_TLB_CONFLICT  = 0x20, /* TLB Conflict */
+} SMMUTransErr;
+
+/*
+ * Generic structure populated by derived SMMU devices
+ * after decoding the configuration information and used as
+ * input to the page table walk
+ */
+typedef struct SMMUTransCfg {
+    hwaddr   input;            /* input address */
+    hwaddr   output;           /* Output address */
+    int      stage;            /* translation stage */
+    uint32_t oas;              /* output address width */
+    uint32_t tsz;              /* input range, ie. 2^(64 -tnsz)*/
+    uint64_t ttbr;             /* TTBR address */
+    uint32_t granule_sz;       /* granule page shift */
+    bool     aa64;             /* arch64 or aarch32 translation table */
+    int      initial_level;    /* initial lookup level */
+    bool     disabled;         /* smmu is disabled */
+    bool     bypassed;         /* stage is bypassed */
+} SMMUTransCfg;
+
+typedef struct SMMUDevice {
+    void               *smmu;
+    PCIBus             *bus;
+    int                devfn;
+    IOMMUMemoryRegion  iommu;
+    AddressSpace       as;
+} SMMUDevice;
+
+typedef struct SMMUNotifierNode {
+    SMMUDevice *sdev;
+    QLIST_ENTRY(SMMUNotifierNode) next;
+} SMMUNotifierNode;
+
+typedef struct SMMUPciBus {
+    PCIBus       *bus;
+    SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
+} SMMUPciBus;
+
+typedef struct SMMUState {
+    /* <private> */
+    SysBusDevice  dev;
+    char *mrtypename;
+    MemoryRegion iomem;
+
+    GHashTable *smmu_as_by_busptr;
+    SMMUPciBus *smmu_as_by_bus_num[SMMU_PCI_BUS_MAX];
+    QLIST_HEAD(, SMMUNotifierNode) notifiers_list;
+
+} SMMUState;
+
+typedef int (*smmu_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
+
+typedef struct {
+    /* <private> */
+    SysBusDeviceClass parent_class;
+} SMMUBaseClass;
+
+#define TYPE_SMMU_DEV_BASE "smmu-base"
+#define SMMU_SYS_DEV(obj) OBJECT_CHECK(SMMUState, (obj), TYPE_SMMU_DEV_BASE)
+#define SMMU_DEVICE_GET_CLASS(obj)                              \
+    OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_SMMU_DEV_BASE)
+#define SMMU_DEVICE_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(SMMUBaseClass, (klass), TYPE_SMMU_DEV_BASE)
+
+#endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
