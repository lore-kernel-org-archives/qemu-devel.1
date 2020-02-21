Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF6C11D27
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16360208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DCndNWCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16360208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zBb-00089k-6e
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7r-00022U-6s
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7o-00087M-Gn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:15 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36835 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7n-0007xp-T6; Thu, 20 Feb 2020 22:37:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwD0KD6z9sSM; Fri, 21 Feb 2020 14:36:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256220;
 bh=irEbmT2qIhVClFjuYmtCndsrNhu0PgrZVW8X/QT3fBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DCndNWCfTdNaShUGop7UbMq24Kp7sZBfESADaZBq/s3GkfIfo5REHKynxAKrEAHCm
 nPS7JILBYfeitSE79PE1v+sJSoegwbaR0efDPfsgHKsigwfF51r2RCQZbkn5K0U76I
 Z8tfzUMcHRTv+rnrw6wB0ovq7l283Tkh4MVX/Zrs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/20] spapr: Add NVDIMM device support
Date: Fri, 21 Feb 2020 14:36:37 +1100
Message-Id: <20200221033650.444386-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Bharata B Rao <bharata@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
device interface in QEMU to support virtual NVDIMM devices for Power.
Create the required DT entries for the device (some entries have
dummy values right now).

The patch creates the required DT node and sends a hotplug
interrupt to the guest. Guest is expected to undertake the normal
DR resource add path in response and start issuing PAPR SCM hcalls.

The device support is verified based on the machine version unlike x86.

This is how it can be used ..
Ex :
For coldplug, the device to be added in qemu command line as shown below
-object memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D/tm=
p/nvdimm0,share=3Dyes,size=3D1073872896
-device nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a920e8=
e9e,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0

For hotplug, the device to be added from monitor as below
object_add memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D=
/tmp/nvdimm0,share=3Dyes,size=3D1073872896
device_add nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a92=
0e8e9e,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
               [Early implementation]
Message-Id: <158131058078.2897.12767731856697459923.stgit@lep8c.aus.stgla=
bs.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc64-softmmu.mak |   1 +
 hw/mem/Kconfig                    |   2 +-
 hw/ppc/Makefile.objs              |   2 +-
 hw/ppc/spapr.c                    |  69 ++++++++++--
 hw/ppc/spapr_drc.c                |  19 ++++
 hw/ppc/spapr_events.c             |   4 +
 hw/ppc/spapr_nvdimm.c             | 177 ++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_drc.h        |   9 ++
 include/hw/ppc/spapr_nvdimm.h     |  37 +++++++
 9 files changed, 309 insertions(+), 11 deletions(-)
 create mode 100644 hw/ppc/spapr_nvdimm.c
 create mode 100644 include/hw/ppc/spapr_nvdimm.h

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
index cca52665d9..ae0841fa3a 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_POWERNV=3Dy
=20
 # For pSeries
 CONFIG_PSERIES=3Dy
+CONFIG_NVDIMM=3Dy
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 620fd4cb59..2ad052a536 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -8,4 +8,4 @@ config MEM_DEVICE
 config NVDIMM
     bool
     default y
-    depends on PC
+    depends on (PC || PSERIES)
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index a4bac57be6..c3d3cc56eb 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -7,7 +7,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio=
.o spapr_events.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
-obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
+obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o spapr_nvdimm.o
 obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
 obj-$(call land,$(CONFIG_PSERIES),$(CONFIG_LINUX)) +=3D spapr_pci_vfio.o=
 spapr_pci_nvlink2.o
 # IBM PowerNV
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 691c391060..cb220fde45 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -80,6 +80,7 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/ppc/spapr_nvdimm.h"
=20
 #include "monitor/monitor.h"
=20
@@ -675,6 +676,14 @@ static int spapr_populate_drmem_v2(SpaprMachineState=
 *spapr, void *fdt,
         size =3D di->size;
         node =3D di->node;
=20
+        /*
+         * The NVDIMM area is hotpluggable after the NVDIMM is unplugged=
. The
+         * area is marked hotpluggable in the next iteration for the big=
ger
+         * chunk including the NVDIMM occupied area.
+         */
+        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM)
+            continue;
+
         /* Entry for hot-pluggable area */
         if (cur_addr < addr) {
             drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_s=
ize);
@@ -1266,6 +1275,11 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bo=
ol reset, size_t space)
         }
     }
