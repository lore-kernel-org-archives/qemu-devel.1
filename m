Received: from eggs.gnu.org ([2001:4830:134:3::10]:43444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCN-0004vn-KN
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCK-0001fh-38
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCJ-0001ep-Po
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:59 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbAZ047977
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:58 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm3s40c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:58 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:57 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:54 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-61-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 60/67] pci-assign: sync MSI/MSI-X cap and table
 with PCIDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Xu <peterx@redhat.com>

Since commit e1d4fb2d ("kvm-irqchip: x86: add msi route notify fn"),
kvm_irqchip_add_msi_route() starts to use pci_get_msi_message() to fetch
MSI info. This requires that we setup MSI related fields in PCIDevice.
For most devices, that won't be a problem, as long as we are using
general interfaces like msi_init()/msix_init().

However, for pci-assign devices, MSI/MSI-X is treated differently - PCI
assign devices are maintaining its own MSI table and cap information in
AssignedDevice struct. however that's not synced up with PCIDevice's
fields. That will leads to pci_get_msi_message() failed to find correct
MSI capability, even with an NULL msix_table.

A quick fix is to sync up the two places: both the capability bits and
table address for MSI/MSI-X.

Reported-by: Changlimin <changlimin@h3c.com>
Tested-by: Changlimin <changlimin@h3c.com>
Cc: qemu-stable@nongnu.org
Fixes: e1d4fb2d ("kvm-irqchip: x86: add msi route notify fn")
Signed-off-by: Peter Xu <peterx@redhat.com>

Message-Id: <1480042522-16551-1-git-send-email-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 64e184e2608d3c93dda1bba8ae6dc2185b5228fb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/kvm/pci-assign.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
index 8238fbc..87dcbdd 100644
--- a/hw/i386/kvm/pci-assign.c
+++ b/hw/i386/kvm/pci-assign.c
@@ -1251,6 +1251,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
             error_propagate(errp, local_err);
             return -ENOTSUP;
         }
+        dev->dev.cap_present |= QEMU_PCI_CAP_MSI;
         dev->cap.available |= ASSIGNED_DEVICE_CAP_MSI;
         /* Only 32-bit/no-mask currently supported */
         ret = pci_add_capability2(pci_dev, PCI_CAP_ID_MSI, pos, 10,
@@ -1285,6 +1286,7 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev, Error **errp)
             error_propagate(errp, local_err);
             return -ENOTSUP;
         }
+        dev->dev.cap_present |= QEMU_PCI_CAP_MSIX;
         dev->cap.available |= ASSIGNED_DEVICE_CAP_MSIX;
         ret = pci_add_capability2(pci_dev, PCI_CAP_ID_MSIX, pos, 12,
                                   &local_err);
@@ -1648,6 +1650,7 @@ static void assigned_dev_register_msix_mmio(AssignedDevice *dev, Error **errp)
         dev->msix_table = NULL;
         return;
     }
+    dev->dev.msix_table = (uint8_t *)dev->msix_table;
 
     assigned_dev_msix_reset(dev);
 
@@ -1665,6 +1668,7 @@ static void assigned_dev_unregister_msix_mmio(AssignedDevice *dev)
         error_report("error unmapping msix_table! %s", strerror(errno));
     }
     dev->msix_table = NULL;
+    dev->dev.msix_table = NULL;
 }
 
 static const VMStateDescription vmstate_assigned_device = {
-- 
1.9.1
