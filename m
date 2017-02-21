Received: from eggs.gnu.org ([2001:4830:134:3::10]:36374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5Dh-000721-3C
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5Dc-0008Pt-88
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:50:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg5Db-0008Pf-Qi
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:50:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99A693A7687
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:50:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:50:31 +0100
Message-Id: <1487663432-10410-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] xhci: properties cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Split xhci properties into common and nec specific.

Move the backward compat flags to nec, so the new qemu-xhci
devices doesn't carry on the compatibiity stuff.

Move the msi/msix switches too and just enable msix for qemu-xhci.

Also move the intrs and slots properties.  Wasn't a great idea to
make them configurable in the first place, nobody needs this.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 28dd2f2..f0af852 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -635,6 +635,11 @@ static bool xhci_get_flag(XHCIState *xhci, enum xhci_flags bit)
     return xhci->flags & (1 << bit);
 }
 
+static void xhci_set_flag(XHCIState *xhci, enum xhci_flags bit)
+{
+    xhci->flags |= (1 << bit);
+}
+
 static uint64_t xhci_mfindex_get(XHCIState *xhci)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -3839,17 +3844,21 @@ static const VMStateDescription vmstate_xhci = {
     }
 };
 
-static Property xhci_properties[] = {
+static Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("superspeed-ports-first",
                     XHCIState, flags, XHCI_FLAG_SS_FIRST, true),
     DEFINE_PROP_BIT("force-pcie-endcap", XHCIState, flags,
                     XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
-    DEFINE_PROP_BIT("streams", XHCIState, flags,
-                    XHCI_FLAG_ENABLE_STREAMS, true),
     DEFINE_PROP_UINT32("intrs", XHCIState, numintrs, MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCIState, numslots, MAXSLOTS),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property xhci_properties[] = {
+    DEFINE_PROP_BIT("streams", XHCIState, flags,
+                    XHCI_FLAG_ENABLE_STREAMS, true),
     DEFINE_PROP_UINT32("p2",    XHCIState, numports_2, 4),
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
     DEFINE_PROP_END_OF_LIST(),
@@ -3881,7 +3890,9 @@ static const TypeInfo xhci_info = {
 static void nec_xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->props       = nec_xhci_properties;
     k->vendor_id    = PCI_VENDOR_ID_NEC;
     k->device_id    = PCI_DEVICE_ID_NEC_UPD720200;
     k->revision     = 0x03;
@@ -3902,10 +3913,22 @@ static void qemu_xhci_class_init(ObjectClass *klass, void *data)
     k->revision     = 0x01;
 }
 
+static void qemu_xhci_instance_init(Object *obj)
+{
+    XHCIState *xhci = XHCI(obj);
+
+    xhci->msi      = ON_OFF_AUTO_OFF;
+    xhci->msix     = ON_OFF_AUTO_AUTO;
+    xhci->numintrs = MAXINTRS;
+    xhci->numslots = MAXSLOTS;
+    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
+}
+
 static const TypeInfo qemu_xhci_info = {
     .name          = TYPE_QEMU_XHCI,
     .parent        = TYPE_XHCI,
     .class_init    = qemu_xhci_class_init,
+    .instance_init = qemu_xhci_instance_init,
 };
 
 static void xhci_register_types(void)
-- 
1.8.3.1
