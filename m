Received: from eggs.gnu.org ([2001:4830:134:3::10]:56964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDU-0007va-9H
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDT-0000kT-0M
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDS-0000er-PS
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDJ-0007ap-GK
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:16 +0100
Message-Id: <20180410121724.8549-5-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/12] hw/sd/bcm2835_sdhost: Add tracepoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add some tracepoints to the bcm2835_sdhost driver, to assist
debugging.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180319161556.16446-2-peter.maydell@linaro.org
---
 hw/sd/bcm2835_sdhost.c | 10 ++++++++++
 hw/sd/trace-events     |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index f7f4e656df..79f3c5ceeb 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -15,6 +15,7 @@
 #include "qemu/log.h"
 #include "sysemu/blockdev.h"
 #include "hw/sd/bcm2835_sdhost.h"
+#include "trace.h"
 
 #define TYPE_BCM2835_SDHOST_BUS "bcm2835-sdhost-bus"
 #define BCM2835_SDHOST_BUS(obj) \
@@ -99,6 +100,7 @@ static void bcm2835_sdhost_update_irq(BCM2835SDHostState *s)
 {
     uint32_t irq = s->status &
         (SDHSTS_BUSY_IRPT | SDHSTS_BLOCK_IRPT | SDHSTS_SDIO_IRPT);
+    trace_bcm2835_sdhost_update_irq(irq);
     qemu_set_irq(s->irq, !!irq);
 }
 
@@ -211,6 +213,7 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
 
         s->edm &= ~0xf;
         s->edm |= SDEDM_FSM_DATAMODE;
+        trace_bcm2835_sdhost_edm_change("datacnt 0", s->edm);
 
         if (s->config & SDHCFG_DATA_IRPT_EN) {
             s->status |= SDHSTS_SDIO_IRPT;
@@ -229,6 +232,7 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
 
     s->edm &= ~(0x1f << 4);
     s->edm |= ((s->fifo_len & 0x1f) << 4);
+    trace_bcm2835_sdhost_edm_change("fifo run", s->edm);
 }
 
 static uint64_t bcm2835_sdhost_read(void *opaque, hwaddr offset,
@@ -280,6 +284,8 @@ static uint64_t bcm2835_sdhost_read(void *opaque, hwaddr offset,
         break;
     }
 
+    trace_bcm2835_sdhost_read(offset, res, size);
+
     return res;
 }
 
@@ -288,6 +294,8 @@ static void bcm2835_sdhost_write(void *opaque, hwaddr offset,
 {
     BCM2835SDHostState *s = (BCM2835SDHostState *)opaque;
 
+    trace_bcm2835_sdhost_write(offset, value, size);
+
     switch (offset) {
     case SDCMD:
         s->cmd = value;
@@ -314,6 +322,7 @@ static void bcm2835_sdhost_write(void *opaque, hwaddr offset,
             value &= ~0xf;
         }
         s->edm = value;
+        trace_bcm2835_sdhost_edm_change("guest register write", s->edm);
         break;
     case SDHCFG:
         s->config = value;
@@ -390,6 +399,7 @@ static void bcm2835_sdhost_reset(DeviceState *dev)
     s->cmd = 0;
     s->cmdarg = 0;
     s->edm = 0x0000c60f;
+    trace_bcm2835_sdhost_edm_change("device reset", s->edm);
     s->config = 0;
     s->hbct = 0;
     s->hblc = 0;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 2059ace61f..bfd1d62efc 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,11 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/sd/bcm2835_sdhost.c
+bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+bcm2835_sdhost_edm_change(const char *why, uint32_t edm) "(%s) EDM now 0x%x"
+bcm2835_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x\n"
+
 # hw/sd/core.c
 sdbus_command(const char *bus_name, uint8_t cmd, uint32_t arg, uint8_t crc) "@%s CMD%02d arg 0x%08x crc 0x%02x"
 sdbus_read(const char *bus_name, uint8_t value) "@%s value 0x%02x"
-- 
2.16.2
