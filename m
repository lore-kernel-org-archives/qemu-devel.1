Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrjl-00044W-HI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrjk-0007lH-OI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1evrjk-0007kf-Iz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:45:36 -0400
Date: Tue, 13 Mar 2018 23:45:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520977432-187679-18-git-send-email-mst@redhat.com>
References: <1520977432-187679-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1520977432-187679-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/22] hw/pci: remove obsolete PCIDevice->init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

All PCI devices are now QOM'ified.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h |  1 -
 hw/pci/pci.c         | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d8c18c7..e28f3fa 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -217,7 +217,6 @@ typedef struct PCIDeviceClass {
     DeviceClass parent_class;
=20
     void (*realize)(PCIDevice *dev, Error **errp);
-    int (*init)(PCIDevice *dev);/* TODO convert to realize() and remove =
*/
     PCIUnregisterFunc *exit;
     PCIConfigReadFunc *config_read;
     PCIConfigWriteFunc *config_write;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2174c25..f98efdc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2049,18 +2049,6 @@ static void pci_qdev_realize(DeviceState *qdev, Er=
ror **errp)
     }
 }
=20
-static void pci_default_realize(PCIDevice *dev, Error **errp)
-{
-    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
-
-    if (pc->init) {
-        if (pc->init(dev) < 0) {
-            error_setg(errp, "Device initialization failed");
-            return;
-        }
-    }
-}
-
 PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifu=
nction,
                                     const char *name)
 {
@@ -2533,13 +2521,11 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev=
)
 static void pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k =3D DEVICE_CLASS(klass);
-    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
=20
     k->realize =3D pci_qdev_realize;
     k->unrealize =3D pci_qdev_unrealize;
     k->bus_type =3D TYPE_PCI_BUS;
     k->props =3D pci_props;
-    pc->realize =3D pci_default_realize;
 }
=20
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
--=20
MST
