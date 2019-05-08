Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE263C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7585A21019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7585A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOG1P-0001Yz-Jw
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:25:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFwC-0005JY-E3
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFw9-0000N7-TW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:57358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOFw9-00005t-HR
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 23:20:16 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 23:20:13 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com, mst@redhat.com, eblake@redhat.com,
	ehabkost@redhat.com, xiaoguangrong.eric@gmail.com
Date: Wed,  8 May 2019 14:17:26 +0800
Message-Id: <20190508061726.27631-12-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 11/11] hmat acpi: Implement _HMA method to
 update HMAT at runtime
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, tao3.xu@intel.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, rth@twiddle.net
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

Changes in v4 -> v3:
    - move AcpiHmaState from PCMachineState to MachineState
    to make HMAT more generalic (Igor)
    - use build_acpi_aml_common() introduced in patch 10/11 to
    simplify hmat_build_aml (Igor)
---
 hw/acpi/hmat.c          | 296 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/hmat.h          |  72 ++++++++++
 hw/core/machine.c       |   3 +
 hw/i386/acpi-build.c    |   2 +
 hw/i386/pc.c            |   3 +
 hw/i386/pc_piix.c       |   4 +
 hw/i386/pc_q35.c        |   4 +
 include/hw/boards.h     |   1 +
 include/qemu/typedefs.h |   1 +
 9 files changed, 386 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3a8c41162d..bc2dffd079 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -28,6 +28,7 @@
 #include "hw/i386/pc.h"
 #include "hw/acpi/hmat.h"
 #include "hw/nvram/fw_cfg.h"
+#include "hw/mem/nvdimm.h"
 
 static uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
 static uint32_t num_initiator, num_target;
@@ -262,6 +263,270 @@ static void hmat_build_hma(GArray *table_data, MachineState *ms)
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
+static void hmat_build_hma_buffer(MachineState *ms)
+{
+    HmatHmaBuffer *hma_buf = &(ms->acpi_hma_state->hma_buf);
+
+    /* Free the old hma buffer before new allocation. */
+    g_array_free(hma_buf->hma, true);
+
+    hma_buf->hma = g_array_new(false, true /* clear */, 1);
+    acpi_data_push(hma_buf->hma, 40);
+
+    /* build HMAT in a given buffer. */
+    hmat_build_hma(hma_buf->hma, ms);
+    hmat_build_header((void *)hma_buf->hma->data,
+                      "HMAT", hma_buf->hma->len, 1, NULL, NULL);
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
+void hmat_update(MachineState *ms)
+{
+    /* build HMAT in a given buffer. */
+    hmat_build_hma_buffer(ms);
+}
+
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms)
 {
     uint64_t hmat_start, hmat_len;
@@ -276,3 +541,34 @@ void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms)
                  (void *)(table_data->data + hmat_start),
                  "HMAT", hmat_len, 1, NULL, NULL);
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
+    build_acpi_aml_common(method, buf, buf_size,
+                          call_result, buf_name, dev,
+                          "RHMA", "_HMA",
+                          HMAM_RET_STATUS_SUCCESS,
+                          HMAM_RET_STATUS_HMA_CHANGED);
+}
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 8f563f19dd..7b24a3327f 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -102,6 +102,78 @@ struct HMAT_Cache_Info {
     uint16_t    num_smbios_handles;
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
+    /* detect if HMA support is enabled. */
+    bool is_enabled;
+
+    /* the data of the fw_cfg file HMAM_MEM_FILE. */
+    GArray *hmam_mem;
+
+    HmatHmaBuffer hma_buf;
+
+    /* the IO region used by OSPM to transfer control to QEMU. */
+    MemoryRegion io_mr;
+};
+
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
 void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms);
+void hmat_build_aml(Aml *dsdt);
+void hmat_init_acpi_state(AcpiHmaState *state, MemoryRegion *io,
+                          FWCfgState *fw_cfg, Object *owner);
+void hmat_update(MachineState *ms);
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 90bebb8d3a..f4a6dc5b2e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -23,6 +23,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/hmat.h"
 
 GlobalProperty hw_compat_4_0[] = {};
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
@@ -859,6 +860,7 @@ static void machine_initfn(Object *obj)
 
     if (mc->numa_supported) {
         ms->numa_state = g_new0(NumaState, 1);
+        ms->acpi_hma_state = g_new0(AcpiHmaState, 1);
     } else {
         ms->numa_state = NULL;
     }
@@ -883,6 +885,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
+    g_free(ms->acpi_hma_state);
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d3d8c93631..d869c5ae7b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1844,6 +1844,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_pci0_int(dsdt);
     }
 
+    hmat_build_aml(dsdt);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1c7b2a97bc..3021375144 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -77,6 +77,7 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "hw/acpi/hmat.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2130,6 +2131,8 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(ms->nvdimms_state);
     }
 
+    hmat_update(ms);
+
     hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
 out:
     error_propagate(errp, local_err);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5b38..966d98d619 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -58,6 +58,7 @@
 #include "migration/misc.h"
 #include "kvm_i386.h"
 #include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
 
 #define MAX_IDE_BUS 2
 
@@ -301,6 +302,9 @@ static void pc_init1(MachineState *machine,
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
+
+    hmat_init_acpi_state(machine->acpi_hma_state, system_io,
+                         pcms->fw_cfg, OBJECT(pcms));
 }
 
 /* Looking for a pc_compat_2_4() function? It doesn't exist.
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37dd350511..610b10467a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -54,6 +54,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -333,6 +334,9 @@ static void pc_q35_init(MachineState *machine)
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
+
+    hmat_init_acpi_state(machine->acpi_hma_state, system_io,
+                         pcms->fw_cfg, OBJECT(pcms));
 }
 
 #define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8609f923d9..e8d94a69b5 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -315,6 +315,7 @@ struct MachineState {
     CPUArchIdList *possible_cpus;
     struct NVDIMMState *nvdimms_state;
     NumaState *numa_state;
+    AcpiHmaState *acpi_hma_state;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index d971f5109e..a207cc1f88 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -5,6 +5,7 @@
    pull in all the real definitions.  */
 
 /* Please keep this list in case-insensitive alphabetical order */
+typedef struct AcpiHmaState AcpiHmaState;
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
-- 
2.17.1


