Received: from eggs.gnu.org ([2001:4830:134:3::10]:58150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwc-00051M-Ab
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwZ-0004uU-53
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwY-0004uJ-Rj
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:03 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:40 +0800
Message-Id: <20170320001249.25521-2-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 01/10] nvdimm xen: disable label
 support on Xen
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

If xen_enabled(), memory_region_get_ram_ptr() always returns NULL and
nvdimm_realize() cannot get the correct pointer to the label area. This
commit disables the label support for Xen accelerator to workaround
this issue.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
---
 hw/mem/nvdimm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db896b0bb6..0d3e17e94c 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -87,7 +87,11 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
     align = memory_region_get_alignment(mr);
 
     pmem_size = size - nvdimm->label_size;
-    nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
+    /*
+     * TODO: explain the reason
+     */
+    if (nvdimm->label_size)
+        nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
     pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
 
     if (size <= nvdimm->label_size || !pmem_size) {
-- 
2.12.0