=20
+    /* NVDIMM devices */
+    if (mc->nvdimm_supported) {
+        spapr_dt_persistent_memory(fdt);
+    }
+
     return fdt;
 }
=20
@@ -2629,6 +2643,7 @@ static void spapr_machine_init(MachineState *machin=
e)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
     SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *initrd_filename =3D machine->initrd_filename;
     PCIHostState *phb;
@@ -2861,6 +2876,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
             "may run and log hardware error on the destination");
     }
=20
+    if (mc->nvdimm_supported) {
+        spapr_create_nvdimm_dr_connectors(spapr);
+    }
+
     /* Set up RTAS event infrastructure */
     spapr_events_init(spapr);
=20
@@ -3430,7 +3449,8 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
     Error *local_err =3D NULL;
     SpaprMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
-    uint64_t size, addr;
+    uint64_t size, addr, slot;
+    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
=20
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_ab=
ort);
=20
@@ -3439,14 +3459,24 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
         goto out;
     }
=20
-    addr =3D object_property_get_uint(OBJECT(dimm),
-                                    PC_DIMM_ADDR_PROP, &local_err);
-    if (local_err) {
-        goto out_unplug;
+    if (!is_nvdimm) {
+        addr =3D object_property_get_uint(OBJECT(dimm),
+                                        PC_DIMM_ADDR_PROP, &local_err);
+        if (local_err) {
+            goto out_unplug;
+        }
+        spapr_add_lmbs(dev, addr, size,
+                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
+                       &local_err);
+    } else {
+        slot =3D object_property_get_uint(OBJECT(dimm),
+                                        PC_DIMM_SLOT_PROP, &local_err);
+        if (local_err) {
+            goto out_unplug;
+        }
+        spapr_add_nvdimm(dev, slot, &local_err);
     }
=20
-    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_=
EVT),
-                   &local_err);
     if (local_err) {
         goto out_unplug;
     }
@@ -3464,6 +3494,8 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
 {
     const SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
     SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
+    const MachineClass *mc =3D MACHINE_CLASS(smc);
+    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     Error *local_err =3D NULL;
     uint64_t size;
@@ -3475,16 +3507,27 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
         return;
     }
=20
+    if (is_nvdimm && !mc->nvdimm_supported) {
+        error_setg(errp, "NVDIMM hotplug not supported for this machine"=
);
+        return;
+    }
+
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_e=
rr);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
=20
-    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
-                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
+                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
         return;
+    } else if (is_nvdimm) {
+        spapr_nvdimm_validate_opts(NVDIMM(dev), size, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
=20
     memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P,
@@ -3624,6 +3667,12 @@ static void spapr_memory_unplug_request(HotplugHan=
dler *hotplug_dev,
     int i;
     SpaprDrc *drc;
=20
+    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+        error_setg(&local_err,
+                   "nvdimm device hot unplug is not supported yet.");
+        goto out;
+    }
+
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_a=
bort);
     nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
=20
@@ -4418,6 +4467,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->update_dt_enabled =3D true;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus =3D true;
+    mc->nvdimm_supported =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path =3D spapr_get_fw_dev_path;
     nc->nmi_monitor_handler =3D spapr_nmi;
@@ -4533,6 +4583,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
+    mc->nvdimm_supported =3D false;
 }
=20
 DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 17aeac3801..fc62e04901 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callbac=
k */
+#include "hw/ppc/spapr_nvdimm.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/reset.h"
 #include "trace.h"
@@ -709,6 +710,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k,=
 void *data)
     drck->dt_populate =3D spapr_phb_dt_populate;
 }
