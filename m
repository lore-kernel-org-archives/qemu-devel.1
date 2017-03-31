Received: from eggs.gnu.org ([2001:4830:134:3::10]:54965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8g-0008SX-8l
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8e-00028w-Py
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:21496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cts8e-00020h-Df
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:32 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 31 Mar 2017 16:41:47 +0800
Message-Id: <20170331084147.32716-5-haozhong.zhang@intel.com>
In-Reply-To: <20170331084147.32716-1-haozhong.zhang@intel.com>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC PATCH 4/4] nvdimm acpi: build flush hint address
 structure if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Add an boolean option 'flush-hint' to device 'nvdimm'. If it's on, a
flush hint address structure will be constructed for each nvdimm
device.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/acpi/nvdimm.c        | 106 +++++++++++++++++++++++++++++++++++++++++++++---
 hw/i386/pc.c            |   5 ++-
 hw/mem/nvdimm.c         |  26 ++++++++++++
 include/hw/mem/nvdimm.h |   2 +-
 4 files changed, 132 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index ea2ac3e..a7ff0b2 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -32,6 +32,8 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
 
 static int nvdimm_device_list(Object *obj, void *opaque)
 {
@@ -168,6 +170,22 @@ struct NvdimmNfitControlRegion {
 typedef struct NvdimmNfitControlRegion NvdimmNfitControlRegion;
 
 /*
+ * NVDIMM Flush Hint Address Structure
+ *
+ * It enables the data durability mechanism via ACPI.
+ */
+struct NvdimmNfitFlushHintAddress {
+    uint16_t type;
+    uint16_t length;
+    uint32_t nfit_handle;
+    uint16_t nr_flush_hint_addr;
+    uint8_t  reserved[6];
+#define NR_FLUSH_HINT_ADDR 1
+    uint64_t flush_hint_addr[NR_FLUSH_HINT_ADDR];
+} QEMU_PACKED;
+typedef struct NvdimmNfitFlushHintAddress NvdimmNfitFlushHintAddress;
+
+/*
  * Module serial number is a unique number for each device. We use the
  * slot id of NVDIMM device to generate this number so that each device
  * associates with a different number.
@@ -343,10 +361,79 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
                                          (DSM) in DSM Spec Rev1.*/);
 }
 
-static GArray *nvdimm_build_device_structure(void)
+static uint64_t nvdimm_flush_hint_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void nvdimm_flush_hint_write(void *opaque, hwaddr addr,
+                                    uint64_t data, unsigned size)
+{
+    nvdimm_debug("Write Flush Hint: offset 0x%"HWADDR_PRIx", data 0x%"PRIx64"\n",
+                 addr, data);
+    nvdimm_flush((NVDIMMDevice *)opaque);
+}
+
+static const MemoryRegionOps nvdimm_flush_hint_ops = {
+    .read = nvdimm_flush_hint_read,
+    .write = nvdimm_flush_hint_write,
+};
+
+/*
+ * ACPI 6.0: 5.2.25.7 Flush Hint Address Structure
+ */
+static void nvdimm_build_structure_flush_hint(GArray *structures,
+                                              DeviceState *dev,
+                                              unsigned int cache_line_size,
+                                              Error **errp)
+{
+    NvdimmNfitFlushHintAddress *flush_hint;
+    int slot = object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP, NULL);
+    PCDIMMDevice *dimm = PC_DIMM(dev);
+    NVDIMMDevice *nvdimm = NVDIMM(dev);
+    uint64_t addr;
+    unsigned int i;
+    MemoryRegion *mr;
+    Error *local_err = NULL;
+
+    if (!nvdimm->flush_hint_enabled) {
+        return;
+    }
+
+    if (cache_line_size * NR_FLUSH_HINT_ADDR > dimm->reserved_size) {
+        error_setg(&local_err,
+                   "insufficient reserved space for flush hint buffers");
+        goto out;
+    }
+
+    addr = object_property_get_int(OBJECT(dev), PC_DIMM_ADDR_PROP, NULL);
+    addr += object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_PROP, NULL);
+
+    flush_hint = acpi_data_push(structures, sizeof(*flush_hint));
+    flush_hint->type = cpu_to_le16(6 /* Flush Hint Address Structure */);
+    flush_hint->length = cpu_to_le16(sizeof(*flush_hint));
+    flush_hint->nfit_handle = cpu_to_le32(nvdimm_slot_to_handle(slot));
+    flush_hint->nr_flush_hint_addr = cpu_to_le16(NR_FLUSH_HINT_ADDR);
+
+    for (i = 0; i < NR_FLUSH_HINT_ADDR; i++, addr += cache_line_size) {
+        flush_hint->flush_hint_addr[i] = cpu_to_le64(addr);
+
+        mr = g_new0(MemoryRegion, 1);
+        memory_region_init_io(mr, OBJECT(dev), &nvdimm_flush_hint_ops, nvdimm,
+                              "nvdimm-flush-hint", cache_line_size);
+        memory_region_add_subregion(get_system_memory(), addr, mr);
+    }
+
+ out:
+    error_propagate(errp, local_err);
+}
+
+static GArray *nvdimm_build_device_structure(AcpiNVDIMMState *state,
+                                             Error **errp)
 {
     GSList *device_list = nvdimm_get_device_list();
     GArray *structures = g_array_new(false, true /* clear */, 1);
+    Error *local_err = NULL;
 
     for (; device_list; device_list = device_list->next) {
         DeviceState *dev = device_list->data;
@@ -362,9 +449,17 @@ static GArray *nvdimm_build_device_structure(void)
 
         /* build NVDIMM Control Region Structure. */
         nvdimm_build_structure_dcr(structures, dev);
+
+        /* build Flush Hint Address Structure */
+        nvdimm_build_structure_flush_hint(structures, dev,
+                                          state->cache_line_size, &local_err);
+        if (local_err) {
+            break;
+        }
     }
     g_slist_free(device_list);
 
+    error_propagate(errp, local_err);
     return structures;
 }
 
