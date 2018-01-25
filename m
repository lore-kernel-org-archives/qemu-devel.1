Received: from eggs.gnu.org ([2001:4830:134:3::10]:33811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoo-0003MC-Pf
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehon-0003Ff-NP
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:54 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehon-0003Co-Cr
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:53 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehol-0006yj-Bc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:51 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:29 +0000
Message-Id: <1516887809-6265-22-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/21] pl110: Implement vertical compare/next
 base interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Linus Walleij <linus.walleij@linaro.org>

This implements rudimentary support for interrupt generation on the
PL110. I am working on a new DRI/KMS driver for Linux and since that
uses the blanking interrupt, we need something to fire here. Without
any interrupt support Linux waits for a while and then gives ugly
messages about the vblank not working in the console (it does not
hang perpetually or anything though, DRI is pretty forgiving).

I solved it for now by setting up a timer to fire at 60Hz and pull
the interrupts for "vertical compare" and "next memory base"
at this interval. This works fine and fires roughly the same number
of IRQs on QEMU as on the hardware and leaves the console clean
and nice.

People who want to create more accurate emulation can probably work
on top of this if need be. It is certainly closer to the hardware
behaviour than what we have today anyway.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Message-id: 20180123225654.5764-1-linus.walleij@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: folded long lines]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/pl110.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 8c7dcc6..cf68457 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -12,6 +12,7 @@
 #include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
+#include "qemu/timer.h"
 #include "qemu/log.h"
 
 #define PL110_CR_EN   0x001
@@ -19,6 +20,8 @@
 #define PL110_CR_BEBO 0x200
 #define PL110_CR_BEPO 0x400
 #define PL110_CR_PWR  0x800
+#define PL110_IE_NB   0x004
+#define PL110_IE_VC   0x008
 
 enum pl110_bppmode
 {
@@ -50,6 +53,7 @@ typedef struct PL110State {
     MemoryRegion iomem;
     MemoryRegionSection fbsection;
     QemuConsole *con;
+    QEMUTimer *vblank_timer;
 
     int version;
     uint32_t timing[4];
@@ -320,7 +324,24 @@ static void pl110_resize(PL110State *s, int width, int height)
 /* Update interrupts.  */
 static void pl110_update(PL110State *s)
 {
-  /* TODO: Implement interrupts.  */
+    /* Raise IRQ if enabled and any status bit is 1 */
+    if (s->int_status & s->int_mask) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void pl110_vblank_interrupt(void *opaque)
+{
+    PL110State *s = opaque;
+
+    /* Fire the vertical compare and next base IRQs and re-arm */
+    s->int_status |= (PL110_IE_NB | PL110_IE_VC);
+    timer_mod(s->vblank_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                                NANOSECONDS_PER_SECOND / 60);
+    pl110_update(s);
 }
 
 static uint64_t pl110_read(void *opaque, hwaddr offset,
@@ -429,6 +450,11 @@ static void pl110_write(void *opaque, hwaddr offset,
         s->bpp = (val >> 1) & 7;
         if (pl110_enabled(s)) {
             qemu_console_resize(s->con, s->cols, s->rows);
+            timer_mod(s->vblank_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                                        NANOSECONDS_PER_SECOND / 60);
+        } else {
+            timer_del(s->vblank_timer);
         }
         break;
     case 10: /* LCDICR */
@@ -474,6 +500,8 @@ static void pl110_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->iomem, OBJECT(s), &pl110_ops, s, "pl110", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
+    s->vblank_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                   pl110_vblank_interrupt, s);
     qdev_init_gpio_in(dev, pl110_mux_ctrl_set, 1);
     s->con = graphic_console_init(dev, 0, &pl110_gfx_ops, s);
 }
-- 
2.7.4
