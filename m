Received: from eggs.gnu.org ([2001:4830:134:3::10]:48360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tpiepho@impinj.com>) id 1fkb0D-0007cZ-6A
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 16:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tpiepho@impinj.com>) id 1fkb0C-0000EO-6z
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 16:12:17 -0400
From: Trent Piepho <tpiepho@impinj.com>
Date: Tue, 31 Jul 2018 13:10:56 -0700
Message-ID: <20180731201056.29257-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] imx_spi: Unset XCH when TX FIFO becomes empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Chubb <peter.chubb@nicta.com.au>, Trent Piepho <tpiepho@impinj.com>

The current emulation will clear the XCH bit when a burst finishes.
This is not quite correct.  According to the i.MX7d referemce manual,
Rev 0.1, =C2=A710.1.7.3:

    This bit [XCH] is cleared automatically when all data in the TXFIFO
    and the shift register has been shifted out.

So XCH should be cleared when the FIFO empties, not on completion of a
burst.  The FIFO is 64 x 32 bits =3D 2048 bits, while the max burst size
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
---
 hw/ssi/imx_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index b66505ca49..02c38c9e47 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -208,8 +208,6 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
         }
=20
         if (s->burst_length <=3D 0) {
-            s->regs[ECSPI_CONREG] &=3D ~ECSPI_CONREG_XCH;
-
             if (!imx_spi_is_multiple_master_burst(s)) {
                 s->regs[ECSPI_STATREG] |=3D ECSPI_STATREG_TC;
                 break;
@@ -219,6 +217,7 @@ static void imx_spi_flush_txfifo(IMXSPIState *s)
=20
     if (fifo32_is_empty(&s->tx_fifo)) {
         s->regs[ECSPI_STATREG] |=3D ECSPI_STATREG_TC;
+        s->regs[ECSPI_CONREG] &=3D ~ECSPI_CONREG_XCH;
     }
=20
     /* TODO: We should also use TDR and RDR bits */
--=20
2.14.4
