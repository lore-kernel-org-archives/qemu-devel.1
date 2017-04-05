Received: from eggs.gnu.org ([2001:4830:134:3::10]:43035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cvrd5-0003Bj-Bs
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cvrd0-000798-Kh
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cvrd0-000792-FK
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:34:06 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 05 Apr 2017 14:34:02 -0600
Message-ID: <20170405203345.12539.45427.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] vfio/pci-quirks: Exclude non-ioport BAR from
 NVIDIA quirk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, 1678466@bugs.launchpad.net

The NVIDIA BAR5 quirk is targeting an ioport BAR.  Some older devices
have a BAR5 which is not ioport and can induce a segfault here.  Test
the BAR type to skip these devices.

Link: https://bugs.launchpad.net/qemu/+bug/1678466
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e9b493b939db..349085ea12bc 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -660,7 +660,7 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
     VFIOConfigWindowQuirk *window;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
-        !vdev->vga || nr != 5) {
+        !vdev->vga || nr != 5 || !vdev->bars[5].ioport) {
         return;
     }
 
