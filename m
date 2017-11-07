Received: from eggs.gnu.org ([2001:4830:134:3::10]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eC85e-0004Us-SB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eC85a-0003iN-Ud
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:55:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56862
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eC85a-0003i2-Oq
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:55:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7HrwJh065365
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:55:06 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e3gec3mfk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:55:05 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 7 Nov 2017 17:55:01 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  7 Nov 2017 18:54:55 +0100
In-Reply-To: <20171107175455.73793-1-borntraeger@de.ibm.com>
References: <20171107175455.73793-1-borntraeger@de.ibm.com>
Message-Id: <20171107175455.73793-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/pci: let pci devices start in
 configured mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Currently, to enable a pci device in the guest, the user has to issue
echo 1 > /sys/bus/pci/slots/00000000/power. This is not what people
expect. On an LPAR, the user can put a PCI device in configured or
deconfigured state via IOCDS. The "start in deconfigured state" can be
used for "sharing" a pci function across LPARs. This is not what we are
going to use in KVM, so always start configured.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e7a58e8..2b1e140 100644
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
2.9.4
