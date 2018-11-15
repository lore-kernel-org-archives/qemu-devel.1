Received: from eggs.gnu.org ([2001:4830:134:3::10]:56270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNGL-0003YX-MA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNGB-000838-QA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:13 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNNG9-00081p-SV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:03 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so18785967otk.8
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:25:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 15 Nov 2018 13:24:44 -0600
Message-Id: <20181115192446.17187-11-minyard@acm.org>
In-Reply-To: <20181115192446.17187-1-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 10/12] i2c: Add a size constant for the
 smbus_eeprom size
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

It was hard-coded to 256 in a number of places, create a constant
for that.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 8d4eed129f..8e9b734c09 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -35,6 +35,8 @@
 #define SMBUS_EEPROM(obj) \
     OBJECT_CHECK(SMBusEEPROMDevice, (obj), TYPE_SMBUS_EEPROM)
 
+#define SMBUS_EEPROM_SIZE 256
+
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
     void *data;
@@ -70,7 +72,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
     for (; len > 0; len--) {
         data[eeprom->offset] = *buf++;
-        eeprom->offset = (eeprom->offset + 1) % 256;
+        eeprom->offset = (eeprom->offset + 1) % SMBUS_EEPROM_SIZE;
     }
 
     return 0;
@@ -129,12 +131,14 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int eeprom_spd_size)
 {
     int i;
-    uint8_t *eeprom_buf = g_malloc0(8 * 256); /* XXX: make this persistent */
+     /* XXX: make this persistent */
+    uint8_t *eeprom_buf = g_malloc0(8 * SMBUS_EEPROM_SIZE);
     if (eeprom_spd_size > 0) {
         memcpy(eeprom_buf, eeprom_spd, eeprom_spd_size);
     }
 
     for (i = 0; i < nb_eeprom; i++) {
-        smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
+        smbus_eeprom_init_one(smbus, 0x50 + i,
+                              eeprom_buf + (i * SMBUS_EEPROM_SIZE));
     }
 }
-- 
2.17.1
