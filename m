Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E842C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FFA2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FFA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8Mu-0003kg-7O
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ix8J9-0007B3-Lk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ix8J7-0000z7-4i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ix8J6-0000ur-Mz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00UBi56u079172
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:48:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xu5qc5uts-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:48:23 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 30 Jan 2020 11:48:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 30 Jan 2020 11:48:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00UBmHF151052646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 11:48:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCC084C052;
 Thu, 30 Jan 2020 11:48:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3B834C04A;
 Thu, 30 Jan 2020 11:48:16 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jan 2020 11:48:16 +0000 (GMT)
Subject: [PATCH v5 3/4] spapr: Add NVDIMM device support
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Thu, 30 Jan 2020 05:48:15 -0600
In-Reply-To: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20013011-0028-0000-0000-000003D5E020
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013011-0029-0000-0000-0000249A2EA0
Message-Id: <158038488675.16440.7063690858146740608.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-30_03:2020-01-28,
 2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 suspectscore=2 priorityscore=1501
 malwarescore=0 mlxscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300087
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: qemu-ppc@nongnu.org, sbhat@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
-object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
-device nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

For hotplug, the device to be added from monitor as below
object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
device_add nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
               [Early implementation]
---
 default-configs/ppc64-softmmu.mak |    1 
 hw/mem/Kconfig                    |    2 
 hw/ppc/spapr.c                    |  212 +++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_drc.c                |   18 +++
 hw/ppc/spapr_events.c             |    4 +
 include/hw/ppc/spapr.h            |   11 ++
 include/hw/ppc/spapr_drc.h        |    9 ++
 7 files changed, 243 insertions(+), 14 deletions(-)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index cca52665d9..ae0841fa3a 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -8,3 +8,4 @@ CONFIG_POWERNV=y
 
 # For pSeries
 CONFIG_PSERIES=y
+CONFIG_NVDIMM=y
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 02cf53fc5b..4ea73c31fe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -79,6 +79,8 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/mem/nvdimm.h"
+#include "qemu/nvdimm-utils.h"
 
 #include "monitor/monitor.h"
 
@@ -684,12 +686,22 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
             nr_entries++;
         }
 
-        /* Entry for DIMM */
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
         g_assert(drc);
-        elem = spapr_get_drconf_cell(size / lmb_size, addr,
-                                     spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+
+        if (info->value->type == MEMORY_DEVICE_INFO_KIND_DIMM) {
+            /* Entry for DIMM */
+            elem = spapr_get_drconf_cell(size / lmb_size, addr,
+                                         spapr_drc_index(drc), node,
+                                         SPAPR_LMB_FLAGS_ASSIGNED);
+        } else if (info->value->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            /*
+             * Entry for the NVDIMM occupied area. The area is
+             * hotpluggable after the NVDIMM is unplugged.
+             */
+            elem = spapr_get_drconf_cell(size / lmb_size, addr,
+                                         spapr_drc_index(drc), -1, 0);
+        }
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
@@ -1130,6 +1142,85 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
     }
 }
 
