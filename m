Received: from eggs.gnu.org ([2001:4830:134:3::10]:54219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHz5-0005yU-JB
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHz2-0002Vq-E7
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHz2-0002VF-3o
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:12:36 -0500
Date: Tue, 18 Dec 2018 11:12:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-14-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 13/30] pcie: Add link speed and width fields
 to PCIESlot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Geoffrey McRae <geoff@hostfission.com>, Eric Auger <eric.auger@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Add fields allowing the PCIe link speed and width of a PCIESlot to
be configured, with an instance_post_init callback on the root port
parent class to set defaults.  This allows child classes to set these
via properties or via their own instance_init callback, without
requiring all implementions to support arbitrary user selected values.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_port.h     |  4 ++++
 hw/pci-bridge/pcie_root_port.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 0736014bfd..df242a0caf 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -49,6 +49,10 @@ struct PCIESlot {
     /* pci express switch port with slot */
     uint8_t     chassis;
     uint16_t    slot;
+
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+
     QLIST_ENTRY(PCIESlot) next;
 };
 
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 45f9e8cd4a..34ad76743c 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -140,6 +140,19 @@ static Property rp_props[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void rp_instance_post_init(Object *obj)
+{
+    PCIESlot *s = PCIE_SLOT(obj);
+
+    if (!s->speed) {
+        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
+    }
+
+    if (!s->width) {
+        s->width = QEMU_PCI_EXP_LNK_X1;
+    }
+}
+
 static void rp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -157,6 +170,7 @@ static void rp_class_init(ObjectClass *klass, void *data)
 static const TypeInfo rp_info = {
     .name          = TYPE_PCIE_ROOT_PORT,
     .parent        = TYPE_PCIE_SLOT,
+    .instance_post_init = rp_instance_post_init,
     .class_init    = rp_class_init,
     .abstract      = true,
     .class_size = sizeof(PCIERootPortClass),
-- 
MST
