Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfunw-0001cI-EM
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cfunv-00005J-I0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cfunv-0008WR-9D
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:43:27 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C0524E4D8
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:43:27 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Mon, 20 Feb 2017 22:43:11 +0200
Message-Id: <1487623393-2492-3-git-send-email-marcel@redhat.com>
In-Reply-To: <1487623393-2492-1-git-send-email-marcel@redhat.com>
References: <1487623393-2492-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 2/4] hw/virtio: fix error enabling flags in
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
Cc: mst@redhat.com, marcel@redhat.com

When the virtio devices are PCI Express, make error-enabling flags
writable to respect the PCIe spec.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/virtio/virtio-pci.c | 12 ++++++++++++
 hw/virtio/virtio-pci.h |  4 ++++
 include/hw/compat.h    |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5ce42af..9e2bca6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1819,6 +1819,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
          */
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
+            /* Init error enabling flags */
+            pcie_cap_deverr_init(pci_dev);
+        }
+
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
             pcie_ats_init(pci_dev, 256);
         }
@@ -1849,6 +1854,7 @@ static void virtio_pci_reset(DeviceState *qdev)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
     VirtioBusState *bus = VIRTIO_BUS(&proxy->bus);
+    PCIDevice *dev = PCI_DEVICE(qdev);
     int i;
 
     virtio_pci_stop_ioeventfd(proxy);
@@ -1858,6 +1864,10 @@ static void virtio_pci_reset(DeviceState *qdev)
     for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
         proxy->vqs[i].enabled = 0;
     }
+
+    if (pci_is_express(dev)) {
+        pcie_cap_deverr_reset(dev);
+    }
 }
 
 static Property virtio_pci_properties[] = {
@@ -1878,6 +1888,8 @@ static Property virtio_pci_properties[] = {
                      ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
+    DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index d00064c..120661d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -73,6 +73,7 @@ enum {
     VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
+    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
 };
 
 /* Need to activate work-arounds for buggy guests at vmstate load. */
@@ -100,6 +101,9 @@ enum {
 /* address space translation service */
 #define VIRTIO_PCI_FLAG_ATS (1 << VIRTIO_PCI_FLAG_ATS_BIT)
 
+/* Init error enabling flags */
+#define VIRTIO_PCI_FLAG_INIT_DEVERR (1 << VIRTIO_PCI_FLAG_INIT_DEVERR_BIT)
+
 typedef struct {
     MSIMessage msg;
     int virq;
diff --git a/include/hw/compat.h b/include/hw/compat.h
index ce3bfe3..c98776a 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -22,6 +22,10 @@
         .driver   = TYPE_PCI_DEVICE,\
         .property = "x-pcie-extcap-init",\
         .value    = "off",\
+    },{\
+        .driver   = "virtio-pci",\
+        .property = "x-pcie-deverr-init",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_7 \
-- 
2.5.5
