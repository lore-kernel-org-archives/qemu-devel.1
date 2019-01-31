Received: from eggs.gnu.org ([209.51.188.92]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6co-00079R-QO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6cl-0003Dv-OT
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:19:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:58183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gp6cl-000313-8t
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:59 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 31 Jan 2019 15:16:58 +0800
Message-Id: <20190131071658.29120-9-tao3.xu@intel.com>
In-Reply-To: <20190131071658.29120-1-tao3.xu@intel.com>
References: <20190131071658.29120-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v3 8/8] acpi: rewrite the _FIT method to use it
 in _HMA method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, karl.heubaum@oracle.com, jingqi.liu@intel.com, danmei.wei@intel.com, qemu-devel@nongnu.org, tao3.xu@intel.com

Per Igor's comment, rewrite NFIT code to build _HMA method.

We rewirte the function nvdimm_build_common_dsm(Aml *dev) and
nvdimm_build_fit(Aml *dev) in hw/acpi/nvdimm.c so that we can use
method_number as input to decide to generate _FIT or _HMA method.

Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/acpi/hmat.c          | 208 +--------------------
 hw/acpi/hmat.h          |   1 -
 hw/acpi/nvdimm.c        | 389 ++++++++++++++++++++++++++--------------
 hw/i386/acpi-build.c    |   2 +-
 include/hw/mem/nvdimm.h |  11 ++
 5 files changed, 270 insertions(+), 341 deletions(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index d802e1cce1..37ece80101 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -100,10 +100,10 @@ static void classify_proximity_domains(void)
 
 static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
 {
-/*
- * The Proximity Domain of System Physical Address ranges defined
- * in the HMAT, NFIT and SRAT tables shall match each other.
- */
+    /*
+     * The Proximity Domain of System Physical Address ranges defined
+     * in the HMAT, NFIT and SRAT tables shall match each other.
+     */
 
     GSList *device_list = NULL;
     AcpiHmatLBInfo *hmat_lb;
@@ -386,112 +386,6 @@ static void hmat_build_hma_buffer(PCMachineState *pcms)
     hma_buf->dirty = true;
 }
 
-static void hmat_build_common_aml(Aml *dev)
-{
-    Aml *method, *ifctx, *hmam_mem;
-    Aml *unsupport;
-    Aml *pckg, *pckg_index, *pckg_buf, *field;
-    Aml *hmam_out_buf, *hmam_out_buf_size;
-    uint8_t byte_list[1];
-
-    method = aml_method(HMA_COMMON_METHOD, 1, AML_SERIALIZED);
-    hmam_mem = aml_local(6);
-    hmam_out_buf = aml_local(7);
-
-    aml_append(method, aml_store(aml_name(HMAM_ACPI_MEM_ADDR), hmam_mem));
-
-    /* map _HMA memory and IO into ACPI namespace. */
-    aml_append(method, aml_operation_region(HMAM_IOPORT, AML_SYSTEM_IO,
-               aml_int(HMAM_ACPI_IO_BASE), HMAM_ACPI_IO_LEN));
-    aml_append(method, aml_operation_region(HMAM_MEMORY,
-               AML_SYSTEM_MEMORY, hmam_mem, HMAM_MEMORY_SIZE));
-
-    /*
-     * _HMAC notifier:
-     * HMAM_NOTIFY: write the address of DSM memory and notify QEMU to
-     *                    emulate the access.
-     *
-     * It is the IO port so that accessing them will cause VM-exit, the
-     * control will be transferred to QEMU.
-     */
-    field = aml_field(HMAM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
-                      AML_PRESERVE);
-    aml_append(field, aml_named_field(HMAM_NOTIFY,
-               sizeof(uint32_t) * BITS_PER_BYTE));
-    aml_append(method, field);
-
-    /*
-     * _HMAC input:
-     * HMAM_OFFSET: store the current offset of _HMA buffer.
-     *
-     * They are RAM mapping on host so that these accesses never cause VMExit.
-     */
-    field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
-                      AML_PRESERVE);
-    aml_append(field, aml_named_field(HMAM_OFFSET,
-               sizeof(typeof_field(HmatHmamIn, offset)) * BITS_PER_BYTE));
-    aml_append(method, field);
-
-    /*
-     * _HMAC output:
-     * HMAM_OUT_BUF_SIZE: the size of the buffer filled by QEMU.
-     * HMAM_OUT_BUF: the buffer QEMU uses to store the result.
-     *
-     * Since the page is reused by both input and out, the input data
-     * will be lost after storing new result into ODAT so we should fetch
-     * all the input data before writing the result.
-     */
-    field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
-                      AML_PRESERVE);
-    aml_append(field, aml_named_field(HMAM_OUT_BUF_SIZE,
-               sizeof(typeof_field(HmatHmamOut, len)) * BITS_PER_BYTE));
-    aml_append(field, aml_named_field(HMAM_OUT_BUF,
-       (sizeof(HmatHmamOut) - sizeof(uint32_t)) * BITS_PER_BYTE));
-    aml_append(method, field);
-
-    /*
-     * do not support any method if HMA memory address has not been
-     * patched.
-     */
-    unsupport = aml_if(aml_equal(hmam_mem, aml_int(0x0)));
-    byte_list[0] = HMAM_RET_STATUS_UNSUPPORT;
-    aml_append(unsupport, aml_return(aml_buffer(1, byte_list)));
-    aml_append(method, unsupport);
-
-    /* The parameter (Arg0) of _HMAC is a package which contains a buffer. */
-    pckg = aml_arg(0);
-    ifctx = aml_if(aml_and(aml_equal(aml_object_type(pckg),
-                   aml_int(4 /* Package */)) /* It is a Package? */,
-                   aml_equal(aml_sizeof(pckg), aml_int(1)) /* 1 element */,
-                   NULL));
-
-    pckg_index = aml_local(2);
-    pckg_buf = aml_local(3);
-    aml_append(ifctx, aml_store(aml_index(pckg, aml_int(0)), pckg_index));
-    aml_append(ifctx, aml_store(aml_derefof(pckg_index), pckg_buf));
-    aml_append(ifctx, aml_store(pckg_buf, aml_name(HMAM_OFFSET)));
-    aml_append(method, ifctx);
-
-    /*
-     * tell QEMU about the real address of HMA memory, then QEMU
-     * gets the control and fills the result in _HMAC memory.
-     */
-    aml_append(method, aml_store(hmam_mem, aml_name(HMAM_NOTIFY)));
-
-    hmam_out_buf_size = aml_local(1);
-    /* RLEN is not included in the payload returned to guest. */
-    aml_append(method, aml_subtract(aml_name(HMAM_OUT_BUF_SIZE),
-                                aml_int(4), hmam_out_buf_size));
-    aml_append(method, aml_store(aml_shiftleft(hmam_out_buf_size, aml_int(3)),
-                                 hmam_out_buf_size));
-    aml_append(method, aml_create_field(aml_name(HMAM_OUT_BUF),
-                                aml_int(0), hmam_out_buf_size, "OBUF"));
-    aml_append(method, aml_concatenate(aml_buffer(0, NULL), aml_name("OBUF"),
-                                hmam_out_buf));
-    aml_append(method, aml_return(hmam_out_buf));
-    aml_append(dev, method);
-}
-
 void hmat_init_acpi_state(AcpiHmaState *state, MemoryRegion *io,
                           FWCfgState *fw_cfg, Object *owner)
 {
@@ -528,97 +422,3 @@ void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
                  (void *)(table_data->data + hmat_start),
                  "HMAT", hmat_len, 1, NULL, NULL);
 }
