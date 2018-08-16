Received: from eggs.gnu.org ([2001:4830:134:3::10]:59027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQY-0000PF-8e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQX-0001x2-Eu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQX-0001wM-6Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQW-000073-98
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:25 +0100
Message-Id: <20180816133438.17061-18-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/30] imx_spi: Unset XCH when TX FIFO becomes
 empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Trent Piepho <tpiepho@impinj.com>

The current emulation will clear the XCH bit when a burst finishes.
This is not quite correct.  According to the i.MX7d referemce manual,
Rev 0.1, §10.1.7.3:

    This bit [XCH] is cleared automatically when all data in the TXFIFO
    and the shift register has been shifted out.

So XCH should be cleared when the FIFO empties, not on completion of a
burst.  The FIFO is 64 x 32 bits = 2048 bits, while the max burst size
is larger at 4096 bits.  So it's possible that the burst is not finished
after the TXFIFO empties.

Sending a large block (> 2048 bits) with the Linux driver will use a
burst that is larger than the TXFIFO.  After the TXFIFO has emptied XCH
does not become unset, as the burst is not yet finished.

What should happen after the TXFIFO empties is the driver will refill it
and set XCH.  The rising edge of XCH will trigger another transfer to
begin.  However, since the emulation does not set XCH to 0, there is no
rising edge and the next trasfer never begins.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Message-id: 20180731201056.29257-1-tpiepho@impinj.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/imx_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index b66505ca495..02c38c9e479 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -208,8 +208,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
         }
 
         if (s->burst_length <= 0) {
-            s->regs[ECSPI_CONREG] &= ~ECSPI_CONREG_XCH;
-
             if (!imx_spi_is_multiple_master_burst(s)) {
                 s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
                 break;
@@ -219,6 +217,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
 
     if (fifo32_is_empty(&s->tx_fifo)) {
         s->regs[ECSPI_STATREG] |= ECSPI_STATREG_TC;
+        s->regs[ECSPI_CONREG] &= ~ECSPI_CONREG_XCH;
     }
 
     /* TODO: We should also use TDR and RDR bits */
-- 
2.18.0
