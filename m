Received: from eggs.gnu.org ([2001:4830:134:3::10]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGU-0005Re-OM
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGR-0003WJ-Iw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGR-000355-9u
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:47 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:10 +0800
Message-Id: <20171207101812.23602-9-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 08/10] nvdimm acpi: add functions
 to access DSM memory on Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Xen hvmloader can load QEMU-built NVDIMM ACPI tables via the
BIOSLinkerLoader interface, but it allocates memory in an area not
covered by any memory regions in QEMU, i.e., the hvmloader memory
cannot be accessed via the normal cpu_physical_memory_{read,write}().
If QEMU on Xen has to access the hvmloader memory in DSM emulation,
it has to take a different path, i.e., xen_copy_{from,to}_guest().

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/nvdimm.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 6ceea196e7..7b3062e001 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -32,6 +32,7 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/xen/xen.h"
 
 static int nvdimm_device_list(Object *obj, void *opaque)
 {
@@ -497,6 +498,35 @@ struct NvdimmFuncReadFITOut {
 typedef struct NvdimmFuncReadFITOut NvdimmFuncReadFITOut;
 QEMU_BUILD_BUG_ON(sizeof(NvdimmFuncReadFITOut) > NVDIMM_DSM_MEMORY_SIZE);
 
+/*
+ * Xen hvmloader can load QEMU-built NVDIMM ACPI tables via the
+ * BIOSLinkerLoader interface, but it allocates memory in an area not
+ * covered by any memory regions in QEMU, i.e., the hvmloader memory
+ * cannot be accessed via the normal cpu_physical_memory_{read,write}().
+ * If QEMU on Xen has to access the hvmloader memory in DSM emulation,
+ * it has to take a different path, i.e., xen_copy_{from,to}_guest().
+ */
+
+static void
+nvdimm_copy_from_dsm_mem(hwaddr dsm_mem_addr, void *dst, unsigned size)
+{
+    if (xen_enabled()) {
+        xen_copy_from_guest(dsm_mem_addr, dst, size);
+    } else {
+        cpu_physical_memory_read(dsm_mem_addr, dst, size);
+    }
+}
+
+static void
+nvdimm_copy_to_dsm_mem(hwaddr dsm_mem_addr, void *src, unsigned size)
+{
+    if (xen_enabled()) {
+        xen_copy_to_guest(dsm_mem_addr, src, size);
+    } else {
+        cpu_physical_memory_write(dsm_mem_addr, src, size);
+    }
+}
+
 static void
 nvdimm_dsm_function0(uint32_t supported_func, hwaddr dsm_mem_addr)
 {
@@ -504,7 +534,7 @@ nvdimm_dsm_function0(uint32_t supported_func, hwaddr dsm_mem_addr)
         .len = cpu_to_le32(sizeof(func0)),
         .supported_func = cpu_to_le32(supported_func),
     };
-    cpu_physical_memory_write(dsm_mem_addr, &func0, sizeof(func0));
+    nvdimm_copy_to_dsm_mem(dsm_mem_addr, &func0, sizeof(func0));
 }
 
 static void
@@ -514,7 +544,7 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
         .len = cpu_to_le32(sizeof(out)),
         .func_ret_status = cpu_to_le32(func_ret_status),
     };
-    cpu_physical_memory_write(dsm_mem_addr, &out, sizeof(out));
+    nvdimm_copy_to_dsm_mem(dsm_mem_addr, &out, sizeof(out));
 }
 
 #define NVDIMM_DSM_RET_STATUS_SUCCESS        0 /* Success */
@@ -569,7 +599,7 @@ exit:
     read_fit_out->func_ret_status = cpu_to_le32(func_ret_status);
     memcpy(read_fit_out->fit, fit->data + read_fit->offset, read_len);
 
-    cpu_physical_memory_write(dsm_mem_addr, read_fit_out, size);
+    nvdimm_copy_to_dsm_mem(dsm_mem_addr, read_fit_out, size);
 
     g_free(read_fit_out);
 }
@@ -655,8 +685,8 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
     label_size_out.label_size = cpu_to_le32(label_size);
     label_size_out.max_xfer = cpu_to_le32(mxfer);
 
-    cpu_physical_memory_write(dsm_mem_addr, &label_size_out,
-                              sizeof(label_size_out));
+    nvdimm_copy_to_dsm_mem(dsm_mem_addr, &label_size_out,
+                           sizeof(label_size_out));
 }
 
 static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
@@ -721,7 +751,7 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     nvc->read_label_data(nvdimm, get_label_data_out->out_buf,
                          get_label_data->length, get_label_data->offset);
 
-    cpu_physical_memory_write(dsm_mem_addr, get_label_data_out, size);
+    nvdimm_copy_to_dsm_mem(dsm_mem_addr, get_label_data_out, size);
     g_free(get_label_data_out);
 }
 
@@ -831,7 +861,7 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
      * this by copying DSM memory to QEMU local memory.
      */
     in = g_new(NvdimmDsmIn, 1);
-    cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
+    nvdimm_copy_from_dsm_mem(dsm_mem_addr, in, sizeof(*in));
 
     le32_to_cpus(&in->revision);
     le32_to_cpus(&in->function);
-- 
2.15.1
