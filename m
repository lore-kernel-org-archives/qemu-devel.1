Received: from eggs.gnu.org ([2001:4830:134:3::10]:56294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYE-0000xu-TZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYD-0004ak-GT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:23374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGYD-0004UV-7r
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:25 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:54 +0800
Message-Id: <20170911044157.15403-8-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 07/10] nvdimm acpi: copy NFIT to
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
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

Xen relies on QEMU to build the guest NFIT.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
---
 hw/acpi/nvdimm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9121a766c6..d9cdc5a531 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -404,6 +404,12 @@ static void nvdimm_build_nfit(AcpiNVDIMMState *state, GArray *table_offsets,
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
2.11.0
