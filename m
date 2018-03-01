Received: from eggs.gnu.org ([2001:4830:134:3::10]:33732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-0003hX-PZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-00086F-PJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJs-00084T-I7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJk-0000YU-LF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:27 +0000
Message-Id: <20180301112403.12487-7-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/42] hw/i2c-ddc: Do not fail writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Linus Walleij <linus.walleij@linaro.org>

The tx function of the DDC I2C slave emulation was returning 1
on all writes resulting in NACK in the I2C bus. Changing it to
0 makes the DDC I2C work fine with bit-banged I2C such as the
versatile I2C.

I guess it was not affecting whatever I2C controller this was
used with until now, but with the Versatile I2C it surely
does not work.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Message-id: 20180227104903.21353-4-linus.walleij@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/i2c-ddc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index 199dac9e41..bec0c91e2d 100644
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
2.16.2
