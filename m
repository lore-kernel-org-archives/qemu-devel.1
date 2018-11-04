Received: from eggs.gnu.org ([2001:4830:134:3::10]:45920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skintigh@gmail.com>) id 1gMmyh-0005u1-PW
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 23:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skintigh@gmail.com>) id 1gMmyg-0007Iy-Ef
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 23:40:35 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skintigh@gmail.com>) id 1gMmyg-00079T-6w
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 23:40:34 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so3381458oia.4
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 20:40:18 -0800 (PST)
MIME-Version: 1.0
From: Seth K <skintigh@gmail.com>
Date: Sun, 4 Nov 2018 02:42:38 -0500
Message-ID: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] Corrected memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

I corrected these 2 memory regions based on specifications from the chip
manufacturer. The existing ranges seem to overlap and and cause odd
behavior and/or crashes when trying to set up multiple UARTs,
I also played with changing MAX_SERIAL_PORTS to 8 to match the hardware,
but I did not include that in this patch as I never fully tested its
effects.
This is my first patch, I hope I did it correctly,
Seth Kintigh
---
 hw/char/stm32f2xx_usart.c  | 2 +-
 hw/timer/stm32f2xx_timer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 032b5fda13..f3363a2952 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -202,7 +202,7 @@ static void stm32f2xx_usart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);

     memory_region_init_io(&s->mmio, obj, &stm32f2xx_usart_ops, s,
-                          TYPE_STM32F2XX_USART, 0x2000);
+                          TYPE_STM32F2XX_USART, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }

diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 58fc7b1188..ae744d1642 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -308,7 +308,7 @@ static void stm32f2xx_timer_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);

     memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
-                          "stm32f2xx_timer", 0x4000);
+                          "stm32f2xx_timer", 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);

     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt,
s);
-- 
2.11.0
