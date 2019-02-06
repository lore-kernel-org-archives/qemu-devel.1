Received: from eggs.gnu.org ([209.51.188.92]:52896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1grFja-0003Wl-9l
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1grFjY-0005Ad-D8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:26:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1grFjX-00058y-W3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:26:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x165OL5S041928
	for <qemu-devel@nongnu.org>; Wed, 6 Feb 2019 00:26:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qfmq5bp90-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 00:26:50 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Wed, 6 Feb 2019 05:26:48 -0000
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Tue, 05 Feb 2019 23:26:41 -0600
In-Reply-To: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154943079488.27958.9812294887340963535.stgit@lep8c.aus.stglabs.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 4/4] spapr: Add Hcalls to support PAPR
 NVDIMM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, sbhat@linux.ibm.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, imammedo@redhat.com, david@gibson.dropbear.id.au

This patch implements few of the necessary hcalls for the nvdimm support.

PAPR semantics is such that each NVDIMM device is comprising of multiple
SCM(Storage Class Memory) blocks. The guest requests the hypervisor to bind
each of the SCM blocks of the NVDIMM device using hcalls. There can be
SCM block unbind requests in case of driver errors or unplug(not supported now)
use cases. The NVDIMM label read/writes are done through hcalls.

Since each virtual NVDIMM device is divided into multiple SCM blocks, the bind,
unbind, and queries using hcalls on those blocks can come independently. This
doesn't fit well into the qemu device semantics, where the map/unmap are done
at the (whole)device/object level granularity. The patch doesnt actually
bind/unbind on hcalls but let it happen at the object_add/del phase itself
instead.

The guest kernel makes bind/unbind requests for the virtual NVDIMM device at the
region level granularity. Without interleaving, each virtual NVDIMM device is
presented as separate region. There is no way to configure the virtual NVDIMM
interleaving for the guests today. So, there is no way a partial bind/unbind
request can come for the vNVDIMM in a hcall for a subset of SCM blocks of a
virtual NVDIMM. Hence it is safe to do bind/unbind everything during the
object_add/del.

The kernel today is not using the hcalls - h_scm_mem_query, h_scm_mem_clear,
h_scm_query_logical_mem_binding and h_scm_query_block_mem_binding. They are just
stubs in this patch.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c   |  230 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |   12 ++-
 2 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 17bcaa3822..40553e80d6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,11 +3,13 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_drc.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