-
-void hmat_build_aml(Aml *dev)
-{
-    Aml *method, *pkg, *buf, *buf_size, *offset, *call_result;
-    Aml *whilectx, *ifcond, *ifctx, *elsectx, *hma;
-
-    hmat_build_common_aml(dev);
-
-    buf = aml_local(0);
-    buf_size = aml_local(1);
-    hma = aml_local(2);
-
-    aml_append(dev, aml_name_decl(HMAM_RHMA_STATUS, aml_int(0)));
-
-    /* build helper function, RHMA. */
-    method = aml_method("RHMA", 1, AML_SERIALIZED);
-    aml_append(method, aml_name_decl("OFST", aml_int(0)));
-
-    /* prepare input package. */
-    pkg = aml_package(1);
-    aml_append(method, aml_store(aml_arg(0), aml_name("OFST")));
-    aml_append(pkg, aml_name("OFST"));
-
-    /* call Read HMA function. */
-    call_result = aml_call1(HMA_COMMON_METHOD, pkg);
-    aml_append(method, aml_store(call_result, buf));
-
-    /* handle _HMAC result. */
-    aml_append(method, aml_create_dword_field(buf,
-               aml_int(0) /* offset at byte 0 */, "STAU"));
-
-    aml_append(method, aml_store(aml_name("STAU"),
-                                 aml_name(HMAM_RHMA_STATUS)));
-
-    /* if something is wrong during _HMAC. */
-    ifcond = aml_equal(aml_int(HMAM_RET_STATUS_SUCCESS),
-                       aml_name("STAU"));
-    ifctx = aml_if(aml_lnot(ifcond));
-    aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
-    aml_append(method, ifctx);
-
-    aml_append(method, aml_store(aml_sizeof(buf), buf_size));
-    aml_append(method, aml_subtract(buf_size,
-                                    aml_int(4) /* the size of "STAU" */,
-                                    buf_size));
-
-    /* if we read the end of hma. */
-    ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
-    aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
-    aml_append(method, ifctx);
-
-    aml_append(method, aml_create_field(buf,
-                            aml_int(4 * BITS_PER_BYTE), /* offset at byte 4.*/
-                            aml_shiftleft(buf_size, aml_int(3)), "BUFF"));
-    aml_append(method, aml_return(aml_name("BUFF")));
-    aml_append(dev, method);
-
-    /* build _HMA. */
-    method = aml_method("_HMA", 0, AML_SERIALIZED);
-    offset = aml_local(3);
-
-    aml_append(method, aml_store(aml_buffer(0, NULL), hma));
-    aml_append(method, aml_store(aml_int(0), offset));
-
-    whilectx = aml_while(aml_int(1));
-    aml_append(whilectx, aml_store(aml_call1("RHMA", offset), buf));
-    aml_append(whilectx, aml_store(aml_sizeof(buf), buf_size));
-
-    /*
-     * if hma buffer was changed during RHMA, read from the beginning
-     * again.
-     */
-    ifctx = aml_if(aml_equal(aml_name(HMAM_RHMA_STATUS),
-                             aml_int(HMAM_RET_STATUS_HMA_CHANGED)));
-    aml_append(ifctx, aml_store(aml_buffer(0, NULL), hma));
-    aml_append(ifctx, aml_store(aml_int(0), offset));
-    aml_append(whilectx, ifctx);
-
-    elsectx = aml_else();
-
-    /* finish hma read if no data is read out. */
-    ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
-    aml_append(ifctx, aml_return(hma));
-    aml_append(elsectx, ifctx);
-
-    /* update the offset. */
-    aml_append(elsectx, aml_add(offset, buf_size, offset));
-    /* append the data we read out to the hma buffer. */
-    aml_append(elsectx, aml_concatenate(hma, buf, hma));
-    aml_append(whilectx, elsectx);
-    aml_append(method, whilectx);
-
-    aml_append(dev, method);
-}
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index 4f2c2df91e..7973a5d41d 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -31,7 +31,6 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/aml-build.h"
 
