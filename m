Received: from eggs.gnu.org ([2001:4830:134:3::10]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8d-0008QR-Ct
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cts8b-000265-VJ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:21496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cts8b-00020h-N5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:42:29 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Fri, 31 Mar 2017 16:41:46 +0800
Message-Id: <20170331084147.32716-4-haozhong.zhang@intel.com>
In-Reply-To: <20170331084147.32716-1-haozhong.zhang@intel.com>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC PATCH 3/4] nvdimm acpi: record the cache line
 size in AcpiNVDIMMState
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

Software is allowed to write up to a cache line of data to the flush
hint address (ACPI spec 6.1, Table 5-135). NVDIMM ACPI code needs this
parameter to decide the address space size for flush hint addresses.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/acpi/nvdimm.c        | 5 ++++-
 hw/i386/pc_piix.c       | 2 +-
 hw/i386/pc_q35.c        | 2 +-
 include/hw/mem/nvdimm.h | 5 ++++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec..ea2ac3e 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -881,7 +881,8 @@ void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
 }
 
 void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
-                            FWCfgState *fw_cfg, Object *owner)
+                            FWCfgState *fw_cfg, Object *owner,
+                            unsigned int cache_line_size)
 {
     memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
                           "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
@@ -893,6 +894,8 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
                     state->dsm_mem->len);
 
     nvdimm_init_fit_buffer(&state->fit_buf);
+
+    state->cache_line_size = cache_line_size;
 }
 
 #define NVDIMM_COMMON_DSM       "NCAL"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa..81dd379 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -298,7 +298,7 @@ static void pc_init1(MachineState *machine,
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+                               pcms->fw_cfg, OBJECT(pcms), 64);
     }
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8..19f5515 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -272,7 +272,7 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcms->acpi_nvdimm_state.is_enabled) {
         nvdimm_init_acpi_state(&pcms->acpi_nvdimm_state, system_io,
-                               pcms->fw_cfg, OBJECT(pcms));
+                               pcms->fw_cfg, OBJECT(pcms), 64);
     }
 }
 
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index eb71f41..888def6 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -134,11 +134,14 @@ struct AcpiNVDIMMState {
 
     /* the IO region used by OSPM to transfer control to QEMU. */
     MemoryRegion io_mr;
+
+    unsigned int cache_line_size;
 };
 typedef struct AcpiNVDIMMState AcpiNVDIMMState;
 
 void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
-                            FWCfgState *fw_cfg, Object *owner);
+                            FWCfgState *fw_cfg, Object *owner,
+                            unsigned int cache_line_size);
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, AcpiNVDIMMState *state,
                        uint32_t ram_slots);
-- 
2.10.1
