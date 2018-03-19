Received: from eggs.gnu.org ([2001:4830:134:3::10]:46143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exxbJ-000433-C4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exxbI-0007LP-2x
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:25:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 16:15:56 +0000
Message-Id: <20180319161556.16446-3-peter.maydell@linaro.org>
In-Reply-To: <20180319161556.16446-1-peter.maydell@linaro.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12 2/2] hw/sd/bcm2835_sdhost: Don't raise
 spurious interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>

The Linux bcm2835_sdhost driver doesn't work on QEMU, because our
model raises spurious data interrupts.  Our function
bcm2835_sdhost_fifo_run() will flag an interrupt any time it is
called with s->datacnt == 0, even if the host hasn't actually issued
a data read or write command yet.  This means that the driver gets a
spurious data interrupt as soon as it enables IRQs and then does
something else that causes us to call the fifo_run routine, like
writing to SDHCFG, and before it does the write to SDCMD to issue the
read.  The driver's IRQ handler then spins forever complaining that
there's no data and the SD controller isn't in a state where there's
going to be any data:

[   41.040738] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
[   41.042059] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
(continues forever).

Move the interrupt flag setting to more plausible places:
 * for BUSY, raise this as soon as a BUSYWAIT command has executed
 * for DATA, raise this when the FIFO has any space free (for a write)
   or any data in it (for a read)
 * for BLOCK, raise this when the data count is 0 and we've
   actually done some reading or writing

This is pure guesswork since the documentation for this hardware is
not public, but it is sufficient to get the Linux bcm2835_sdhost
driver to work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/bcm2835_sdhost.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 79f3c5ceeb..0fd0853fa3 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -137,6 +137,9 @@ static void bcm2835_sdhost_send_command(BCM2835SDHostState *s)
         }
 #undef RWORD
     }
+    if ((s->cmd & SDCMD_BUSYWAIT) && (s->config & SDHCFG_BUSY_IRPT_EN)) {
+        s->status |= SDHSTS_BUSY_IRPT;
+    }
     return;
 
 error:
@@ -187,18 +190,27 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
                 n++;
                 if (n == 4) {
                     bcm2835_sdhost_fifo_push(s, value);
+                    s->status |= SDHSTS_DATA_FLAG;
+                    if (s->config & SDHCFG_DATA_IRPT_EN) {
+                        s->status |= SDHSTS_SDIO_IRPT;
+                    }
                     n = 0;
                     value = 0;
                 }
             }
             if (n != 0) {
                 bcm2835_sdhost_fifo_push(s, value);
+                s->status |= SDHSTS_DATA_FLAG;
             }
         } else { /* write */
             n = 0;
             while (s->datacnt > 0 && (s->fifo_len > 0 || n > 0)) {
                 if (n == 0) {
                     value = bcm2835_sdhost_fifo_pop(s);
+                    s->status |= SDHSTS_DATA_FLAG;
+                    if (s->config & SDHCFG_DATA_IRPT_EN) {
+                        s->status |= SDHSTS_SDIO_IRPT;
+                    }
                     n = 4;
                 }
                 n--;
@@ -207,28 +219,19 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
                 value >>= 8;
             }
         }
+        if (s->datacnt == 0) {
+            s->edm &= ~0xf;
+            s->edm |= SDEDM_FSM_DATAMODE;
+            trace_bcm2835_sdhost_edm_change("datacnt 0", s->edm);
+
+            if ((s->cmd & SDCMD_WRITE_CMD) &&
+                (s->config & SDHCFG_BLOCK_IRPT_EN)) {
+                s->status |= SDHSTS_BLOCK_IRPT;
+            }
+        }
     }
-    if (s->datacnt == 0) {
-        s->status |= SDHSTS_DATA_FLAG;
 
-        s->edm &= ~0xf;
-        s->edm |= SDEDM_FSM_DATAMODE;
-        trace_bcm2835_sdhost_edm_change("datacnt 0", s->edm);
-
-        if (s->config & SDHCFG_DATA_IRPT_EN) {
-            s->status |= SDHSTS_SDIO_IRPT;
-        }
-
-        if ((s->cmd & SDCMD_BUSYWAIT) && (s->config & SDHCFG_BUSY_IRPT_EN)) {
-            s->status |= SDHSTS_BUSY_IRPT;
-        }
-
-        if ((s->cmd & SDCMD_WRITE_CMD) && (s->config & SDHCFG_BLOCK_IRPT_EN)) {
-            s->status |= SDHSTS_BLOCK_IRPT;
-        }
-
-        bcm2835_sdhost_update_irq(s);
-    }
+    bcm2835_sdhost_update_irq(s);
 
     s->edm &= ~(0x1f << 4);
     s->edm |= ((s->fifo_len & 0x1f) << 4);
-- 
2.16.2