+static int spapr_dt_nvdimm(void *fdt, int parent_offset,
+                           NVDIMMDevice *nvdimm)
+{
+    int child_offset;
+    char buf[40];
+    SpaprDrc *drc;
+    uint32_t drc_idx;
+    uint32_t node = object_property_get_uint(OBJECT(nvdimm), PC_DIMM_NODE_PROP,
+                                             &error_abort);
+    uint64_t slot = object_property_get_uint(OBJECT(nvdimm), PC_DIMM_SLOT_PROP,
+                                             &error_abort);
+    uint32_t associativity[] = {
+        cpu_to_be32(0x4), /* length */
+        cpu_to_be32(0x0), cpu_to_be32(0x0),
+        cpu_to_be32(0x0), cpu_to_be32(node)
+    };
+    uint64_t lsize = nvdimm->label_size;
+    uint64_t size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                            NULL);
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
+    g_assert(drc);
+
+    drc_idx = spapr_drc_index(drc);
+
+    sprintf(buf, "ibm,pmemory@%x", drc_idx);
+    child_offset = fdt_add_subnode(fdt, parent_offset, buf);
+    _FDT(child_offset);
+
+    _FDT((fdt_setprop_cell(fdt, child_offset, "reg", drc_idx)));
+    _FDT((fdt_setprop_string(fdt, child_offset, "compatible", "ibm,pmemory")));
+    _FDT((fdt_setprop_string(fdt, child_offset, "device_type", "ibm,pmemory")));
+
+    _FDT((fdt_setprop(fdt, child_offset, "ibm,associativity", associativity,
+                      sizeof(associativity))));
+
+    qemu_uuid_unparse(&nvdimm->uuid, buf);
+    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,unit-guid", buf)));
+
+    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,my-drc-index", drc_idx)));
+
+    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,block-size",
+                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
+    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,number-of-blocks",
+                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
+    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,metadata-size", lsize)));
+
+    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,pmem-application",
+                             "operating-system")));
+    _FDT(fdt_setprop(fdt, child_offset, "ibm,cache-flush-required", NULL, 0));
+
+    return child_offset;
+}
+
+static void spapr_dt_persistent_memory(void *fdt)
+{
+    int offset = fdt_subnode_offset(fdt, 0, "persistent-memory");
+    GSList *iter, *nvdimms = nvdimm_get_device_list();
+
+    if (offset < 0) {
+        offset = fdt_add_subnode(fdt, 0, "persistent-memory");
+        _FDT(offset);
+        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
+        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
+        _FDT((fdt_setprop_string(fdt, offset, "device_type",
+                                 "ibm,persistent-memory")));
+    }
+
+    /* Create DT entries for cold plugged NVDIMM devices */
+    for (iter = nvdimms; iter; iter = iter->next) {
+        NVDIMMDevice *nvdimm = iter->data;
+
+        spapr_dt_nvdimm(fdt, offset, nvdimm);
+    }
+    g_slist_free(nvdimms);
+
+    return;
+}
+
 void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 {
     MachineState *machine = MACHINE(spapr);
@@ -1265,6 +1356,11 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
         }
     }
 
+    /* NVDIMM devices */
+    if (mc->nvdimm_supported) {
+        spapr_dt_persistent_memory(fdt);
+    }
+
     return fdt;
 }
 
@@ -2366,6 +2462,16 @@ static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
     }
 }
 
+static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    int i;
+
+    for (i = 0; i < machine->ram_slots; i++) {
+        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);
+    }
+}
+
 /*
  * If RAM size, maxmem size and individual node mem sizes aren't aligned
  * to SPAPR_MEMORY_BLOCK_SIZE(256MB), then refuse to start the guest
@@ -2582,6 +2688,7 @@ static void spapr_machine_init(MachineState *machine)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     PCIHostState *phb;
@@ -2807,6 +2914,10 @@ static void spapr_machine_init(MachineState *machine)
         spapr_create_lmb_dr_connectors(spapr);
     }
 
+    if (mc->nvdimm_supported) {
+        spapr_create_nvdimm_dr_connectors(spapr);
+    }
+
     /* Set up RTAS event infrastructure */
     spapr_events_init(spapr);
 
@@ -3306,6 +3417,16 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(drc->dev);
+
+    *fdt_start_offset = spapr_dt_nvdimm(fdt, 0, nvdimm);
+
+    return 0;
+}
+
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
@@ -3368,13 +3489,34 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     }
 }
 
+static void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
+{
+    SpaprDrc *drc;
+    bool hotplugged = spapr_drc_hotplugged(dev);
+    Error *local_err = NULL;
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
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
 static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
     Error *local_err = NULL;
     SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    uint64_t size, addr;
+    uint64_t size, addr, slot;
+    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
     size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
 
@@ -3383,14 +3525,24 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
-    addr = object_property_get_uint(OBJECT(dimm),
-                                    PC_DIMM_ADDR_PROP, &local_err);
-    if (local_err) {
-        goto out_unplug;
+    if (!is_nvdimm) {
+        addr = object_property_get_uint(OBJECT(dimm),
+                                        PC_DIMM_ADDR_PROP, &local_err);
+        if (local_err) {
+            goto out_unplug;
+        }
+        spapr_add_lmbs(dev, addr, size,
+                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
+                       &local_err);
+    } else {
+        slot = object_property_get_uint(OBJECT(dimm),
+                                        PC_DIMM_SLOT_PROP, &local_err);
+        if (local_err) {
+            goto out_unplug;
+        }
+        spapr_add_nvdimm(dev, slot, &local_err);
     }
 
-    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                   &local_err);
     if (local_err) {
         goto out_unplug;
     }
@@ -3408,6 +3560,8 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
+    const MachineClass *mc = MACHINE_CLASS(smc);
+    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     Error *local_err = NULL;
     uint64_t size;
@@ -3419,16 +3573,40 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
+    if (is_nvdimm && !mc->nvdimm_supported) {
+        error_setg(errp, "NVDIMM hotplug not supported for this machine");
+        return;
+    }
+
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
+    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
-                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
+                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
         return;
+    } else if (is_nvdimm) {
+        char *uuidstr = NULL;
+        QemuUUID uuid;
+
+        if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
+            error_setg(errp, "NVDIMM memory size excluding the label area"
+                       " must be a multiple of %" PRIu64 "MB",
+                       SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
+            return;
+        }
+
+        uuidstr = object_property_get_str(OBJECT(dimm), NVDIMM_UUID_PROP, NULL);
+        qemu_uuid_parse(uuidstr, &uuid);
+        g_free(uuidstr);
+
+        if (qemu_uuid_is_null(&uuid)) {
+            error_setg(errp, "NVDIMM device requires the uuid to be set");
+            return;
+        }
     }
 
     memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
