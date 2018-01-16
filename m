Received: from eggs.gnu.org ([2001:4830:134:3::10]:59304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6H-0003DK-Oy
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6B-00074a-Ua
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:25 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6B-00073g-Ql
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:19 -0500
Received: by mail-qk0-x241.google.com with SMTP id w1so20775638qka.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:46 -0300
Message-Id: <20180116131555.14242-3-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] smbus_eeprom: replace
 SMBusDeviceClass::init by DeviceClass::reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i2c/smbus_eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index b13ec0fe7a..7e81ae4fe5 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -97,12 +97,11 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
     return eeprom_receive_byte(dev);
 }
 
-static int smbus_eeprom_initfn(SMBusDevice *dev)
+static void smbus_eeprom_reset(DeviceState *dev)
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
+    dc->reset = smbus_eeprom_reset;
     sc->quick_cmd = eeprom_quick_cmd;
     sc->send_byte = eeprom_send_byte;
     sc->receive_byte = eeprom_receive_byte;
-- 
2.15.1
