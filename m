Received: from eggs.gnu.org ([2001:4830:134:3::10]:56341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYJ-00011r-Gd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYI-0004d0-Nr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:23374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGYI-0004UV-EH
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:30 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:56 +0800
Message-Id: <20170911044157.15403-10-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 09/10] nvdimm acpi: do not build
 _FIT method on Xen
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

Xen currently does not support vNVDIMM hotplug and always sets QEMU
option "maxmem" to be just enough for RAM and vNVDIMM, so it's not
necessary to build _FIT method when QEMU is used as Xen device model.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
---
 hw/acpi/nvdimm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index bf887512ad..61789c3966 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1245,7 +1245,14 @@ static void nvdimm_build_ssdt_device(Aml *dev, uint32_t ram_slots)
 
     /* 0 is reserved for root device. */
     nvdimm_build_device_dsm(dev, 0);
-    nvdimm_build_fit(dev);
+    /*
+     * Xen does not support vNVDIMM hotplug, and always sets the QEMU
+     * option "maxmem" to be just enough for RAM and static plugged
+     * vNVDIMM, so it's unnecessary to build _FIT method on Xen.
+     */
+    if (!xen_enabled()) {
+        nvdimm_build_fit(dev);
+    }
 
     nvdimm_build_nvdimm_devices(dev, ram_slots);
 }
-- 
2.11.0
