Received: from eggs.gnu.org ([2001:4830:134:3::10]:35547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dIW05-00081e-EM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dIW02-0007wi-81
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:07:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:42121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dIW01-0007vt-VV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:07:30 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed,  7 Jun 2017 16:06:39 +0800
Message-Id: <20170607080639.22120-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] nvdimm acpi: fix region format interface code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Per ACPI 6.2, section 5.2.25.6 and JEDEC Annex L Release 3, the
current region format interface code 0x201 indicates the block
addressed function interface 1, rather than a byte addressable
interface. Fix it by using 0x301 which indicates the byte addressable
no energy backed function interface 1.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/acpi/nvdimm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec034..b5734f5897 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -338,9 +338,10 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
     nfit_dcr->revision_id = cpu_to_le16(1 /* Current Revision supported
                                              in ACPI 6.0 is 1. */);
     nfit_dcr->serial_number = cpu_to_le32(sn);
-    nfit_dcr->fic = cpu_to_le16(0x201 /* Format Interface Code. See Chapter
-                                         2: NVDIMM Device Specific Method
-                                         (DSM) in DSM Spec Rev1.*/);
+    nfit_dcr->fic = cpu_to_le16(0x301 /* Format Interface Code:
+                                         Byte addressable, no energy backed.
+                                         See ACPI 6.2, sect 5.2.25.6 and
+                                         JEDEC Annex L Release 3. */);
 }
 
 static GArray *nvdimm_build_device_structure(void)
-- 
2.11.0
