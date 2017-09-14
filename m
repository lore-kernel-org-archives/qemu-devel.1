Received: from eggs.gnu.org ([2001:4830:134:3::10]:46523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJa-00086k-QL
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJZ-00080Q-VS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJZ-0007yZ-Nm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJY-0005uU-J4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:53 +0100
Message-Id: <1505411573-27848-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/18] mps2-an511: Fix wiring of UART overflow
 interrupt lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix an error that meant we were wiring every UART's overflow
interrupts into the same inputs 0 and 1 of the OR gate,
rather than giving each its own input.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1505232834-20890-1-git-send-email-peter.maydell@linaro.org
---
 hw/arm/mps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index abb0ab6..769cff8 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -287,8 +287,8 @@ static void mps2_common_init(MachineState *machine)
             cmsdk_apb_uart_create(uartbase[i],
                                   qdev_get_gpio_in(txrx_orgate_dev, 0),
                                   qdev_get_gpio_in(txrx_orgate_dev, 1),
-                                  qdev_get_gpio_in(orgate_dev, 0),
-                                  qdev_get_gpio_in(orgate_dev, 1),
+                                  qdev_get_gpio_in(orgate_dev, i * 2),
+                                  qdev_get_gpio_in(orgate_dev, i * 2 + 1),
                                   NULL,
                                   uartchr, SYSCLK_FRQ);
         }
-- 
2.7.4
