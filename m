Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F2CC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1F4216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1F4216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkYd-0001Tj-Ao
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hkkOf-0007DT-9T
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hkkOc-0007ms-RW
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:58468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hkkOc-0007fE-Cq
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:18:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jul 2019 00:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; d="scan'208";a="165681708"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2019 00:18:26 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Tue,  9 Jul 2019 15:15:18 +0800
Message-Id: <20190709071520.8745-13-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709071520.8745-1-tao3.xu@intel.com>
References: <20190709071520.8745-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [PATCH RESEND v6 12/14] hmat acpi: Implement _HMA
 method to update HMAT at runtime
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

OSPM evaluates HMAT only during system initialization.
Any changes to the HMAT state at runtime or information
regarding HMAT for hot plug are communicated using _HMA method.

_HMA is an optional object that enables the platform to provide
the OS with updated Heterogeneous Memory Attributes information
at runtime. _HMA provides OSPM with the latest HMAT in entirety
overriding existing HMAT.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v6:
    - move AcpiHmaState from PCMachineState to MachineState
    to make HMAT more generalic (Igor)
    - use build_acpi_aml_common() introduced in patch 10/11 to
    simplify hmat_build_aml (Igor)
    - Add _HMA only qemu use hmat-lb or hmat-cache
---
 hw/acpi/hmat.c        | 297 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/hmat.h        |  68 ++++++++++
 hw/core/machine.c     |   4 +
 hw/core/numa.c        |  10 ++
 hw/i386/acpi-build.c  |   4 +
 hw/i386/pc_piix.c     |   6 +
 hw/i386/pc_q35.c      |   6 +
 include/sysemu/numa.h |   5 +
 8 files changed, 400 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index a207581f11..33b9dd2e04 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -27,6 +27,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/numa.h"
 #include "hw/acpi/hmat.h"
