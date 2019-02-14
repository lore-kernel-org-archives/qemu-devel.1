Received: from eggs.gnu.org ([209.51.188.92]:49709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeW-0002tY-E1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGTv-0006Pi-Mj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGTv-0006Ov-GU
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:11 -0500
Received: by mail-wm1-x341.google.com with SMTP id j125so5992535wmj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:50:54 +0000
Message-Id: <20190214125107.22178-2-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/14] hw/arm/armsse: Fix miswiring of
 expansion IRQs
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

In commit 91c1e9fcbd7548db368 where we added dual-CPU support to
the ARMSSE, we set up the wiring of the expansion IRQs via nested
loops: the outer loop on 'i' loops for each CPU, and the inner loop
on 'j' loops for each interrupt. Fix a typo which meant we were
wiring every expansion IRQ line to external IRQ 0 on CPU 0 and
to external IRQ 1 on CPU 1.

Fixes: 91c1e9fcbd7548db368 ("hw/arm/armsse: Support dual-CPU configuration")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/armsse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 5d53071a5a0..9a8c49547db 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -565,7 +565,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         /* Connect EXP_IRQ/EXP_CPUn_IRQ GPIOs to the NVIC's lines 32 and up */
         s->exp_irqs[i] = g_new(qemu_irq, s->exp_numirq);
         for (j = 0; j < s->exp_numirq; j++) {
-            s->exp_irqs[i][j] = qdev_get_gpio_in(cpudev, i + 32);
+            s->exp_irqs[i][j] = qdev_get_gpio_in(cpudev, j + 32);
         }
         if (i == 0) {
             gpioname = g_strdup("EXP_IRQ");
-- 
2.20.1
