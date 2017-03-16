Received: from eggs.gnu.org ([2001:4830:134:3::10]:48818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFs-0000Ch-Qt
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFr-00014r-QK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:08 -0400
Received: from mail.kernel.org ([198.145.29.136]:60982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFr-000122-Ge
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:07 -0400
Date: Thu, 16 Mar 2017 04:35:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489631689-6382-3-git-send-email-mst@redhat.com>
References: <1489631689-6382-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489631689-6382-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] hw/virtio: fix error enabling flags in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

When the virtio devices are PCI Express, make error-enabling flags
writable to respect the PCIe spec.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h |  4 ++++
 include/hw/compat.h    |  4 ++++
 hw/virtio/virtio-pci.c | 12 ++++++++++++
 dtc                    |  2 +-
 4 files changed, 21 insertions(+), 1 deletion(-)

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
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 69cc471..f6de5ee 100644
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
@@ -1862,6 +1868,10 @@ static void virtio_pci_reset(DeviceState *qdev)
         proxy->vqs[i].avail[0] = proxy->vqs[i].avail[1] = 0;
         proxy->vqs[i].used[0] = proxy->vqs[i].used[1] = 0;
     }
+
+    if (pci_is_express(dev)) {
+        pcie_cap_deverr_reset(dev);
+    }
 }
 
 static Property virtio_pci_properties[] = {
@@ -1882,6 +1892,8 @@ static Property virtio_pci_properties[] = {
                      ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
+    DEFINE_PROP_BIT("x-pcie-deverr-init", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_INIT_DEVERR_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/dtc b/dtc
index 558cd81..65cc4d2 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
+Subproject commit 65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf
-- 
MST
