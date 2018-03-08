Received: from eggs.gnu.org ([2001:4830:134:3::10]:59694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=598f021c8=igor.druzhinin@citrix.com>)
	id 1etv2Q-0007n0-FI
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=598f021c8=igor.druzhinin@citrix.com>)
	id 1etv2L-0006oj-Nm
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:52:50 -0500
Received: from smtp.citrix.com ([66.165.176.89]:28406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=598f021c8=igor.druzhinin@citrix.com>)
	id 1etv2L-0006o6-Hw
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:52:45 -0500
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Thu, 8 Mar 2018 12:52:31 +0000
Message-ID: <1520513551-19851-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen-pvdevice: Introduce a simplistic
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
Cc: sstabellini@kernel.org, paul.durrant@citrix.com, anthony.perard@citrix.com, mst@redhat.com, pbonzini@redhat.com, Igor Druzhinin <igor.druzhinin@citrix.com>

This should help to avoid problems with accessing the device after
migration/resume without PV drivers. Older systems will acquire
the new record when migrated which should not change their state for
worse.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 hw/i386/xen/xen_pvdevice.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index c093b34..ef22a03 100644
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
