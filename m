Received: from eggs.gnu.org ([2001:4830:134:3::10]:49479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgR-0007Wn-35
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1encgQ-0000S8-DU
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:07 -0500
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:55519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1encgQ-0000Ro-9f
	for qemu-devel@nongnu.org; Sun, 18 Feb 2018 23:04:06 -0500
Received: by mail-it0-x234.google.com with SMTP id b66so7678761itd.5
	for <qemu-devel@nongnu.org>; Sun, 18 Feb 2018 20:04:06 -0800 (PST)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 18 Feb 2018 20:03:38 -0800
Message-Id: <20180219040342.12686-2-mdavidsaver@gmail.com>
In-Reply-To: <20180219040342.12686-1-mdavidsaver@gmail.com>
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 1/5] timer: ds1338 add magic reset for test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Brook <paul@codesourcery.com>, Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

When running w/ QTest, allow the tester
to reliably zero time offsets.
Allows tests to read the current time,
and set time, independent of test order.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 3849b74a68..41c2d7dac6 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -14,6 +14,7 @@
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/bcd.h"
+#include "sysemu/qtest.h"
 
 /* Size of NVRAM including both the user-accessible area and the
  * secondary register area.
@@ -132,6 +133,14 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
     DS1338State *s = DS1338(i2c);
 
     if (s->addr_byte) {
+        if (data == 0xff && qtest_enabled()) {
+            /* magic, out of bounds, address to allow test code
+             * to reset offset
+             */
+            s->offset = 0;
+            s->wday_offset = 0;
+            return 0;
+        }
         s->ptr = data & (NVRAM_SIZE - 1);
         s->addr_byte = false;
         return 0;
-- 
2.11.0
