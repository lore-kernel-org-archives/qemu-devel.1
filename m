Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FAC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A98D2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A98D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8Nu-00056g-B9
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ix8JP-0007PW-Bg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ix8JM-0001KV-58
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ix8JL-0001H4-RS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00UBirHX099873
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:48:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xue96vvsw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:48:37 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 30 Jan 2020 11:48:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 30 Jan 2020 11:48:31 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00UBmUHj57933906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 11:48:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88C29A4057;
 Thu, 30 Jan 2020 11:48:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BEDFA4040;
 Thu, 30 Jan 2020 11:48:29 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jan 2020 11:48:29 +0000 (GMT)
Subject: [PATCH v5 4/4] spapr: Add Hcalls to support PAPR NVDIMM device
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Thu, 30 Jan 2020 05:48:28 -0600
In-Reply-To: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20013011-4275-0000-0000-0000039C658F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013011-4276-0000-0000-000038B0832B
Message-Id: <158038490304.16440.12988347988338519913.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-30_03:2020-01-28,
 2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 suspectscore=2 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0
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

This patch implements few of the necessary hcalls for the nvdimm support.

PAPR semantics is such that each NVDIMM device is comprising of multiple
SCM(Storage Class Memory) blocks. The guest requests the hypervisor to
bind each of the SCM blocks of the NVDIMM device using hcalls. There can
be SCM block unbind requests in case of driver errors or unplug(not
supported now) use cases. The NVDIMM label read/writes are done through
hcalls.

Since each virtual NVDIMM device is divided into multiple SCM blocks,
the bind, unbind, and queries using hcalls on those blocks can come
independently. This doesn't fit well into the qemu device semantics,
where the map/unmap are done at the (whole)device/object level granularity.
The patch doesnt actually bind/unbind on hcalls but let it happen at the
device_add/del phase itself instead.

The guest kernel makes bind/unbind requests for the virtual NVDIMM device
at the region level granularity. Without interleaving, each virtual NVDIMM
device is presented as a separate guest physical address range. So, there
is no way a partial bind/unbind request can come for the vNVDIMM in a
hcall for a subset of SCM blocks of a virtual NVDIMM. Hence it is safe to
do bind/unbind everything during the device_add/del.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/Makefile.objs   |    2 
 hw/ppc/spapr_nvdimm.c  |  327 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    8 +
 3 files changed, 335 insertions(+), 2 deletions(-)
 create mode 100644 hw/ppc/spapr_nvdimm.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index a4bac57be6..c3d3cc56eb 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -7,7 +7,7 @@ obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
-obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
+obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o spapr_nvdimm.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 obj-$(call land,$(CONFIG_PSERIES),$(CONFIG_LINUX)) += spapr_pci_vfio.o spapr_pci_nvlink2.o
 # IBM PowerNV
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
new file mode 100644
index 0000000000..8d1c2dc009
--- /dev/null
+++ b/hw/ppc/spapr_nvdimm.c
@@ -0,0 +1,327 @@
+/*
+ * QEMU PAPR Storage Class Memory Interfaces
+ *
+ * Copyright (c) 2019-2020, IBM Corporation.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_drc.h"
+#include "hw/mem/nvdimm.h"
+#include "qemu/range.h"
+#include "qemu/nvdimm-utils.h"
+
+static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t offset = args[1];
+    uint64_t numBytesToRead = args[2];
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm;
+    NVDIMMClass *ddc;
+    uint64_t data = 0;
+    uint8_t buf[8] = { 0 };
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (numBytesToRead != 1 && numBytesToRead != 2 &&
+        numBytesToRead != 4 && numBytesToRead != 8) {
+        return H_P3;
+    }
+
+    nvdimm = NVDIMM(drc->dev);
+    if ((offset + numBytesToRead < offset) ||
+        (nvdimm->label_size < numBytesToRead + offset)) {
+        return H_P2;
+    }
+
+    ddc = NVDIMM_GET_CLASS(nvdimm);
+    ddc->read_label_data(nvdimm, buf, numBytesToRead, offset);
+
+    switch (numBytesToRead) {
+    case 1:
+        data = ldub_p(buf);
+        break;
+    case 2:
+        data = lduw_be_p(buf);
+        break;
+    case 4:
+        data = ldl_be_p(buf);
+        break;
+    case 8:
+        data = ldq_be_p(buf);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    args[0] = data;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
+                                         target_ulong opcode,
+                                         target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t offset = args[1];
+    uint64_t data = args[2];
+    uint64_t numBytesToWrite = args[3];
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm;
+    NVDIMMClass *ddc;
+    uint8_t buf[8] = { 0 };
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (numBytesToWrite != 1 && numBytesToWrite != 2 &&
+        numBytesToWrite != 4 && numBytesToWrite != 8) {
+        return H_P4;
+    }
+
+    nvdimm = NVDIMM(drc->dev);
+    if ((offset + numBytesToWrite < offset) ||
+        (nvdimm->label_size < numBytesToWrite + offset)) {
+        return H_P2;
+    }
+
+    switch (numBytesToWrite) {
+    case 1:
+        if (data & 0xffffffffffffff00) {
+            return H_P2;
+        }
+        stb_p(buf, data);
+        break;
+    case 2:
+        if (data & 0xffffffffffff0000) {
+            return H_P2;
+        }
+        stw_be_p(buf, data);
+        break;
+    case 4:
+        if (data & 0xffffffff00000000) {
+            return H_P2;
+        }
+        stl_be_p(buf, data);
+        break;
+    case 8:
+        stq_be_p(buf, data);
+        break;
+    default:
+            g_assert_not_reached();
+    }
+
+    ddc = NVDIMM_GET_CLASS(nvdimm);
+    ddc->write_label_data(nvdimm, buf, numBytesToWrite, offset);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                   target_ulong opcode, target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t starting_idx = args[1];
+    uint64_t no_of_scm_blocks_to_bind = args[2];
+    uint64_t target_logical_mem_addr = args[3];
+    uint64_t continue_token = args[4];
+    uint64_t size;
+    uint64_t total_no_of_scm_blocks;
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    hwaddr addr;
+    NVDIMMDevice *nvdimm;
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    /*
+     * Currently continue token should be zero qemu has already bound
+     * everything and this hcall doesnt return H_BUSY.
+     */
+    if (continue_token > 0) {
+        return H_P5;
+    }
+
+    /* Currently qemu assigns the address. */
+    if (target_logical_mem_addr != 0xffffffffffffffff) {
+        return H_OVERLAP;
+    }
+
+    nvdimm = NVDIMM(drc->dev);
+
+    size = object_property_get_uint(OBJECT(nvdimm),
+                                    PC_DIMM_SIZE_PROP, &error_abort);
+
+    total_no_of_scm_blocks = size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    if (starting_idx > total_no_of_scm_blocks) {
+        return H_P2;
+    }
+
+    if (((starting_idx + no_of_scm_blocks_to_bind) < starting_idx) ||
+        ((starting_idx + no_of_scm_blocks_to_bind) > total_no_of_scm_blocks)) {
+        return H_P3;
+    }
+
+    addr = object_property_get_uint(OBJECT(nvdimm),
+                                    PC_DIMM_ADDR_PROP, &error_abort);
+
+    addr += starting_idx * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    /* Already bound, Return target logical address in R5 */
+    args[1] = addr;
+    args[2] = no_of_scm_blocks_to_bind;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                     target_ulong opcode, target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t starting_scm_logical_addr = args[1];
+    uint64_t no_of_scm_blocks_to_unbind = args[2];
+    uint64_t continue_token = args[3];
+    uint64_t size_to_unbind;
+    Range blockrange = range_empty;
+    Range nvdimmrange = range_empty;
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm;
+    uint64_t size, addr;
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    /* continue_token should be zero as this hcall doesn't return H_BUSY. */
+    if (continue_token > 0) {
+        return H_P4;
+    }
+
+    /* Check if starting_scm_logical_addr is block aligned */
+    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
+                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
+        return H_P2;
+    }
+
+    size_to_unbind = no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+    if (no_of_scm_blocks_to_unbind == 0 || no_of_scm_blocks_to_unbind !=
+                               size_to_unbind / SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
+        return H_P3;
+    }
+
+    nvdimm = NVDIMM(drc->dev);
+    size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                   &error_abort);
+    addr = object_property_get_int(OBJECT(nvdimm), PC_DIMM_ADDR_PROP,
+                                   &error_abort);
+
+    range_init_nofail(&nvdimmrange, addr, size);
+    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_unbind);
+
+    if (!range_contains_range(&nvdimmrange, &blockrange)) {
+        return H_P3;
+    }
+
+    args[1] = no_of_scm_blocks_to_unbind;
+
+    /* let unplug take care of actual unbind */
+    return H_SUCCESS;
+}
+
+#define H_UNBIND_SCOPE_ALL 0x1
+#define H_UNBIND_SCOPE_DRC 0x2
+
+static target_ulong h_scm_unbind_all(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                     target_ulong opcode, target_ulong *args)
+{
+    uint64_t target_scope = args[0];
+    uint32_t drc_index = args[1];
+    uint64_t continue_token = args[2];
+    NVDIMMDevice *nvdimm;
+    uint64_t size;
+    uint64_t no_of_scm_blocks_unbound = 0;
+
+    /* continue_token should be zero as this hcall doesn't return H_BUSY. */
+    if (continue_token > 0) {
+        return H_P4;
+    }
+
+    if (target_scope == H_UNBIND_SCOPE_DRC) {
+        SpaprDrc *drc = spapr_drc_by_index(drc_index);
+
+        if (!drc || !drc->dev ||
+            spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+            return H_P2;
+        }
+
+        nvdimm = NVDIMM(drc->dev);
+        size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                       &error_abort);
+
+        no_of_scm_blocks_unbound = size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+    } else if (target_scope ==  H_UNBIND_SCOPE_ALL) {
+        GSList *list, *nvdimms;
+
+        nvdimms = nvdimm_get_device_list();
+        for (list = nvdimms; list; list = list->next) {
+            nvdimm = list->data;
+            size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                           &error_abort);
+
+            no_of_scm_blocks_unbound += size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+        }
+        g_slist_free(nvdimms);
+    } else {
+        return H_PARAMETER;
+    }
+
+    args[1] = no_of_scm_blocks_unbound;
+
+    /* let unplug take care of actual unbind */
+    return H_SUCCESS;
+}
+
+static void spapr_scm_register_types(void)
+{
+    /* qemu/scm specific hcalls */
+    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
+    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
+    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
+    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
+    spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
+}
+
+type_init(spapr_scm_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ed2de4bae5..633ff5202b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -287,6 +287,7 @@ struct SpaprMachineState {
 #define H_P7              -60
 #define H_P8              -61
 #define H_P9              -62
+#define H_OVERLAP         -68
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -494,8 +495,13 @@ struct SpaprMachineState {
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
+#define H_SCM_READ_METADATA     0x3E4
+#define H_SCM_WRITE_METADATA    0x3E8
+#define H_SCM_BIND_MEM          0x3EC
+#define H_SCM_UNBIND_MEM        0x3F0
+#define H_SCM_UNBIND_ALL        0x3FC
 
-#define MAX_HCALL_OPCODE        H_INT_RESET
+#define MAX_HCALL_OPCODE        H_SCM_UNBIND_ALL
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.


