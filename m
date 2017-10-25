Received: from eggs.gnu.org ([2001:4830:134:3::10]:57113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e7BRZ-0006HE-GF
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 22:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e7BRW-0007Cl-Bp
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 22:29:21 -0400
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Wed, 25 Oct 2017 07:59:04 +0530
Message-Id: <1508898544-10307-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu devel V4 PATCH] msf2: Remove dead code reported
 by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com, f4bug@amsat.org, imammedo@redhat.com, pbonzini@redhat.com, darren.kenny@oracle.com, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Fixed incorrect frame size mask, validated maximum frame
size in spi_write and removed dead code.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
v4:
	changed %d to %u while logging frame size error.
v3:
	Added comment that [31:6] bits are reserved in R_SPI_DFSIZE
	register and logged incorrect value too in guest error(suggested
	by Darren).
v2:
	else if -> else in set_fifodepth
	log guest error when frame size is more than 32

 hw/ssi/mss-spi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 5a8e308..d60daba 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -76,9 +76,10 @@
 #define C_BIGFIFO            (1 << 29)
 #define C_RESET              (1 << 31)
 
-#define FRAMESZ_MASK         0x1F
+#define FRAMESZ_MASK         0x3F
 #define FMCOUNT_MASK         0x00FFFF00
 #define FMCOUNT_SHIFT        8
+#define FRAMESZ_MAX          32
 
 static void txfifo_reset(MSSSpiState *s)
 {
@@ -104,10 +105,8 @@ static void set_fifodepth(MSSSpiState *s)
         s->fifo_depth = 32;
     } else if (size <= 16) {
         s->fifo_depth = 16;
-    } else if (size <= 32) {
-        s->fifo_depth = 8;
     } else {
-        s->fifo_depth = 4;
+        s->fifo_depth = 8;
     }
 }
 
@@ -301,6 +300,17 @@ static void spi_write(void *opaque, hwaddr addr,
         if (s->enabled) {
             break;
         }
+        /*
+         * [31:6] bits are reserved bits and for future use.
+         * [5:0] are for frame size. Only [5:0] bits are validated
+         * during write, [31:6] bits are untouched.
+         */
+        if ((value & FRAMESZ_MASK) > FRAMESZ_MAX) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Incorrect size %u provided."
+                         "Maximum frame size is %u\n",
+                         __func__, value & FRAMESZ_MASK, FRAMESZ_MAX);
+            break;
+        }
         s->regs[R_SPI_DFSIZE] = value;
         break;
 
-- 
2.5.0
