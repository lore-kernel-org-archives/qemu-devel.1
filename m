Received: from eggs.gnu.org ([209.51.188.92]:46626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFe-0000VK-BM
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFV-0002I8-N8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFV-0002DP-E3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id c18so18489701otl.13
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:29 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:17:06 -0600
Message-Id: <20190228181710.2477-16-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/19] i2c:smbus_eeprom: Add normal type name
 and cast to smbus_eeprom.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>

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
index 2816e35bcc..76f0d4aab0 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -32,6 +32,11 @@
 
 //#define DEBUG
 
+#define TYPE_SMBUS_EEPROM "smbus-eeprom"
+
+#define SMBUS_EEPROM(obj) \
+    OBJECT_CHECK(SMBusEEPROMDevice, (obj), TYPE_SMBUS_EEPROM)
+
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
     void *data;
@@ -40,7 +45,7 @@ typedef struct SMBusEEPROMDevice {
 
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
     uint8_t *data = eeprom->data;
     uint8_t val = data[eeprom->offset++];
 
@@ -53,7 +58,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 
 static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
     uint8_t *data = eeprom->data;
 
 #ifdef DEBUG
@@ -75,7 +80,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
 
     eeprom->offset = 0;
 }
@@ -99,7 +104,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo smbus_eeprom_info = {
-    .name          = "smbus-eeprom",
+    .name          = TYPE_SMBUS_EEPROM,
     .parent        = TYPE_SMBUS_DEVICE,
     .instance_size = sizeof(SMBusEEPROMDevice),
     .class_init    = smbus_eeprom_class_initfn,
@@ -116,7 +121,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 {
     DeviceState *dev;
 
-    dev = qdev_create((BusState *) smbus, "smbus-eeprom");
+    dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
     qdev_prop_set_ptr(dev, "data", eeprom_buf);
     qdev_init_nofail(dev);
-- 
2.17.1
