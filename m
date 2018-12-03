Received: from eggs.gnu.org ([2001:4830:134:3::10]:49755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gTnj4-0006nI-7A
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gTnix-00089d-M4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:53:26 -0500
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon,  3 Dec 2018 06:52:50 -0600
Message-Id: <20181203125250.11195-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] i2c: Add a length check to the SMBus write
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, QEMU Stable <qemu-stable@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Avoid an overflow.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: QEMU Stable <qemu-stable@nongnu.org>
---
 hw/i2c/smbus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 6ff77c582f..30028bfcc2 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -193,7 +193,11 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
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
         BADF("Unexpected write in state %d\n", dev->mode);
-- 
2.17.1