-#define ACPI_HMAT_SPA               0
 #define ACPI_HMAT_LB_INFO           1
 #define ACPI_HMAT_CACHE_INFO        2
 
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index e53b2cb681..795236bb1b 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -32,6 +32,7 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/hmat.h"
 
 static int nvdimm_device_list(Object *obj, void *opaque)
 {
@@ -959,26 +960,49 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
 
 #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
 
-static void nvdimm_build_common_dsm(Aml *dev)
+static void nvdimm_build_common_dsm(Aml *dev, uint16_t method_number)
 {
-    Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
+    Aml *method = NULL, *ifctx = NULL, *function = NULL;
+    Aml *handle = NULL, *uuid = NULL, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
-    Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_size;
+    Aml *pckg = NULL, *pckg_index, *pckg_buf, *field;
+    Aml *dsm_out_buf, *dsm_out_buf_size;
     uint8_t byte_list[1];
+    uint16_t acpi_io_base = 0;
+    const char *acpi_mem_addr = NULL, *ioport = NULL, *memory = NULL;
+    const char *aml_offset = NULL;
+
+    switch (method_number) {
+    case 0: /* build common dsm in _FIT method */
+        acpi_mem_addr = NVDIMM_ACPI_MEM_ADDR;
+        ioport = NVDIMM_DSM_IOPORT;
+        acpi_io_base = NVDIMM_ACPI_IO_BASE;
+        memory = NVDIMM_DSM_MEMORY;
+        aml_offset = NVDIMM_DSM_ARG3;
+        method = aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
+        uuid = aml_arg(0);
+        function = aml_arg(2);
+        handle = aml_arg(4);
+        break;
+    case 1: /* build common dsm in _HMA method */
+        acpi_mem_addr = HMAM_ACPI_MEM_ADDR;
+        ioport = HMAM_IOPORT;
+        acpi_io_base = HMAM_ACPI_IO_BASE;
+        memory = HMAM_MEMORY;
+        aml_offset = HMAM_OFFSET;
+        method = aml_method(HMA_COMMON_METHOD, 1, AML_SERIALIZED);
+        break;
+    }
 
-    method = aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
-    uuid = aml_arg(0);
-    function = aml_arg(2);
-    handle = aml_arg(4);
     dsm_mem = aml_local(6);
     dsm_out_buf = aml_local(7);
 
-    aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem));
+    aml_append(method, aml_store(aml_name("%s", acpi_mem_addr), dsm_mem));
 
     /* map DSM memory and IO into ACPI namespace. */
