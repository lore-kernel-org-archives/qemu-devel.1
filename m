Received: from eggs.gnu.org ([2001:4830:134:3::10]:56316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYH-000101-6t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYG-0004bx-9M
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:23374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGYF-0004UV-Uj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:28 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:55 +0800
Message-Id: <20170911044157.15403-9-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 08/10] nvdimm acpi: copy ACPI
 namespace device of vNVDIMM to Xen guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

Xen relies on QEMU to build the ACPI namespace device of vNVDIMM for
Xen guest.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
---
 hw/acpi/nvdimm.c | 55 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index d9cdc5a531..bf887512ad 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1226,22 +1226,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
     }
 }
 
-static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_arrea,
-                              uint32_t ram_slots)
+static void nvdimm_build_ssdt_device(Aml *dev, uint32_t ram_slots)
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
@@ -1262,6 +1248,25 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
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
+    nvdimm_build_ssdt_device(dev, ram_slots);
 
     aml_append(sb_scope, dev);
     aml_append(ssdt, sb_scope);
@@ -1285,6 +1290,18 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
     free_aml_allocator();
 }
 
+static void nvdimm_build_xen_ssdt(uint32_t ram_slots)
+{
+    Aml *dev = init_aml_allocator();
+
+    nvdimm_build_ssdt_device(dev, ram_slots);
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
@@ -1296,8 +1313,12 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
         return;
     }
 
-    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
-                      ram_slots);
+    if (!xen_enabled()) {
+        nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
+                          ram_slots);
+    } else {
+        nvdimm_build_xen_ssdt(ram_slots);
+    }
 
     device_list = nvdimm_get_device_list();
     /* no NVDIMM device is plugged. */
-- 
2.11.0
