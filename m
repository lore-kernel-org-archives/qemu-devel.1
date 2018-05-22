Received: from eggs.gnu.org ([2001:4830:134:3::10]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ3-0001cB-IB
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ2-0007PK-PG
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fLCJ2-0007P3-Ia
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:44 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 22 May 2018 11:46:28 -0700
Message-Id: <1527014802-11289-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL v2 01/15] xen-pvdevice: Introduce a simplistic
 xen-pvdevice save state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

From: Igor Druzhinin <igor.druzhinin@citrix.com>

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
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
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
1.9.1
