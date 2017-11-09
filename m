Received: from eggs.gnu.org ([2001:4830:134:3::10]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCooW-0005GW-Jn
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCooQ-00034c-QT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:32:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  9 Nov 2017 16:32:03 +0100
Message-Id: <20171109153204.26436-2-cohuck@redhat.com>
In-Reply-To: <20171109153204.26436-1-cohuck@redhat.com>
References: <20171109153204.26436-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 1/2] s390x/pci: let pci devices start
 in configured mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Currently, to enable a pci device in the guest, the user has to issue
echo 1 > /sys/bus/pci/slots/00000000/power. This is not what people
expect. On an LPAR, the user can put a PCI device in configured or
deconfigured state via IOCDS. The "start in deconfigured state" can be
used for "sharing" a pci function across LPARs. This is not what we are
going to use in KVM, so always start configured.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Message-Id: <20171107175455.73793-2-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e7a58e81f7..2b1e1409bf 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -715,7 +715,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         pbdev->pdev = pdev;
         pbdev->iommu = s390_pci_get_iommu(s, pdev->bus, pdev->devfn);
         pbdev->iommu->pbdev = pbdev;
-        pbdev->state = ZPCI_FS_STANDBY;
+        pbdev->state = ZPCI_FS_DISABLED;
 
         if (s390_pci_msix_init(pbdev)) {
             error_setg(errp, "MSI-X support is mandatory "
-- 
2.13.6
