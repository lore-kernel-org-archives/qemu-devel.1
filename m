Received: from eggs.gnu.org ([2001:4830:134:3::10]:56569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpvyq-0003yx-Ho
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cpvyk-0000P2-P0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cpvyk-0000OM-JT
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:00:02 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Mon, 20 Mar 2017 12:59:51 +0100
Message-Id: <20170320115951.25345-3-lersek@redhat.com>
In-Reply-To: <20170320115951.25345-1-lersek@redhat.com>
References: <20170320115951.25345-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/acpi/vmgenid: prevent more than one
 vmgenid device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>

Multiple instances make no sense.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/acpi/vmgenid.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index c3ddcc8e7cb0..b5c0dfcf19e1 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -214,6 +214,8 @@ static Property vmgenid_properties[] = {
 static void vmgenid_realize(DeviceState *dev, Error **errp)
 {
     VmGenIdState *vms = VMGENID(dev);
+    Object *one_vmgenid;
+    bool ambiguous;
 
     if (!vms->write_pointer_available) {
         error_setg(errp, "%s requires DMA write support in fw_cfg, "
@@ -221,6 +223,14 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    one_vmgenid = object_resolve_path_type("", VMGENID_DEVICE, &ambiguous);
+    if (one_vmgenid == NULL) {
+        assert(ambiguous);
+        error_setg(errp, "at most one %s device is permitted", VMGENID_DEVICE);
+        return;
+    }
+    assert(one_vmgenid == OBJECT(vms));
+
     qemu_register_reset(vmgenid_handle_reset, vms);
 }
 
-- 
2.9.3
