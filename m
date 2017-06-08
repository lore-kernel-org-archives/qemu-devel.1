Received: from eggs.gnu.org ([2001:4830:134:3::10]:59189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EQ-0001S2-Q8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EP-0007md-R0
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ3EP-0007m1-Kk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:33 -0400
Date: Thu, 8 Jun 2017 22:36:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496950567-26343-3-git-send-email-mst@redhat.com>
References: <1496950567-26343-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496950567-26343-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] nvdimm acpi: fix region format interface
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

Per ACPI 6.2, section 5.2.25.6 and JEDEC Annex L Release 3, the
current region format interface code 0x201 indicates the block
addressed function interface 1, rather than a byte addressable
interface. Fix it by using 0x301 which indicates the byte addressable
no energy backed function interface 1.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/acpi/nvdimm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 8e7d6ec..b5734f5 100644
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
MST
