Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwf-00052S-4W
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwe-0004vF-7L
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwd-0004uJ-Ty
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:08 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:43 +0800
Message-Id: <20170320001249.25521-5-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 04/10] nvdimm acpi: do not use
 fw_cfg on Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

Xen relies on QEMU to build guest ACPI for NVDIMM. However, no fw_cfg
is created when QEMU is used as Xen device model, so QEMU should avoid
using fw_cfg on Xen.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
---
 hw/acpi/aml-build.c | 9 ++++++---
 hw/acpi/nvdimm.c    | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index c6f2032dec..3925f261ad 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1530,9 +1530,12 @@ build_header(BIOSLinker *linker, GArray *table_data,
     h->oem_revision = cpu_to_le32(1);
     memcpy(h->asl_compiler_id, ACPI_BUILD_APPNAME4, 4);
     h->asl_compiler_revision = cpu_to_le32(1);
-    /* Checksum to be filled in by Guest linker */
-    bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
-        tbl_offset, len, checksum_offset);
+    /* No linker when used as Xen device model */
+    if (linker) {
+        /* Checksum to be filled in by Guest linker */
+        bios_linker_loader_add_checksum(linker, ACPI_BUILD_TABLE_FILE,
+                                        tbl_offset, len, checksum_offset);
+    }
 }
 
 void *acpi_data_push(GArray *table_data, unsigned size)
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec034..bb45452e70 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -889,8 +889,9 @@ void nvdimm_init_acpi_state(AcpiNVDIMMState *state, MemoryRegion *io,
 
     state->dsm_mem = g_array_new(false, true /* clear */, 1);
     acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
-    fw_cfg_add_file(fw_cfg, NVDIMM_DSM_MEM_FILE, state->dsm_mem->data,
-                    state->dsm_mem->len);
+    if (fw_cfg)
+        fw_cfg_add_file(fw_cfg, NVDIMM_DSM_MEM_FILE, state->dsm_mem->data,
+                        state->dsm_mem->len);
 
     nvdimm_init_fit_buffer(&state->fit_buf);
 }
-- 
2.12.0
