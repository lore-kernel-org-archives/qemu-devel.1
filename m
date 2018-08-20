Received: from eggs.gnu.org ([2001:4830:134:3::10]:51553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqlC-0002pR-Rw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frql0-0002SL-Ff
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:45 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:39195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1frqkw-0002F7-8s
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:30 -0400
Received: by mail-oi0-x235.google.com with SMTP id d189-v6so28171248oib.6
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:26:27 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 20 Aug 2018 15:26:02 -0500
Message-Id: <1534796770-10295-3-git-send-email-minyard@acm.org>
In-Reply-To: <1534796770-10295-1-git-send-email-minyard@acm.org>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 02/10] i2c:pm_smbus: Fix the semantics of
 block I2C transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The I2C block transfer commands was not implemented correctly, it
read a length byte and such like it was an smbus transfer.

So fix the smbus_read_block() and smbus_write_block() functions
so they can properly handle I2C transfers, and normal SMBus
transfers (for upcoming changes).  Pass in a transfer size and
a bool to know whether to use the size byte (like SMBus) or use
the length given (like I2C).

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c      | 10 ++++++++--
 hw/i2c/smbus.c         | 37 ++++++++++++++++++++++++-------------
 include/hw/i2c/smbus.h | 17 +++++++++++++++--
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 83c2377..f1fe889 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -117,10 +117,16 @@ static void smb_transaction(PMSMBus *s)
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
index 587ce1a..6ff77c5 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -293,33 +293,42 @@ int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data)
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
 
@@ -330,7 +339,9 @@ int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
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
index 4fdba02..d8b1b9e 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -72,9 +72,22 @@ int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command);
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
 
 void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
-- 
2.7.4
