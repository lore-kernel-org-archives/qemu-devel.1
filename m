Received: from eggs.gnu.org ([2001:4830:134:3::10]:53846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnV13-0001aL-DB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1cnV0z-0004o0-HV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:48:21 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 13 Mar 2017 20:47:49 +0200
Message-Id: <20170313184750.429-3-krzk@kernel.org>
In-Reply-To: <20170313184750.429-1-krzk@kernel.org>
References: <20170313184750.429-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH v3 2/3] hw/char/exynos4210_uart: Constify
 static array and few arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Krzysztof Kozlowski <krzk@kernel.org>

The static array exynos4210_uart_regs with register values is not
modified so it can be made const.

Few other functions accept driver or uart state as an argument but they
do not change it and do not cast it so this can be made const for code
safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/char/exynos4210_uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index b75f28d473bf..bff706ab3a68 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -102,7 +102,7 @@ typedef struct Exynos4210UartReg {
     uint32_t            reset_value;
 } Exynos4210UartReg;
 
-static Exynos4210UartReg exynos4210_uart_regs[] = {
+static const Exynos4210UartReg exynos4210_uart_regs[] = {
     {"ULCON",    ULCON,    0x00000000},
     {"UCON",     UCON,     0x00003000},
     {"UFCON",    UFCON,    0x00000000},
@@ -220,7 +220,7 @@ static uint8_t fifo_retrieve(Exynos4210UartFIFO *q)
     return  ret;
 }
 
-static int fifo_elements_number(Exynos4210UartFIFO *q)
+static int fifo_elements_number(const Exynos4210UartFIFO *q)
 {
     if (q->sp < q->rp) {
         return q->size - q->rp + q->sp;
@@ -229,7 +229,7 @@ static int fifo_elements_number(Exynos4210UartFIFO *q)
     return q->sp - q->rp;
 }
 
-static int fifo_empty_elements_number(Exynos4210UartFIFO *q)
+static int fifo_empty_elements_number(const Exynos4210UartFIFO *q)
 {
     return q->size - fifo_elements_number(q);
 }
@@ -245,7 +245,7 @@ static void fifo_reset(Exynos4210UartFIFO *q)
     q->rp = 0;
 }
 
-static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(Exynos4210UartState *s)
+static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
 {
     uint32_t level = 0;
     uint32_t reg;
-- 
2.9.3
