Received: from eggs.gnu.org ([2001:4830:134:3::10]:39067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsy-0003xN-Jh
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzst-0007eF-Kv
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:48 -0500
Date: Fri, 16 Dec 2016 23:17:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-9-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 8/9] pci: fix error message for express
 slots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Marcel Apfelbaum <marcel@redhat.com>, stefanha@redhat.com

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
MST
