Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE627ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D4F20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D4F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5GD-0002lE-Q4
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1iK5EQ-0000jV-FD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1iK5EN-0003gX-Mp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:38:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1032
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1iK5EN-0003gN-HL
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:38:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9EIc4g9149336
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:38:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vmwfr24n3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:38:06 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Mon, 14 Oct 2019 19:37:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 14 Oct 2019 19:37:53 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9EIbqDQ44367908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2019 18:37:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27CF24C044;
 Mon, 14 Oct 2019 18:37:52 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA5B24C059;
 Mon, 14 Oct 2019 18:37:50 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2019 18:37:50 +0000 (GMT)
Subject: [PATCH v3 2/3] spapr: Add NVDIMM device support
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Mon, 14 Oct 2019 13:37:50 -0500
In-Reply-To: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101418-0020-0000-0000-0000037901B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101418-0021-0000-0000-000021CF1BC6
Message-Id: <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-14_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: sbhat@linux.vnet.ibm.com, qemu-devel@nongnu.org
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
 hw/mem/nvdimm.c                   |   40 +++++++
 hw/ppc/spapr.c                    |  218 ++++++++++++++++++++++++++++++++++---
 hw/ppc/spapr_drc.c                |   18 +++
 hw/ppc/spapr_events.c             |    4 +
 include/hw/mem/nvdimm.h           |    7 +
 include/hw/ppc/spapr.h            |   11 ++
 include/hw/ppc/spapr_drc.h        |    9 ++
 9 files changed, 293 insertions(+), 17 deletions(-)

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
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 375f9a588a..e1238b5bed 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -69,11 +69,51 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    char *value = NULL;
+
+    value = qemu_uuid_unparse_strdup(&nvdimm->uuid);
+
+    visit_type_str(v, name, &value, errp);
+    g_free(value);
+}
+
+
+static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    Error *local_err = NULL;
+    char *value;
+
+    visit_type_str(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
+        error_setg(errp, "Property '%s.%s' has invalid value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    g_free(value);
+
+out:
+    error_propagate(errp, local_err);
+}
+
+
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
+
+    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
+                        nvdimm_set_uuid, NULL, NULL, NULL);
 }
 
 static void nvdimm_finalize(Object *obj)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 08a2a5a770..eb5c205078 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -80,6 +80,8 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/mem/nvdimm.h"
+#include "qemu/nvdimm-utils.h"
 
 #include <libfdt.h>
 
@@ -716,7 +718,8 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
     uint8_t *int_buf, *cur_index;
     int ret;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
-    uint64_t addr, cur_addr, size;
+    uint64_t addr, cur_addr, size, slot;
+    uint64_t scm_block_size = SPAPR_MINIMUM_SCM_BLOCK_SIZE;
     uint32_t nr_boot_lmbs = (machine->device_memory->base / lmb_size);
     uint64_t mem_end = machine->device_memory->base +
                        memory_region_size(&machine->device_memory->mr);
@@ -741,6 +744,7 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
         addr = di->addr;
         size = di->size;
         node = di->node;
+        slot = di->slot;
 
         /* Entry for hot-pluggable area */
         if (cur_addr < addr) {
@@ -752,12 +756,20 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
             nr_entries++;
         }
 
-        /* Entry for DIMM */
-        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
-        g_assert(drc);
-        elem = spapr_get_drconf_cell(size / lmb_size, addr,
-                                     spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+        if (info->value->type == MEMORY_DEVICE_INFO_KIND_DIMM) {
+            /* Entry for DIMM */
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
+            g_assert(drc);
+            elem = spapr_get_drconf_cell(size / lmb_size, addr,
+                                         spapr_drc_index(drc), node,
+                                         SPAPR_LMB_FLAGS_ASSIGNED);
+        } else if (info->value->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            /* Entry for NVDIMM */
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
+            g_assert(drc);
+            elem = spapr_get_drconf_cell(size / scm_block_size, addr,
+                                         spapr_drc_index(drc), -1, 0);
+        }
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
@@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
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
 static void *spapr_build_fdt(SpaprMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
@@ -1392,6 +1483,11 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
         }
     }
 
