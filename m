Received: from eggs.gnu.org ([2001:4830:134:3::10]:36250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=603125fd5=igor.druzhinin@citrix.com>)
	id 1evt8K-0002wv-ED
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=603125fd5=igor.druzhinin@citrix.com>)
	id 1evt8H-0000Kg-A6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:15:04 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:42852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=603125fd5=igor.druzhinin@citrix.com>)
	id 1evt8G-0000Ix-GJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:15:00 -0400
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Tue, 13 Mar 2018 23:14:54 +0000
Message-ID: <1520982894-4180-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] xen-pvdevice: Introduce a simplistic
 xen-pvdevice save state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, paul.durrant@citrix.com, pbonzini@redhat.com, mst@redhat.com, Igor Druzhinin <igor.druzhinin@citrix.com>

This should help to avoid problems with accessing the device after
migration/resume without PV drivers by migrating its PCI configuration
space state. Without an explicitly defined state record it resets
every time a VM migrates which confuses the OS and makes every
access to xen-pvdevice MMIO region to fail. PV tools enable some
logic to save and restore PCI configuration state from within the VM
every time it migrates which basically hides the issue.

Older systems will acquire the new record when migrated which should
not change their state for worse.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
---
v2: add more concrete info
---
 hw/i386/xen/xen_pvdevice.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index f748823..a146f18 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -71,6 +71,16 @@ static const MemoryRegionOps xen_pv_mmio_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static const VMStateDescription vmstate_xen_pvdevice = {
+    .name = "xen-pvdevice",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, XenPVDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void xen_pv_realize(PCIDevice *pci_dev, Error **errp)
 {
     XenPVDevice *d = XEN_PV_DEVICE(pci_dev);
@@ -120,6 +130,7 @@ static void xen_pv_class_init(ObjectClass *klass, void *data)
     k->class_id = PCI_CLASS_SYSTEM_OTHER;
     dc->desc = "Xen PV Device";
     dc->props = xen_pv_props;
+    dc->vmsd = &vmstate_xen_pvdevice;
 }
 
 static const TypeInfo xen_pv_type_info = {
-- 
2.7.4