+#include "hw/mem/nvdimm.h"
+#include "hw/nvram/fw_cfg.h"
 
 /*
  * ACPI 6.3:
@@ -238,6 +240,270 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
     }
 }
 
+static uint64_t
+hmat_hma_method_read(void *opaque, hwaddr addr, unsigned size)
+{
+    printf("BUG: we never read _HMA IO Port.\n");
+    return 0;
+}
+
+/* _HMA Method: read HMA data. */
+static void hmat_handle_hma_method(AcpiHmaState *state,
+                                   HmatHmamIn *in, hwaddr hmam_mem_addr)
+{
+    HmatHmaBuffer *hma_buf = &state->hma_buf;
+    HmatHmamOut *read_hma_out;
+    GArray *hma;
+    uint32_t read_len = 0, ret_status;
+    int size;
+
+    if (in != NULL) {
+        le32_to_cpus(&in->offset);
+    }
+
+    hma = hma_buf->hma;
+    if (in->offset > hma->len) {
+        ret_status = HMAM_RET_STATUS_INVALID;
+        goto exit;
+    }
+
+   /* It is the first time to read HMA. */
+    if (!in->offset) {
+        hma_buf->dirty = false;
+    } else if (hma_buf->dirty) {
+        /* HMA has been changed during Reading HMA. */
+        ret_status = HMAM_RET_STATUS_HMA_CHANGED;
+        goto exit;
+    }
+
+    ret_status = HMAM_RET_STATUS_SUCCESS;
+    read_len = MIN(hma->len - in->offset,
+                   HMAM_MEMORY_SIZE - 2 * sizeof(uint32_t));
+exit:
+    size = sizeof(HmatHmamOut) + read_len;
+    read_hma_out = g_malloc(size);
+
+    read_hma_out->len = cpu_to_le32(size);
+    read_hma_out->ret_status = cpu_to_le32(ret_status);
+    memcpy(read_hma_out->data, hma->data + in->offset, read_len);
+
+    cpu_physical_memory_write(hmam_mem_addr, read_hma_out, size);
+
+    g_free(read_hma_out);
+}
+
+static void
+hmat_hma_method_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    AcpiHmaState *state = opaque;
+    hwaddr hmam_mem_addr = val;
+    HmatHmamIn *in;
+
+    in = g_new(HmatHmamIn, 1);
+    cpu_physical_memory_read(hmam_mem_addr, in, sizeof(*in));
+
+    hmat_handle_hma_method(state, in, hmam_mem_addr);
+}
+
+static const MemoryRegionOps hmat_hma_method_ops = {
+    .read = hmat_hma_method_read,
+    .write = hmat_hma_method_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void hmat_init_hma_buffer(HmatHmaBuffer *hma_buf)
+{
+    hma_buf->hma = g_array_new(false, true /* clear */, 1);
+}
+
+static uint8_t hmat_acpi_table_checksum(uint8_t *buffer, uint32_t length)
+{
+    uint8_t sum = 0;
+    uint8_t *end = buffer + length;
+
+    while (buffer < end) {
+        sum = (uint8_t) (sum + *(buffer++));
+    }
+    return (uint8_t)(0 - sum);
+}
+
+static void hmat_build_header(AcpiTableHeader *h,
+             const char *sig, int len, uint8_t rev,
+             const char *oem_id, const char *oem_table_id)
+{
+    memcpy(&h->signature, sig, 4);
+    h->length = cpu_to_le32(len);
+    h->revision = rev;
+
+    if (oem_id) {
+        strncpy((char *)h->oem_id, oem_id, sizeof h->oem_id);
+    } else {
+        memcpy(h->oem_id, ACPI_BUILD_APPNAME6, 6);
+    }
+
+    if (oem_table_id) {
+        strncpy((char *)h->oem_table_id, oem_table_id, sizeof(h->oem_table_id));
+    } else {
+        memcpy(h->oem_table_id, ACPI_BUILD_APPNAME4, 4);
+        memcpy(h->oem_table_id + 4, sig, 4);
+    }
+
+    h->oem_revision = cpu_to_le32(1);
+    memcpy(h->asl_compiler_id, ACPI_BUILD_APPNAME4, 4);
+    h->asl_compiler_revision = cpu_to_le32(1);
+
+    /* Caculate the checksum of acpi table. */
+    h->checksum = 0;
+    h->checksum = hmat_acpi_table_checksum((uint8_t *)h, len);
+}
+
+static void hmat_build_hma_buffer(NumaState *nstat)
+{
+    HmatHmaBuffer *hma_buf = &(nstat->acpi_hma_state->hma_buf);
+
+    /* Free the old hma buffer before new allocation. */
+    g_array_free(hma_buf->hma, true);
+
+    hma_buf->hma = g_array_new(false, true /* clear */, 1);
+    acpi_data_push(hma_buf->hma, 40);
+
+    /* build HMAT in a given buffer. */
+    hmat_build_table_structs(hma_buf->hma, nstat);
+    hmat_build_header((void *)hma_buf->hma->data,
+                      "HMAT", hma_buf->hma->len, 2, NULL, NULL);
+    hma_buf->dirty = true;
+}
+
+static void hmat_build_common_aml(Aml *dev)
+{
+    Aml *method, *ifctx, *hmam_mem;
+    Aml *unsupport;
+    Aml *pckg, *pckg_index, *pckg_buf, *field;
+    Aml *hmam_out_buf, *hmam_out_buf_size;
+    uint8_t byte_list[1];
+
+    method = aml_method(HMA_COMMON_METHOD, 1, AML_SERIALIZED);
+    hmam_mem = aml_local(6);
+    hmam_out_buf = aml_local(7);
+
+    aml_append(method, aml_store(aml_name(HMAM_ACPI_MEM_ADDR), hmam_mem));
+
+    /* map _HMA memory and IO into ACPI namespace. */
+    aml_append(method, aml_operation_region(HMAM_IOPORT, AML_SYSTEM_IO,
+               aml_int(HMAM_ACPI_IO_BASE), HMAM_ACPI_IO_LEN));
+    aml_append(method, aml_operation_region(HMAM_MEMORY,
+               AML_SYSTEM_MEMORY, hmam_mem, HMAM_MEMORY_SIZE));
+
+    /*
+     * _HMAC notifier:
+     * HMAM_NOTIFY: write the address of DSM memory and notify QEMU to
+     *                    emulate the access.
+     *
+     * It is the IO port so that accessing them will cause VM-exit, the
+     * control will be transferred to QEMU.
+     */
+    field = aml_field(HMAM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
+                      AML_PRESERVE);
+    aml_append(field, aml_named_field(HMAM_NOTIFY,
+               sizeof(uint32_t) * BITS_PER_BYTE));
+    aml_append(method, field);
+
+    /*
+     * _HMAC input:
+     * HMAM_OFFSET: store the current offset of _HMA buffer.
+     *
+     * They are RAM mapping on host so that these accesses never cause VMExit.
+     */
+    field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
+                      AML_PRESERVE);
+    aml_append(field, aml_named_field(HMAM_OFFSET,
+               sizeof(typeof_field(HmatHmamIn, offset)) * BITS_PER_BYTE));
+    aml_append(method, field);
+
+    /*
+     * _HMAC output:
+     * HMAM_OUT_BUF_SIZE: the size of the buffer filled by QEMU.
+     * HMAM_OUT_BUF: the buffer QEMU uses to store the result.
+     *
+     * Since the page is reused by both input and out, the input data
+     * will be lost after storing new result into ODAT so we should fetch
+     * all the input data before writing the result.
+     */
+    field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
+                      AML_PRESERVE);
+    aml_append(field, aml_named_field(HMAM_OUT_BUF_SIZE,
+               sizeof(typeof_field(HmatHmamOut, len)) * BITS_PER_BYTE));
+    aml_append(field, aml_named_field(HMAM_OUT_BUF,
+       (sizeof(HmatHmamOut) - sizeof(uint32_t)) * BITS_PER_BYTE));
+    aml_append(method, field);
+
+    /*
+     * do not support any method if HMA memory address has not been
+     * patched.
+     */
+    unsupport = aml_if(aml_equal(hmam_mem, aml_int(0x0)));
+    byte_list[0] = HMAM_RET_STATUS_UNSUPPORT;
+    aml_append(unsupport, aml_return(aml_buffer(1, byte_list)));
+    aml_append(method, unsupport);
+
+    /* The parameter (Arg0) of _HMAC is a package which contains a buffer. */
+    pckg = aml_arg(0);
+    ifctx = aml_if(aml_and(aml_equal(aml_object_type(pckg),
+                   aml_int(4 /* Package */)) /* It is a Package? */,
+                   aml_equal(aml_sizeof(pckg), aml_int(1)) /* 1 element */,
+                   NULL));
+
+    pckg_index = aml_local(2);
+    pckg_buf = aml_local(3);
+    aml_append(ifctx, aml_store(aml_index(pckg, aml_int(0)), pckg_index));
+    aml_append(ifctx, aml_store(aml_derefof(pckg_index), pckg_buf));
+    aml_append(ifctx, aml_store(pckg_buf, aml_name(HMAM_OFFSET)));
+    aml_append(method, ifctx);
+
+    /*
+     * tell QEMU about the real address of HMA memory, then QEMU
+     * gets the control and fills the result in _HMAC memory.
+     */
+    aml_append(method, aml_store(hmam_mem, aml_name(HMAM_NOTIFY)));
+
+    hmam_out_buf_size = aml_local(1);
+    /* RLEN is not included in the payload returned to guest. */
+    aml_append(method, aml_subtract(aml_name(HMAM_OUT_BUF_SIZE),
+                                aml_int(4), hmam_out_buf_size));
+    aml_append(method, aml_store(aml_shiftleft(hmam_out_buf_size, aml_int(3)),
+                                 hmam_out_buf_size));
+    aml_append(method, aml_create_field(aml_name(HMAM_OUT_BUF),
+                                aml_int(0), hmam_out_buf_size, "OBUF"));
+    aml_append(method, aml_concatenate(aml_buffer(0, NULL), aml_name("OBUF"),
+                                hmam_out_buf));
+    aml_append(method, aml_return(hmam_out_buf));
+    aml_append(dev, method);
+}
+
+void hmat_init_acpi_state(AcpiHmaState *state, MemoryRegion *io,
+                          FWCfgState *fw_cfg, Object *owner)
+{
+    memory_region_init_io(&state->io_mr, owner, &hmat_hma_method_ops, state,
+                          "hma-acpi-io", HMAM_ACPI_IO_LEN);
+    memory_region_add_subregion(io, HMAM_ACPI_IO_BASE, &state->io_mr);
+
+    state->hmam_mem = g_array_new(false, true /* clear */, 1);
+    fw_cfg_add_file(fw_cfg, HMAM_MEM_FILE, state->hmam_mem->data,
+                    state->hmam_mem->len);
+
+    hmat_init_hma_buffer(&state->hma_buf);
+}
+
+void hmat_update(NumaState *nstat)
+{
+    /* build HMAT in a given buffer. */
+    hmat_build_hma_buffer(nstat);
+}
+
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
 {
     uint64_t hmat_start;
@@ -253,3 +519,34 @@ void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
                  (void *)(table_data->data + hmat_start),
                  "HMAT", table_data->len - hmat_start, 2, NULL, NULL);
 }
