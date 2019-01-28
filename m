Received: from eggs.gnu.org ([209.51.188.92]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEF-0003Zq-Sx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7r-0005W0-EY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:30 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7r-0005UU-9D
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:15 -0500
Received: by mail-io1-xd41.google.com with SMTP id b23so14206132ios.10
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:13 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:47 -0600
Message-Id: <20190128175458.27255-9-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 08/19] i2c:smbus_eeprom: Get rid of the
 quick command
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

It's not necessary, it won't be called if it's NULL.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index c2b9e3383e..4bc579e69e 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -36,13 +36,6 @@ typedef struct SMBusEEPROMDevice {
     uint8_t offset;
 } SMBusEEPROMDevice;
 
-static void eeprom_quick_cmd(SMBusDevice *dev, uint8_t read)
-{
-#ifdef DEBUG
-    printf("eeprom_quick_cmd: addr=0x%02x read=%d\n", dev->i2c.address, read);
-#endif
-}
-
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
@@ -95,7 +88,6 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
     dc->realize = smbus_eeprom_realize;
-    sc->quick_cmd = eeprom_quick_cmd;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     dc->props = smbus_eeprom_properties;
-- 
2.17.1
