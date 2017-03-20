Received: from eggs.gnu.org ([2001:4830:134:3::10]:58230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwl-000598-T3
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwi-0004wT-Nd
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwi-0004uJ-Fv
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:12 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:45 +0800
Message-Id: <20170320001249.25521-7-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 06/10] nvdimm acpi: build and copy
 NVDIMM namespace devices to guest on Xen
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

Build and copy NVDIMM namespace devices to guest when QEMU is used as
Xen device model. Only the body of each AML device is built and copied.
Xen hvmloader will complete other parts of namespace devices and put
in SSDT.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
---
 hw/acpi/nvdimm.c | 55 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 2509561729..1e077eca25 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1222,22 +1222,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
     }
 }
 
-static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_arrea,
-                              uint32_t ram_slots)
+static void nvdimm_build_devices(Aml *dev, uint32_t ram_slots)
 {
-    Aml *ssdt, *sb_scope, *dev;
-    int mem_addr_offset, nvdimm_ssdt;
-
-    acpi_add_table(table_offsets, table_data);
-
-    ssdt = init_aml_allocator();
-    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
-
-    sb_scope = aml_scope("\\_SB");
-
-    dev = aml_device("NVDR");
-
     /*
      * ACPI 6.0: 9.20 NVDIMM Devices:
      *
@@ -1258,6 +1244,25 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
     nvdimm_build_fit(dev);
 
     nvdimm_build_nvdimm_devices(dev, ram_slots);
+}
+
+static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
+                              BIOSLinker *linker, GArray *dsm_dma_arrea,
+                              uint32_t ram_slots)
+{
+    Aml *ssdt, *sb_scope, *dev;
+    int mem_addr_offset, nvdimm_ssdt;
+
+    acpi_add_table(table_offsets, table_data);
+
+    ssdt = init_aml_allocator();
+    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
+
+    sb_scope = aml_scope("\\_SB");
+
+    dev = aml_device("NVDR");
+
+    nvdimm_build_devices(dev, ram_slots);
 
     aml_append(sb_scope, dev);
     aml_append(ssdt, sb_scope);
@@ -1281,6 +1286,18 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
     free_aml_allocator();
 }
 
+static void nvdimm_build_xen_nvdimm_devices(uint32_t ram_slots)
+{
+    Aml *dev = init_aml_allocator();
+
+    nvdimm_build_devices(dev, ram_slots);
+    build_append_named_dword(dev->buf, NVDIMM_ACPI_MEM_ADDR);
+    xen_acpi_copy_to_guest("NVDR", dev->buf->data, dev->buf->len,
+                           XEN_DM_ACPI_BLOB_TYPE_NSDEV);
+
+    free_aml_allocator();
+}
+
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, AcpiNVDIMMState *state,
                        uint32_t ram_slots)
@@ -1292,8 +1309,12 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
         return;
     }
 
-    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
-                      ram_slots);
+    if (!xen_enabled()) {
+        nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
+                          ram_slots);
+    } else {
+        nvdimm_build_xen_nvdimm_devices(ram_slots);
+    }
 
     device_list = nvdimm_get_device_list();
     /* no NVDIMM device is plugged. */
-- 
2.12.0
