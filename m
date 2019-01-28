Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEI-0003Db-6q
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7u-0005YD-CU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:31 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:45620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7u-0005Xj-7D
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:18 -0500
Received: by mail-io1-xd42.google.com with SMTP id c2so14189424iom.12
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:18 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:45 -0600
Message-Id: <20190128175458.27255-7-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 06/19] i2c:smbus: Simplify write operation
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

There were two different write functions and the SMBus code kept
track of the command.

Keeping track of the command wasn't useful, in fact it wasn't quite
correct for the eeprom_smbus code.  And there is no need for two write
functions.  Just have one write function and the first byte in the
buffer is the command.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c        | 47 ++++++++++++------------------------
 hw/i2c/smbus_slave.c         | 25 ++++---------------
 include/hw/i2c/smbus_slave.h | 21 ++++++++++------
 3 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index d82423aa7e..3f9ed266f8 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -43,16 +43,6 @@ static void eeprom_quick_cmd(SMBusDevice *dev, uint8_t read)
 #endif
 }
 
-static void eeprom_send_byte(SMBusDevice *dev, uint8_t val)
-{
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
-#ifdef DEBUG
-    printf("eeprom_send_byte: addr=0x%02x val=0x%02x\n",
-           dev->i2c.address, val);
-#endif
-    eeprom->offset = val;
-}
-
 static uint8_t eeprom_receive_byte(SMBusDevice *dev)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
@@ -65,34 +55,30 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
     return val;
 }
 
-static void eeprom_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int len)
+static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 {
     SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
-    int n;
+    uint8_t *data = eeprom->data;
+
 #ifdef DEBUG
     printf("eeprom_write_byte: addr=0x%02x cmd=0x%02x val=0x%02x\n",
-           dev->i2c.address, cmd, buf[0]);
+           dev->i2c.address, buf[0], buf[1]);
 #endif
-    /* A page write operation is not a valid SMBus command.
-       It is a block write without a length byte.  Fortunately we
-       get the full block anyway.  */
-    /* TODO: Should this set the current location?  */
-    if (cmd + len > 256)
-        n = 256 - cmd;
-    else
-        n = len;
-    memcpy(eeprom->data + cmd, buf, n);
-    len -= n;
-    if (len)
-        memcpy(eeprom->data, buf + n, len);
+    /* len is guaranteed to be > 0 */
+    eeprom->offset = buf[0];
+    buf++;
+    len--;
+
+    for (; len > 0; len--) {
+        data[eeprom->offset] = *buf++;
+        eeprom->offset = (eeprom->offset + 1) % 256;
+    }
+
+    return 0;
 }
 
-static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
+static uint8_t eeprom_read_data(SMBusDevice *dev, int n)
 {
-    SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *) dev;
-    /* If this is the first byte then set the current position.  */
-    if (n == 0)
-        eeprom->offset = cmd;
     /* As with writes, we implement block reads without the
        SMBus length byte.  */
     return eeprom_receive_byte(dev);
@@ -117,7 +103,6 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
 
     dc->realize = smbus_eeprom_realize;
     sc->quick_cmd = eeprom_quick_cmd;
-    sc->send_byte = eeprom_send_byte;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
     sc->read_data = eeprom_read_data;
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 6a89a286e3..92c7a5086c 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -54,18 +54,9 @@ static void smbus_do_write(SMBusDevice *dev)
 {
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
 
-    if (dev->data_len == 1) {
-        DPRINTF("Send Byte\n");
-        if (sc->send_byte) {
-            sc->send_byte(dev, dev->data_buf[0]);
-        }
-    } else {
-        dev->command = dev->data_buf[0];
-        DPRINTF("Command %d len %d\n", dev->command, dev->data_len - 1);
-        if (sc->write_data) {
-            sc->write_data(dev, dev->command, dev->data_buf + 1,
-                           dev->data_len - 1);
-        }
+    DPRINTF("Command %d len %d\n", dev->data_buf[0], dev->data_len);
+    if (sc->write_data) {
+        sc->write_data(dev, dev->data_buf, dev->data_len);
     }
 }
 
@@ -98,13 +89,7 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
                 BADF("Read after write with no data\n");
                 dev->mode = SMBUS_CONFUSED;
             } else {
-                if (dev->data_len > 1) {
-                    smbus_do_write(dev);
-                } else {
-                    dev->command = dev->data_buf[0];
-                    DPRINTF("%02x: Command %d\n", dev->i2c.address,
-                            dev->command);
-                }
+                smbus_do_write(dev);
                 DPRINTF("Read mode\n");
                 dev->data_len = 0;
                 dev->mode = SMBUS_READ_DATA;
@@ -177,7 +162,7 @@ static uint8_t smbus_i2c_recv(I2CSlave *s)
         break;
     case SMBUS_READ_DATA:
         if (sc->read_data) {
-            ret = sc->read_data(dev, dev->command, dev->data_len);
+            ret = sc->read_data(dev, dev->data_len);
             dev->data_len++;
         } else {
             ret = 0;
diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
index 5ef1c72ad0..fa92201ec6 100644
--- a/include/hw/i2c/smbus_slave.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -46,18 +46,24 @@ typedef struct SMBusDeviceClass
      * This may be NULL, quick commands are ignore in that case.
      */
     void (*quick_cmd)(SMBusDevice *dev, uint8_t read);
-    void (*send_byte)(SMBusDevice *dev, uint8_t val);
+
     uint8_t (*receive_byte)(SMBusDevice *dev);
-    /* We can't distinguish between a word write and a block write with
-       length 1, so pass the whole data block including the length byte
-       (if present).  The device is responsible figuring out what type of
-       command  this is.  */
-    void (*write_data)(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int len);
+
+    /*
+     * We can't distinguish between a word write and a block write with
+     * length 1, so pass the whole data block including the length byte
+     * (if present).  The device is responsible figuring out what type of
+     * command this is.
+     * This may be NULL if no data is written to the device.  Writes
+     * will be ignore in that case.
+     */
+    int (*write_data)(SMBusDevice *dev, uint8_t *buf, uint8_t len);
+
     /* Likewise we can't distinguish between different reads, or even know
        the length of the read until the read is complete, so read data a
        byte at a time.  The device is responsible for adding the length
        byte on block reads.  */
-    uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
+    uint8_t (*read_data)(SMBusDevice *dev, int n);
 } SMBusDeviceClass;
 
 struct SMBusDevice {
@@ -68,7 +74,6 @@ struct SMBusDevice {
     int mode;
     int data_len;
     uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
-    uint8_t command;
 };
 
 #endif
-- 
2.17.1