@@ -16,6 +18,7 @@
 #include "hw/ppc/spapr_ovec.h"
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/nvdimm.h"
 
 struct LPCRSyncState {
     target_ulong value;
@@ -1808,6 +1811,222 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
+                                        sPAPRMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t offset = args[1];
+    uint8_t numBytesToRead = args[2];
+    sPAPRDRConnector *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm = NULL;
+    NVDIMMClass *ddc = NULL;
+
+    if (numBytesToRead != 1 && numBytesToRead != 2 &&
+        numBytesToRead != 4 && numBytesToRead != 8) {
+        return H_P3;
+    }
+
+    if (offset & (numBytesToRead - 1)) {
+        return H_P2;
+    }
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    nvdimm = NVDIMM(drc->dev);
+    ddc = NVDIMM_GET_CLASS(nvdimm);
+
+    ddc->read_label_data(nvdimm, &args[0], numBytesToRead, offset);
+
+    return H_SUCCESS;
+}
+
+
+static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
+                                         sPAPRMachineState *spapr,
+                                         target_ulong opcode,
+                                         target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t offset = args[1];
+    uint64_t data = args[2];
+    int8_t numBytesToWrite = args[3];
+    sPAPRDRConnector *drc = spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm = NULL;
+    DeviceState *dev = NULL;
+    NVDIMMClass *ddc = NULL;
+
+    if (numBytesToWrite != 1 && numBytesToWrite != 2 &&
+        numBytesToWrite != 4 && numBytesToWrite != 8) {
+        return H_P4;
+    }
+
+    if (offset & (numBytesToWrite - 1)) {
+        return H_P2;
+    }
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    dev = drc->dev;
+    nvdimm = NVDIMM(dev);
+    if (offset >= nvdimm->label_size) {
+        return H_P3;
+    }
+
+    ddc = NVDIMM_GET_CLASS(nvdimm);
+
+    ddc->write_label_data(nvdimm, &data, numBytesToWrite, offset);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index = args[0];
+    uint64_t starting_index = args[1];
+    uint64_t no_of_scm_blocks_to_bind = args[2];
+    uint64_t target_logical_mem_addr = args[3];
+    uint64_t continue_token = args[4];
+    uint64_t size;
+    uint64_t total_no_of_scm_blocks;
+
+    sPAPRDRConnector *drc = spapr_drc_by_index(drc_index);
+    hwaddr addr;
+    DeviceState *dev = NULL;
+    PCDIMMDevice *dimm = NULL;
+    Error *local_err = NULL;
+
+    if (drc && spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    dev = drc->dev;
+    dimm = PC_DIMM(dev);
+
+    size = object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_SIZE_PROP, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return H_PARAMETER;
+    }
+
+    total_no_of_scm_blocks = size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    if (starting_index > total_no_of_scm_blocks) {
+        return H_P2;
+    }
+
+    if ((starting_index + no_of_scm_blocks_to_bind) > total_no_of_scm_blocks) {
+        return H_P3;
+    }
+
+    /* Currently qemu assigns the address. */
+    if (target_logical_mem_addr != 0xffffffffffffffff) {
+        return H_OVERLAP;
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
+    /* NB : Already bound, Return target logical address in R4 */
+    addr = object_property_get_uint(OBJECT(dimm),
+                                    PC_DIMM_ADDR_PROP, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return H_PARAMETER;
+    }
+
+    args[1] = addr;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint64_t starting_scm_logical_addr = args[0];
+    uint64_t no_of_scm_blocks_to_unbind = args[1];
+    uint64_t size_to_unbind;
+    uint64_t continue_token = args[2];
+    Range as = range_empty;
+    GSList *dimms = NULL;
+    bool valid = false;
+
+    size_to_unbind = no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    /* Check if starting_scm_logical_addr is block aligned */
+    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
+                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
+        return H_PARAMETER;
+    }
+
+    range_init_nofail(&as, starting_scm_logical_addr, size_to_unbind);
+
+    dimms = nvdimm_get_device_list();
+    for (; dimms; dimms = dimms->next) {
+        NVDIMMDevice *nvdimm = dimms->data;
+        Range tmp;
+        int size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                           NULL);
+        int addr = object_property_get_int(OBJECT(nvdimm), PC_DIMM_ADDR_PROP,
+                                           NULL);
+        range_init_nofail(&tmp, addr, size);
+
+        if (range_contains_range(&tmp, &as)) {
+            valid = true;
+            break;
+        }
+    }
+
+    if (!valid) {
+        return H_P2;
+    }
+
+    if (continue_token > 0) {
+        return H_P3;
+    }
+
+    /*NB : dont do anything, let object_del take care of this for now. */
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_query_block_mem_binding(PowerPCCPU *cpu,
+                                                  sPAPRMachineState *spapr,
+                                                  target_ulong opcode,
+                                                  target_ulong *args)
+{
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_query_logical_mem_binding(PowerPCCPU *cpu,
+                                                    sPAPRMachineState *spapr,
+                                                    target_ulong opcode,
+                                                    target_ulong *args)
+{
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_mem_query(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1907,6 +2126,17 @@ static void hypercall_register_types(void)
     /* qemu/KVM-PPC specific hcalls */
     spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
 
+    /* qemu/scm specific hcalls */
+    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
+    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
+    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
+    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
+    spapr_register_hypercall(H_SCM_QUERY_BLOCK_MEM_BINDING,
+                             h_scm_query_block_mem_binding);
+    spapr_register_hypercall(H_SCM_QUERY_LOGICAL_MEM_BINDING,
+                             h_scm_query_logical_mem_binding);
+    spapr_register_hypercall(H_SCM_MEM_QUERY, h_scm_mem_query);
+
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 21a9709afe..28249567f4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -268,6 +268,7 @@ struct sPAPRMachineState {
 #define H_P7              -60
 #define H_P8              -61
 #define H_P9              -62
+#define H_OVERLAP         -68
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -473,8 +474,15 @@ struct sPAPRMachineState {
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
-
-#define MAX_HCALL_OPCODE        H_INT_RESET
+#define H_SCM_READ_METADATA     0x3E4
+#define H_SCM_WRITE_METADATA     0x3E8
+#define H_SCM_BIND_MEM          0x3EC
+#define H_SCM_UNBIND_MEM        0x3F0
+#define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
+#define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
+#define H_SCM_MEM_QUERY         0x3FC
+
+#define MAX_HCALL_OPCODE        H_SCM_MEM_QUERY
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