=20
+static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
+{
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
+    drck->typename =3D "PMEM";
+    drck->drc_name_prefix =3D "PMEM ";
+    drck->release =3D NULL;
+    drck->dt_populate =3D spapr_pmem_dt_populate;
+}
+
 static const TypeInfo spapr_dr_connector_info =3D {
     .name          =3D TYPE_SPAPR_DR_CONNECTOR,
     .parent        =3D TYPE_DEVICE,
@@ -759,6 +771,12 @@ static const TypeInfo spapr_drc_phb_info =3D {
     .class_init    =3D spapr_drc_phb_class_init,
 };
=20
+static const TypeInfo spapr_drc_pmem_info =3D {
+    .name          =3D TYPE_SPAPR_DRC_PMEM,
+    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
+    .class_init    =3D spapr_drc_pmem_class_init,
+};
+
 /* helper functions for external users */
=20
 SpaprDrc *spapr_drc_by_index(uint32_t index)
@@ -1230,6 +1248,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
     type_register_static(&spapr_drc_phb_info);
+    type_register_static(&spapr_drc_pmem_info);
=20
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 884e455f02..8b32b7eea5 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -196,6 +196,7 @@ struct rtas_event_log_v6_hp {
 #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
 #define RTAS_LOG_V6_HP_TYPE_PHB                          4
 #define RTAS_LOG_V6_HP_TYPE_PCI                          5
+#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
     uint8_t hotplug_action;
 #define RTAS_LOG_V6_HP_ACTION_ADD                        1
 #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
@@ -631,6 +632,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
         hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PHB;
         break;
+    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
+        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PMEM;
+        break;
     default:
         /* we shouldn't be signaling hotplug events for resources
          * that don't support them
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
new file mode 100644
index 0000000000..d03c8d3a5c
--- /dev/null
+++ b/hw/ppc/spapr_nvdimm.c
@@ -0,0 +1,177 @@
+/*
+ * QEMU PAPR Storage Class Memory Interfaces
+ *
+ * Copyright (c) 2019-2020, IBM Corporation.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/ppc/spapr_drc.h"
+#include "hw/ppc/spapr_nvdimm.h"
+#include "hw/mem/nvdimm.h"
+#include "qemu/nvdimm-utils.h"
+#include "hw/ppc/fdt.h"
+
+void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
+                                Error **errp)
+{
+    char *uuidstr =3D NULL;
+    QemuUUID uuid;
+
+    if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
+        error_setg(errp, "NVDIMM memory size excluding the label area"
+                   " must be a multiple of %" PRIu64 "MB",
+                   SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
+        return;
+    }
+
+    uuidstr =3D object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP=
, NULL);
+    qemu_uuid_parse(uuidstr, &uuid);
+    g_free(uuidstr);
+
+    if (qemu_uuid_is_null(&uuid)) {
+        error_setg(errp, "NVDIMM device requires the uuid to be set");
+        return;
+    }
+}
+
+
+void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
+{
+    SpaprDrc *drc;
+    bool hotplugged =3D spapr_drc_hotplugged(dev);
+    Error *local_err =3D NULL;
+
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
+    g_assert(drc);
+
+    spapr_drc_attach(drc, dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (hotplugged) {
+        spapr_hotplug_req_add_by_index(drc);
+    }
+}
+
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **err=
p)
+{
+    NVDIMMDevice *nvdimm =3D NVDIMM(drc->dev);
+
+    *fdt_start_offset =3D spapr_dt_nvdimm(fdt, 0, nvdimm);
+
+    return 0;
+}
+
+void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    int i;
+
+    for (i =3D 0; i < machine->ram_slots; i++) {
+        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
+    }
+}
+
+
+int spapr_dt_nvdimm(void *fdt, int parent_offset,
+                           NVDIMMDevice *nvdimm)
+{
+    int child_offset;
+    char *buf;
+    SpaprDrc *drc;
+    uint32_t drc_idx;
+    uint32_t node =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_N=
ODE_PROP,
+                                             &error_abort);
+    uint64_t slot =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_S=
LOT_PROP,
+                                             &error_abort);
+    uint32_t associativity[] =3D {
+        cpu_to_be32(0x4), /* length */
+        cpu_to_be32(0x0), cpu_to_be32(0x0),
+        cpu_to_be32(0x0), cpu_to_be32(node)
+    };
+    uint64_t lsize =3D nvdimm->label_size;
+    uint64_t size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SI=
ZE_PROP,
+                                            NULL);
+
+    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
+    g_assert(drc);
+
+    drc_idx =3D spapr_drc_index(drc);
+
+    buf =3D g_strdup_printf("ibm,pmemory@%x", drc_idx);
+    child_offset =3D fdt_add_subnode(fdt, parent_offset, buf);
+    g_free(buf);
+
+    _FDT(child_offset);
+
+    _FDT((fdt_setprop_cell(fdt, child_offset, "reg", drc_idx)));
+    _FDT((fdt_setprop_string(fdt, child_offset, "compatible", "ibm,pmemo=
ry")));
+    _FDT((fdt_setprop_string(fdt, child_offset, "device_type", "ibm,pmem=
ory")));
+
+    _FDT((fdt_setprop(fdt, child_offset, "ibm,associativity", associativ=
ity,
+                      sizeof(associativity))));
+
+    buf =3D qemu_uuid_unparse_strdup(&nvdimm->uuid);
+    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,unit-guid", buf)));
+    g_free(buf);
+
+    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,my-drc-index", drc_id=
x)));
+
+    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,block-size",
+                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
+    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,number-of-blocks",
+                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
+    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,metadata-size", lsize=
)));
+
+    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,pmem-application",
+                             "operating-system")));
+    _FDT(fdt_setprop(fdt, child_offset, "ibm,cache-flush-required", NULL=
, 0));
+
+    return child_offset;
+}
+
+void spapr_dt_persistent_memory(void *fdt)
+{
+    int offset =3D fdt_subnode_offset(fdt, 0, "persistent-memory");
+    GSList *iter, *nvdimms =3D nvdimm_get_device_list();
+
+    if (offset < 0) {
+        offset =3D fdt_add_subnode(fdt, 0, "persistent-memory");
+        _FDT(offset);
+        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
+        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
+        _FDT((fdt_setprop_string(fdt, offset, "device_type",
+                                 "ibm,persistent-memory")));
+    }
+
+    /* Create DT entries for cold plugged NVDIMM devices */
+    for (iter =3D nvdimms; iter; iter =3D iter->next) {
+        NVDIMMDevice *nvdimm =3D iter->data;
+
+        spapr_dt_nvdimm(fdt, offset, nvdimm);
+    }
+    g_slist_free(nvdimms);
+
+    return;
+}
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 83f03cc577..df3d958a66 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -78,6 +78,13 @@
 #define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_PHB)
