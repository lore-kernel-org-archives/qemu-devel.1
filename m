Received: from eggs.gnu.org ([2001:4830:134:3::10]:35372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gYfuF-0007A9-1V
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 18:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gYfuA-000139-3V
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 18:33:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gYfu8-0000nY-Tv
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 18:33:01 -0500
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Mon, 17 Dec 2018 07:34:39 +0800
Message-Id: <1545003279-17233-1-git-send-email-dongli.zhang@oracle.com>
Subject: [Qemu-devel] [PATCH 1/1] msix: correct pba size calculation used
 for msix_exclusive_bar initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com

The bar_pba_size is more than what the pba is expected to have, although
this usually would not affect the bar_size used for dev->msix_exclusive_bar
initialization.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/pci/msix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 702dac4..234c0a3 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -345,7 +345,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     char *name;
     uint32_t bar_size = 4096;
     uint32_t bar_pba_offset = bar_size / 2;
-    uint32_t bar_pba_size = (nentries / 8 + 1) * 8;
+    uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
 
     /*
      * Migration compatibility dictates that this remains a 4k
-- 
2.7.4
