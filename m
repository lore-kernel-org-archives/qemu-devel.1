Received: from eggs.gnu.org ([2001:4830:134:3::10]:43311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0R-0002Ij-Gh
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0Q-0000FC-Ew
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:07 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0Q-0000Eu-8v
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:06 -0500
Received: by mail-pg0-x241.google.com with SMTP id b1so22369346pgc.1
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:06 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:35 -0600
Message-Id: <1483111310-24808-5-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 04/19] i2c:pm_smbus: Fix the semantics of block
 I2C transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The I2C block transfer commands was not implemented correctly, it
read a length byte and such like it was an smbus transfer.

So fix the smbus_read_block() and smbus_write_block() functions
so they can properly handle I2C transfers, and normal SMBus
transfers (for upcoming changes).  Pass in a transfer size and
a bool to know whether to use the size byte (like SMBus) or use
the length given (like I2C).

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/pm_smbus.c      | 10 ++++++++--
 hw/i2c/smbus.c         | 37 ++++++++++++++++++++++++-------------
 include/hw/i2c/smbus.h | 17 +++++++++++++++--
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 92c3aebd..679edbc 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -115,10 +115,16 @@ static void smb_transaction(PMSMBus *s)
         break;
     case PROT_I2C_BLOCK_DATA:
         if (read) {
-            ret = smbus_read_block(bus, addr, cmd, s->smb_data);
+            int xfersize = s->smb_data0;
+            if (xfersize > sizeof(s->smb_data)) {
+                xfersize = sizeof(s->smb_data);
+            }
+            ret = smbus_read_block(bus, addr, s->smb_data1, s->smb_data,
+                                   xfersize, false, true);
             goto data8;
         } else {
-            ret = smbus_write_block(bus, addr, cmd, s->smb_data, s->smb_data0);
+            ret = smbus_write_block(bus, addr, cmd, s->smb_data, s->smb_data0,
+                                    false);
             goto done;
         }
         break;
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index c631a1c..4cb651e 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -301,33 +301,42 @@ int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data)
     return 0;
 }
 
-int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data)
+int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
+                     int len, bool recv_len, bool send_cmd)
 {
-    int len;
+    int rlen;
     int i;
 
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
+    if (send_cmd) {
+        if (i2c_start_transfer(bus, addr, 0)) {
+            return -1;
+        }
+        i2c_send(bus, command);
     }
-    i2c_send(bus, command);
     if (i2c_start_transfer(bus, addr, 1)) {
-        i2c_end_transfer(bus);
+        if (send_cmd) {
+            i2c_end_transfer(bus);
+        }
         return -1;
     }
-    len = i2c_recv(bus);
-    if (len > 32) {
-        len = 0;
+    if (recv_len) {
+        rlen = i2c_recv(bus);
+    } else {
+        rlen = len;
     }
-    for (i = 0; i < len; i++) {
+    if (rlen > len) {
+        rlen = 0;
+    }
+    for (i = 0; i < rlen; i++) {
         data[i] = i2c_recv(bus);
     }
     i2c_nack(bus);
     i2c_end_transfer(bus);
-    return len;
+    return rlen;
 }
 
 int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
-                      int len)
+                      int len, bool send_len)
 {
     int i;
 
@@ -338,7 +347,9 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
         return -1;
     }
     i2c_send(bus, command);
-    i2c_send(bus, len);
+    if (send_len) {
+        i2c_send(bus, len);
+    }
     for (i = 0; i < len; i++) {
         i2c_send(bus, data[i]);
     }
diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index 544bbc1..f1b8078 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -73,9 +73,22 @@ int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command);
 int smbus_write_byte(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t data);
 int smbus_read_word(I2CBus *bus, uint8_t addr, uint8_t command);
 int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data);
-int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data);
+
+/*
+ * Do a block transfer from an I2C device.  If recv_len is set, then the
+ * first received byte is a length field and is used to know how much data
+ * to receive.  Otherwise receive "len" bytes.  If send_cmd is set, send
+ * the command byte first before receiving the data.
+ */
+int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
+                     int len, bool recv_len, bool send_cmd);
+
+/*
+ * Do a block transfer to an I2C device.  If send_len is set, send the
+ * "len" value before the data.
+ */
 int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
-                      int len);
+                      int len, bool send_len);
 
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int size);
-- 
2.7.4
