Received: from eggs.gnu.org ([2001:4830:134:3::10]:59427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBV-0006Nc-Ud
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBU-00047G-Jk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBU-00046g-Er
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A4DE818BAED
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:20 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F40D63F50
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:16:01 +0200
Message-Id: <20180531171606.21604-10-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 48/53] hw/i2c/smbus: Use DeviceClass::realize
 instead of SMBusDeviceClass::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

SMBusDeviceClass::init is no more used, remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180419212727.26095-2-f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180528144509.15812-2-armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/smbus.c         | 9 ---------
 hw/i2c/smbus_eeprom.c  | 5 ++---
 include/hw/i2c/smbus.h | 1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 2d1b79a689..587ce1ab7f 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -202,14 +202,6 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
=20
-static int smbus_device_init(I2CSlave *i2c)
-{
-    SMBusDevice *dev =3D SMBUS_DEVICE(i2c);
-    SMBusDeviceClass *sc =3D SMBUS_DEVICE_GET_CLASS(dev);
-
-    return sc->init(dev);
-}
-
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
 {
@@ -350,7 +342,6 @@ static void smbus_device_class_init(ObjectClass *klas=
s, void *data)
 {
     I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
=20
-    sc->init =3D smbus_device_init;
     sc->event =3D smbus_i2c_event;
     sc->recv =3D smbus_i2c_recv;
     sc->send =3D smbus_i2c_send;
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index b13ec0fe7a..125c887d1f 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -97,12 +97,11 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, uin=
t8_t cmd, int n)
     return eeprom_receive_byte(dev);
 }
=20
-static int smbus_eeprom_initfn(SMBusDevice *dev)
+static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
     SMBusEEPROMDevice *eeprom =3D (SMBusEEPROMDevice *)dev;
=20
     eeprom->offset =3D 0;
-    return 0;
 }
=20
 static Property smbus_eeprom_properties[] =3D {
@@ -115,7 +114,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *kl=
ass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     SMBusDeviceClass *sc =3D SMBUS_DEVICE_CLASS(klass);
=20
-    sc->init =3D smbus_eeprom_initfn;
+    dc->realize =3D smbus_eeprom_realize;
     sc->quick_cmd =3D eeprom_quick_cmd;
     sc->send_byte =3D eeprom_send_byte;
     sc->receive_byte =3D eeprom_receive_byte;
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
--=20
2.17.0
