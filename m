Received: from eggs.gnu.org ([2001:4830:134:3::10]:43677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCV-0005Dj-SC
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCT-0001mm-96
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCS-0001lp-Uy
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haip129101
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:07 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkw91e3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:07 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:07 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:45:01 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-68-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 67/67] vfio/pci: Fix
 vfio_rtl8168_quirk_data_read address offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thorsten Kohfeldt <thorsten.kohfeldt@gmx.de>, Alex Williamson <alex.williamson@redhat.com>

From: Thorsten Kohfeldt <thorsten.kohfeldt@gmx.de>

Introductory comment for rtl8168 VFIO MSI-X quirk states:
At BAR2 offset 0x70 there is a dword data register,
         offset 0x74 is a dword address register.
vfio: vfio_bar_read(0000:05:00.0:BAR2+0x70, 4) = 0xfee00398 // read data

Thus, correct offset for data read is 0x70,
but function vfio_rtl8168_quirk_data_read() wrongfully uses offset 0x74.

Signed-off-by: Thorsten Kohfeldt <thorsten.kohfeldt@gmx.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
(cherry picked from commit 31e6a7b17b35711eb44f0e686b5ba68d15bfe4c1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/pci-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bec694c..1e97bc4 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -898,7 +898,7 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
 {
     VFIOrtl8168Quirk *rtl = opaque;
     VFIOPCIDevice *vdev = rtl->vdev;
-    uint64_t data = vfio_region_read(&vdev->bars[2].region, addr + 0x74, size);
+    uint64_t data = vfio_region_read(&vdev->bars[2].region, addr + 0x70, size);
 
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
-- 
1.9.1
