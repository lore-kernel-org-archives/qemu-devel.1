Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFnV-0007hg-Fo
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1faFkC-0004nX-F4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 03:32:25 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  3 Jul 2018 09:19:55 +0200
Message-Id: <1530602398-16127-13-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
References: <1530602398-16127-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 12/15] nvdimm: use configurable ACPI IO base
 and size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

This patch uses configurable IO base and size to create NPIO AML for
ACPI NFIT. Since a different architecture like AArch64 does not use
port-mapped IO, a configurable IO base is required to create correct
mapping of ACPI IO address and size.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- s/size/len in pc_piix.c and pc_q35.c
---
 hw/acpi/nvdimm.c        | 28 +++++++++++++++++++---------
 hw/i386/pc_piix.c       |  8 +++++++-
 hw/i386/pc_q35.c        |  8 +++++++-
 include/hw/mem/nvdimm.h | 12 ++++++++++++
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 27eeb66..17d7146 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -929,8 +929,8 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
                             FWCfgState *fw_cfg, Object *owner)
 {
     memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
-                          "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
-    memory_region_add_subregion(io, NVDIMM_ACPI_IO_BASE, &state->io_mr);
+                          "nvdimm-acpi-io", state->dsm_io.len);
+    memory_region_add_subregion(io, state->dsm_io.base, &state->io_mr);
 
     state->dsm_mem = g_array_new(false, true /* clear */, 1);
     acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
@@ -959,12 +959,14 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
 
 #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
 
-static void nvdimm_build_common_dsm(Aml *dev)
+static void nvdimm_build_common_dsm(Aml *dev,
+                                    AcpiNVDIMMState *acpi_nvdimm_state)
 {
     Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
     Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_size;
     uint8_t byte_list[1];
+    AmlRegionSpace rs;
 
     method = aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
     uuid = aml_arg(0);
@@ -975,9 +977,16 @@ static void nvdimm_build_common_dsm(Aml *dev)
 
     aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem));
 
+    if (acpi_nvdimm_state->dsm_io.type == NVDIMM_ACPI_IO_PORT) {
+        rs = AML_SYSTEM_IO;
+    } else {
+        rs = AML_SYSTEM_MEMORY;
+    }
+
     /* map DSM memory and IO into ACPI namespace. */
-    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTEM_IO,
-               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
+    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, rs,
+               aml_int(acpi_nvdimm_state->dsm_io.base),
+               acpi_nvdimm_state->dsm_io.len));
     aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
                AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
 
@@ -1260,7 +1269,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
 }
 
 static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_arrea,
+                              BIOSLinker *linker,
+                              AcpiNVDIMMState *acpi_nvdimm_state,
                               uint32_t ram_slots)
 {
     Aml *ssdt, *sb_scope, *dev;
@@ -1288,7 +1298,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
      */
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
 
-    nvdimm_build_common_dsm(dev);
+    nvdimm_build_common_dsm(dev, acpi_nvdimm_state);
 
     /* 0 is reserved for root device. */
     nvdimm_build_device_dsm(dev, 0);
@@ -1307,7 +1317,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
                                                NVDIMM_ACPI_MEM_ADDR);
 
     bios_linker_loader_alloc(linker,
-                             NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
+                             NVDIMM_DSM_MEM_FILE, acpi_nvdimm_state->dsm_mem,
                              sizeof(NvdimmDsmIn), false /* high memory */);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
@@ -1329,7 +1339,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
         return;
     }
 
-    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
+    nvdimm_build_ssdt(table_offsets, table_data, linker, state,
                       ram_slots);
 
     device_list = nvdimm_get_device_list();
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d357907..95dde50 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -296,7 +296,13 @@ static void pc_init1(MachineState *machine,
     }
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+        AcpiNVDIMMState *acpi_nvdimm_state = &pcms->acpi_nvdimm_state;
+
+        acpi_nvdimm_state->dsm_io.type = NVDIMM_ACPI_IO_PORT;
+        acpi_nvdimm_state->dsm_io.base = NVDIMM_ACPI_IO_BASE;
+        acpi_nvdimm_state->dsm_io.len = NVDIMM_ACPI_IO_LEN;
+
+        nvdimm_init_acpi_state(acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1a73e18..98e9d08 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -276,7 +276,13 @@ static void pc_q35_init(MachineState *machine)
     pc_nic_init(pcmc, isa_bus, host_bus);
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+        AcpiNVDIMMState *acpi_nvdimm_state = &pcms->acpi_nvdimm_state;
+
+        acpi_nvdimm_state->dsm_io.type = NVDIMM_ACPI_IO_PORT;
+        acpi_nvdimm_state->dsm_io.base = NVDIMM_ACPI_IO_BASE;
+        acpi_nvdimm_state->dsm_io.len = NVDIMM_ACPI_IO_LEN;
+
+        nvdimm_init_acpi_state(acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index c5c9b3c..af8a5fd 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -123,6 +123,17 @@ struct NvdimmFitBuffer {
 };
 typedef struct NvdimmFitBuffer NvdimmFitBuffer;
 
+typedef enum {
+    NVDIMM_ACPI_IO_PORT,
+    NVDIMM_ACPI_IO_MEMORY,
+} AcpiNVDIMMIOType;
+
+typedef struct AcpiNVDIMMIOEntry {
+    AcpiNVDIMMIOType type;
+    hwaddr base;
+    hwaddr len;
+} AcpiNVDIMMIOEntry;
+
 struct AcpiNVDIMMState {
     /* detect if NVDIMM support is enabled. */
     bool is_enabled;
@@ -140,6 +151,7 @@ struct AcpiNVDIMMState {
      */
     int32_t persistence;
     char    *persistence_string;
+    AcpiNVDIMMIOEntry dsm_io;
 };
 typedef struct AcpiNVDIMMState AcpiNVDIMMState;
 
-- 
2.5.5
