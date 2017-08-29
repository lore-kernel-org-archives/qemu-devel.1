Received: from eggs.gnu.org ([2001:4830:134:3::10]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC4-0000po-7V
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC1-000530-7F
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC0-00052Q-SD
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E868077501
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:42 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yuam-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:42 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:42 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:44 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-10-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 09/79] pci: deassert intx when pci device
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: "Herongguang (Stephen)" <herongguang.he@huawei.com>

If a pci device is not reset by VM (by writing into config space)
and unplugged by VM, after that when VM reboots, qemu may assert:
pcibus_reset: Assertion `bus->irq_count[i] == 0' failed

Cc: qemu-stable@nongnu.org
Signed-off-by: herongguang <herongguang.he@huawei.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 3936161f1fd72d1dfa577aaba910819c5e873260)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b..98ccc27 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1083,6 +1083,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
         pc->exit(pci_dev);
     }
 
+    pci_device_deassert_intx(pci_dev);
     do_pci_unregister_device(pci_dev);
 }
 
-- 
2.7.4
