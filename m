Received: from eggs.gnu.org ([2001:4830:134:3::10]:56832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fC18Q-0003gi-Qb
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fC18P-0003Nw-TE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:01:50 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 12:01:37 +0100
Message-Id: <20180427110137.19304-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/iotkit.c: fix minor memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Coverity (CID1390573) spots that we forgot to free the
gpioname strings in a loop in the iotkit realize function.
Correct the error.

This isn't a significant leak, because this function
only ever runs once.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
