Received: from eggs.gnu.org ([2001:4830:134:3::10]:56902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynX-0003BH-7g
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynU-0006D9-Nx
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:23 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynU-0006Cb-Bi
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:20 -0500
Received: by mail-qk0-x242.google.com with SMTP id q14so40813881qke.7
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:01 -0300
Message-Id: <20171229174933.1781-11-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/42] sdhci: add a GPIO for the 'access
 control' LED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

It blinks to caution the user not to remove the card while the SD card is
being accessed.
So far it only emit a trace event.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 14 ++++++++++++++
 hw/sd/trace-events    |  1 +
 3 files changed, 17 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a6fe064f51..da943a6562 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -45,6 +45,8 @@ typedef struct SDHCIState {
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
     qemu_irq irq;
+    qemu_irq access_led;
+    int access_led_level;
 
     /* Registers cleared on reset */
     /* 0x00 */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index acd5aa1e19..4679a6d5ed 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -203,6 +203,16 @@ static void sdhci_poweron_reset(DeviceState *dev)
     }
 }
 
+static void sdhci_led_handler(void *opaque, int line, int level)
+{
+    SDHCIState *s = (SDHCIState *)opaque;
+
+    if (s->access_led_level != level) {
+        trace_sdhci_led(level);
+        s->access_led_level = level;
+    }
+}
+
 static void sdhci_data_transfer(void *opaque);
 
 static void sdhci_send_command(SDHCIState *s)
@@ -1051,6 +1061,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                 !(s->capareg & (1 << (31 - ((s->pwrcon >> 1) & 0x7))))) {
             s->pwrcon &= ~SDHC_POWER_ON;
         }
+        qemu_set_irq(s->access_led, s->hostctl & 1);
         break;
     case SDHC_CLKCON:
         if (!(mask & 0xFF000000)) {
@@ -1163,6 +1174,7 @@ static void sdhci_initfn(SDHCIState *s)
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
                         TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
 
+    s->access_led = qemu_allocate_irq(sdhci_led_handler, s, 0);
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
 }
@@ -1187,6 +1199,8 @@ static void sdhci_uninitfn(SDHCIState *s)
     timer_free(s->insert_timer);
     timer_del(s->transfer_timer);
     timer_free(s->transfer_timer);
+
+    qemu_free_irq(s->access_led);
 }
 
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index e4e26c6d73..f821db2046 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -13,6 +13,7 @@ sdhci_adma_transfer_completed(void) "ADMA transfer completed"
 sdhci_access(const char *access, unsigned int size, uint64_t offset, const char *dir, uint64_t val, uint64_t val2) "%s %ub: addr[0x%04" PRIx64 "] %s %" PRIu64 "(0x%" PRIx64 ")"
 sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read from input buffer"
 sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of data"
+sdhci_led(bool state) "LED: %u"
 
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1
