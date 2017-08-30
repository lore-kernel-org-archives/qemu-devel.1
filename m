Received: from eggs.gnu.org ([2001:4830:134:3::10]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Hm-0004d2-TH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Hm-0006P4-5z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:52 +0200
Message-Id: <20170830165252.13421-45-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 44/44] s390x/pci: fixup trap_msix()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

The function trap_msix() is to check if pcistg instruction would access
msix table entries. The correct boundary condition should be
[table_offset, table_offset+entries*entry_size). But the current
condition calculated misses the last entry. So let's fixup it.

Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Message-Id: <1503907487-2764-2-git-send-email-zyimin@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index b7beb8c36a..eba9ffb5f2 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -440,8 +440,8 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
 {
     if (pbdev->msix.available && pbdev->msix.table_bar == pcias &&
         offset >= pbdev->msix.table_offset &&
-        offset <= pbdev->msix.table_offset +
-                  (pbdev->msix.entries - 1) * PCI_MSIX_ENTRY_SIZE) {
+        offset < (pbdev->msix.table_offset +
+                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
         return 1;
     } else {
         return 0;
-- 
2.13.5
