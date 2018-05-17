Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB2I-0001mV-9L
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB1w-00012m-If
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:63840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fJB1w-0000tQ-1p
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:00:44 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Wed, 16 May 2018 23:00:23 -0600
Message-Id: <20180517050024.20101-4-ross.zwisler@linux.intel.com>
In-Reply-To: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v2 3/4] nvdimm,
 acpi: support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>

Add a machine command line option to allow the user to control the Platform
Capabilities Structure in the virtualized NFIT.  This Platform Capabilities
Structure was added in ACPI 6.2 Errata A.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 docs/nvdimm.txt         | 18 ++++++++++++++++++
 hw/acpi/nvdimm.c        | 44 ++++++++++++++++++++++++++++++++++++++++----
 hw/i386/pc.c            | 31 +++++++++++++++++++++++++++++++
 include/hw/i386/pc.h    |  1 +
 include/hw/mem/nvdimm.h |  5 +++++
 5 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index e903d8bb09..3f18013880 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -153,3 +153,21 @@ guest NVDIMM region mapping structure.  This unarmed flag indicates
 guest software that this vNVDIMM device contains a region that cannot
 accept persistent writes. In result, for example, the guest Linux
 NVDIMM driver, marks such vNVDIMM device as read-only.
+
+Platform Capabilities
+---------------------
+
+ACPI 6.2 Errata A added support for a new Platform Capabilities Structure
+which allows the platform to communicate what features it supports related to
+NVDIMM data durability.  Users can provide a capabilities value to a guest via
+the optional "nvdimm-cap" machine command line option:
+
+    -machine pc,accel=kvm,nvdimm,nvdimm-cap=2
+
+As of ACPI 6.2 Errata A, the following values are valid for the bottom two
+bits:
+
+2 - Memory Controller Flush to NVDIMM Durability on Power Loss Capable.
+3 - CPU Cache Flush to NVDIMM Durability on Power Loss Capable.
+
+For a complete list of the flags available please consult the ACPI spec.
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 59d6e4254c..980d4c2ebb 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -169,6 +169,21 @@ struct NvdimmNfitControlRegion {
 } QEMU_PACKED;
 typedef struct NvdimmNfitControlRegion NvdimmNfitControlRegion;
 
+/*
+ * NVDIMM Platform Capabilities Structure
+ *
+ * Defined in section 5.2.25.9 of ACPI 6.2 Errata A, September 2017
+ */
+struct NvdimmNfitPlatformCaps {
+    uint16_t type;
+    uint16_t length;
+    uint8_t highest_cap;
+    uint8_t reserved[3];
+    uint32_t capabilities;
+    uint8_t reserved2[4];
+} QEMU_PACKED;
+typedef struct NvdimmNfitPlatformCaps NvdimmNfitPlatformCaps;
+
 /*
  * Module serial number is a unique number for each device. We use the
  * slot id of NVDIMM device to generate this number so that each device
@@ -351,7 +366,23 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
                                          JEDEC Annex L Release 3. */);
 }
 
-static GArray *nvdimm_build_device_structure(void)
+/*
+ * ACPI 6.2 Errata A: 5.2.25.9 NVDIMM Platform Capabilities Structure
+ */
+static void
+nvdimm_build_structure_caps(GArray *structures, uint32_t capabilities)
+{
+    NvdimmNfitPlatformCaps *nfit_caps;
+
+    nfit_caps = acpi_data_push(structures, sizeof(*nfit_caps));
+
+    nfit_caps->type = cpu_to_le16(7 /* NVDIMM Platform Capabilities */);
+    nfit_caps->length = cpu_to_le16(sizeof(*nfit_caps));
+    nfit_caps->highest_cap = 2;
+    nfit_caps->capabilities = cpu_to_le32(capabilities);
+}
+
+static GArray *nvdimm_build_device_structure(AcpiNVDIMMState *state)
 {
     GSList *device_list = nvdimm_get_device_list();
     GArray *structures = g_array_new(false, true /* clear */, 1);
@@ -373,6 +404,9 @@ static GArray *nvdimm_build_device_structure(void)
     }
     g_slist_free(device_list);
 
+    if (state->capabilities)
+        nvdimm_build_structure_caps(structures, state->capabilities);
+
     return structures;
 }
 
@@ -381,16 +415,18 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
     fit_buf->fit = g_array_new(false, true /* clear */, 1);
 }
 
-static void nvdimm_build_fit_buffer(NvdimmFitBuffer *fit_buf)
+static void nvdimm_build_fit_buffer(AcpiNVDIMMState *state)
 {
+    NvdimmFitBuffer *fit_buf = &state->fit_buf;
+
     g_array_free(fit_buf->fit, true);
-    fit_buf->fit = nvdimm_build_device_structure();
+    fit_buf->fit = nvdimm_build_device_structure(state);
     fit_buf->dirty = true;
 }
 
 void nvdimm_plug(AcpiNVDIMMState *state)
 {
-    nvdimm_build_fit_buffer(&state->fit_buf);
+    nvdimm_build_fit_buffer(state);
 }
 
 static void nvdimm_build_nfit(AcpiNVDIMMState *state, GArray *table_offsets,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d768930d02..1b2684c549 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2182,6 +2182,33 @@ static void pc_machine_set_nvdimm(Object *obj, bool value, Error **errp)
     pcms->acpi_nvdimm_state.is_enabled = value;
 }
 
+static void pc_machine_get_nvdimm_capabilities(Object *obj, Visitor *v,
+                                               const char *name, void *opaque,
+                                               Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+    uint32_t value = pcms->acpi_nvdimm_state.capabilities;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void pc_machine_set_nvdimm_capabilities(Object *obj, Visitor *v,
+                                               const char *name, void *opaque,
+                                               Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+    Error *error = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    pcms->acpi_nvdimm_state.capabilities = value;
+}
+
 static bool pc_machine_get_smbus(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2395,6 +2422,10 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_add_bool(oc, PC_MACHINE_NVDIMM,
         pc_machine_get_nvdimm, pc_machine_set_nvdimm, &error_abort);
 
+    object_class_property_add(oc, PC_MACHINE_NVDIMM_CAP, "uint32",
+        pc_machine_get_nvdimm_capabilities,
+        pc_machine_set_nvdimm_capabilities, NULL, NULL, &error_abort);
+
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
         pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2a98e3ad68..e9b22f929c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -76,6 +76,7 @@ struct PCMachineState {
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
 #define PC_MACHINE_NVDIMM           "nvdimm"
+#define PC_MACHINE_NVDIMM_CAP       "nvdimm-cap"
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 74c60332e1..3c82751bab 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -134,6 +134,11 @@ struct AcpiNVDIMMState {
 
     /* the IO region used by OSPM to transfer control to QEMU. */
     MemoryRegion io_mr;
+
+    /*
+     * Platform capabilities, section 5.2.25.9 of ACPI 6.2 Errata A
+     */
+    int32_t capabilities;
 };
 typedef struct AcpiNVDIMMState AcpiNVDIMMState;
 
-- 
2.14.3
