Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlN-00017i-4y
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlM-0004Et-5P
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ezRlL-0004EB-VW
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:50:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ezRlK-0007fP-Tu
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:50:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 18:49:53 +0000
Message-Id: <20180323184958.14252-6-peter.maydell@linaro.org>
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/10] i.MX: Support serial RS-232 break properly
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

Linux does not detect a break from this IMX serial driver as a magic
sysrq.  Nor does it note a break in the port error counts.

The former is because the Linux driver uses the BRCD bit in the USR2
register to trigger the RS-232 break handler in the kernel, which is
where sysrq hooks in.  The emulated UART was not setting this status
bit.

The latter is because the Linux driver expects, in addition to the BRK
bit, that the ERR bit is set when a break is read in the FIFO.  A break
should also count as a frame error, so add that bit too.

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Message-id: 20180320013657.25038-1-tpiepho@impinj.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/imx_serial.h | 1 +
 hw/char/imx_serial.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 5b99cee7cf..ee80da12e6 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -26,6 +26,7 @@
 
 #define URXD_CHARRDY    (1<<15)   /* character read is valid */
 #define URXD_ERR        (1<<14)   /* Character has error */
+#define URXD_FRMERR     (1<<12)   /* Character has frame error */
 #define URXD_BRK        (1<<11)   /* Break received */
 
 #define USR1_PARTYER    (1<<15)   /* Parity Error */
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1e5540472b..0747db9f2b 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -308,6 +308,9 @@ static void imx_put_data(void *opaque, uint32_t value)
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
     s->readbuff = value;
+    if (value & URXD_BRK) {
+        s->usr2 |= USR2_BRCD;
+    }
     imx_update(s);
 }
 
@@ -319,7 +322,7 @@ static void imx_receive(void *opaque, const uint8_t *buf, int size)
 static void imx_event(void *opaque, int event)
 {
     if (event == CHR_EVENT_BREAK) {
-        imx_put_data(opaque, URXD_BRK);
+        imx_put_data(opaque, URXD_BRK | URXD_FRMERR | URXD_ERR);
     }
 }
 
-- 
2.16.2
