Received: from eggs.gnu.org ([2001:4830:134:3::10]:43184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4s-0000y0-ON
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4q-0002e1-O2
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4q-0002dm-FV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:20 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:43 -0500
Message-Id: <20170313195547.21466-27-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 26/30] trace: Fix parameter types in hw/timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Fabien Chouteau <chouteau@adacore.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite, as well as updating callers
to use a consistent type.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/timer/grlib_gptimer.c |  6 +++---
 hw/timer/trace-events    | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e9..96a5864 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -235,19 +235,19 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
     case SCALER_OFFSET:
         value &= 0xFFFF; /* clean up the value */
         unit->scaler = value;
-        trace_grlib_gptimer_writel(-1, addr, unit->scaler);
+        trace_grlib_gptimer_writel(-1, addr, (uint64_t) unit->scaler);
         return;

     case SCALER_RELOAD_OFFSET:
         value &= 0xFFFF; /* clean up the value */
         unit->reload = value;
-        trace_grlib_gptimer_writel(-1, addr, unit->reload);
+        trace_grlib_gptimer_writel(-1, addr, (uint64_t) unit->reload);
         grlib_gptimer_set_scaler(unit, value);
         return;

     case CONFIG_OFFSET:
         /* Read Only (disable timer freeze not supported) */
-        trace_grlib_gptimer_writel(-1, addr, 0);
+        trace_grlib_gptimer_writel(-1, addr, (uint64_t) 0);
         return;

     default:
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index d17cfe6..dc4c89c 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -5,7 +5,7 @@ slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit
 slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count %x%08x"
 slavio_timer_mem_readl_invalid(uint64_t addr) "invalid read address %"PRIx64
 slavio_timer_mem_readl(uint64_t addr, uint32_t ret) "read %"PRIx64" = %08x"
-slavio_timer_mem_writel(uint64_t addr, uint32_t val) "write %"PRIx64" = %08x"
+slavio_timer_mem_writel(uint64_t addr, uint64_t val) "write %"PRIx64" = %08" PRIx64
 slavio_timer_mem_writel_limit(unsigned int timer_index, uint64_t count) "processor %d user timer set to %016"PRIx64
 slavio_timer_mem_writel_counter_invalid(void) "not user timer"
 slavio_timer_mem_writel_status_start(unsigned int timer_index) "processor %d user timer started"
@@ -22,17 +22,17 @@ grlib_gptimer_restart(int id, uint32_t reload) "timer:%d reload val: 0x%x"
 grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:0x%x freq: 0x%x"
 grlib_gptimer_hit(int id) "timer:%d HIT"
 grlib_gptimer_readl(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
-grlib_gptimer_writel(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
+grlib_gptimer_writel(int id, uint64_t addr, uint64_t val) "timer:%d addr 0x%"PRIx64" 0x%" PRIx64

 # hw/timer/lm32_timer.c
-lm32_timer_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-lm32_timer_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+lm32_timer_memory_write(hwaddr addr, uint64_t value) "addr 0x%08" HWADDR_PRIx " value 0x%08" PRIx64
+lm32_timer_memory_read(hwaddr addr, uint32_t value) "addr 0x%08" HWADDR_PRIx " value 0x%08x"
 lm32_timer_hit(void) "timer hit"
 lm32_timer_irq_state(int level) "irq state %d"

 # hw/timer/milkymist-sysctl.c
-milkymist_sysctl_memory_read(uint32_t addr, uint32_t value) "addr %08x value %08x"
-milkymist_sysctl_memory_write(uint32_t addr, uint32_t value) "addr %08x value %08x"
+milkymist_sysctl_memory_read(hwaddr addr, uint32_t value) "addr %08" HWADDR_PRIx " value %08x"
+milkymist_sysctl_memory_write(hwaddr addr, uint64_t value) "addr %08" HWADDR_PRIx " value %08" PRIx64
 milkymist_sysctl_icap_write(uint32_t value) "value %08x"
 milkymist_sysctl_start_timer0(void) "Start timer0"
 milkymist_sysctl_stop_timer0(void) "Stop timer0"
@@ -54,4 +54,4 @@ aspeed_timer_read(uint64_t offset, unsigned size, uint64_t value) "From 0x%" PRI
 systick_reload(void) "systick reload"
 systick_timer_tick(void) "systick reload"
 systick_read(uint64_t addr, uint32_t value, unsigned size) "systick read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+systick_write(uint64_t addr, uint64_t value, unsigned size) "systick write addr 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.9.3
