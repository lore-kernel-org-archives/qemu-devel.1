Received: from eggs.gnu.org ([2001:4830:134:3::10]:51765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJE-0005hI-1b
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJC-0000cv-Hq
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJC-0000as-8B
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJB-00034A-4p
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:27 +0100
Message-Id: <20180504171540.25813-12-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/24] hw/arm/smmu-common: smmu base device and
 datatypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

The patch introduces the smmu base device and class for the ARM
smmu. Devices for specific versions will be derived from this
base device.

We also introduce some important datatypes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1524665762-31355-2-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs                |   1 +
 include/hw/arm/smmu-common.h        | 123 ++++++++++++++++++++++++++++
 hw/arm/smmu-common.c                |  81 ++++++++++++++++++
 default-configs/aarch64-softmmu.mak |   1 +
 4 files changed, 206 insertions(+)
 create mode 100644 include/hw/arm/smmu-common.h
 create mode 100644 hw/arm/smmu-common.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2885e3e234..558436f3a5 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,3 +35,4 @@ obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
+obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
new file mode 100644
index 0000000000..d682be82d2
--- /dev/null
+++ b/include/hw/arm/smmu-common.h
@@ -0,0 +1,123 @@
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
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
new file mode 100644
index 0000000000..e086ff52a5
--- /dev/null
+++ b/hw/arm/smmu-common.c
@@ -0,0 +1,81 @@
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
+    SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    sbc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void smmu_base_reset(DeviceState *dev)
+{
+    /* will be filled later on */
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
diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 9ddccf855e..6f790f061a 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
 CONFIG_XLNX_ZYNQMP_ARM=y
+CONFIG_ARM_SMMUV3=y
-- 
2.17.0
