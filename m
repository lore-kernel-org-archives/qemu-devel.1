Received: from eggs.gnu.org ([2001:4830:134:3::10]:56325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNGY-0003gT-UF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNGF-00084M-GC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:17 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNNGD-00081u-HB
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:05 -0500
Received: by mail-ot1-x342.google.com with SMTP id n46so19071313otb.9
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:25:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 15 Nov 2018 13:24:46 -0600
Message-Id: <20181115192446.17187-13-minyard@acm.org>
In-Reply-To: <20181115192446.17187-1-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 12/12] i2c: Add a reset function to
 smbus_eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Reset the contents to init data and reset the offset on a machine
reset.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 942057dc10..d0a8d63869 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -106,7 +106,7 @@ static const VMStateDescription vmstate_smbus_eeprom = {
     }
 };
 
-static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
+static void smbus_eeprom_reset(DeviceState *dev)
 {
     SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
 
@@ -114,6 +114,11 @@ static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
     eeprom->offset = 0;
 }
 
+static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
+{
+    smbus_eeprom_reset(dev);
+}
+
 static Property smbus_eeprom_properties[] = {
     DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
     DEFINE_PROP_END_OF_LIST(),
@@ -125,6 +130,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
     dc->realize = smbus_eeprom_realize;
+    dc->reset = smbus_eeprom_reset;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     dc->props = smbus_eeprom_properties;
-- 
2.17.1