-    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTEM_IO,
-               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
-    aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
+    aml_append(method, aml_operation_region(ioport, AML_SYSTEM_IO,
+               aml_int(acpi_io_base), NVDIMM_ACPI_IO_LEN));
+    aml_append(method, aml_operation_region(memory,
                AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
 
     /*
@@ -989,122 +1013,191 @@ static void nvdimm_build_common_dsm(Aml *dev)
      * It is the IO port so that accessing them will cause VM-exit, the
      * control will be transferred to QEMU.
      */
-    field = aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
+    field = aml_field(ioport, AML_DWORD_ACC, AML_NOLOCK,
                       AML_PRESERVE);
     aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
                sizeof(uint32_t) * BITS_PER_BYTE));
     aml_append(method, field);
 
-    /*
-     * DSM input:
-     * NVDIMM_DSM_HANDLE: store device's handle, it's zero if the _DSM call
-     *                    happens on NVDIMM Root Device.
-     * NVDIMM_DSM_REVISION: store the Arg1 of _DSM call.
-     * NVDIMM_DSM_FUNCTION: store the Arg2 of _DSM call.
-     * NVDIMM_DSM_ARG3: store the Arg3 of _DSM call which is a Package
-     *                  containing function-specific arguments.
-     *
-     * They are RAM mapping on host so that these accesses never cause
-     * VM-EXIT.
-     */
-    field = aml_field(NVDIMM_DSM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
-                      AML_PRESERVE);
-    aml_append(field, aml_named_field(NVDIMM_DSM_HANDLE,
-               sizeof(typeof_field(NvdimmDsmIn, handle)) * BITS_PER_BYTE));
-    aml_append(field, aml_named_field(NVDIMM_DSM_REVISION,
-               sizeof(typeof_field(NvdimmDsmIn, revision)) * BITS_PER_BYTE));
-    aml_append(field, aml_named_field(NVDIMM_DSM_FUNCTION,
-               sizeof(typeof_field(NvdimmDsmIn, function)) * BITS_PER_BYTE));
-    aml_append(field, aml_named_field(NVDIMM_DSM_ARG3,
-         (sizeof(NvdimmDsmIn) - offsetof(NvdimmDsmIn, arg3)) * BITS_PER_BYTE));
-    aml_append(method, field);
+    field = aml_field(memory, AML_DWORD_ACC, AML_NOLOCK, AML_PRESERVE);
+    switch (method_number) {
+    case 0: /* build common dsm in _FIT method */
+        /*
+         * DSM input:
+         * NVDIMM_DSM_HANDLE: store device's handle, it's zero if
+         *                    the _DSM call happens on NVDIMM Root
+         *                    Device.
+         * NVDIMM_DSM_REVISION: store the Arg1 of _DSM call.
+         * NVDIMM_DSM_FUNCTION: store the Arg2 of _DSM call.
+         * NVDIMM_DSM_ARG3: store the Arg3 of _DSM call which is a
+         *                  Package containing function-specific
+         *                  arguments.
+         *
+         * They are RAM mapping on host so that these accesses
+         * never cause VM-EXIT.
+         */
+        aml_append(field, aml_named_field(NVDIMM_DSM_HANDLE,
+                    sizeof(typeof_field(NvdimmDsmIn, handle)) *
+                    BITS_PER_BYTE));
+        aml_append(field, aml_named_field(NVDIMM_DSM_REVISION,
+                    sizeof(typeof_field(NvdimmDsmIn, revision)) *
+                    BITS_PER_BYTE));
+        aml_append(field, aml_named_field(NVDIMM_DSM_FUNCTION,
+                    sizeof(typeof_field(NvdimmDsmIn, function)) *
+                    BITS_PER_BYTE));
+        aml_append(field, aml_named_field(NVDIMM_DSM_ARG3,
+                    (sizeof(NvdimmDsmIn) - offsetof(NvdimmDsmIn, arg3)) *
+                    BITS_PER_BYTE));
+        aml_append(method, field);
 
-    /*
-     * DSM output:
-     * NVDIMM_DSM_OUT_BUF_SIZE: the size of the buffer filled by QEMU.
-     * NVDIMM_DSM_OUT_BUF: the buffer QEMU uses to store the result.
-     *
-     * Since the page is reused by both input and out, the input data
-     * will be lost after storing new result into ODAT so we should fetch
-     * all the input data before writing the result.
-     */
-    field = aml_field(NVDIMM_DSM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
-                      AML_PRESERVE);
-    aml_append(field, aml_named_field(NVDIMM_DSM_OUT_BUF_SIZE,
-               sizeof(typeof_field(NvdimmDsmOut, len)) * BITS_PER_BYTE));
-    aml_append(field, aml_named_field(NVDIMM_DSM_OUT_BUF,
-       (sizeof(NvdimmDsmOut) - offsetof(NvdimmDsmOut, data)) * BITS_PER_BYTE));
-    aml_append(method, field);
+        /*
+         * DSM output:
+         * NVDIMM_DSM_OUT_BUF_SIZE: the size of the buffer
+         *                          filled by QEMU.
+         * NVDIMM_DSM_OUT_BUF: the buffer QEMU uses to
+         *                     store the result.
+         *
+         * Since the page is reused by both input and out,
+         * the input data will be lost after storing new
+         * result into ODAT so we should fetch all the input
+         * data before writing the result.
+         */
+        field = aml_field(memory, AML_DWORD_ACC, AML_NOLOCK,
+                        AML_PRESERVE);
+        aml_append(field, aml_named_field(NVDIMM_DSM_OUT_BUF_SIZE,
+                sizeof(typeof_field(NvdimmDsmOut, len)) *
+                BITS_PER_BYTE));
+        aml_append(field, aml_named_field(NVDIMM_DSM_OUT_BUF,
+                (sizeof(NvdimmDsmOut) - offsetof(NvdimmDsmOut, data)) *
+                BITS_PER_BYTE));
+        aml_append(method, field);
 
-    /*
-     * do not support any method if DSM memory address has not been
-     * patched.
-     */
-    unpatched = aml_equal(dsm_mem, aml_int(0x0));
+        /*
+         * do not support any method if DSM memory address has not been
+         * patched.
+         */
+        unpatched = aml_equal(dsm_mem, aml_int(0x0));
+
+        expected_uuid = aml_local(0);
+
+        ifctx = aml_if(aml_equal(handle, aml_int(0x0)));
+        aml_append(ifctx, aml_store(
+                aml_touuid("2F10E7A4-9E91-11E4-89D3-123B93F75CBA")
+                /* UUID for NVDIMM Root Device */, expected_uuid));
+        aml_append(method, ifctx);
+        elsectx = aml_else();
+        ifctx = aml_if(aml_equal(handle,
+                                aml_int(NVDIMM_QEMU_RSVD_HANDLE_ROOT)));
+        aml_append(ifctx, aml_store(aml_touuid(NVDIMM_QEMU_RSVD_UUID
+                /* UUID for QEMU internal use */), expected_uuid));
+        aml_append(elsectx, ifctx);
+        elsectx2 = aml_else();
+        aml_append(elsectx2, aml_store(
+                aml_touuid("4309AC30-0D11-11E4-9191-0800200C9A66")
+                /* UUID for NVDIMM Devices */, expected_uuid));
+        aml_append(elsectx, elsectx2);
+        aml_append(method, elsectx);
+
+        uuid_invalid = aml_lnot(aml_equal(uuid, expected_uuid));
+
+        unsupport = aml_if(aml_or(unpatched, uuid_invalid, NULL));
 
-    expected_uuid = aml_local(0);
+        /*
+         * function 0 is called to inquire what functions are supported by
+         * OSPM
+         */
+        ifctx = aml_if(aml_equal(function, aml_int(0)));
+        byte_list[0] = 0 /* No function Supported */;
+        aml_append(ifctx, aml_return(aml_buffer(1, byte_list)));
+        aml_append(unsupport, ifctx);
 
-    ifctx = aml_if(aml_equal(handle, aml_int(0x0)));
-    aml_append(ifctx, aml_store(
-               aml_touuid("2F10E7A4-9E91-11E4-89D3-123B93F75CBA")
-               /* UUID for NVDIMM Root Device */, expected_uuid));
-    aml_append(method, ifctx);
-    elsectx = aml_else();
-    ifctx = aml_if(aml_equal(handle, aml_int(NVDIMM_QEMU_RSVD_HANDLE_ROOT)));
-    aml_append(ifctx, aml_store(aml_touuid(NVDIMM_QEMU_RSVD_UUID
-               /* UUID for QEMU internal use */), expected_uuid));
-    aml_append(elsectx, ifctx);
-    elsectx2 = aml_else();
-    aml_append(elsectx2, aml_store(
-               aml_touuid("4309AC30-0D11-11E4-9191-0800200C9A66")
-               /* UUID for NVDIMM Devices */, expected_uuid));
-    aml_append(elsectx, elsectx2);
-    aml_append(method, elsectx);
+        /* No function is supported yet. */
+        byte_list[0] = NVDIMM_DSM_RET_STATUS_UNSUPPORT;
+        aml_append(unsupport, aml_return(aml_buffer(1, byte_list)));
+        aml_append(method, unsupport);
+
+        /*
+         * The HDLE indicates the DSM function is issued from which device,
+         * it reserves 0 for root device and is the handle for
+         * NVDIMM devices. See the comments in nvdimm_slot_to_handle().
+         */
+        aml_append(method, aml_store(handle,
+                aml_name(NVDIMM_DSM_HANDLE)));
+        aml_append(method, aml_store(aml_arg(1),
+                aml_name(NVDIMM_DSM_REVISION)));
+        aml_append(method, aml_store(aml_arg(2),
+                aml_name(NVDIMM_DSM_FUNCTION)));
 
-    uuid_invalid = aml_lnot(aml_equal(uuid, expected_uuid));
+        /*
+         * The fourth parameter (Arg3) of _DSM is a package which contains
+         * a buffer, the layout of the buffer is specified by UUID (Arg0),
+         * Revision ID (Arg1) and Function Index (Arg2) which are documented
+         * in the DSM Spec.
+         */
+        pckg = aml_arg(3);
+        ifctx = aml_if(aml_and(aml_equal(aml_object_type(pckg),
+                    aml_int(4 /* Package */)) /* It is a Package? */,
+                    aml_equal(aml_sizeof(pckg),
+                                aml_int(1)) /* 1 element? */,
+                                NULL));
 
-    unsupport = aml_if(aml_or(unpatched, uuid_invalid, NULL));
+        break;
+    case 1: /* build common dsm in _HMA method */
+        /*
+         * _HMAC input:
+         * HMAM_OFFSET: store the current offset of _HMA buffer.
+         *
+         * They are RAM mapping on host so that
+         * these accesses never cause VMExit.
+         */
+        aml_append(field, aml_named_field(HMAM_OFFSET,
+                sizeof(typeof_field(HmatHmamIn, offset)) * BITS_PER_BYTE));
+        aml_append(method, field);
 
-    /*
-     * function 0 is called to inquire what functions are supported by
-     * OSPM
-     */
-    ifctx = aml_if(aml_equal(function, aml_int(0)));
-    byte_list[0] = 0 /* No function Supported */;
-    aml_append(ifctx, aml_return(aml_buffer(1, byte_list)));
-    aml_append(unsupport, ifctx);
+        /*
+         * _HMAC output:
+         * HMAM_OUT_BUF_SIZE: the size of the buffer filled by QEMU.
+         * HMAM_OUT_BUF: the buffer QEMU uses to store the result.
+         *
+         * Since the page is reused by both input and out, the input data
+         * will be lost after storing new result into ODAT so we should
+         * fetch all the input data before writing the result.
+         */
+        field = aml_field(HMAM_MEMORY, AML_DWORD_ACC, AML_NOLOCK,
+                        AML_PRESERVE);
+        aml_append(field, aml_named_field(HMAM_OUT_BUF_SIZE,
+                sizeof(typeof_field(HmatHmamOut, len)) * BITS_PER_BYTE));
+        aml_append(field, aml_named_field(HMAM_OUT_BUF,
+                (sizeof(HmatHmamOut) - sizeof(uint32_t)) * BITS_PER_BYTE));
+        aml_append(method, field);
 
-    /* No function is supported yet. */
-    byte_list[0] = NVDIMM_DSM_RET_STATUS_UNSUPPORT;
-    aml_append(unsupport, aml_return(aml_buffer(1, byte_list)));
-    aml_append(method, unsupport);
+        /*
+         * do not support any method if HMA memory address has not been
+         * patched.
+         */
+        unsupport = aml_if(aml_equal(dsm_mem, aml_int(0x0)));
+        byte_list[0] = HMAM_RET_STATUS_UNSUPPORT;
+        aml_append(unsupport, aml_return(aml_buffer(1, byte_list)));
+        aml_append(method, unsupport);
 
-    /*
-     * The HDLE indicates the DSM function is issued from which device,
-     * it reserves 0 for root device and is the handle for NVDIMM devices.
-     * See the comments in nvdimm_slot_to_handle().
-     */
-    aml_append(method, aml_store(handle, aml_name(NVDIMM_DSM_HANDLE)));
-    aml_append(method, aml_store(aml_arg(1), aml_name(NVDIMM_DSM_REVISION)));
-    aml_append(method, aml_store(aml_arg(2), aml_name(NVDIMM_DSM_FUNCTION)));
+        /*
+         * The parameter (Arg0) of _HMAC is
+         * a package which contains a buffer.
+         */
+        pckg = aml_arg(0);
+        ifctx = aml_if(aml_and(aml_equal(aml_object_type(pckg),
+                    aml_int(4 /* Package */)) /* It is a Package? */,
+                    aml_equal(aml_sizeof(pckg), aml_int(1)) /* 1 element */,
+                    NULL));
 
-    /*
-     * The fourth parameter (Arg3) of _DSM is a package which contains
-     * a buffer, the layout of the buffer is specified by UUID (Arg0),
-     * Revision ID (Arg1) and Function Index (Arg2) which are documented
-     * in the DSM Spec.
-     */
-    pckg = aml_arg(3);
-    ifctx = aml_if(aml_and(aml_equal(aml_object_type(pckg),
-                   aml_int(4 /* Package */)) /* It is a Package? */,
-                   aml_equal(aml_sizeof(pckg), aml_int(1)) /* 1 element? */,
-                   NULL));
+        break;
+    }
 
     pckg_index = aml_local(2);
     pckg_buf = aml_local(3);
     aml_append(ifctx, aml_store(aml_index(pckg, aml_int(0)), pckg_index));
     aml_append(ifctx, aml_store(aml_derefof(pckg_index), pckg_buf));
