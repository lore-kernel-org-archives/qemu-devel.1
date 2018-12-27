Received: from eggs.gnu.org ([208.118.235.92]:46259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gcUDu-0005iZ-7K
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gcUDq-0003Ir-Qs
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:53:10 -0500
Received: from mail-gateway-shared02.cyon.net ([194.126.200.224]:53040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gcUDq-0003Gq-Gs
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 06:53:06 -0500
Received: from s013.cyon.net ([149.126.4.22])
	by mail-gateway-shared02.cyon.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim)
	(envelope-from <public@hansmi.ch>) id 1gcUDk-0005lE-TN
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:53:03 +0100
From: Michael Hanselmann <public@hansmi.ch>
Date: Thu, 27 Dec 2018 11:51:55 +0000
Message-Id: <e0d6e64a5f4b3ed436bb91aa3428986a06a0f1f1.1545911443.git.public@hansmi.ch>
Subject: [Qemu-devel] [PATCH] smbus_eeprom: Limit data writes to 255 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, Michael Hanselmann <public@hansmi.ch>

The "eeprom_write_data" function in "smbus_eeprom.c" had no provisions
to limit the length of data written. If a caller were able to manipulate
the "len" parameter they could potentially write before or after the
target buffer.
---
 hw/i2c/smbus_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index f18aa3de35..74fa1c328c 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -76,6 +76,7 @@ static void eeprom_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf, int l
        It is a block write without a length byte.  Fortunately we
        get the full block anyway.  */
     /* TODO: Should this set the current location?  */
+    len &= 0xff;
     if (cmd + len > 256)
         n = 256 - cmd;
     else
-- 
2.11.0
