Received: from eggs.gnu.org ([209.51.188.92]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBED-0003Zq-Vc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB8U-0005sK-Di
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:56:02 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB8S-0005fH-DT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:53 -0500
Received: by mail-pg1-x543.google.com with SMTP id c25so7528635pgb.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:26 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:56 -0600
Message-Id: <20190128175458.27255-18-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 17/19] i2c:smbus_eeprom: Add vmstate
 handling to the smbus eeprom
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

Transfer the state of the EEPROM on a migration.  This way the
data remains consistent on migration.

This required moving the actual data to a separate array and
using the data provided in the init function as a separate
initialization array, since a pointer property has to be a
void * and the array needs to be uint8_t[].

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index b3cc9c7083..c0a0c4d501 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
 #include "hw/i2c/smbus_eeprom.h"
@@ -39,8 +40,10 @@
 
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
-    void *data;
+    uint8_t data[SMBUS_EEPROM_SIZE];
+    void *init_data;
     uint8_t offset;
+    bool accessed;
 } SMBusEEPROMDevice;
 
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
@@ -49,6 +52,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
     uint8_t *data = eeprom->data;
     uint8_t val = data[eeprom->offset++];
 
+    eeprom->accessed = true;
 #ifdef DEBUG
     printf("eeprom_receive_byte: addr=0x%02x val=0x%02x\n",
            dev->i2c.address, val);
@@ -61,6 +65,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
     SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
     uint8_t *data = eeprom->data;
 
+    eeprom->accessed = true;
 #ifdef DEBUG
     printf("eeprom_write_byte: addr=0x%02x cmd=0x%02x val=0x%02x\n",
            dev->i2c.address, buf[0], buf[1]);
@@ -78,15 +83,39 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
     return 0;
 }
 
+static bool smbus_eeprom_vmstate_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    SMBusEEPROMDevice *eeprom = opaque;
+
+    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev)) &&
+        !mc->smbus_no_migration_support;
+}
+
+static const VMStateDescription vmstate_smbus_eeprom = {
+    .name = "smbus-eeprom",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smbus_eeprom_vmstate_needed,
+    .fields      = (VMStateField[]) {
+        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
+        VMSTATE_UINT8_ARRAY(data, SMBusEEPROMDevice, SMBUS_EEPROM_SIZE),
+        VMSTATE_UINT8(offset, SMBusEEPROMDevice),
+        VMSTATE_BOOL(accessed, SMBusEEPROMDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
     SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
 
+    memcpy(eeprom->data, eeprom->init_data, SMBUS_EEPROM_SIZE);
     eeprom->offset = 0;
 }
 
 static Property smbus_eeprom_properties[] = {
-    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, data),
+    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -99,6 +128,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     dc->props = smbus_eeprom_properties;
+    dc->vmsd = &vmstate_smbus_eeprom;
     /* Reason: pointer property "data" */
     dc->user_creatable = false;
 }
-- 
2.17.1