=20
+#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
+#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PMEM)
+#define SPAPR_DRC_PMEM_CLASS(klass) \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PMEM)
+#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(SpaprDrc, (obj), \
+                                         TYPE_SPAPR_DRC_PMEM)
 /*
  * Various hotplug types managed by SpaprDrc
  *
@@ -95,6 +102,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO =3D 3,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI =3D 4,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB =3D 8,
+    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM =3D 9,
 } SpaprDrcTypeShift;
=20
 typedef enum {
@@ -104,6 +112,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_VIO =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_V=
IO,
     SPAPR_DR_CONNECTOR_TYPE_PCI =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_P=
CI,
     SPAPR_DR_CONNECTOR_TYPE_LMB =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_L=
MB,
+    SPAPR_DR_CONNECTOR_TYPE_PMEM =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_=
PMEM,
 } SpaprDrcType;
=20
 /*
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.=
h
new file mode 100644
index 0000000000..b3330cc485
--- /dev/null
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU PowerPC PAPR SCM backend definitions
+ *
+ * Copyright (c) 2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef HW_SPAPR_NVDIMM_H
+#define HW_SPAPR_NVDIMM_H
+
+#include "hw/mem/nvdimm.h"
+#include "hw/ppc/spapr.h"
+
+/*
+ * The nvdimm size should be aligned to SCM block size.
+ * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
+ * inorder to have SCM regions not to overlap with dimm memory regions.
+ * The SCM devices can have variable block sizes. For now, fixing the
+ * block size to the minimum value.
+ */
+#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
+
+/* Have an explicit check for alignment */
+QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_MEMORY_BLOCK_SIZE=
);
+
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **err=
p);
+int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm);
+void spapr_dt_persistent_memory(void *fdt);
+void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
+                                Error **errp);
+void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
+void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
+
+#endif
--=20
2.24.1