+
+void hmat_build_aml(Aml *dev)
+{
+    Aml *method, *pkg, *buf, *buf_name, *buf_size, *call_result;
+
+    hmat_build_common_aml(dev);
+
+    buf = aml_local(0);
+    buf_size = aml_local(1);
+    buf_name = aml_local(2);
+
+    aml_append(dev, aml_name_decl(HMAM_RHMA_STATUS, aml_int(0)));
+
+    /* build helper function, RHMA. */
+    method = aml_method("RHMA", 1, AML_SERIALIZED);
+    aml_append(method, aml_name_decl("OFST", aml_int(0)));
+
+    /* prepare input package. */
+    pkg = aml_package(1);
+    aml_append(method, aml_store(aml_arg(0), aml_name("OFST")));
+    aml_append(pkg, aml_name("OFST"));
+
+    /* call Read HMA function. */
+    call_result = aml_call1(HMA_COMMON_METHOD, pkg);
+
+    aml_build_runtime_buf(method, buf, buf_size,
+                          call_result, buf_name, dev,
+                          "RHMA", "_HMA",
+                          HMAM_RET_STATUS_SUCCESS,
+                          HMAM_RET_STATUS_HMA_CHANGED);
+}
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index ba655281cc..937d5ee6dc 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -99,6 +99,74 @@ struct HMAT_Cache_Info {
     uint16_t    line_size;
 };
 