-    aml_append(ifctx, aml_store(pckg_buf, aml_name(NVDIMM_DSM_ARG3)));
+    aml_append(ifctx, aml_store(pckg_buf, aml_name("%s", aml_offset)));
     aml_append(method, ifctx);
 
     /*
@@ -1138,19 +1231,37 @@ static void nvdimm_build_device_dsm(Aml *dev, uint32_t handle)
     aml_append(dev, method);
 }
 
-static void nvdimm_build_fit(Aml *dev)
+void nvdimm_build_fit(Aml *dev, uint16_t method_number)
 {
-    Aml *method, *pkg, *buf, *buf_size, *offset, *call_result;
-    Aml *whilectx, *ifcond, *ifctx, *elsectx, *fit;
+    Aml *method, *pkg, *buf, *buf_size, *offset, *call_result = NULL;
+    Aml *whilectx, *ifcond, *ifctx, *elsectx, *buf_name;
+    const char *help_function = NULL, *method_name = NULL;
+    int ret_status_success, ret_status_changed;
+
+    switch (method_number) {
+    case 0: /* _FIT method */
+        method_name = "_FIT";
+        help_function = "RFIT";
+        ret_status_success = NVDIMM_DSM_RET_STATUS_SUCCESS;
+        ret_status_changed = NVDIMM_DSM_RET_STATUS_FIT_CHANGED;
+        break;
+    case 1: /* _HMA method */
+        method_name = "_HMA";
+        nvdimm_build_common_dsm(dev, METHOD_NAME_HMA);
+        help_function = "RHMA";
+        ret_status_success = HMAM_RET_STATUS_SUCCESS;
+        ret_status_changed = HMAM_RET_STATUS_HMA_CHANGED;
+        break;
+    }
 
     buf = aml_local(0);
     buf_size = aml_local(1);