@@ -3568,6 +3746,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     int i;
     SpaprDrc *drc;
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+        error_setg(&local_err,
+                   "nvdimm device hot unplug is not supported yet.");
+        goto out;
+    }
+
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_abort);
     nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
@@ -4362,6 +4546,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
+    mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
@@ -4467,6 +4652,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
     spapr_machine_5_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    mc->nvdimm_supported = false;
 }
 
 DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 17aeac3801..1e496b9fc9 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -709,6 +709,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_phb_dt_populate;
 }
 
+static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
+{
+    SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
+    drck->typename = "PMEM";
+    drck->drc_name_prefix = "PMEM ";
+    drck->release = NULL;
+    drck->dt_populate = spapr_pmem_dt_populate;
+}
+
 static const TypeInfo spapr_dr_connector_info = {
     .name          = TYPE_SPAPR_DR_CONNECTOR,
     .parent        = TYPE_DEVICE,
@@ -759,6 +770,12 @@ static const TypeInfo spapr_drc_phb_info = {
     .class_init    = spapr_drc_phb_class_init,
 };
 
+static const TypeInfo spapr_drc_pmem_info = {
+    .name          = TYPE_SPAPR_DRC_PMEM,
+    .parent        = TYPE_SPAPR_DRC_LOGICAL,
+    .class_init    = spapr_drc_pmem_class_init,
+};
+
 /* helper functions for external users */
 
 SpaprDrc *spapr_drc_by_index(uint32_t index)
@@ -1230,6 +1247,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
     type_register_static(&spapr_drc_phb_info);
+    type_register_static(&spapr_drc_pmem_info);
 
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index e355e000d0..1731197af3 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -194,6 +194,7 @@ struct rtas_event_log_v6_hp {
 #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
 #define RTAS_LOG_V6_HP_TYPE_PHB                          4
 #define RTAS_LOG_V6_HP_TYPE_PCI                          5
+#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
     uint8_t hotplug_action;
 #define RTAS_LOG_V6_HP_ACTION_ADD                        1
 #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
@@ -531,6 +532,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
         hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
         break;
+    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
+        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PMEM;
+        break;
     default:
         /* we shouldn't be signaling hotplug events for resources
          * that don't support them
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 61f005c6f6..ed2de4bae5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -810,6 +810,8 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp);
 void spapr_phb_release(DeviceState *dev);
 int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
@@ -845,6 +847,15 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
 
+/*
+ * The nvdimm size should be aligned to SCM block size.
+ * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
+ * inorder to have SCM regions not to overlap with dimm memory regions.
+ * The SCM devices can have variable block sizes. For now, fixing the
+ * block size to the minimum value.
+ */
+#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
+
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 83f03cc577..df3d958a66 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -78,6 +78,13 @@
 #define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_PHB)
 
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
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO = 3,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI = 4,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB = 8,
+    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM = 9,
 } SpaprDrcTypeShift;
 
 typedef enum {
@@ -104,6 +112,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_VIO = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO,
     SPAPR_DR_CONNECTOR_TYPE_PCI = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI,
     SPAPR_DR_CONNECTOR_TYPE_LMB = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB,
+    SPAPR_DR_CONNECTOR_TYPE_PMEM = 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM,
 } SpaprDrcType;
 
 /*