+#define HMAM_MEMORY_SIZE    4096
+#define HMAM_MEM_FILE       "etc/acpi/hma-mem"
+
+/*
+ * 32 bits IO port starting from 0x0a19 in guest is reserved for
+ * HMA ACPI emulation.
+ */
+#define HMAM_ACPI_IO_BASE     0x0a19
+#define HMAM_ACPI_IO_LEN      4
+
+#define HMAM_ACPI_MEM_ADDR  "HMTA"
+#define HMAM_MEMORY         "HRAM"
+#define HMAM_IOPORT         "HPIO"
+
+#define HMAM_NOTIFY         "NTFI"
+#define HMAM_OUT_BUF_SIZE   "RLEN"
+#define HMAM_OUT_BUF        "ODAT"
+
+#define HMAM_RHMA_STATUS    "RSTA"
+#define HMA_COMMON_METHOD   "HMAC"
+#define HMAM_OFFSET         "OFFT"
+
+#define HMAM_RET_STATUS_SUCCESS        0 /* Success */
+#define HMAM_RET_STATUS_UNSUPPORT      1 /* Not Supported */
+#define HMAM_RET_STATUS_INVALID        2 /* Invalid Input Parameters */
+#define HMAM_RET_STATUS_HMA_CHANGED    0x100 /* HMA Changed */
+
+/*
+ * HmatHmaBuffer:
+ * @hma: HMA buffer with the updated HMAT. It is updated when
+ *   the memory device is plugged or unplugged.
+ * @dirty: It allows OSPM to detect changes and restart read if there is any.
+ */
+struct HmatHmaBuffer {
+    GArray *hma;
+    bool dirty;
+};
+typedef struct HmatHmaBuffer HmatHmaBuffer;
+
+struct AcpiHmaState {
+    /* the data of the fw_cfg file HMAM_MEM_FILE. */
+    GArray *hmam_mem;
+
+    HmatHmaBuffer hma_buf;
+
+    /* the IO region used by OSPM to transfer control to QEMU. */
+    MemoryRegion io_mr;
+};
+typedef struct AcpiHmaState AcpiHmaState;
+
+struct HmatHmamIn {
+    /* the offset in the _HMA buffer */
+    uint32_t offset;
+} QEMU_PACKED;
+typedef struct HmatHmamIn HmatHmamIn;
+
+struct HmatHmamOut {
+    /* the size of buffer filled by QEMU. */
+    uint32_t len;
+    uint32_t ret_status;   /* return status code. */
+    uint8_t data[4088];
+} QEMU_PACKED;
+typedef struct HmatHmamOut HmatHmamOut;
+
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat);
+void hmat_build_aml(Aml *dsdt);
+void hmat_init_acpi_state(AcpiHmaState *state, MemoryRegion *io,
+                          FWCfgState *fw_cfg, Object *owner);
+void hmat_update(NumaState *nstat);
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 063cb7923c..234cf63aad 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -26,6 +26,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/hmat.h"
 
 GlobalProperty hw_compat_4_0[] = {
     { "VGA",            "edid", "false" },
@@ -1000,6 +1001,9 @@ static void machine_finalize(Object *obj)
     g_free(ms->firmware);
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
+    if (ms->numa_state->hma_enabled) {
+        g_free(ms->numa_state->acpi_hma_state);
+    }
     g_free(ms->numa_state);
 }
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 75db35ac19..5ed53ef05e 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -251,6 +251,11 @@ void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
         return;
     }
 
