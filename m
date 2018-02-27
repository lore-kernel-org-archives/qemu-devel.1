Received: from eggs.gnu.org ([2001:4830:134:3::10]:54737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcot-0006Jv-RH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcot-0004CM-4z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:15 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:44427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eqcos-0004Bo-Um
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:15 -0500
Received: by mail-lf0-x242.google.com with SMTP id v9so26819224lfa.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:49:14 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 11:49:01 +0100
Message-Id: <20180227104903.21353-4-linus.walleij@linaro.org>
In-Reply-To: <20180227104903.21353-1-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 3/5] hw/i2c-ddc: Do not fail writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, Linus Walleij <linus.walleij@linaro.org>

The tx function of the DDC I2C slave emulation was returning 1
on all writes resulting in NACK in the I2C bus. Changing it to
0 makes the DDC I2C work fine with bit-banged I2C such as the
versatile I2C.

I guess it was not affecting whatever I2C controller this was
used with until now, but with the Versatile I2C it surely
does not work.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
