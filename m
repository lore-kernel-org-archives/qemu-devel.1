Received: from eggs.gnu.org ([209.51.188.92]:52003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTvu-000200-6z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTvq-0005u9-3Z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:13 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTvn-0005UN-8a
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:09 -0500
Received: by mail-ot1-x344.google.com with SMTP id n71so40778176ota.10
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:36:34 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 20 Feb 2019 07:59:55 -0600
Message-Id: <20190220135956.22589-19-minyard@acm.org>
In-Reply-To: <20190220135956.22589-1-minyard@acm.org>
References: <20190220135956.22589-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/19] i2c:smbus_eeprom: Add a reset function
 to smbus_eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Reset the contents to init data and reset the offset on a machine
reset.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index c0a0c4d501..44887b4a27 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -106,7 +106,17 @@ static const VMStateDescription vmstate_smbus_eeprom = {
     }
 };
 
-static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
+/*
+ * Reset the EEPROM contents to the initial state on a reset.  This
+ * isn't really how an EEPROM works, of course, but the general
+ * principle of QEMU is to restore function on reset to what it would
+ * be if QEMU was stopped and started.
+ *
+ * The proper thing to do would be to have a backing blockdev to hold
+ * the contents and restore that on startup, and not do this on reset.
+ * But until that time, act as if we had been stopped and restarted.
+ */
+static void smbus_eeprom_reset(DeviceState *dev)
 {
     SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
 
@@ -114,6 +124,11 @@ static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
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
@@ -125,6 +140,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
 
     dc->realize = smbus_eeprom_realize;
+    dc->reset = smbus_eeprom_reset;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     dc->props = smbus_eeprom_properties;
-- 
2.17.1
