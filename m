Received: from eggs.gnu.org ([2001:4830:134:3::10]:40940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qj-0001gY-1G
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qd-0004v4-Fx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qd-0004td-6P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Y1p020617
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:30 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 299yqc6ymd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:29 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:29 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:01 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-38-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/81] pci: fix error message for express slots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

PCI Express downstream slot has a single PCI slot
behind it, using PCI_DEVFN(PCI_SLOT(devfn), 0)
does not give you function 0 in cases such as ARI
as well as some error cases.

This is exactly what we are hitting:
   $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg
-monitor stdio
   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
   Segmentation fault (core dumped)

The fix is to use the pci_get_function_0 API.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Tested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit d93ddfb1f8fb72a7c175a8cf1028c639f769d105)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 24fae16..637d545 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -982,8 +982,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
                    " new func %s cannot be exposed to guest.",
-                   PCI_SLOT(devfn),
-                   bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)]->name,
+                   PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
+                   pci_get_function_0(pci_dev)->name,
                    name);
 
        return NULL;
-- 
2.7.4
