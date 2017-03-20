Received: from eggs.gnu.org ([2001:4830:134:3::10]:58198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwh-00054W-9N
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwg-0004ve-Dw
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwg-0004uJ-4J
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:10 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:44 +0800
Message-Id: <20170320001249.25521-6-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 05/10] nvdimm acpi: copy NFIT to
 Xen guest
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

Xen relies on QEMU to build the guest NFIT.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
---
 hw/acpi/nvdimm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index bb45452e70..2509561729 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -32,6 +32,7 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/xen/xen.h"
 
 static int nvdimm_device_list(Object *obj, void *opaque)
 {
@@ -402,6 +403,12 @@ static void nvdimm_build_nfit(AcpiNVDIMMState *state, GArray *table_offsets,
     build_header(linker, table_data,
                  (void *)(table_data->data + header), "NFIT",
                  sizeof(NvdimmNfitHeader) + fit_buf->fit->len, 1, NULL, NULL);
+
+    if (xen_enabled()) {
+        xen_acpi_copy_to_guest("NFIT", table_data->data + header,
+                               sizeof(NvdimmNfitHeader) + fit_buf->fit->len,
+                               XEN_DM_ACPI_BLOB_TYPE_TABLE);
+    }
 }
 
 #define NVDIMM_DSM_MEMORY_SIZE      4096
-- 
2.12.0
