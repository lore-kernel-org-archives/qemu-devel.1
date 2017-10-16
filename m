Received: from eggs.gnu.org ([2001:4830:134:3::10]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e49bc-0001Ut-GJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e49bY-00076O-H6
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:55:12 -0400
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Mon, 16 Oct 2017 23:24:49 +0530
Message-Id: <1508176489-9002-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu devel PATCH] msf2: Remove dead code reported by
 Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com, f4bug@amsat.org, imammedo@redhat.com, pbonzini@redhat.com, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Fixed incorrect frame size mask, validated maximum frame
size in spi_write and removed dead code.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 hw/ssi/mss-spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 5a8e308..1e49cbc 100644
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
@@ -106,8 +107,6 @@ static void set_fifodepth(MSSSpiState *s)
         s->fifo_depth = 16;
     } else if (size <= 32) {
         s->fifo_depth = 8;
-    } else {
-        s->fifo_depth = 4;
     }
 }
 
@@ -301,6 +300,9 @@ static void spi_write(void *opaque, hwaddr addr,
         if (s->enabled) {
             break;
         }
+        if ((value & FRAMESZ_MASK) > FRAMESZ_MAX) {
+            break;
+        }
         s->regs[R_SPI_DFSIZE] = value;
         break;
 
-- 
2.5.0
