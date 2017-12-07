Received: from eggs.gnu.org ([2001:4830:134:3::10]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN404-00043l-0i
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN403-0006Sa-1B
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:36 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN402-0006S6-RU
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:34 -0500
Received: by mail-pf0-x242.google.com with SMTP id d23so5669990pfe.9
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:34 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:16 -0600
Message-Id: <1512683181-8420-10-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 09/14] i2c: Add vmstate handling to the smbus
 eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index b13ec0f..089005d 100644
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
 static int smbus_eeprom_initfn(SMBusDevice *dev)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
@@ -122,12 +135,13 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
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
