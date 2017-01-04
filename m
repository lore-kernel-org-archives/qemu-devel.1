Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cOrge-0005Nm-RC
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cOrgc-0005jQ-JE
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cOrgc-0005iu-DG
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:57:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C4FC804E2
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 19:57:26 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  4 Jan 2017 21:57:16 +0200
Message-Id: <1483559838-8797-3-git-send-email-marcel@redhat.com>
In-Reply-To: <1483559838-8797-1-git-send-email-marcel@redhat.com>
References: <1483559838-8797-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] hw/virtio: fix error enabling flags in
 Device Control register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, yvugenfi@redhat.com

When the virtio devices are PCI Express, make error-enabling flags
writable to respect the PCIe spec.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/virtio/virtio-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 21c2b9d..da2124f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1802,6 +1802,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
          * PCI Power Management Interface Specification.
          */
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
+        /* Init error enabling flags */
+        pcie_cap_deverr_init(pci_dev);
     } else {
         /*
          * make future invocations of pci_is_express() return false
@@ -1828,6 +1830,7 @@ static void virtio_pci_reset(DeviceState *qdev)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
     VirtioBusState *bus = VIRTIO_BUS(&proxy->bus);
+    PCIDevice *dev = PCI_DEVICE(qdev);
     int i;
 
     virtio_pci_stop_ioeventfd(proxy);
@@ -1837,6 +1840,10 @@ static void virtio_pci_reset(DeviceState *qdev)
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         proxy->vqs[i].enabled = 0;
     }
+
+    if (pci_is_express(dev)) {
+        pcie_cap_deverr_reset(dev);
+    }
 }
 
 static Property virtio_pci_properties[] = {
-- 
2.5.5
