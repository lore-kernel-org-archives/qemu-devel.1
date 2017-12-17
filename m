Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsR-0001O3-Lj
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsQ-0005hl-MU
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:39 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:41741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsQ-0005hJ-H2
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:38 -0500
Received: by mail-qt0-x243.google.com with SMTP id i40so17852922qti.8
	for <qemu-devel@nongnu.org>; Sun, 17 Dec 2017 12:49:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 17 Dec 2017 17:49:12 -0300
Message-Id: <20171217204912.12420-5-f4bug@amsat.org>
In-Reply-To: <20171217204912.12420-1-f4bug@amsat.org>
References: <20171217204912.12420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] hw/pci: remove obsolete PCIDevice->init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

All PCI devices are now QOM'ified.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/pci/pci.h |  1 -
 hw/pci/pci.c         | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d02a0a383..0f1ed64c2f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -217,7 +217,6 @@ typedef struct PCIDeviceClass {
     DeviceClass parent_class;
 
     void (*realize)(PCIDevice *dev, Error **errp);
-    int (*init)(PCIDevice *dev);/* TODO convert to realize() and remove */
     PCIUnregisterFunc *exit;
     PCIConfigReadFunc *config_read;
     PCIConfigWriteFunc *config_write;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b2d139bd9a..cd25ab6f6b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2054,18 +2054,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     }
 }
 
-static void pci_default_realize(PCIDevice *dev, Error **errp)
-{
-    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
-
-    if (pc->init) {
-        if (pc->init(dev) < 0) {
-            error_setg(errp, "Device initialization failed");
-            return;
-        }
-    }
-}
-
 PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifunction,
                                     const char *name)
 {
@@ -2538,13 +2526,11 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev)
 static void pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_qdev_realize;
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     k->props = pci_props;
-    pc->realize = pci_default_realize;
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
-- 
2.15.1
