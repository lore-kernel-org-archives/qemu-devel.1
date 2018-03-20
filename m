Received: from eggs.gnu.org ([2001:4830:134:3::10]:57097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tpiepho@impinj.com>) id 1ey6Dc-0000Y5-3i
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tpiepho@impinj.com>) id 1ey6Da-0003fV-WA
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:37:40 -0400
From: Trent Piepho <tpiepho@impinj.com>
Date: Mon, 19 Mar 2018 18:36:57 -0700
Message-Id: <20180320013657.25038-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] i.MX: Support serial RS-232 break properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Trent Piepho <tpiepho@impinj.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

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
---
 hw/char/imx_serial.c         | 5 ++++-
 include/hw/char/imx_serial.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 70405ccf8b..4ca821d74c 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -286,6 +286,9 @@ static void imx_put_data(void *opaque, uint32_t value)
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
     s->readbuff = value;
+    if (value & URXD_BRK) {
+        s->usr2 |= USR2_BRCD;
+    }
     imx_update(s);
 }
 
@@ -297,7 +300,7 @@ static void imx_receive(void *opaque, const uint8_t *buf, int size)
 static void imx_event(void *opaque, int event)
 {
     if (event == CHR_EVENT_BREAK) {
-        imx_put_data(opaque, URXD_BRK);
+        imx_put_data(opaque, URXD_BRK | URXD_FRMERR | URXD_ERR);
     }
 }
 
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index baeec3183f..f8575ae6db 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -26,6 +26,7 @@
 
 #define URXD_CHARRDY    (1<<15)   /* character read is valid */
 #define URXD_ERR        (1<<14)   /* Character has error */
+#define URXD_FRMERR     (1<<12)   /* Character has frame error */
 #define URXD_BRK        (1<<11)   /* Break received */
 
 #define USR1_PARTYER    (1<<15)   /* Parity Error */
-- 
2.14.3
