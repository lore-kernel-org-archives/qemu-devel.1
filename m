Received: from eggs.gnu.org ([2001:4830:134:3::10]:35253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.tai@oracle.com>) id 1epErS-0007k9-1L
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.tai@oracle.com>) id 1epErO-0006r3-8I
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:02:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thomas.tai@oracle.com>)
	id 1epErN-0006pM-VC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:02:06 -0500
From: Thomas Tai <thomas.tai@oracle.com>
Date: Fri, 23 Feb 2018 10:02:01 -0500
Message-Id: <20180223150201.2960-1-thomas.tai@oracle.com>
Subject: [Qemu-devel] [PATCH] e1000e : fix PCIe AER error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thomas.tai@oracle.com, qemu-devel@nongnu.org, dmitry.fleytman@gmail.com

When using qemu pcie_aer_inject_error command to inject
an error on e1000e, the error is not sent to the guest.
The problem is caused by the e1000e did not initialize
the device error control registers mask. Since the
default mask is 0, any value written to the registers
will be masked off.

Followed pci-bridge/xio3130_downstream.c to use
pcie_cap_deverr_init() to initialize the mask.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 hw/net/e1000e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 191398a3d5..1ebcaa2d19 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -478,6 +478,7 @@ static void e1000e_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize PM capability");
     }
 
+    pcie_cap_deverr_init(pci_dev);
     if (pcie_aer_init(pci_dev, PCI_ERR_VER, e1000e_aer_offset,
                       PCI_ERR_SIZEOF, NULL) < 0) {
         hw_error("Failed to initialize AER capability");
-- 
2.14.1
