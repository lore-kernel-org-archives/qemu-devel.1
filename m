Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaa-0004vg-CK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaV-0001dz-Hu
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAgaV-0001cc-3i
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:35 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 11 Oct 2018 20:25:12 +0100
Message-Id: <20181011192513.63634-7-dgilbert@redhat.com>
In-Reply-To: <20181011192513.63634-1-dgilbert@redhat.com>
References: <20181011192513.63634-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] qmp,
 hmp: make subsystem/system-vendor identities optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: wei@redhat.com, thuth@redhat.com, i.maximets@samsung.com, den@openvz.org

From: "Denis V. Lunev" <den@openvz.org>

According to PCI specification, subsystem id and subsystem vendor id
are present only in type 0 and type 2 headers (at different offsets),
but not in type 1 headers.

Thus we should make this data optional in struct PciDeviceId and skip
reporting them via HMP if the information is not available.

Additional (wrong information) about PCI bridges (Type1 devices) has been
added in 5383a705 and fortunately not released. This patch fixes that
problem. The problem was spotted by Markus.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181002135538.12113-1-den@openvz.org>
Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c          |  6 ++++--
 hw/pci/pci.c   | 13 ++++++++++---
 qapi/misc.json |  4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hmp.c b/hmp.c
index 61ef120423..7828f93a39 100644
--- a/hmp.c
+++ b/hmp.c
@@ -837,8 +837,10 @@ static void hmp_info_pci_device(Monitor *mon, const =
PciDeviceInfo *dev)
=20
     monitor_printf(mon, ": PCI device %04" PRIx64 ":%04" PRIx64 "\n",
                    dev->id->vendor, dev->id->device);
-    monitor_printf(mon, "      PCI subsystem %04" PRIx64 ":%04" PRIx64 "=
\n",
-                   dev->id->subsystem_vendor, dev->id->subsystem);
+    if (dev->id->has_subsystem_vendor && dev->id->has_subsystem) {
+        monitor_printf(mon, "      PCI subsystem %04" PRIx64 ":%04" PRIx=
64 "\n",
+                       dev->id->subsystem_vendor, dev->id->subsystem);
+    }
=20
     if (dev->has_irq) {
         monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 51d0dec466..b937f0dc0a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1737,9 +1737,6 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevic=
e *dev, PCIBus *bus,
     info->id =3D g_new0(PciDeviceId, 1);
     info->id->vendor =3D pci_get_word(dev->config + PCI_VENDOR_ID);
     info->id->device =3D pci_get_word(dev->config + PCI_DEVICE_ID);
-    info->id->subsystem =3D pci_get_word(dev->config + PCI_SUBSYSTEM_ID)=
;
-    info->id->subsystem_vendor =3D
-        pci_get_word(dev->config + PCI_SUBSYSTEM_VENDOR_ID);
     info->regions =3D qmp_query_pci_regions(dev);
     info->qdev_id =3D g_strdup(dev->qdev.id ? dev->qdev.id : "");
=20
@@ -1752,6 +1749,16 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevi=
ce *dev, PCIBus *bus,
     if (type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
         info->has_pci_bridge =3D true;
         info->pci_bridge =3D qmp_query_pci_bridge(dev, bus, bus_num);
+    } else if (type =3D=3D PCI_HEADER_TYPE_NORMAL) {
+        info->id->has_subsystem =3D info->id->has_subsystem_vendor =3D t=
rue;
+        info->id->subsystem =3D pci_get_word(dev->config + PCI_SUBSYSTEM=
_ID);
+        info->id->subsystem_vendor =3D
+            pci_get_word(dev->config + PCI_SUBSYSTEM_VENDOR_ID);
+    } else if (type =3D=3D PCI_HEADER_TYPE_CARDBUS) {
+        info->id->has_subsystem =3D info->id->has_subsystem_vendor =3D t=
rue;
+        info->id->subsystem =3D pci_get_word(dev->config + PCI_CB_SUBSYS=
TEM_ID);
+        info->id->subsystem_vendor =3D
+            pci_get_word(dev->config + PCI_CB_SUBSYSTEM_VENDOR_ID);
     }
=20
     return info;
diff --git a/qapi/misc.json b/qapi/misc.json
index f98de3a58c..3a68af9ca3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -839,8 +839,8 @@
 # Since: 2.4
 ##
 { 'struct': 'PciDeviceId',
-  'data': {'device': 'int', 'vendor': 'int', 'subsystem': 'int',
-            'subsystem-vendor': 'int'} }
+  'data': {'device': 'int', 'vendor': 'int', '*subsystem': 'int',
+            '*subsystem-vendor': 'int'} }
=20
 ##
 # @PciDeviceInfo:
--=20
2.19.0