@@ -373,16 +468,17 @@ static void nvdimm_init_fit_buffer(NvdimmFitBuffer *fit_buf)
     fit_buf->fit = g_array_new(false, true /* clear */, 1);
 }
 
-static void nvdimm_build_fit_buffer(NvdimmFitBuffer *fit_buf)
+static void nvdimm_build_fit_buffer(AcpiNVDIMMState *state, Error **errp)
 {
+    NvdimmFitBuffer *fit_buf = &state->fit_buf;
     g_array_free(fit_buf->fit, true);
-    fit_buf->fit = nvdimm_build_device_structure();
+    fit_buf->fit = nvdimm_build_device_structure(state, errp);
     fit_buf->dirty = true;
 }
 
-void nvdimm_plug(AcpiNVDIMMState *state)
+void nvdimm_plug(AcpiNVDIMMState *state, Error **errp)
 {
-    nvdimm_build_fit_buffer(&state->fit_buf);
+    nvdimm_build_fit_buffer(state, errp);
 }
 
 static void nvdimm_build_nfit(AcpiNVDIMMState *state, GArray *table_offsets,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e..da4a5d7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1718,7 +1718,10 @@ static void pc_dimm_plug(HotplugHandler *hotplug_dev,
                        "nvdimm is not enabled: missing 'nvdimm' in '-M'");
             goto out;
         }
-        nvdimm_plug(&pcms->acpi_nvdimm_state);
+        nvdimm_plug(&pcms->acpi_nvdimm_state, &local_err);
+        if (local_err) {
+            goto out;
+        }
     }
 
     hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 484ab8b..a26908b 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -64,11 +64,37 @@ out:
     error_propagate(errp, local_err);
 }
 
+static bool nvdimm_get_flush_hint(Object *obj, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+
+    return nvdimm->flush_hint_enabled;
+}
+
+static void nvdimm_set_flush_hint(Object *obj, bool val, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    Error *local_err = NULL;
+
+    if (nvdimm->flush_hint_enabled) {
+        error_setg(&local_err, "cannot change property value");
+        goto out;
+    }
+
+    nvdimm->flush_hint_enabled = val;
+
+ out:
+    error_propagate(errp, local_err);
+}
+
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, "label-size", "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
+    object_property_add_bool(obj, "flush-hint",
+                             nvdimm_get_flush_hint, nvdimm_set_flush_hint,
+                             NULL);
 }
 
 static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 888def6..726f4d9 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -145,7 +145,7 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, AcpiNVDIMMState *state,
                        uint32_t ram_slots);
-void nvdimm_plug(AcpiNVDIMMState *state);
+void nvdimm_plug(AcpiNVDIMMState *state, Error **errp);
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
 void nvdimm_flush(NVDIMMDevice *nvdimm);
 #endif
-- 
2.10.1
