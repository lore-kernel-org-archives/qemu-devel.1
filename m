Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBED-0003Db-HM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB8V-0005ta-06
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:56:03 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB8U-0005cJ-PN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:54 -0500
Received: by mail-pf1-x442.google.com with SMTP id h3so8353036pfg.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:23 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:54 -0600
Message-Id: <20190128175458.27255-16-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/19] i2c:smbus_eeprom: Add normal type
 name and cast to smbus_eeprom.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Create a type name and a cast macro and use those through the
code.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 62e634c745..91d68ff588 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -30,6 +30,11 @@
 
 //#define DEBUG
 
+#define TYPE_SMBUS_EEPROM "smbus-eeprom"
+
+#define SMBUS_EEPROM(obj) \
+    OBJECT_CHECK(SMBusEEPROMDevice, (obj), TYPE_SMBUS_EEPROM)
+
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
     void *data;
@@ -38,7 +43,7 @@ typedef struct SMBusEEPROMDevice {
 
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
     uint8_t *data = eeprom->data;
     uint8_t val = data[eeprom->offset++];
 
@@ -51,7 +56,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 
 static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
     uint8_t *data = eeprom->data;
 
 #ifdef DEBUG
@@ -73,7 +78,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
 
     eeprom->offset = 0;
 }
@@ -97,7 +102,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo smbus_eeprom_info = {
-    .name          = "smbus-eeprom",
+    .name          = TYPE_SMBUS_EEPROM,
     .parent        = TYPE_SMBUS_DEVICE,
     .instance_size = sizeof(SMBusEEPROMDevice),
     .class_init    = smbus_eeprom_class_initfn,
@@ -114,7 +119,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
     DeviceState *dev;
 
-    dev = qdev_create((BusState *) smbus, "smbus-eeprom");
+    dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
     qdev_prop_set_ptr(dev, "data", eeprom_buf);
     qdev_init_nofail(dev);
-- 
2.17.1
