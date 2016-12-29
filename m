Received: from eggs.gnu.org ([2001:4830:134:3::10]:52944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cMixv-00053Z-Mg
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cMixs-0001c4-HB
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:14:27 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu, 29 Dec 2016 23:12:11 +0100
Message-Id: <1483049536-21548-2-git-send-email-hpoussin@reactos.org>
In-Reply-To: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] pci: add pci_vga_type(),
 giving the device name of the chosen VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

This is in fact a split of pci_vga_init() function in two parts.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 hw/pci/pci.c         | 22 ++++++++++++++++------
 include/hw/pci/pci.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 24fae16..0d5a862 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1816,19 +1816,19 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBu=
s *rootbus,
     return pci_dev;
 }
=20
-PCIDevice *pci_vga_init(PCIBus *bus)
+const char *pci_vga_type(void)
 {
     switch (vga_interface_type) {
     case VGA_CIRRUS:
-        return pci_create_simple(bus, -1, "cirrus-vga");
+        return "cirrus-vga";
     case VGA_QXL:
-        return pci_create_simple(bus, -1, "qxl-vga");
+        return "qxl-vga";
     case VGA_STD:
-        return pci_create_simple(bus, -1, "VGA");
+        return "VGA";
     case VGA_VMWARE:
-        return pci_create_simple(bus, -1, "vmware-svga");
+        return "vmware-svga";
     case VGA_VIRTIO:
-        return pci_create_simple(bus, -1, "virtio-vga");
+        return "virtio-vga";
     case VGA_NONE:
     default: /* Other non-PCI types. Checking for unsupported types is a=
lready
                 done in vl.c. */
@@ -1836,6 +1836,16 @@ PCIDevice *pci_vga_init(PCIBus *bus)
     }
 }
=20
+PCIDevice *pci_vga_init(PCIBus *bus)
+{
+    const char *vga_type =3D pci_vga_type();
+    if (vga_type) {
+        return pci_create_simple(bus, -1, vga_type);
+    } else {
+        return NULL;
+    }
+}
+
 /* Whether a given bus number is in range of the secondary
  * bus of the given bridge device. */
 static bool pci_secondary_bus_in_range(PCIDevice *dev, int bus_num)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 772692f..aa8d014 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -420,6 +420,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *r=
ootbus,
                                const char *default_model,
                                const char *default_devaddr);
=20
+const char *pci_vga_type(void);
 PCIDevice *pci_vga_init(PCIBus *bus);
=20
 int pci_bus_num(PCIBus *s);
--=20
2.1.4
