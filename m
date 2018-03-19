Received: from eggs.gnu.org ([2001:4830:134:3::10]:49689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbx-0002Jc-RK
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbw-0007dZ-RH
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzbw-0007dJ-K9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbv-0002zt-Ka
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:19 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:05 +0000
Message-Id: <20180319183415.1976-4-peter.maydell@linaro.org>
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/13] char: i.MX: Simplify imx_update()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Code of imx_update() is slightly confusing since the "flags" variable
doesn't really corespond to anything in real hardware and server as a
kitchensink accumulating events normally reported via USR1 and USR2
registers.

Change the code to explicitly evaluate state of interrupts reported
via USR1 and USR2 against corresponding masking bits and use the to
detemine if IRQ line should be asserted or not.

NOTE: Check for UTS1_TXEMPTY being set has been dropped for two
reasons:

    1. Emulation code implements a single character FIFO, so this flag
       will always be set since characters are trasmitted as a part of
       the code emulating "push" into the FIFO

    2. imx_update() is really just a function doing ORing and maksing
       of reported events, so checking for UTS1_TXEMPTY should happen,
       if it's ever really needed should probably happen outside of
       it.

Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: Bill Paul <wpaul@windriver.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Message-id: 20180315191141.6789-1-andrew.smirnov@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/imx_serial.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 70405ccf8b..d1e8586280 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -56,16 +56,24 @@ static const VMStateDescription vmstate_imx_serial = {
 
 static void imx_update(IMXSerialState *s)
 {
-    uint32_t flags;
+    uint32_t usr1;
+    uint32_t usr2;
+    uint32_t mask;
 
-    flags = (s->usr1 & s->ucr1) & (USR1_TRDY|USR1_RRDY);
-    if (s->ucr1 & UCR1_TXMPTYEN) {
-        flags |= (s->uts1 & UTS1_TXEMPTY);
-    } else {
-        flags &= ~USR1_TRDY;
-    }
+    /*
+     * Lucky for us TRDY and RRDY has the same offset in both USR1 and
+     * UCR1, so we can get away with something as simple as the
+     * following:
+     */
+    usr1 = s->usr1 & s->ucr1 & (USR1_TRDY | USR1_RRDY);
+    /*
+     * Bits that we want in USR2 are not as conveniently laid out,
+     * unfortunately.
+     */
+    mask = (s->ucr1 & UCR1_TXMPTYEN) ? USR2_TXFE : 0;
+    usr2 = s->usr2 & mask;
 
-    qemu_set_irq(s->irq, !!flags);
+    qemu_set_irq(s->irq, usr1 || usr2);
 }
 
 static void imx_serial_reset(IMXSerialState *s)
-- 
2.16.2