-    fit = aml_local(2);
+    buf_name = aml_local(2);
 
     aml_append(dev, aml_name_decl(NVDIMM_DSM_RFIT_STATUS, aml_int(0)));
 
-    /* build helper function, RFIT. */
-    method = aml_method("RFIT", 1, AML_SERIALIZED);
+    /* build helper function. */
+    method = aml_method(help_function, 1, AML_SERIALIZED);
     aml_append(method, aml_name_decl("OFST", aml_int(0)));
 
     /* prepare input package. */
@@ -1158,12 +1269,20 @@ static void nvdimm_build_fit(Aml *dev)
     aml_append(method, aml_store(aml_arg(0), aml_name("OFST")));
     aml_append(pkg, aml_name("OFST"));
 
-    /* call Read_FIT function. */
-    call_result = aml_call5(NVDIMM_COMMON_DSM,
-                            aml_touuid(NVDIMM_QEMU_RSVD_UUID),
-                            aml_int(1) /* Revision 1 */,
-                            aml_int(0x1) /* Read FIT */,
-                            pkg, aml_int(NVDIMM_QEMU_RSVD_HANDLE_ROOT));
+    /* call Read function. */
+    switch (method_number) {
+    case 0: /* build common dsm in _FIT method */
+        call_result = aml_call5(NVDIMM_COMMON_DSM,
+                                aml_touuid(NVDIMM_QEMU_RSVD_UUID),
+                                aml_int(1) /* Revision 1 */,
+                                aml_int(0x1) /* Read FIT */,
+                                pkg, aml_int(NVDIMM_QEMU_RSVD_HANDLE_ROOT));
+        break;
+    case 1: /* build common dsm in _FIT method */
+        call_result = aml_call1(HMA_COMMON_METHOD, pkg);
+        break;
+    }
+
     aml_append(method, aml_store(call_result, buf));
 
     /* handle _DSM result. */
