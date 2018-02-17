Received: from eggs.gnu.org ([2001:4830:134:3::10]:46097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1en34w-0005mi-Qf
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 09:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1en34s-0003nM-W8
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 09:03:02 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1en34s-0003mv-Ot
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 09:02:58 -0500
Received: by mail-lf0-x243.google.com with SMTP id f136so7584084lff.8
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 06:02:58 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 17 Feb 2018 15:00:49 +0100
Message-Id: <20180217140051.22731-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] hw/i2c-ddc: Do not fail writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Linus Walleij <linus.walleij@linaro.org>

The tx function of the DDC I2C slave emulation was returning 1
on all writes resulting in NACK in the I2C bus. Changing it to
0 makes the DDC I2C work fine with bit-banged I2C such as the
versatile I2C.

I guess it was not affecting whatever I2C controller this was
used with until now, but with the Versatile I2C it surely
does not work.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 hw/i2c/i2c-ddc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index 199dac9e41c1..bec0c91e2dd0 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -259,12 +259,12 @@ static int i2c_ddc_tx(I2CSlave *i2c, uint8_t data)
         s->reg = data;
         s->firstbyte = false;
         DPRINTF("[EDID] Written new pointer: %u\n", data);
-        return 1;
+        return 0;
     }
 
     /* Ignore all writes */
     s->reg++;
-    return 1;
+    return 0;
 }
 
 static void i2c_ddc_init(Object *obj)
-- 
2.14.3
