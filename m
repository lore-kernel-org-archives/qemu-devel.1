Received: from eggs.gnu.org ([209.51.188.92]:42781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb1-0002Q3-8B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb0-00075R-HU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:11 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVb0-00074W-BW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:10 -0500
Received: by mail-wr1-x42e.google.com with SMTP id u4so15427375wrp.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:17 +0000
Message-Id: <20190118145805.6852-2-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/49] hw/char/stm32f2xx_usart: Do not update
 data register when device is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When the device is disabled, the internal circuitry keeps the data
register loaded and doesn't update it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20190104182057.8778-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32f2xx_usart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index f3363a2952d..10392c70e2d 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -53,14 +53,13 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
 {
     STM32F2XXUsartState *s = opaque;
 
-    s->usart_dr = *buf;
-
     if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
         /* USART not enabled - drop the chars */
         DB_PRINT("Dropping the chars\n");
         return;
     }
 
+    s->usart_dr = *buf;
     s->usart_sr |= USART_SR_RXNE;
 
     if (s->usart_cr1 & USART_CR1_RXNEIE) {
-- 
2.20.1