@@ -1174,7 +1293,7 @@ static void nvdimm_build_fit(Aml *dev)
                                  aml_name(NVDIMM_DSM_RFIT_STATUS)));
 
      /* if something is wrong during _DSM. */
-    ifcond = aml_equal(aml_int(NVDIMM_DSM_RET_STATUS_SUCCESS),
+    ifcond = aml_equal(aml_int(ret_status_success),
                        aml_name("STAU"));
     ifctx = aml_if(aml_lnot(ifcond));
     aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
@@ -1185,7 +1304,7 @@ static void nvdimm_build_fit(Aml *dev)
                                     aml_int(4) /* the size of "STAU" */,
                                     buf_size));
 
-    /* if we read the end of fit. */
+    /* if we read the end of fit or hma. */
     ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
     aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
     aml_append(method, ifctx);
@@ -1196,38 +1315,38 @@ static void nvdimm_build_fit(Aml *dev)
     aml_append(method, aml_return(aml_name("BUFF")));
     aml_append(dev, method);
 
-    /* build _FIT. */
-    method = aml_method("_FIT", 0, AML_SERIALIZED);
+    /* build _FIT or _HMA. */
+    method = aml_method(method_name, 0, AML_SERIALIZED);
     offset = aml_local(3);
 
-    aml_append(method, aml_store(aml_buffer(0, NULL), fit));
+    aml_append(method, aml_store(aml_buffer(0, NULL), buf_name));
     aml_append(method, aml_store(aml_int(0), offset));
 
     whilectx = aml_while(aml_int(1));
