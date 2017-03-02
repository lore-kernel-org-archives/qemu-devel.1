Received: from eggs.gnu.org ([2001:4830:134:3::10]:46772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNf1-0003Xc-Dn
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNf0-0007fh-E5
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:35 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cjNf0-0007fD-8m
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:34 -0500
Received: by mail-pf0-x244.google.com with SMTP id 67so1971490pfg.2
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 02:08:32 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu,  2 Mar 2017 02:08:11 -0800
Message-Id: <1488449293-80280-2-git-send-email-liqiang6-s@360.cn>
In-Reply-To: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
References: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH 1/3] ide: qdev: register ide bus unrealize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

we have an idebus unrealize function, but it was being
registered as the unrealize function for the IDE Device,
so it was not getting invoked on device teardown because
nothing is "unrealizing" the IDE devices themselves.

Suggested-by: John Snow <jsnow@redhat.com>
Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/ide/qdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index dbaa75c..fbf7aa5 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -31,7 +31,7 @@
 /* --------------------------------- */
 
 static char *idebus_get_fw_dev_path(DeviceState *dev);
-static void idebus_unrealize(DeviceState *qdev, Error **errp);
+static void idebus_unrealize(BusState *qdev, Error **errp);
 
 static Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
@@ -43,14 +43,15 @@ static void ide_bus_class_init(ObjectClass *klass, void *data)
     BusClass *k = BUS_CLASS(klass);
 
     k->get_fw_dev_path = idebus_get_fw_dev_path;
+    k->unrealize = idebus_unrealize;
 }
 
-static void idebus_unrealize(DeviceState *qdev, Error **errp)
+static void idebus_unrealize(BusState *bus, Error **errp)
 {
-    IDEBus *bus = DO_UPCAST(IDEBus, qbus, qdev->parent_bus);
+    IDEBus *ibus = IDE_BUS(bus);
 
-    if (bus->vmstate) {
-        qemu_del_vm_change_state_handler(bus->vmstate);
+    if (ibus->vmstate) {
+        qemu_del_vm_change_state_handler(ibus->vmstate);
     }
 }
 
@@ -365,7 +366,6 @@ static void ide_device_class_init(ObjectClass *klass, void *data)
     k->init = ide_qdev_init;
     set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
     k->bus_type = TYPE_IDE_BUS;
-    k->unrealize = idebus_unrealize;
     k->props = ide_props;
 }
 
-- 
1.8.3.1