+    /* NVDIMM devices */
+    if (mc->nvdimm_supported) {
+        spapr_dt_persistent_memory(fdt);
+    }
+
     return fdt;
 }
 
@@ -2521,6 +2617,16 @@ static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
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
@@ -2734,6 +2840,7 @@ static void spapr_machine_init(MachineState *machine)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     PCIHostState *phb;
@@ -2915,6 +3022,10 @@ static void spapr_machine_init(MachineState *machine)
         spapr_create_lmb_dr_connectors(spapr);
     }
 
+    if (mc->nvdimm_supported) {
+        spapr_create_nvdimm_dr_connectors(spapr);
+    }
+
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "spapr-rtas.bin");
     if (!filename) {
         error_report("Could not find LPAR rtas '%s'", "spapr-rtas.bin");
@@ -3436,6 +3547,16 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
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
@@ -3498,13 +3619,34 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
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
 
@@ -3513,14 +3655,24 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -3538,6 +3690,8 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     const SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
+    const MachineClass *mc = MACHINE_CLASS(smc);
+    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     Error *local_err = NULL;
     uint64_t size;
@@ -3549,16 +3703,40 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -3698,6 +3876,12 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
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
 
@@ -4453,6 +4637,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
+    mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
@@ -4558,6 +4743,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
     };
 
     spapr_machine_4_2_class_options(mc);
+    mc->nvdimm_supported = false;
     smc->linux_pci_probe = false;
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 62f1a42592..815167e42f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -708,6 +708,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
     drck->dt_populate = spapr_phb_dt_populate;
 }
 
+static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
+{
+    SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
+
+    drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
+    drck->typename = "MEM";
+    drck->drc_name_prefix = "PMEM ";
+    drck->release = NULL;
+    drck->dt_populate = spapr_pmem_dt_populate;
+}
+
 static const TypeInfo spapr_dr_connector_info = {
     .name          = TYPE_SPAPR_DR_CONNECTOR,
     .parent        = TYPE_DEVICE,
@@ -758,6 +769,12 @@ static const TypeInfo spapr_drc_phb_info = {
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
@@ -1229,6 +1246,7 @@ static void spapr_drc_register_types(void)
     type_register_static(&spapr_drc_pci_info);
     type_register_static(&spapr_drc_lmb_info);
     type_register_static(&spapr_drc_phb_info);
+    type_register_static(&spapr_drc_pmem_info);
 
     spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
                         rtas_set_indicator);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 0e4c19523a..b9a4d1607c 100644
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
@@ -530,6 +531,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
         hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
         break;
+    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
+        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PMEM;
+        break;
     default:
         /* we shouldn't be signaling hotplug events for resources
          * that don't support them
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..4807ca615b 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
 
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "qemu/uuid.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -49,6 +50,7 @@
                                                TYPE_NVDIMM)
 
 #define NVDIMM_LABEL_SIZE_PROP "label-size"
+#define NVDIMM_UUID_PROP       "uuid"
 #define NVDIMM_UNARMED_PROP    "unarmed"
 
 struct NVDIMMDevice {
@@ -83,6 +85,11 @@ struct NVDIMMDevice {
      * the guest write persistence.
      */
     bool unarmed;
+
+    /*
+     * The PPC64 - spapr requires each nvdimm device have a uuid.
+     */
+    QemuUUID uuid;
 };
 typedef struct NVDIMMDevice NVDIMMDevice;
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 03111fd55b..a8cb3513d0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -811,6 +811,8 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 void spapr_lmb_release(DeviceState *dev);
 int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp);
 void spapr_phb_release(DeviceState *dev);
 int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
@@ -846,6 +848,15 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
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


