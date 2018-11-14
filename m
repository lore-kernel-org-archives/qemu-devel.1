Received: from eggs.gnu.org ([2001:4830:134:3::10]:33855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gN283-0004WJ-O0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gN281-0004zM-1z
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gN280-0004z8-SZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:51:13 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 14 Nov 2018 13:51:05 -0700
Message-ID: <154222866587.9288.1217475364900572268.stgit@gimli.home>
In-Reply-To: <154222737752.9288.484557356059052047.stgit@gimli.home>
References: <154222737752.9288.484557356059052047.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC for-3.2 PATCH 4/7] pcie: Add link speed and width
 fields to PCIESlot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, geoff@hostfission.com

Add fields allowing the PCIe link speed and width of a PCIESlot to
be configured, with an instance_post_init callback on the root port
parent class to set defaults.  This allows child classes to via
properties, without requiring all implementions to support arbitrary
user selected values, and also allows child class instance_init
callbacks to set defaults, for example using a machine defined link
default.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci-bridge/pcie_root_port.c |   14 ++++++++++++++
 include/hw/pci/pcie_port.h     |    4 ++++
 2 files changed, 18 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 45f9e8cd4a36..34ad76743c44 100644
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
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 0736014bfdb4..df242a0cafff 100644
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
 
