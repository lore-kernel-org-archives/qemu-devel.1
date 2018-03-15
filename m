Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ewYIE-0005xS-75
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ewYIA-0001a6-NE
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:12:02 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 15 Mar 2018 12:11:40 -0700
Message-Id: <20180315191141.6789-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] char: i.MX: Simplify imx_update()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Bill Paul <wpaul@windriver.com>

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
2.14.3