+    if (!ms->numa_state->hma_enabled && !ms->numa_state->acpi_hma_state) {
+        ms->numa_state->hma_enabled = true;
+        ms->numa_state->acpi_hma_state = g_new0(AcpiHmaState, 1);
+    }
+
     if (node->has_latency) {
         hmat_lb = ms->numa_state->hmat_lb[node->hierarchy][node->data_type];
 
@@ -352,6 +357,11 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
         return;
     }
 
+    if (!ms->numa_state->hma_enabled && !ms->numa_state->acpi_hma_state) {
+        ms->numa_state->hma_enabled = true;
+        ms->numa_state->acpi_hma_state = g_new0(AcpiHmaState, 1);
+    }
+
     hmat_cache = g_malloc0(sizeof(*hmat_cache));
 
     hmat_cache->mem_proximity = node->node_id;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6eee709258..e38fbbcc37 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1857,6 +1857,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_pci0_int(dsdt);
     }
 
+    if (machine->numa_state->hma_enabled) {
+        hmat_build_aml(dsdt);
+    }
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c2280c72ef..9ef92ba4cb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -59,6 +59,7 @@
 #include "migration/misc.h"
 #include "kvm_i386.h"
 #include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
 
 #define MAX_IDE_BUS 2
 
@@ -307,6 +308,11 @@ else {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
+
+    if (machine->numa_state->hma_enabled) {
+        hmat_init_acpi_state(machine->numa_state->acpi_hma_state, system_io,
+                             pcms->fw_cfg, OBJECT(pcms));
+    }
 }
 
 /* Looking for a pc_compat_2_4() function? It doesn't exist.
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 397e1fdd2f..0e42698b8e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -54,6 +54,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -333,6 +334,11 @@ static void pc_q35_init(MachineState *machine)
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
+
+    if (machine->numa_state->hma_enabled) {
+        hmat_init_acpi_state(machine->numa_state->acpi_hma_state, system_io,
+                             pcms->fw_cfg, OBJECT(pcms));
+    }
 }
 
 #define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 3649262918..ba040b8b76 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -38,6 +38,11 @@ struct NumaState {
 
     /* Memory Side Cache Information Structure */
     HMAT_Cache_Info *hmat_cache[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
+
+    /* Detect if HMA support is enabled. */
+    bool hma_enabled;
+
+    struct AcpiHmaState *acpi_hma_state;
 };
 typedef struct NumaState NumaState;
 
-- 
2.20.1


