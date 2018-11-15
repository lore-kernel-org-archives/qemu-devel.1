Received: from eggs.gnu.org ([2001:4830:134:3::10]:56161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNGF-0003Ro-Ff
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNG4-0007zi-18
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:07 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNNG3-0007zP-Ou
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:24:55 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so12635634otl.0
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:24:55 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 15 Nov 2018 13:24:38 -0600
Message-Id: <20181115192446.17187-5-minyard@acm.org>
In-Reply-To: <20181115192446.17187-1-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 04/12] i2c: Add a length check to the SMBus
 write handling
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

Avoid an overflow.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_slave.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 83ca041b5d..fa988919d8 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -182,7 +182,11 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     switch (dev->mode) {
     case SMBUS_WRITE_DATA:
         DPRINTF("Write data %02x\n", data);
-        dev->data_buf[dev->data_len++] = data;
+        if (dev->data_len >= sizeof(dev->data_buf)) {
+            BADF("Too many bytes sent\n");
+        } else {
+            dev->data_buf[dev->data_len++] = data;
+        }
         break;
 
     default:
-- 
2.17.1
