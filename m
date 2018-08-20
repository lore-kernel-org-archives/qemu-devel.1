Received: from eggs.gnu.org ([2001:4830:134:3::10]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqlF-0002rL-1n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frql2-0002WO-BI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:46 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1frqkw-0002Km-R7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:32 -0400
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so28119896oib.10
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:26:30 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 20 Aug 2018 15:26:10 -0500
Message-Id: <1534796770-10295-11-git-send-email-minyard@acm.org>
In-Reply-To: <1534796770-10295-1-git-send-email-minyard@acm.org>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 10/10] i2c: Add vmstate handling to the
 smbus eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index f18aa3d..d4430b0 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -29,6 +29,8 @@
 
 //#define DEBUG
 
+#define TYPE_SMBUS_EEPROM_DEVICE "smbus-eeprom"
+
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
     void *data;
@@ -97,6 +99,17 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
     return eeprom_receive_byte(dev);
 }
 
+static const VMStateDescription vmstate_smbus_eeprom = {
+    .name = TYPE_SMBUS_EEPROM_DEVICE,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
+        VMSTATE_UINT8(offset, SMBusEEPROMDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
@@ -121,12 +134,13 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     sc->write_data = eeprom_write_data;
     sc->read_data = eeprom_read_data;
     dc->props = smbus_eeprom_properties;
+    dc->vmsd = &vmstate_smbus_eeprom;
     /* Reason: pointer property "data" */
     dc->user_creatable = false;
 }
 
 static const TypeInfo smbus_eeprom_info = {
-    .name          = "smbus-eeprom",
+    .name          = TYPE_SMBUS_EEPROM_DEVICE,
     .parent        = TYPE_SMBUS_DEVICE,
     .instance_size = sizeof(SMBusEEPROMDevice),
     .class_init    = smbus_eeprom_class_initfn,
-- 
2.7.4
