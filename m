Received: from eggs.gnu.org ([2001:4830:134:3::10]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5g-0002Ui-BE
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5f-0007q0-6W
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:40 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5f-0007pt-2d
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:39 -0400
Received: by mail-qk0-x243.google.com with SMTP id s78so6875730qkl.8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:27:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 18:27:24 -0300
Message-Id: <20180419212727.26095-2-f4bug@amsat.org>
In-Reply-To: <20180419212727.26095-1-f4bug@amsat.org>
References: <20180419212727.26095-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/4] hw/i2c/smbus: Use DeviceClass::realize
 instead of SMBusDeviceClass::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

SMBusDeviceClass::init is no more used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/smbus.h | 1 -
 hw/i2c/smbus.c         | 9 ---------
 hw/i2c/smbus_eeprom.c  | 5 ++---
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index 544bbc1957..cfe3fa69f3 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -38,7 +38,6 @@
 typedef struct SMBusDeviceClass
 {
     I2CSlaveClass parent_class;
-    int (*init)(SMBusDevice *dev);
     void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
     void (*send_byte)(SMBusDevice *dev, uint8_t val);
     uint8_t (*receive_byte)(SMBusDevice *dev);
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a689..587ce1ab7f 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -202,14 +202,6 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
-static int smbus_device_init(I2CSlave *i2c)
-{
-    SMBusDevice *dev = SMBUS_DEVICE(i2c);
-    SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
-
-    return sc->init(dev);
-}
-
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
 {
@@ -350,7 +342,6 @@ static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
 
-    sc->init = smbus_device_init;
     sc->event = smbus_i2c_event;
     sc->recv = smbus_i2c_recv;
     sc->send = smbus_i2c_send;
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index b13ec0fe7a..125c887d1f 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -97,12 +97,11 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
     return eeprom_receive_byte(dev);
 }
 
-static int smbus_eeprom_initfn(SMBusDevice *dev)
+static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
 
     eeprom->offset = 0;
-    return 0;
 }
 
 static Property smbus_eeprom_properties[] = {
@@ -115,7 +114,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
-    sc->init = smbus_eeprom_initfn;
+    dc->realize = smbus_eeprom_realize;
     sc->quick_cmd = eeprom_quick_cmd;
     sc->send_byte = eeprom_send_byte;
     sc->receive_byte = eeprom_receive_byte;
-- 
2.17.0
