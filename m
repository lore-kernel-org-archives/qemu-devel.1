Received: from eggs.gnu.org ([209.51.188.92]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwaYA-0004Qx-RR
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 17:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwaY9-0000Wg-ED
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 17:41:10 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Feb 2019 23:40:00 +0100
Message-Id: <20190220224003.4420-15-eric.auger@redhat.com>
In-Reply-To: <20190220224003.4420-1-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 14/17] nvdimm: use configurable ACPI IO base
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
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

This patch uses configurable IO base and size to create NPIO AML for
ACPI NFIT. Since a different architecture like AArch64 does not use
port-mapped IO, a configurable IO base is required to create correct
mapping of ACPI IO address and size.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- Use NvdimmDsmIO constant
- use AcpiGenericAddress instead of AcpiNVDIMMIOEntry

v2 -> v3:
- s/size/len in pc_piix.c and pc_q35.c
---
 hw/acpi/nvdimm.c        | 31 ++++++++++++++++++++++---------
 hw/i386/pc_piix.c       |  6 +++++-
 hw/i386/pc_q35.c        |  6 +++++-
 include/hw/mem/nvdimm.h |  4 ++++
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index e53b2cb681..fddc790945 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -33,6 +33,9 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
=20
+const struct AcpiGenericAddress NvdimmDsmIO =3D { .space_id =3D AML_AS_S=
YSTEM_IO,
+        .bit_width =3D NVDIMM_ACPI_IO_LEN << 3, .address =3D NVDIMM_ACPI=
_IO_BASE};
+
 static int nvdimm_device_list(Object *obj, void *opaque)
 {
     GSList **list =3D opaque;
@@ -929,8 +932,8 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, M=
emoryRegion *io,
                             FWCfgState *fw_cfg, Object *owner)
 {
     memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
-                          "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
-    memory_region_add_subregion(io, NVDIMM_ACPI_IO_BASE, &state->io_mr);
+                          "nvdimm-acpi-io", state->dsm_io.bit_width >> 3=
);
+    memory_region_add_subregion(io, state->dsm_io.address, &state->io_mr=
);
=20
     state->dsm_mem =3D g_array_new(false, true /* clear */, 1);
     acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
@@ -959,12 +962,14 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state,=
 MemoryRegion *io,
=20
 #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
=20
-static void nvdimm_build_common_dsm(Aml *dev)
+static void nvdimm_build_common_dsm(Aml *dev,
+                                    AcpiNVDIMMState *acpi_nvdimm_state)
 {
     Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
     Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_bu=
f_size;
     uint8_t byte_list[1];
+    AmlRegionSpace rs;
=20
     method =3D aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
     uuid =3D aml_arg(0);
@@ -975,9 +980,16 @@ static void nvdimm_build_common_dsm(Aml *dev)
=20
     aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem=
));
=20
+    if (acpi_nvdimm_state->dsm_io.space_id =3D=3D AML_AS_SYSTEM_IO) {
+        rs =3D AML_SYSTEM_IO;
+    } else {
+        rs =3D AML_SYSTEM_MEMORY;
+    }
+
     /* map DSM memory and IO into ACPI namespace. */
-    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTE=
M_IO,
-               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
+    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, rs,
+               aml_int(acpi_nvdimm_state->dsm_io.address),
+               acpi_nvdimm_state->dsm_io.bit_width >> 3));
     aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
                AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
=20
@@ -1260,7 +1272,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_d=
ev, uint32_t ram_slots)
 }
=20
 static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_arrea,
+                              BIOSLinker *linker,
+                              AcpiNVDIMMState *acpi_nvdimm_state,
                               uint32_t ram_slots)
 {
     Aml *ssdt, *sb_scope, *dev;
@@ -1288,7 +1301,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets=
, GArray *table_data,
      */
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
=20
-    nvdimm_build_common_dsm(dev);
+    nvdimm_build_common_dsm(dev, acpi_nvdimm_state);
=20
     /* 0 is reserved for root device. */
     nvdimm_build_device_dsm(dev, 0);
@@ -1307,7 +1320,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets=
, GArray *table_data,
                                                NVDIMM_ACPI_MEM_ADDR);
=20
     bios_linker_loader_alloc(linker,
-                             NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
+                             NVDIMM_DSM_MEM_FILE, acpi_nvdimm_state->dsm=
_mem,
                              sizeof(NvdimmDsmIn), false /* high memory *=
/);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
@@ -1329,7 +1342,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArra=
y *table_data,
         return;
     }
=20
-    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
+    nvdimm_build_ssdt(table_offsets, table_data, linker, state,
                       ram_slots);
=20
     device_list =3D nvdimm_get_device_list();
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fd0f2c268f..d0a262d106 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -298,7 +298,11 @@ static void pc_init1(MachineState *machine,
     }
=20
     if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+        AcpiNVDIMMState *acpi_nvdimm_state =3D &pcms->acpi_nvdimm_state;
+
+        acpi_nvdimm_state->dsm_io =3D NvdimmDsmIO;
+
+        nvdimm_init_acpi_state(acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4a175ea50e..21f594001f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -330,7 +330,11 @@ static void pc_q35_init(MachineState *machine)
     pc_nic_init(pcmc, isa_bus, host_bus);
=20
     if (pcms->acpi_nvdimm_state.is_enabled) {
-        nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
+        AcpiNVDIMMState *acpi_nvdimm_state =3D &pcms->acpi_nvdimm_state;
+
+        acpi_nvdimm_state->dsm_io =3D NvdimmDsmIO;
+
+        nvdimm_init_acpi_state(acpi_nvdimm_state, system_io,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index c5c9b3c7f8..ead51d958d 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
=20
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
=20
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -123,6 +124,8 @@ struct NvdimmFitBuffer {
 };
 typedef struct NvdimmFitBuffer NvdimmFitBuffer;
=20
+extern const struct AcpiGenericAddress NvdimmDsmIO;
+
 struct AcpiNVDIMMState {
     /* detect if NVDIMM support is enabled. */
     bool is_enabled;
@@ -140,6 +143,7 @@ struct AcpiNVDIMMState {
      */
     int32_t persistence;
     char    *persistence_string;
+    struct AcpiGenericAddress dsm_io;
 };
 typedef struct AcpiNVDIMMState AcpiNVDIMMState;
=20
--=20
2.20.1
