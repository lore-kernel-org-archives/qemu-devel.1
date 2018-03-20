Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGWe-000773-Ef
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGWc-00030t-M9
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:00 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:23 +0100
Message-Id: <1521549456-14072-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 01/14] hw/arm/smmu-common: smmu base device
 and datatypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

The patch introduces the smmu base device and class for the ARM
smmu. Devices for specific versions will be derived from this
base device.

We also introduce some important datatypes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
v9 -> v10:
- invoke the parent_realize
- use device_class_set_parent_realize
- use "" to include headers
- fix indent in SMMUTransCfg
- rename smmu_as_by_busptr into smmu_pcibus_by_busptr and
         smmu_as_by_bus_num into smmu_pcibus_by_bus_num
- mrtypename becomes const
- add Peter's R-b

v8 -> v9:
- remove page walk callback type from this patch (vhost related)
- add a new hash table for caching configuration data
- add reset function
- add asid

v7 -> v8:
- add bus_num property
- add primary-bus property
- add realize and remove instance_init
- rename TYPE and related macros to match naming convention using
  for GIC
- add SMMUPageTableWalkEventInfo
- tt[2] in translation config

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

Conflicts:
	default-configs/aarch64-softmmu.mak

Conflicts:
	hw/arm/Makefile.objs
---
 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/Makefile.objs                |   1 +
 hw/arm/smmu-common.c                |  88 +++++++++++++++++++++++++
 include/hw/arm/smmu-common.h        | 124 ++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 hw/arm/smmu-common.c
 create mode 100644 include/hw/arm/smmu-common.h

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 9ddccf8..6f790f0 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
 CONFIG_XLNX_ZYNQMP_ARM=y
+CONFIG_ARM_SMMUV3=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2885e3e..558436f 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,3 +35,4 @@ obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
+obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
new file mode 100644
index 0000000..f4cda1f
--- /dev/null
+++ b/hw/arm/smmu-common.c
@@ -0,0 +1,88 @@
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
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+
+#include "qemu/error-report.h"
+#include "hw/arm/smmu-common.h"
+
+static void smmu_base_realize(DeviceState *dev, Error **errp)
+{
+    SMMUState *s = ARM_SMMU(dev);
+    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    sbc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+    s->iotlb = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+}
+
+static void smmu_base_reset(DeviceState *dev)
+{
+    SMMUState *s = ARM_SMMU(dev);
+
+    g_hash_table_remove_all(s->configs);
+    g_hash_table_remove_all(s->iotlb);
+}
+
+static Property smmu_dev_properties[] = {
+    DEFINE_PROP_UINT8("bus_num", SMMUState, bus_num, 0),
+    DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus, "PCI", PCIBus *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void smmu_base_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SMMUBaseClass *sbc = ARM_SMMU_CLASS(klass);
+
+    dc->props = smmu_dev_properties;
+    device_class_set_parent_realize(dc, smmu_base_realize,
+                                    &sbc->parent_realize);
+    dc->reset = smmu_base_reset;
+}
+
+static const TypeInfo smmu_base_info = {
+    .name          = TYPE_ARM_SMMU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SMMUState),
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
index 0000000..5910692
--- /dev/null
+++ b/include/hw/arm/smmu-common.h
@@ -0,0 +1,124 @@
+/*
+ * ARM SMMU Support
+ *
+ * Copyright (C) 2015-2016 Broadcom Corporation
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
+ */
+
+#ifndef HW_ARM_SMMU_COMMON_H
+#define HW_ARM_SMMU_COMMON_H
+
+#include "hw/sysbus.h"
+#include "hw/pci/pci.h"
+
+#define SMMU_PCI_BUS_MAX      256
+#define SMMU_PCI_DEVFN_MAX    256
+
+#define SMMU_MAX_VA_BITS      48
+
+/*
+ * Page table walk error types
+ */
+typedef enum {
+    SMMU_PTW_ERR_NONE,
+    SMMU_PTW_ERR_WALK_EABT,   /* Translation walk external abort */
+    SMMU_PTW_ERR_TRANSLATION, /* Translation fault */
+    SMMU_PTW_ERR_ADDR_SIZE,   /* Address Size fault */
+    SMMU_PTW_ERR_ACCESS,      /* Access fault */
+    SMMU_PTW_ERR_PERMISSION,  /* Permission fault */
+} SMMUPTWEventType;
+
+typedef struct SMMUPTWEventInfo {
+    SMMUPTWEventType type;
+    dma_addr_t addr; /* fetched address that induced an abort, if any */
+} SMMUPTWEventInfo;
+
+typedef struct SMMUTransTableInfo {
+    bool disabled;             /* is the translation table disabled? */
+    uint64_t ttb;              /* TT base address */
+    uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
+    uint8_t granule_sz;        /* granule page shift */
+    uint8_t initial_level;     /* initial lookup level */
+} SMMUTransTableInfo;
+
+/*
+ * Generic structure populated by derived SMMU devices
+ * after decoding the configuration information and used as
+ * input to the page table walk
+ */
+typedef struct SMMUTransCfg {
+    int stage;                 /* translation stage */
+    bool aa64;                 /* arch64 or aarch32 translation table */
+    bool disabled;             /* smmu is disabled */
+    bool bypassed;             /* translation is bypassed */
+    bool aborted;              /* translation is aborted */
+    uint64_t ttb;              /* TT base address */
+    uint8_t oas;               /* output address width */
+    uint8_t tbi;               /* Top Byte Ignore */
+    uint16_t asid;
+    SMMUTransTableInfo tt[2];
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
+    const char *mrtypename;
+    MemoryRegion iomem;
+
+    GHashTable *smmu_pcibus_by_busptr;
+    GHashTable *configs; /* cache for configuration data */
+    GHashTable *iotlb;
+    SMMUPciBus *smmu_pcibus_by_bus_num[SMMU_PCI_BUS_MAX];
+    PCIBus *pci_bus;
+    QLIST_HEAD(, SMMUNotifierNode) notifiers_list;
+    uint8_t bus_num;
+    PCIBus *primary_bus;
+} SMMUState;
+
+typedef struct {
+    /* <private> */
+    SysBusDeviceClass parent_class;
+
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+
+} SMMUBaseClass;
+
+#define TYPE_ARM_SMMU "arm-smmu"
+#define ARM_SMMU(obj) OBJECT_CHECK(SMMUState, (obj), TYPE_ARM_SMMU)
+#define ARM_SMMU_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(SMMUBaseClass, (klass), TYPE_ARM_SMMU)
+#define ARM_SMMU_GET_CLASS(obj)                              \
+    OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_ARM_SMMU)
+
+#endif  /* HW_ARM_SMMU_COMMON */
-- 
2.5.5
