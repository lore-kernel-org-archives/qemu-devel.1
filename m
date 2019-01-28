Received: from eggs.gnu.org ([209.51.188.92]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEI-0003dP-OW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7r-0005W6-Fk
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:30 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:55047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7r-0005Uw-9H
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:15 -0500
Received: by mail-it1-x142.google.com with SMTP id i145so21907045ita.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:46 -0600
Message-Id: <20190128175458.27255-8-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 07/19] i2c:smbus: Simplify read handling
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

There were two different read functions, and with the removal of
the command passed in there is no functional difference.  So remove
one of them.  With that you don't need one of the states, so that
can be removed, too.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c        |  8 --------
 hw/i2c/smbus_slave.c         | 21 +++------------------
 include/hw/i2c/smbus_slave.h | 17 ++++++++++-------
 3 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 3f9ed266f8..c2b9e3383e 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -77,13 +77,6 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
     return 0;
 }
 
-static uint8_t eeprom_read_data(SMBusDevice *dev, int n)
-{
-    /* As with writes, we implement block reads without the
-       SMBus length byte.  */
-    return eeprom_receive_byte(dev);
-}
-
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
@@ -105,7 +98,6 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     sc->quick_cmd = eeprom_quick_cmd;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
-    sc->read_data = eeprom_read_data;
     dc->props = smbus_eeprom_properties;
     /* Reason: pointer property "data" */
     dc->user_creatable = false;
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 92c7a5086c..52a57423ee 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -34,7 +34,6 @@ do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
 enum {
     SMBUS_IDLE,
     SMBUS_WRITE_DATA,
-    SMBUS_RECV_BYTE,
     SMBUS_READ_DATA,
     SMBUS_DONE,
     SMBUS_CONFUSED = -1
@@ -82,7 +81,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
         switch (dev->mode) {
         case SMBUS_IDLE:
             DPRINTF("Read mode\n");
-            dev->mode = SMBUS_RECV_BYTE;
+            dev->mode = SMBUS_READ_DATA;
             break;
         case SMBUS_WRITE_DATA:
             if (dev->data_len == 0) {
@@ -91,7 +90,6 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
             } else {
                 smbus_do_write(dev);
                 DPRINTF("Read mode\n");
-                dev->data_len = 0;
                 dev->mode = SMBUS_READ_DATA;
             }
             break;
@@ -148,31 +146,18 @@ static uint8_t smbus_i2c_recv(I2CSlave *s)
 {
     SMBusDevice *dev = SMBUS_DEVICE(s);
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
-    uint8_t ret;
+    uint8_t ret = 0xff;
 
     switch (dev->mode) {
-    case SMBUS_RECV_BYTE:
+    case SMBUS_READ_DATA:
         if (sc->receive_byte) {
             ret = sc->receive_byte(dev);
-        } else {
-            ret = 0;
-        }
-        DPRINTF("Receive Byte %02x\n", ret);
-        dev->mode = SMBUS_DONE;
-        break;
-    case SMBUS_READ_DATA:
-        if (sc->read_data) {
-            ret = sc->read_data(dev, dev->data_len);
-            dev->data_len++;
-        } else {
-            ret = 0;
         }
         DPRINTF("Read data %02x\n", ret);
         break;
     default:
         BADF("Unexpected read in state %d\n", dev->mode);
         dev->mode = SMBUS_CONFUSED;
-        ret = 0;
         break;
     }
     return ret;
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index fa92201ec6..79050fb92d 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -47,8 +47,6 @@ typedef struct SMBusDeviceClass
      */
     void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
 
-    uint8_t (*receive_byte)(SMBusDevice *dev);
-
     /*
      * We can't distinguish between a word write and a block write with
      * length 1, so pass the whole data block including the length byte
@@ -59,11 +57,16 @@ typedef struct SMBusDeviceClass
      */
     int (*write_data)(SMBusDevice *dev, uint8_t *buf, uint8_t len);
 
-    /* Likewise we can't distinguish between different reads, or even know
-       the length of the read until the read is complete, so read data a
-       byte at a time.  The device is responsible for adding the length
-       byte on block reads.  */
-    uint8_t (*read_data)(SMBusDevice *dev, int n);
+    /*
+     * Likewise we can't distinguish between different reads, or even know
+     * the length of the read until the read is complete, so read data a
+     * byte at a time.  The device is responsible for adding the length
+     * byte on block reads.  This call cannot fail, it should return
+     * something, preferably 0xff if nothing is available.
+     * This may be NULL if no data is read from the device.  Reads will
+     * return 0xff in that case.
+     */
+    uint8_t (*receive_byte)(SMBusDevice *dev);
 } SMBusDeviceClass;
 
 struct SMBusDevice {
-- 
2.17.1
