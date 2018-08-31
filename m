Received: from eggs.gnu.org ([2001:4830:134:3::10]:41909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <b.zolnierkie@samsung.com>) id 1fvgbV-0001L6-4e
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <b.zolnierkie@samsung.com>) id 1fvgaH-0003Lq-Ph
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:23:22 -0400
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 31 Aug 2018 12:23:04 +0200
Message-id: <9310418.Wg32kryeWE@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
References: <CGME20180831102306eucas1p1ffbf82383f23675fecb5faf8a2fa54d7@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH] hw/arm/exynos4210: fix Exynos4210 UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

commit 97274d0c05d4 ("hw/char/exynos4210_uart.c: Remove unneeded
handling of NULL chardev") broke Exynos4210 support as it removed
NULL 'Chardev *chr' handling from exynos4210_uart_create() and
currently exynos4210_init() always passes NULL as 'Chardev *chr'
argument to exynos4210_uart_create() calls. Fix it by adding
missing serial_hd() calls to exynos4210_init().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 hw/arm/exynos4210.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/hw/arm/exynos4210.c
===================================================================
--- a/hw/arm/exynos4210.c	2018-08-22 12:21:06.328813907 +0200
+++ b/hw/arm/exynos4210.c	2018-08-22 13:00:54.344771039 +0200
@@ -352,19 +352,19 @@ Exynos4210State *exynos4210_init(MemoryR
 
     /*** UARTs ***/
     exynos4210_uart_create(EXYNOS4210_UART0_BASE_ADDR,
-                           EXYNOS4210_UART0_FIFO_SIZE, 0, NULL,
+                           EXYNOS4210_UART0_FIFO_SIZE, 0, serial_hd(0),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 0)]);
 
     exynos4210_uart_create(EXYNOS4210_UART1_BASE_ADDR,
-                           EXYNOS4210_UART1_FIFO_SIZE, 1, NULL,
+                           EXYNOS4210_UART1_FIFO_SIZE, 1, serial_hd(1),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 1)]);
 
     exynos4210_uart_create(EXYNOS4210_UART2_BASE_ADDR,
-                           EXYNOS4210_UART2_FIFO_SIZE, 2, NULL,
+                           EXYNOS4210_UART2_FIFO_SIZE, 2, serial_hd(2),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 2)]);
 
     exynos4210_uart_create(EXYNOS4210_UART3_BASE_ADDR,
-                           EXYNOS4210_UART3_FIFO_SIZE, 3, NULL,
+                           EXYNOS4210_UART3_FIFO_SIZE, 3, serial_hd(3),
                   s->irq_table[exynos4210_get_irq(EXYNOS4210_UART_INT_GRP, 3)]);
 
     /*** SD/MMC host controllers ***/
