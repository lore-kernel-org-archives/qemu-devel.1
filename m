Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd8-0004yI-A7
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd7-0000ok-9N
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd6-0000mP-Fx
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd2-0003T9-QV
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:44:59 +0100
Message-Id: <20180510174519.11264-2-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/21] hw/arm/iotkit.c: fix minor memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Coverity (CID1390573) spots that we forgot to free the
gpioname strings in a loop in the iotkit realize function.
Correct the error.

This isn't a significant leak, because this function
only ever runs once.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-id: 20180427110137.19304-1-peter.maydell@linaro.org
---
 hw/arm/iotkit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
index c5f0a5b98a..234185e8f7 100644
--- a/hw/arm/iotkit.c
+++ b/hw/arm/iotkit.c
@@ -517,6 +517,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&s->ppc_irq_orgate), i));
         qdev_connect_gpio_out_named(DEVICE(ppc), "irq", 0,
                                     qdev_get_gpio_in(devs, 0));
+        g_free(gpioname);
     }
 
     iotkit_forward_sec_resp_cfg(s);
-- 
2.17.0
