Received: from eggs.gnu.org ([2001:4830:134:3::10]:42970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4e-0000iO-BH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4d-0002WT-9g
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4d-0002VX-28
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2ECE65383
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:30 -0500
Message-Id: <20170313195547.21466-14-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/30] trace: Fix parameter types in hw/char
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces.  In most cases, we just update the
trace definitions to match the caller types; but in one case, the
caller had already done 'val &= 0xff' so casting uint64_t val down
to the type expected by the trace is sufficient.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/char/escc.c       |  4 ++--
 hw/char/trace-events | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 9228091..33a4d20 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -483,7 +483,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
-        trace_escc_mem_writeb_ctrl(CHN_C(s), s->reg, val & 0xff);
+        trace_escc_mem_writeb_ctrl(CHN_C(s), s->reg, (uint8_t) val);
         newreg = 0;
         switch (s->reg) {
         case W_CMD:
@@ -553,7 +553,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
             s->reg = 0;
         break;
     case SERIAL_DATA:
-        trace_escc_mem_writeb_data(CHN_C(s), val);
+        trace_escc_mem_writeb_data(CHN_C(s), (uint8_t) val);
         s->tx = val;
         if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
             if (qemu_chr_fe_get_driver(&s->chr)) {
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 7fd48bb..361eee0 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -13,7 +13,7 @@ virtio_console_chr_event(unsigned int port, int event) "port %u, event %d"

 # hw/char/grlib_apbuart.c
 grlib_apbuart_event(int event) "event:%d"
-grlib_apbuart_writel_unknown(uint64_t addr, uint32_t value) "addr 0x%"PRIx64" value 0x%x"
+grlib_apbuart_writel_unknown(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%" PRIx64
 grlib_apbuart_readl_unknown(uint64_t addr) "addr 0x%"PRIx64

 # hw/char/lm32_juart.c
@@ -23,13 +23,13 @@ lm32_juart_get_jrx(uint32_t value) "jrx 0x%08x"
 lm32_juart_set_jrx(uint32_t value) "jrx 0x%08x"

 # hw/char/lm32_uart.c
-lm32_uart_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-lm32_uart_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+lm32_uart_memory_write(hwaddr addr, uint64_t value) "addr 0x%08" HWADDR_PRIx " value 0x%08" PRIx64
+lm32_uart_memory_read(hwaddr addr, uint32_t value) "addr 0x%08" HWADDR_PRIx " value 0x%08x"
 lm32_uart_irq_state(int level) "irq state %d"

 # hw/char/milkymist-uart.c
-milkymist_uart_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_uart_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_uart_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_uart_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
 milkymist_uart_raise_irq(void) "Raise IRQ"
 milkymist_uart_lower_irq(void) "Lower IRQ"

@@ -50,9 +50,9 @@ escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=%01x

 # hw/char/pl011.c
 pl011_irq_state(int level) "irq state %d"
-pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl011_read(hwaddr addr, uint64_t value) "addr 0x%08" HWADDR_PRIx " value 0x%08" PRIx64
 pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
-pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl011_write(hwaddr addr, uint64_t value) "addr 0x%08" HWADDR_PRIx " value 0x%08" PRIx64
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR %08x read_count %d returning %d"
 pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
 pl011_put_fifo_full(void) "FIFO now full, RXFF set"
-- 
2.9.3