-    aml_append(whilectx, aml_store(aml_call1("RFIT", offset), buf));
+    aml_append(whilectx, aml_store(aml_call1(help_function, offset), buf));
     aml_append(whilectx, aml_store(aml_sizeof(buf), buf_size));
 
     /*
-     * if fit buffer was changed during RFIT, read from the beginning
-     * again.
+     * if buffer was changed during RFIT or RHMA,
+     * read from the beginning again.
      */
     ifctx = aml_if(aml_equal(aml_name(NVDIMM_DSM_RFIT_STATUS),
-                             aml_int(NVDIMM_DSM_RET_STATUS_FIT_CHANGED)));
-    aml_append(ifctx, aml_store(aml_buffer(0, NULL), fit));
+                             aml_int(ret_status_changed)));
+    aml_append(ifctx, aml_store(aml_buffer(0, NULL), buf_name));
     aml_append(ifctx, aml_store(aml_int(0), offset));
     aml_append(whilectx, ifctx);
 
     elsectx = aml_else();
 
-    /* finish fit read if no data is read out. */
+    /* finish fit or hma read if no data is read out. */
     ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
-    aml_append(ifctx, aml_return(fit));
+    aml_append(ifctx, aml_return(buf_name));
     aml_append(elsectx, ifctx);
 
     /* update the offset. */
     aml_append(elsectx, aml_add(offset, buf_size, offset));
-    /* append the data we read out to the fit buffer. */
-    aml_append(elsectx, aml_concatenate(fit, buf, fit));
+    /* append the data we read out to the fit or hma buffer. */
+    aml_append(elsectx, aml_concatenate(buf_name, buf, buf_name));
     aml_append(whilectx, elsectx);
     aml_append(method, whilectx);
 
@@ -1288,11 +1407,11 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
      */
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
 
-    nvdimm_build_common_dsm(dev);
+    nvdimm_build_common_dsm(dev, METHOD_NAME_FIT);
 
     /* 0 is reserved for root device. */
     nvdimm_build_device_dsm(dev, 0);
-    nvdimm_build_fit(dev);
+    nvdimm_build_fit(dev, METHOD_NAME_FIT);
 
     nvdimm_build_nvdimm_devices(dev, ram_slots);
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3ef3794fa1..83fc5b1744 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1853,7 +1853,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_q35_pci0_int(dsdt);
     }
 
-    hmat_build_aml(dsdt);
+    nvdimm_build_fit(dsdt, METHOD_NAME_HMA);
 
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index c5c9b3c7f8..3bc38735e4 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
 
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -110,6 +111,15 @@ typedef struct NVDIMMClass NVDIMMClass;
 #define NVDIMM_ACPI_IO_BASE     0x0a18
 #define NVDIMM_ACPI_IO_LEN      4
 
+/*
+ * The ACPI Device Configuration method name used in nvdimm_build_fit,
+ * use number to representative the name:
+ * 0 means "_FIT"
+ * 1 means "_HMA"
+ */
+#define METHOD_NAME_FIT     0
+#define METHOD_NAME_HMA     1
+
 /*
  * NvdimmFitBuffer:
  * @fit: FIT structures for present NVDIMMs. It is updated when
@@ -150,4 +160,5 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        uint32_t ram_slots);
 void nvdimm_plug(AcpiNVDIMMState *state);
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
+void nvdimm_build_fit(Aml *dev, uint16_t method_number);
 #endif
-- 
2.17.1
